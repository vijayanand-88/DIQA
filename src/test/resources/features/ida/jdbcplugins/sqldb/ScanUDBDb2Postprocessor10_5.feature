Feature: To Verify SqlPostProcessor generates lineage

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: Add valid Credentials for ScanUDB Postprocessor
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                  | body                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/UDB_Credentials | ida/ScanUDBPayloads/credentials/Credentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/UDB_Credentials |                                                  | 200           |                  |          |

  @positve @regression @sanity
  Scenario:Add valid Datasource for ScanUDB Postprocessor
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                              | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads/DataSource/UDBDataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                   | 200           | UDBDataSource    |          |


  @jdbc
  Scenario Outline: SC#1-Run UDBCataloger and SqlPostProcessor Plugin config for ScanUDB plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                            | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger                                                           | ida/ScanUDBPayloads/UDBPPCatalogerConfig.json   | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                           |                                                 | 200           | DB2CatalogerPostProcessor |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPostProcessor   |                                                 | 200           | IDLE                      | $.[?(@.configurationName=='DB2CatalogerPostProcessor')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPostProcessor    | ida/empty.json                                  | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPostProcessor   |                                                 | 200           | IDLE                      | $.[?(@.configurationName=='DB2CatalogerPostProcessor')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLPostProcessor                                                       | ida/ScanUDBPayloads/SQLPostprocessorConfig.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLPostProcessor                                                       |                                                 | 200           | SQL_Postprocessor         |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/SQLPostProcessor/SQL_Postprocessor |                                                 | 200           | IDLE                      | $.[?(@.configurationName=='SQL_Postprocessor')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/InternalNode/dataanalyzer/SQLPostProcessor/SQL_Postprocessor  | ida/empty.json                                  | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/SQLPostProcessor/SQL_Postprocessor |                                                 | 200           | IDLE                      | $.[?(@.configurationName=='SQL_Postprocessor')].status         |

  @sanity @positive @IDA-10.0 @webtest
  Scenario: SC#2 - Verify breadcrumb hierarchy appears correctly for Triggers
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ADRMQT" and clicks on search
    And user performs "facet selection" in "SC1PPUDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADRMQT" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | gechcae-col1.asg.com |
      | DB2:50000            |
      | SAMPLE               |
      | AC                   |
      | ADRMQT               |

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
      | gechcae-col1.asg.com |
      | DB2:50000            |

    ##6767934##
  @webtest @MLP-9604
  Scenario:SC#4_Verify SQLPostProcessor generates lineage for Table to Table(through procedure)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ADRMQT" and clicks on search
    And user performs "facet selection" in "SC1PPUDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADRMQT" item from search results
    Then user performs click and verify in new window
      | Table         | value                                                         | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | dependencies  | ADRVIEW_GER                                                   | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | gechcae-col1.asg.com"."DB2:50000".SAMPLE.AC.ADRMQT.CITY       | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | gechcae-col1.asg.com"."DB2:50000".SAMPLE.AC.ADRMQT.COUNTRY    | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | gechcae-col1.asg.com"."DB2:50000".SAMPLE.AC.ADRMQT.FIRST_NAME | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | gechcae-col1.asg.com"."DB2:50000".SAMPLE.AC.ADRMQT.LAST_NAME  | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | gechcae-col1.asg.com"."DB2:50000".SAMPLE.AC.ADRMQT.STREET     | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | gechcae-col1.asg.com"."DB2:50000".SAMPLE.AC.ADRMQT.ZIP_CODE   | verify widget contains | No               |             |          |          |                 |
      | SQLSource     | SQLSource                                                     | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops  | gechcae-col1.asg.com"."DB2:50000".SAMPLE.AC.ADRMQT.CITY       | click and switch tab   | No               |             |          |          |                 |
      | lineageDown   | ORT                                                           | verify widget contains | No               |             |          |          |                 |
      | lineageUp     | CITY                                                          | verify widget contains | No               |             |          |          |                 |
      | lineageSource | SQLSource                                                     | verify widget contains | No               |             |          |          |                 |
      | lineageSource | SQLSource                                                     | click and switch tab   | No               |             |          |          |                 |
