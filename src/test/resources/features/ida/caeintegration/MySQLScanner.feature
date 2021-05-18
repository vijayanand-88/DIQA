@MLP-26614 @MLP-26637 @MLP-26786
Feature: Rochade based post-processor and reconcile plugin for MySQL
  # MLP-26614 - MySQL rochade based scanner
  # MLP-26637 - DD plugin for MySQL import rochade plugin
  # MLP-26786 - Rochade based post-processor and reconcile plugin for MySQL

  Scenario Outline: Configure Credential,Data Source,Plugin config for My SQL and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                 | bodyFile                                        | path                                | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/MySQLEDICredential                             | payloads/ida/MySQLRocPayloads/credentials.json  | $.MySQLCredentials                  | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/MySQLEDICredential                             |                                                 |                                     | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EDIMySqlCredential                             | payloads/ida/MySQLRocPayloads/credentials.json  | $.EDICredentials                    | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EDIMySqlCredential                             |                                                 |                                     | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/DataSource_for_MySQL_Scan                        | payloads/ida/MySQLRocPayloads/datasource.json   | $.MySQLDataSource                   | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/DataSource_for_MySQL_Scan                        |                                                 |                                     | 200           | MySQLEDIDS         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource                                 | payloads/ida/MySQLRocPayloads/datasource.json   | $.EDIBusDataSource                  | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource                                 |                                                 |                                     | 200           | EDIBusMySQLDS      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/Scanner_for_MySQL_Scan/MySQLScan                 | payloads/ida/MySQLRocPayloads/pluginconfig.json | $.MySQLScan.configurations          | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/Scanner_for_MySQL_Scan/MySQLScan                 |                                                 |                                     | 200           | MySQLScan          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/Scanner_for_MySQL_Import/MySQLImport             | payloads/ida/MySQLRocPayloads/pluginconfig.json | $.MySQLImport.configurations        | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/Scanner_for_MySQL_Import/MySQLImport             |                                                 |                                     | 200           | MySQLImport        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/Scanner_for_MySQL_Postprocess/MySQLPostProcessor | payloads/ida/MySQLRocPayloads/pluginconfig.json | $.MySQLPostProcessor.configurations | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/Scanner_for_MySQL_Postprocess/MySQLPostProcessor |                                                 |                                     | 200           | MySQLPostProcessor |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/Scanner_for_MySQL_Reconcile/MySQLReconcile       | payloads/ida/MySQLRocPayloads/pluginconfig.json | $.MySQLReconcile.configurations     | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/Scanner_for_MySQL_Reconcile/MySQLReconcile       |                                                 |                                     | 200           | MySQLReconcile     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBusMySQL                               | payloads/ida/MySQLRocPayloads/pluginconfig.json | $.EDIBus.configurations             | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBusMySQL                               |                                                 |                                     | 200           | EDIBusMySQL        |          |


  Scenario Outline: Run My SQL Scan,Import,Post Processor,Reconcile and EDI Bus Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | bodyFile | path | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_MySQL_Scan/MySQLScan             |          |      | 200           | IDLE             | $.[?(@.configurationName=='MySQLScan')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_MySQL_Scan/MySQLScan              |          |      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_MySQL_Scan/MySQLScan             |          |      | 200           | IDLE             | $.[?(@.configurationName=='MySQLScan')].status          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_MySQL_Import/MySQLImport             |          |      | 200           | IDLE             | $.[?(@.configurationName=='MySQLImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_MySQL_Import/MySQLImport              |          |      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_MySQL_Import/MySQLImport             |          |      | 200           | IDLE             | $.[?(@.configurationName=='MySQLImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_MySQL_Postprocess/MySQLPostProcessor |          |      | 200           | IDLE             | $.[?(@.configurationName=='MySQLPostProcessor')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_MySQL_Postprocess/MySQLPostProcessor  |          |      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_MySQL_Postprocess/MySQLPostProcessor |          |      | 200           | IDLE             | $.[?(@.configurationName=='MySQLPostProcessor')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_MySQL_Reconcile/MySQLReconcile       |          |      | 200           | IDLE             | $.[?(@.configurationName=='MySQLReconcile')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_MySQL_Reconcile/MySQLReconcile        |          |      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_MySQL_Reconcile/MySQLReconcile       |          |      | 200           | IDLE             | $.[?(@.configurationName=='MySQLReconcile')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusMySQL                                |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusMySQL')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusMySQL                                 |          |      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusMySQL                                |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusMySQL')].status        |




  Scenario: Verify the Analysis log information for Scanner,Import,Post Processor and Reconcile plugins
    Then Analysis log "collector/Scanner_for_MySQL_Scan/MySQLScan%" should display below info/error/warning
      | type | logValue                                                                                                                                    | logCode       | pluginName             | removableText  |
      | INFO | Plugin Scanner_for_MySQL_Scan Start Time:2020-09-06 12:22:11.998, End Time:2020-09-06 12:25:01.283, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | Scanner_for_MySQL_Scan | Plugin Version |
    Then Analysis log "other/Scanner_for_MySQL_Import/MySQLImport%" should display below info/error/warning
      | type | logValue                                                                                                                                      | logCode       | pluginName               | removableText  |
      | INFO | Plugin Scanner_for_MySQL_Import Start Time:2020-09-06 12:25:24.989, End Time:2020-09-06 12:25:48.586, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | Scanner_for_MySQL_Import | Plugin Version |
    Then Analysis log "other/Scanner_for_MySQL_Postprocess/MySQLPostProcessor%" should display below info/error/warning
      | type | logValue                                                                                                                                           | logCode       | pluginName                    | removableText  |
      | INFO | Plugin Scanner_for_MySQL_Postprocess Start Time:2020-09-06 12:46:45.835, End Time:2020-09-06 12:47:07.181, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | Scanner_for_MySQL_Postprocess | Plugin Version |
    Then Analysis log "other/Scanner_for_MySQL_Reconcile/MySQLReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                         | logCode       | pluginName                    | removableText  |
      | INFO | Plugin Scanner_for_MySQL_Reconcile Start Time:2020-09-06 12:47:45.787, End Time:2020-09-06 12:48:21.259, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | Scanner_for_MySQL_Postprocess | Plugin Version |


  @webtest
  Scenario: Verify HTML logs are generated for Scan and Import plugins under log section
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MySQL" and clicks on search
    And user performs "facet selection" in "MySQL" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_MySQL_Scan/MySQLScan%"
    Then user performs click and verify in new window
      | Table | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MySQLDB-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "MySQL" and clicks on search
    And user performs "facet selection" in "MySQL" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_MySQL_Import/MySQLImport%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MySQLDB-ImportLog.html | verify widget contains | No               |             |


  @webtest
  Scenario:Validate the number of data types items loaded from EDI Bus for Table,Column,Service and Schema
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MySQL" and clicks on search
    And user performs "facet selection" in "MySQL" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "qatest [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage | queryField     | columnName | queryOperation | facet         | facetValue | count      |
      | MYSQL        | STRUCTURED   | json/IDA.json | MySQL     | getTableCount  | count(*)   | returnValue    | Metadata Type | Table      | fromSource |
      | MYSQL        | STRUCTURED   | json/IDA.json | MySQL     | getColumnCount | count(*)   | returnValue    | Metadata Type | Column     | fromSource |
      |              |              |               |           |                |            |                | Metadata Type | Schema     | 1          |
      |              |              |               |           |                |            |                | Metadata Type | Database   | 1          |


  @webtest
  Scenario:Verify whether all item types collected from Rochade is displayed in DD platform
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MySQL" and clicks on search
    And user performs "facet selection" in "MySQL" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column   |
      | Table    |
      | Analysis |
      | Database |
      | Service  |
      | Schema   |
      | Trigger  |
      | Function |


  @webtest
  Scenario: SC1#:SC1#Verify breadcrumb hierarchy for MySQL appears correctly for EDIBus collected items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MySQL" and clicks on search
    And user performs "facet selection" in "MySQL" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "qatest [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "creditLimit" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | MOBIQPLUGIN01V≫DB     |
      | qatest                |
      | qatest                |
      | customerdetails_table |
      | creditLimit           |

  @webtest
  Scenario:SC1#_Verify Bussiness tag appears correctly for My SQL - Scan Import PostProcess and Reconcile analysis log
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Rochade" and clicks on search
    And user performs "facet selection" in "Rochade" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Rochade,MySQL" should get displayed for the column "collector/Scanner_for_MySQL_Scan/MySQLScan"
    Then the following tags "Rochade,MySQL" should get displayed for the column "other/Scanner_for_MySQL_Import/MySQLImport"
    Then the following tags "Rochade,MySQL" should get displayed for the column "other/Scanner_for_MySQL_Postprocess/MySQLPostProcessor"
    Then the following tags "Rochade,MySQL" should get displayed for the column "other/Scanner_for_MySQL_Reconcile/MySQLReconcile"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag   | fileName              | userTag               |
      | Default     | Database | Metadata Type | MySQL | qatest                | MySQL                 |
      | Default     | Schema   | Metadata Type | MySQL | qatest                | MySQL                 |
      | Default     | Table    | Metadata Type | MySQL | customerdetails_table | customerdetails_table |
      | Default     | Column   | Metadata Type | MySQL | creditLimit           | creditLimit           |
      | Default     | Service  | Metadata Type | MySQL | MOBIQPLUGIN01V≫DB     | MySQL                 |

  @webtest
  Scenario:Verify the item type attributes for My SQL Database in Item View Page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MySQL" and clicks on search
    And user performs "facet selection" in "MySQL" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "qatest [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "qatest" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                               | widgetName  |
      | Description       |                                             | Description |
      | Definition        | created by ASG-Rochade(R) Scanner for MySQL | Description |
      | Storage type      | MySQL                                       | Description |
    And user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | qatest | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                               | widgetName  |
      | Description       |                                             | Description |
      | Definition        | created by ASG-Rochade(R) Scanner for MySQL | Description |
    And user performs click and verify in new window
      | Table  | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Tables | customerdetails_table | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | BASE TABLE    | Description |
      | Table Type        | TABLE         | Description |
      | Created by        | ADMIN         | Description |
      | Modified by       | ADMIN         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
      | Modified          | Lifecycle  |
    And user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | creditLimit | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | double        | Description |
      | Created by        | ADMIN         | Description |
      | Modified by       | ADMIN         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
      | Modified          | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Length            | 22            | Statistics |

  @webtest
  Scenario: Verify Depedencies and SQL Source widget section is available in Item View page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "mysqlviewtosingletable" and clicks on search
    And user performs "facet selection" in "MySQL" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "mysqlviewtosingletable" item from search results
    Then user performs click and verify in new window
      | Table        | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | customerdetails_table | verify widget contains | No               |             |
      | SQLSource    | SQLSource             | verify widget contains | No               |             |

  Scenario: user get all lineage hop id's for below datatable
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                          | asg_scopeid | targetFile                                     | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | mysqlviewtosingletable        |             | payloads/ida/MySQLRocPayloads/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | mysqlviewtomultipletable      |             | payloads/ida/MySQLRocPayloads/bulkLineage.json |          |
        | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | childcityview                 |             | payloads/ida/MySQLRocPayloads/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | mysqlviewtoviewandviewtotable |             | payloads/ida/MySQLRocPayloads/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                    | bodyFile                                       | path                                            | response code | response message | jsonPath | targetFile                                           |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | payloads/ida/MySQLRocPayloads/bulkLineage.json | $.lineagePayLoads.mysqlviewtosingletable        | 200           |                  | edges    | payloads/ida/MySQLRocPayloads/actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | payloads/ida/MySQLRocPayloads/bulkLineage.json | $.lineagePayLoads.mysqlviewtomultipletable      | 200           |                  | edges    | payloads/ida/MySQLRocPayloads/actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | payloads/ida/MySQLRocPayloads/bulkLineage.json | $.lineagePayLoads.childcityview                 | 200           |                  | edges    | payloads/ida/MySQLRocPayloads/actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | payloads/ida/MySQLRocPayloads/bulkLineage.json | $.lineagePayLoads.mysqlviewtoviewandviewtotable | 200           |                  | edges    | payloads/ida/MySQLRocPayloads/actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                               | JsonPath                      |
      | Constant.REST_DIR/payloads/ida/MySQLRocPayloads/actualLineagehops.json | mysqlviewtosingletable        |
      | Constant.REST_DIR/payloads/ida/MySQLRocPayloads/actualLineagehops.json | mysqlviewtomultipletable      |
      | Constant.REST_DIR/payloads/ida/MySQLRocPayloads/actualLineagehops.json | childcityview                 |
      | Constant.REST_DIR/payloads/ida/MySQLRocPayloads/actualLineagehops.json | mysqlviewtoviewandviewtotable |

  Scenario Outline:  User compares the expected lineage vs actual lineage referenced items
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                             | actualJson                                                             |
      | Constant.REST_DIR/payloads/ida/MySQLRocPayloads/expectedLineagehops.json | Constant.REST_DIR/payloads/ida/MySQLRocPayloads/actualLineagehops.json |


  Scenario Outline: Cleanup the My SQL data loaded from Rochade via EDI Bus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                     | bodyFile                                        | path                           | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBusMySQLCleanUp                            | payloads/ida/MySQLRocPayloads/pluginconfig.json | $.EDIBusCleanup.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBusMySQLCleanUp                            |                                                 |                                | 200           | EDIBusMySQLCleanUp |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusMySQLCleanUp |                                                 |                                | 200           | IDLE               | $.[?(@.configurationName=='EDIBusMySQLCleanUp')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusMySQLCleanUp  |                                                 |                                | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusMySQLCleanUp |                                                 |                                | 200           | IDLE               | $.[?(@.configurationName=='EDIBusMySQLCleanUp')].status |


  @webtest
  Scenario:Verify whether all item types collected from Rochade are cleared in DD Platform
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MySQL" and clicks on search
    And user performs "facet selection" in "MySQL" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Column   |
      | Table    |
      | Analysis |
      | Database |
      | Service  |
      | Schema   |

  Scenario Outline: PS_Delete Credentials, Datasource and cataloger config for Csv S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                 | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/MySQLEDICredential                             |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EDIMySqlCredential                             |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DataSource_for_MySQL_Scan/MySQLEDIDS             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusMySQLDS                   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/Scanner_for_MySQL_Scan/MySQLScan                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/Scanner_for_MySQL_Import/MySQLImport             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/Scanner_for_MySQL_Postprocess/MySQLPostProcessor |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/Scanner_for_MySQL_Reconcile/MySQLReconcile       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBusMySQL                               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBusMySQLCleanUp                        |          |      | 204           |                  |          |


  Scenario: Delete all My SQL Analysis logs
    Given user delete all "Analysis" log with name "collector/Scanner_for_MySQL_Scan/MySQLScan%" using database
    And user delete all "Analysis" log with name "other/Scanner_for_MySQL_Import/MySQLImport%" using database
    And user delete all "Analysis" log with name "other/Scanner_for_MySQL_Postprocess/MySQLPostProcessor%" using database
    And user delete all "Analysis" log with name "other/Scanner_for_MySQL_Reconcile/MySQLReconcile%" using database