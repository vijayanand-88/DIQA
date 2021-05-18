@MLPQA-19925
@REQ_MLP-30513
Feature: SQLServerScript feature
#Stories: @MLP-33933

  @ROC_SQLServerScript
  Scenario:Precondions Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServerScript
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                                             | jsonPath                                            | node            |
      | ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json | $.SQLServerScan.configurations.nodeCondition        | HeadlessEDINode |
      | ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json | $.SQLServerReconcile.configurations.nodeCondition   | HeadlessEDINode |
      | ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json | $.SQLServerPostprocess.configurations.nodeCondition | HeadlessEDINode |
      | ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json | $.SQLServerImport.configurations.nodeCondition      | HeadlessEDINode |


  @ROC_SQLServerScript
  Scenario Outline: Set the Credentials and Datasources for SQLServerWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                      | bodyFile                                                                         | path                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/SQLServerCredentials                                | payloads/ida/SQLServerScriptWrapperPayloads/configs/credentials/credentials.json | $.SQLServerCredentials                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/RochadeCredentials                                  | payloads/ida/SQLServerScriptWrapperPayloads/configs/credentials/credentials.json | $.RochadeCredentials                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ROCSQLServerSADataSource/SQLServerScritDS             | payloads/ida/SQLServerScriptWrapperPayloads/configs/datasource/datasource.json   | $.SQLServerScanDS                     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusSQLServerDS                    | payloads/ida/SQLServerScriptWrapperPayloads/configs/datasource/datasource.json   | $.ediBusSQLServerDS                   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerScriptScan/SQLScanServerScript               | payloads/ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json    | $.SQLServerScan.configurations        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerScriptImport/SQLServerScriptImport           | payloads/ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json    | $.SQLServerImport.configurations      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerScriptPostprocess/SQLServerScriptPostprocess | payloads/ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json    | $.SQLServerPostprocess.configurations | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerScriptReconcile/SQLServerScriptReconcile     | payloads/ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json    | $.SQLServerReconcile.configurations   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBus/EDIBUS_SQLServer                               | payloads/ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json    | $.EDIBUSSQLServer                     | 204           |                  |          |


  @ROC_SQLServerScript
  Scenario Outline: Set and run the Plugins configurations for SQLServerScriptWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | bodyFile | path | response code | response message | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScriptScan/SQLScanServerScript               |          |      | 200           | IDLE             | $.[?(@.configurationName=='SQLScanServerScript')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScriptScan/SQLScanServerScript                |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScriptScan/SQLScanServerScript               |          |      | 200           | IDLE             | $.[?(@.configurationName=='SQLScanServerScript')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScriptImport/SQLServerScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='SQLServerScriptImport')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScriptImport/SQLServerScriptImport            |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScriptImport/SQLServerScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='SQLServerScriptImport')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScriptPostprocess/SQLServerScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='SQLServerScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScriptPostprocess/SQLServerScriptPostprocess  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScriptPostprocess/SQLServerScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='SQLServerScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScriptReconcile/SQLServerScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='SQLServerScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScriptReconcile/SQLServerScriptReconcile      |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScriptReconcile/SQLServerScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='SQLServerScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBUS_SQLServer                                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBUS_SQLServer')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBUS_SQLServer                                  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBUS_SQLServer                                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBUS_SQLServer')].status           |


  @ROC_SQLServerScript @TEST_MLPQA-19913 @REQ_MLP-33933 @TESTSET_MLPQA-19931 @MLPQA-19639
  Scenario: Verify the Logging Enhancements - Analysis logs for SQL Server Script Scan, Import, PostProcess, Reconcile
    Given Analysis log "rochade/SQLServerScriptScan/SQLScanServerScript%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                           | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                     | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:SQLServerScriptScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:SQLScanServerScript | ANALYSIS-0071 | SQLServerScriptScan | Plugin Version |
      | INFO | Plugin SQLServerScriptScan Start Time:2020-11-24 07:38:33.752, End Time:2020-11-24 07:39:50.714, Processed Count:0, Errors:0, Warnings:0                                                           | ANALYSIS-0072 | SQLServerScriptScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                     | ANALYSIS-0020 |                     |                |
    And Analysis log "rochade/SQLServerScriptImport/SQLServerScriptImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                               | logCode       | pluginName            | removableText  |
      | INFO | Plugin started                                                                                                                                                                                         | ANALYSIS-0019 |                       |                |
      | INFO | Plugin Name:SQLServerScriptImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:SQLServerScriptImport | ANALYSIS-0071 | SQLServerScriptImport | Plugin Version |
      | INFO | Plugin SQLServerScriptImport Start Time:2020-11-24 07:40:06.244, End Time:2020-11-24 07:40:50.591, Processed Count:0, Errors:0, Warnings:0                                                             | ANALYSIS-0072 | SQLServerScriptImport |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                         | ANALYSIS-0020 |                       |                |
    And Analysis log "rochade/SQLServerScriptPostprocess/SQLServerScriptPostprocess%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                         | logCode       | pluginName                 | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                   | ANALYSIS-0019 |                            |                |
      | INFO | Plugin Name:SQLServerScriptPostprocess, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:SQLServerScriptPostprocess | ANALYSIS-0071 | SQLServerScriptPostprocess | Plugin Version |
      | INFO | Plugin SQLServerScriptPostprocess Start Time:2021-01-18 11:39:10.947, End Time:2021-01-18 11:39:22.156, Processed Count:0, Errors:0, Warnings:1                                                                  | ANALYSIS-0072 | SQLServerScriptPostprocess |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                   | ANALYSIS-0020 |                            |                |
    And Analysis log "rochade/SQLServerScriptReconcile/SQLServerScriptReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                     | logCode       | pluginName               | removableText  |
      | INFO | Plugin started                                                                                                                                                                                               | ANALYSIS-0019 |                          |                |
      | INFO | Plugin Name:SQLServerScriptReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:SQLServerScriptReconcile | ANALYSIS-0071 | SQLServerScriptReconcile | Plugin Version |
      | INFO | Plugin SQLServerScriptReconcile Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                                | ANALYSIS-0072 | SQLServerScriptReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                               | ANALYSIS-0020 |                          |                |


  @ROC_SQLServerScript @TEST_MLPQA-19908 @TEST_MLPQA-19910 @TEST_MLPQA-19912 @REQ_MLP-33933 @TESTSET_MLPQA-19931 @MLPQA-19639 @webtest
  Scenario: Verify Technology tags for replicated items after running SQL Server Script related & EDIBus plugin
  Verify the Technology tags for Analysis item - Scan, Import, Post Processor, Reconcile
  Verify the availability of HTML file under analysis items for plugins

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SQL Server" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SQL Server" should get displayed for the column "rochade/SQLServerScriptScan/SQLScanServerScript%"
    And user performs "latest analysis click" in Item Results page for "rochade/SQLServerScriptScan/SQLScanServerScript%"
    Then user performs click and verify in new window
      | Table | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanSQLSrvrScript-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "SQL Server" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SQL Server" should get displayed for the column "rochade/SQLServerScriptImport/SQLServerScriptImport%"
    And user performs "latest analysis click" in Item Results page for "rochade/SQLServerScriptImport/SQLServerScriptImport%"
    Then user performs click and verify in new window
      | Table | value                             | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanSQLSrvr_Script-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "SQL Server" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SQL Server" should get displayed for the column "rochade/SQLServerScriptPostprocess/SQLServerScriptPostprocess%"
    And user performs "latest analysis click" in Item Results page for "rochade/SQLServerScriptPostprocess/SQLServerScriptPostprocess%"
    Then user performs click and verify in new window
      | Table | value                           | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanSQLSrvr_Script-PostLog.html | verify widget contains | No               |             |
    And user enters the search text "SQL Server" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SQL Server" should get displayed for the column "rochade/SQLServerScriptReconcile/SQLScriptReconcile%"
    And user enters the search text "bulk/EDIBus" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SQL Server" should get displayed for the column "bulk/EDIBus/EDISQLSCRIPT%"
    And user should be able logoff the IDC

  @ROC_SQLServerScript @TEST_MLPQA-19906 @REQ_MLP-33933 @TESTSET_MLPQA-19931 @MLPQA-19639 @webtest
  Scenario: Metadata verification for items collected after executing SQLServerScript plugins
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SQL Server" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Operation |
      | Service   |

  @ROC_SQLServerScript @TEST_MLPQA-19909 @REQ_MLP-33933 @TESTSET_MLPQA-19931 @MLPQA-19639 @webtest
  Scenario: Verify the breadcrumb hierarchy appears correctly after the plugin run
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SQL Server" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Operation |
      | Service   |
    And user enters the search text "SQL Server" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "SQLSCAN≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "SqlServerScripts≫Operation" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | SQLSCAN≫Operation          |
      | D:\≫Operation              |
      | SqlServerScripts≫Operation |
    And user should be able logoff the IDC


  @ROC_SQLServerScript
  Scenario Outline: user retrieves facets and respective counts of SQLServer wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                                       | response code | response message | filePath                                                            | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/SQLServerScriptWrapperPayloads/API/getFacetsCountRequest.json | 200           |                  | payloads/ida/SQLServerScriptWrapperPayloads/API/facetWiseCount.json |          |

  @ROC_SQLServerScript @TEST_MLPQA-19905 @REQ_MLP-33933 @TESTSET_MLPQA-19931 @MLPQA-19639
  Scenario: Verify SQL Server Script Rochade items are replicated to DD after running EDIBus plugin
    And user gets the items count from json
      | filePath                                                            | jsonPath                                           |
      | payloads/ida/SQLServerScriptWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Service')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_SYSTEM ) |
    And user gets the items count from json
      | filePath                                                            | jsonPath                                             |
      | payloads/ida/SQLServerScriptWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Operation')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TASK ) |

  @ROC_SQLServerScript @TEST_MLPQA-19904 @REQ_MLP-33933 @TESTSET_MLPQA-19931 @MLPQA-19639
  Scenario Outline: Verify all item types collected from SQL Server Script Rochade items are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | bodyFile                                                                      | path            | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/EDIBus/EDIBUS_SQLServer                            | payloads/ida/SQLServerScriptWrapperPayloads/configs/plugin/pluginconfigs.json | $.EDIBusCleanup | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBUS_SQLServer |                                                                               |                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBUS_SQLServer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBUS_SQLServer  |                                                                               |                 | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBUS_SQLServer |                                                                               |                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBUS_SQLServer')].status |

  @ROC_SQLServerScript
  Scenario Outline: PostConditions-Delete the Credentials, Data Sources and Cataloger, Collector, Parser, Lineage plugins Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                      | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScriptScan/SQLScanServerScript               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScriptImport/SQLServerScriptImport           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScriptPostprocess/SQLServerScriptPostprocess |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScriptReconcile/SQLServerScriptReconcile     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBUS_SQLServer                               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCSQLServerSADataSource/SQLServerScritDS             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusSQLServerDS                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SQLServerCredentials                                |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeCredentials                                  |      | 200           |                  |          |