#
    ####################################################Lineage Verification in ScanUDB##########################################################################################################

  ##7126839## ##7126840## ##7126841## ##7126842## ##7126843## ##7126844## ##7126845## ##7126846## ##7126847## ##7126848## ##7126849## ##7126850## ##7126851## ##7126852## ##7126853## ##7126854## ##7126855## ##7126856## ##7126857## ##7126858## ##7126859## ##7126860## ##7126861## ##7126862## ##7126863## ##7126864## ##7126865## ##7126866## ##7126867## ##7126868## ##7126869##
  Scenario Outline:SC#5_user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name        | type  | targetFile                                                       |
      | APPDBPOSTGRES | Default | ADRMQT      | Table | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ADRNEWTAB   | Table | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ADRVIEW_GER | Table | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ADRTAB      | Table | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json |

  Scenario Outline:SC#5_user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                             | payloadFile                                                  | type  | jsonPath       |
      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/ScanUDB/payloads/ADRMQT.json      | Table | $..ADRMQT      |
      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/ScanUDB/payloads/ADRNEWTAB.json   | Table | $..ADRNEWTAB   |
      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/ScanUDB/payloads/ADRVIEW_GER.json | Table | $..ADRVIEW_GER |
      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/ScanUDB/payloads/ADRTAB.json      | Table | $..ADRTAB      |


  Scenario Outline:SC#5_user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                   | body                                                         | file                                                             | type | path           | statusCode | jsonPath   | targetFile                                                          | name        |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/ScanUDB/payloads/ADRMQT.json      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json | List | $..ADRMQT      | 200        | $..edges.* | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRMQT.json      | ADRMQT      |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/ScanUDB/payloads/ADRNEWTAB.json   | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json | List | $..ADRNEWTAB   | 200        | $..edges.* | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRNEWTAB.json   | ADRNEWTAB   |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/ScanUDB/payloads/ADRVIEW_GER.json | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json | List | $..ADRVIEW_GER | 200        | $..edges.* | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRVIEW_GER.json | ADRVIEW_GER |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/ScanUDB/payloads/ADRTAB.json      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/tableIDs.json | List | $..ADRTAB      | 200        | $..edges.* | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRTAB.json      | ADRTAB      |


  Scenario Outline:SC#5_user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
    Examples:
      | LineageFile                                                         | TableName   |
      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRMQT.json      | ADRMQT      |
      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRNEWTAB.json   | ADRNEWTAB   |
      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRVIEW_GER.json | ADRVIEW_GER |
      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRTAB.json      | ADRTAB      |

  Scenario Outline:SC#5_user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                          | actualJson                                                          |
      | Constant.REST_DIR/response/ScanUDB/expectedJsonFiles/ADRMQT.json      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRMQT.json      |
      | Constant.REST_DIR/response/ScanUDB/expectedJsonFiles/ADRNEWTAB.json   | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRNEWTAB.json   |
      | Constant.REST_DIR/response/ScanUDB/expectedJsonFiles/ADRVIEW_GER.json | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRVIEW_GER.json |
      | Constant.REST_DIR/response/ScanUDB/expectedJsonFiles/ADRTAB.json      | Constant.REST_DIR/response/ScanUDB/actualJsonFiles/ADRTAB.json      |


  @MLP-4441 @sanity @positive
  Scenario:SC#6:Delete Database id and Analysis id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type     | query | param |
      | SingleItemDelete | Default | cataloger/UDBCataloger/DB2Cataloger%             | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/SQLPostProcessor/SQL_Postprocessor% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                                           | Database |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com                             | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                                        | Service  |       |       |


  @sanity @positive
  Scenario:SC#7:Delete Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                  | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/UDB_Credentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBDataSource     |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBCataloger      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/SQLPostProcessor  |      | 204           |                  |          |

