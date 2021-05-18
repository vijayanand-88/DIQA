@MLP-28411
Feature: To Verify UDB SqlPostProcessor generates lineage (11.5 Version)

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: Add valid Credentials for ScanUDB Postprocessor
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                  | body                                                 | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/UDB_Credentials | ida/ScanUDBPayloads11_5/credentials/Credentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/UDB_Credentials |                                                      | 200           |                  |          |

  @positve @regression @sanity
  Scenario:Add valid Datasource for ScanUDB Postprocessor
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                                  | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads11_5/DataSource/UDBDataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                       | 200           | UDBDataSource    |          |


  @jdbc
  Scenario Outline: SC#1-Run UDBCataloger and SqlPostProcessor Plugin config for ScanUDB plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPostProcessor                                 | ida/ScanUDBPayloads11_5/UDBPPCatalogerConfig.json   | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPostProcessor                                 |                                                     | 200           | DB2CatalogerPostProcessor |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPostProcessor   |                                                     | 200           | IDLE                      | $.[?(@.configurationName=='DB2CatalogerPostProcessor')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPostProcessor    | ida/empty.json                                      | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPostProcessor   |                                                     | 200           | IDLE                      | $.[?(@.configurationName=='DB2CatalogerPostProcessor')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLPostProcessor/SQL_Postprocessor                                     | ida/ScanUDBPayloads11_5/SQLPostprocessorConfig.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLPostProcessor/SQL_Postprocessor                                     |                                                     | 200           | SQL_Postprocessor         |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/SQLPostProcessor/SQL_Postprocessor |                                                     | 200           | IDLE                      | $.[?(@.configurationName=='SQL_Postprocessor')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/InternalNode/dataanalyzer/SQLPostProcessor/SQL_Postprocessor  | ida/empty.json                                      | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/SQLPostProcessor/SQL_Postprocessor |                                                     | 200           | IDLE                      | $.[?(@.configurationName=='SQL_Postprocessor')].status         |

  @sanity @positive @IDA-10.0 @webtest
  Scenario: SC#2 - Verify breadcrumb hierarchy appears correctly for Triggers
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ADRMQT" and clicks on search
    And user performs "facet selection" in "SC1PPUDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADRMQT" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | diqdb211501v |
      | DB2:50000    |
      | SAMPLE       |
      | TC           |
      | ADRMQT       |

  @webtest @positive
  Scenario: SC#3_Verify the SQL Postprocessor Plugin Processed Items for UDBCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1PPUDB" and clicks on search
    And user performs "facet selection" in "SC1PPUDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/SQLPostProcessor/SQL_Postprocessor%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | diqdb211501v |
      | DB2:50000    |

    ##6767934##
  @webtest @MLP-9604
  Scenario:SC#4_Verify SQLPostProcessor generates lineage for Table to Table(through procedure)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ADRMQT" and clicks on search
    And user performs "facet selection" in "SC1PPUDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADRMQT" item from search results
    Then user performs click and verify in new window
      | Table         | value                                                        | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | dependencies  | ADRVIEW_GER                                                  | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | "diqdb211501v"."DB2:50000".SAMPLE.TC.ADRMQT.CITY (U/D)       | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | "diqdb211501v"."DB2:50000".SAMPLE.TC.ADRMQT.COUNTRY (U/D)    | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | "diqdb211501v"."DB2:50000".SAMPLE.TC.ADRMQT.FIRST_NAME (U/D) | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | "diqdb211501v"."DB2:50000".SAMPLE.TC.ADRMQT.LAST_NAME (U/D)  | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | "diqdb211501v"."DB2:50000".SAMPLE.TC.ADRMQT.STREET (U/D)     | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | "diqdb211501v"."DB2:50000".SAMPLE.TC.ADRMQT.ZIP_CODE (U/D)   | verify widget contains | No               |             |          |          |                 |
      | SQLSource     | SQLSource                                                    | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | "diqdb211501v"."DB2:50000".SAMPLE.TC.ADRMQT.CITY (U/D)       | click and switch tab   | No               |             |          |          |                 |
      | lineageDown   | ORT                                                          | verify widget contains | No               |             |          |          |                 |
      | lineageUp     | CITY                                                         | verify widget contains | No               |             |          |          |                 |
      | lineageSource | SQLSource                                                    | verify widget contains | No               |             |          |          |                 |
      | lineageSource | SQLSource                                                    | click and switch tab   | No               |             |          |          |                 |
    ####################################################Lineage Verification in ScanUDB##########################################################################################################

  #7208150#
  Scenario Outline:SC#5_user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name        | type  | targetFile                                                            |
      | APPDBPOSTGRES | Default | ADRMQT      | Table | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ADRNEWTAB   | Table | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ADRVIEW_GER | Table | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ADRTAB      | Table | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json |

  #7208150#
  Scenario Outline:SC#5_user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                                  | payloadFile                                                       | type  | jsonPath       |
      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/ScanUDB_11.5/payloads/ADRMQT.json      | Table | $..ADRMQT      |
      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/ScanUDB_11.5/payloads/ADRNEWTAB.json   | Table | $..ADRNEWTAB   |
      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/ScanUDB_11.5/payloads/ADRVIEW_GER.json | Table | $..ADRVIEW_GER |
      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/ScanUDB_11.5/payloads/ADRTAB.json      | Table | $..ADRTAB      |

  #7208150#
  Scenario Outline:SC#5_user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                   | body                                                              | file                                                                  | type | path           | statusCode | jsonPath   | targetFile                                                               | name        |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/ScanUDB_11.5/payloads/ADRMQT.json      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json | List | $..ADRMQT      | 200        | $..edges.* | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRMQT.json      | ADRMQT      |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/ScanUDB_11.5/payloads/ADRNEWTAB.json   | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json | List | $..ADRNEWTAB   | 200        | $..edges.* | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRNEWTAB.json   | ADRNEWTAB   |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/ScanUDB_11.5/payloads/ADRVIEW_GER.json | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json | List | $..ADRVIEW_GER | 200        | $..edges.* | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRVIEW_GER.json | ADRVIEW_GER |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/ScanUDB_11.5/payloads/ADRTAB.json      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/tableIDs.json | List | $..ADRTAB      | 200        | $..edges.* | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRTAB.json      | ADRTAB      |

 #7208150#
  Scenario Outline:SC#5_user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
    Examples:
      | LineageFile                                                              | TableName   |
      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRMQT.json      | ADRMQT      |
      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRNEWTAB.json   | ADRNEWTAB   |
      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRVIEW_GER.json | ADRVIEW_GER |
      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRTAB.json      | ADRTAB      |

  #7208150#
  Scenario Outline:SC#5_user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                               | actualJson                                                               |
      | Constant.REST_DIR/response/ScanUDB_11.5/expectedJsonFiles/ADRMQT.json      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRMQT.json      |
      | Constant.REST_DIR/response/ScanUDB_11.5/expectedJsonFiles/ADRNEWTAB.json   | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRNEWTAB.json   |
      | Constant.REST_DIR/response/ScanUDB_11.5/expectedJsonFiles/ADRVIEW_GER.json | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRVIEW_GER.json |
      | Constant.REST_DIR/response/ScanUDB_11.5/expectedJsonFiles/ADRTAB.json      | Constant.REST_DIR/response/ScanUDB_11.5/actualJsonFiles/ADRTAB.json      |


  @MLP-28411 @sanity @positive
  Scenario:SC#6:Delete Database id and Analysis id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type     | query | param |
      | SingleItemDelete | Default | cataloger/UDBCataloger/DB2Cataloger%             | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/SQLPostProcessor/SQL_Postprocessor% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                                           | Database |       |       |
      | SingleItemDelete | Default | diqdb211501v                                     | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                                        | Service  |       |       |


  @sanity @positive
  Scenario:SC#7:Delete Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                  | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/UDB_Credentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBDataSource     |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBCataloger      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/SQLPostProcessor  |      | 204           |                  |          |

