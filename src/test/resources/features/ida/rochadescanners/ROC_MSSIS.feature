@MLPQA-19877
@REQ_MLP-30513
Feature: SSIS Rochade Wrapper Plugin
#Stories: @MLP-32547

  @ROC_MSSIS
  Scenario:Precondions Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_MSSIS
  Scenario:PreCondition Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                               | jsonPath                                      | node            |
      | ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.FileSystemScan.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.MSSISScan.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.MSSISReconcile.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.MSSISLINK.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.MSSISImport.configurations.nodeCondition    | HeadlessEDINode |

  @ROC_MSSIS
  Scenario Outline: Set the Credentials and Datasources for MSSISWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                        | bodyFile                                                        | path                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/MSSISServerCredentials                | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISCredentials.json  | $.MSSISCredentials              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDICredentials                        | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISCredentials.json  | $.EDICredentials                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ROCMSSISDataSource/MSSISDataSource      | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISDataSource.json   | $.MSSISDataSource               | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ROCMSSISSADataSource/MSSISSADataSource  | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISDataSource.json   | $.MSSISSADataSource             | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDataSource       | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISDataSource.json   | $.EDIBusDataSource              | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/MSSISFileSystemScan/MSSISFileSystemScan | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.FileSystemScan.configurations | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/MSSISServerScan/MSSISServerScan         | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.MSSISScan.configurations      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/MSSISImport/MSSISImport                 | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.MSSISImport.configurations    | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/MSSISLink/MSSISLink                     | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.MSSISLINK.configurations      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/MSSISReconcile/MSSISReconcile           | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.MSSISReconcile.configurations | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBus/MSSISEDIBus                      | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.EDIBUS                        | 204           |                  |          |


  @ROC_MSSIS @TEST_MLPQA-18264 @TEST_MLPQA-18265 @TEST_MLPQA-18266 @TEST_MLPQA-18258 @TEST_MLPQA-18271 @TEST_MLPQA-18269 @REQ_MLP-32547 @TESTSET_MLPQA-19902 @MLPQA-19639
  Scenario Outline: Verify MSSISFilesystemScan executed without any issue after adding necessary configuration input
  Verify MSSISImport executed without any issue after adding necessary configuration input
  Verify MSSISLink executed without any issue after adding necessary configuration input
  Verify MSSISReconcile executed without any issue after adding necessary configuration input
  Verify Data collected without any issues when scan source type is set to "Reports and shared data sources from file"
  Verify Data collected without any issues when scan source type is set to "Reports and shared data sources from MSSIS Server"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile | path | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISServerScan/MSSISServerScan         |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISServerScan')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSISServerScan/MSSISServerScan          |          |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISServerScan/MSSISServerScan         |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISServerScan')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISImport/MSSISImport                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISImport')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSISImport/MSSISImport                  |          |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISImport/MSSISImport                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISImport')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISLink/MSSISLink                     |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISLink')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSISLink/MSSISLink                      |          |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISLink/MSSISLink                     |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISLink')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISReconcile/MSSISReconcile           |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISReconcile')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSISReconcile/MSSISReconcile            |          |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISReconcile/MSSISReconcile           |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISReconcile')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSISEDIBus                        |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISEDIBus')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSISEDIBus                         |          |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSISEDIBus                        |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISEDIBus')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISFileSystemScan/MSSISFileSystemScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISFileSystemScan')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSISFileSystemScan/MSSISFileSystemScan  |          |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSISFileSystemScan/MSSISFileSystemScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSISFileSystemScan')].status |


  @ROC_MSSIS @TEST_MLPQA-19884 @TEST_MLPQA-18268 @REQ_MLP-32547 @TESTSET_MLPQA-19902 @MLPQA-19639
  Scenario: Verify the Logging Enhancements - Analysis logs for MSSISServerScan, MSSISFileSystemScan, MSSISImport, MSSISLink, MSSISReconcile
  Verify Logs are updated properly for MSSIS Plugins
    Given Analysis log "rochade/MSSISServerScan/MSSISServerScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                   | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                             | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:MSSISSERVERSCAN, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:diqserver05v.diq.qa.asgint.loc, Plugin Configuration name:MSSISSERVERSCAN | ANALYSIS-0071 | MSSISSERVERSCAN | Plugin Version |
      | INFO | Plugin MSSISServerScan Start Time:2020-11-24 07:38:33.752, End Time:2020-11-24 07:39:50.714,Processed Count:0, Errors:0, Warnings:0                                                        | ANALYSIS-0072 | MSSISSERVERSCAN |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                             | ANALYSIS-0020 |                 |                |
    And Analysis log "rochade/MSSISFileSystemScan/MSSISFileSystemScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                           | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                     | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:MSSISFileSystemScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:diqserver05v.diq.qa.asgint.loc, Plugin Configuration name:MSSISFileSystemScan | ANALYSIS-0071 | MSSISFileSystemScan | Plugin Version |
      | INFO | Plugin MSSISFileSystemScan Start Time:2020-11-24 07:40:06.244, End Time:2020-11-24 07:40:50.591,Processed Count:0, Errors:0, Warnings:0                                                            | ANALYSIS-0072 | MSSISFileSystemScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                     | ANALYSIS-0020 |                     |                |
    And Analysis log "rochade/MSSISImport/MSSISImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                           | logCode       | pluginName  | removableText  |
      | INFO | Plugin started                                                                                                                                                                     | ANALYSIS-0019 |             |                |
      | INFO | Plugin Name:MSSISImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:diqserver05v.diq.qa.asgint.loc, Plugin Configuration name:MSSISImport | ANALYSIS-0071 | MSSISImport | Plugin Version |
      | INFO | Plugin MSSISImport Start Time:2020-11-24 07:40:06.244, End Time:2020-11-24 07:40:50.591,Processed Count:0, Errors:0, Warnings:0                                                    | ANALYSIS-0072 | MSSISImport |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                     | ANALYSIS-0020 |             |                |
    And Analysis log "rochade/MSSISLink/MSSISLink%" should display below info/error/warning
      | type | logValue                                                                                                                                                                       | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                 | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:MSSISLink, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:diqserver05v.diq.qa.asgint.loc, Plugin Configuration name:MSSISLink | ANALYSIS-0071 | MSSISLink  | Plugin Version |
      | INFO | Plugin MSSISLink Start Time:2021-01-18 11:39:10.947, End Time:2021-01-18 11:39:22.156,Processed Count:0, Errors:0, Warnings:0                                                  | ANALYSIS-0072 | MSSISLink  |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                 | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/MSSISReconcile/MSSISReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                             | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                       | ANALYSIS-0019 |                |                |
      | INFO | Plugin Name:MSSISReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:diqserver05v.diq.qa.asgint.loc, Plugin Configuration name:MSSISRECON | ANALYSIS-0071 | MSSISReconcile | Plugin Version |
      | INFO | Plugin MSSISReconcile Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274,Processed Count:0, Errors:0, Warnings:0                                                   | ANALYSIS-0072 | MSSISReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                       | ANALYSIS-0020 |                |                |


  @ROC_MSSIS @webtest @TEST_MLPQA-19882 @TEST_MLPQA-19883 @TEST_MLPQA-19880 @TEST_MLPQA-19879 @REQ_MLP-32547 @TESTSET_MLPQA-19902 @MLPQA-19639
  Scenario: Verify the availability of HTML file under analysis items for plugins
  Verify the availability of HTML file under analysis items for plugins: MSSISServerScan, MSSISImport, MSSISLink
  Verify Technology tags for replicated items after running MSSIS related & EDIBus plugin
  Verify the Technology tags for Analysis item for MSSISServerScan, MSSISFileSystemScan, MSSISFileSystemScan, MSSISImport, MSSISLink, MSSISReconcile
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ServerScan" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSIS" should get displayed for the column "rochade/MSSISServerScan/MSSISServerScan%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSISServerScan/MSSISServerScan%"
    Then user performs click and verify in new window
      | Table | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSIS-ScanLog.log | verify widget contains | No               |             |
    And user enters the search text "FileSystemScan" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSIS" should get displayed for the column "rochade/MSSISFileSystemScan/MSSISFileSystemScan%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSISFileSystemScan/MSSISFileSystemScan%"
    Then user performs click and verify in new window
      | Table | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSIS-ScanLog.log | verify widget contains | No               |             |
    And user enters the search text "MSSISImport" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSIS" should get displayed for the column "rochade/MSSISImport/MSSISImport%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSISImport/MSSISImport%"
    Then user performs click and verify in new window
      | Table | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSIS-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "MSSISLink" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSIS" should get displayed for the column "rochade/MSSISLink/MSSISLink%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSISLink/MSSISLink%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSIS-DBLinkerLog.html | verify widget contains | No               |             |
    And user enters the search text "MSSISReconcile" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSIS" should get displayed for the column "rochade/MSSISReconcile/MSSISReconcile%"
    And user enters the search text "bulk/EDIBus/MSSISEDIBus" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSIS" should get displayed for the column "bulk/EDIBus/MSSISEDIBus%"
    And user should be able logoff the IDC

  @ROC_MSSIS @webtest @TEST_MLPQA-18270 @REQ_MLP-32547 @TESTSET_MLPQA-19902 @MLPQA-19639
  Scenario: Metadata verification for items collected after executing MSSIS plugins
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSIS" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Operation |
      | Service   |


  @ROC_MSSIS @webtest @TEST_MLPQA-19881 @REQ_MLP-32547 @TESTSET_MLPQA-19902 @MLPQA-19639
  Scenario: Verify the breadcrumb hierarchy appears correctly for the data
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSIS" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Operation |
      | Service   |
    And user enters the search text "QueryActivityCollect≫Operation" and clicks on search
    And user performs "facet selection" in "SSIS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "DIDSQLSCN01V≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "QueryActivityCollect≫Operation" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | DIDSQLSCN01V≫Operation         |
      | MSDB≫Operation                 |
      | Data Collector≫Operation       |
      | QueryActivityCollect≫Operation |
    And user should be able logoff the IDC

  @ROC_MSSIS
  Scenario Outline: user retrieves facets and respective counts of SQLServer wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                             | response code | response message | filePath                                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCMSSSISWrapperPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCMSSSISWrapperPayloads/facetWiseCount.json |          |


  @ROC_MSSIS @TEST_MLPQA-18267 @REQ_MLP-32547 @TESTSET_MLPQA-19902 @MLPQA-19639
  Scenario: Verify EDIBus executed without any issue  and data transferred from Metability to Data Discovery after adding necessary configuration input
    And user gets the items count from json
      | filePath                                                  | jsonPath                                           |
      | payloads/ida/ROCMSSSISWrapperPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Service')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_SYSTEM ) |

  @ROC_MSSIS @TEST_MLPQA-19878 @REQ_MLP-32547 @TESTSET_MLPQA-19902 @MLPQA-19639
  Scenario Outline: Verify all item types collected from MSSIS Rochade items are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                              | bodyFile                                                        | path            | response code | response message | jsonPath                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/EDIBus/MSSISEDIBus                            | payloads/ida/ROCMSSSISWrapperPayloads/ROCMSSISPluginConfig.json | $.EDIBusCleanup | 204           |                  |                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSISEDIBus |                                                                 |                 | 200           | IDLE             | $.[?(@.configurationName=='MSSISEDIBus')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSISEDIBus  |                                                                 |                 | 200           |                  |                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSISEDIBus |                                                                 |                 | 200           | IDLE             | $.[?(@.configurationName=='MSSISEDIBus')].status |

  @ROC_MSSIS
  Scenario Outline: PostConditions-Delete the Credentials, Data Sources and Cataloger, Collector, Parser, Lineage plugins Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                        | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSISServerScan/MSSISServerScan         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSISFileSystemScan/MSSISFileSystemScan |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSISImport/MSSISImport                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSISLink/MSSISLink                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSISReconcile/MSSISReconcile           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/MSSISEDIBus                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCMSSISDataSource/MSSISDataSource      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCMSSISSADataSource/MSSISSADataSource  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusDataSource       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/MSSISServerCredentials                |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EDICredentials                        |      | 200           |                  |          |
