@MLPQA-20005
Feature: Verification of Rochade-DD wrapper plugins for SSRS DataSource
#  Stories: @MLP-34025

  @pre-condition @ROC_MSSRS
  Scenario: Pre: Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @ROC_MSSRS
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                       | jsonPath                                           | node            |
      | ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSFileSystemScan.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSServerScan.configurations.nodeCondition     | HeadlessEDINode |
      | ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSImport.configurations.nodeCondition         | HeadlessEDINode |
      | ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSLink.configurations.nodeCondition           | HeadlessEDINode |
      | ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSReconcile.configurations.nodeCondition      | HeadlessEDINode |


  @pre-condition @ROC_MSSRS
  Scenario Outline: Configure Credentials, Data Source for SSRS wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                          | bodyFile                                               | path                   | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeMSSRSCredentials                 | payloads/ida/ROCMSSRSPayloads/RocMSSRSCredentials.json | $.MSSRSCredentials     | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeMSSRSCredentials                 |                                                        |                        | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeMSSRSSACredentials               | payloads/ida/ROCMSSRSPayloads/RocMSSRSCredentials.json | $.EDICredentials       | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeMSSRSSACredentials               |                                                        |                        | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCMSSRSSADataSource/ROCMSSRSSADataSource | payloads/ida/ROCMSSRSPayloads/RocMSSRSDataSource.json  | $.RocMSSRSSADataSource | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCMSSRSSADataSource/ROCMSSRSSADataSource |                                                        |                        | 200           | ROCMSSRSSADataSource |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCMSSRSDataSource/ROCMSSRSDataSource     | payloads/ida/ROCMSSRSPayloads/RocMSSRSDataSource.json  | $.RocMSSRSDataSource   | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCMSSRSDataSource/ROCMSSRSDataSource     |                                                        |                        | 200           | ROCMSSRSDataSource   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource/EDIBusMSSRSDS            | payloads/ida/ROCMSSRSPayloads/RocMSSRSDataSource.json  | $.EDIBusDataSource     | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource/EDIBusMSSRSDS            |                                                        |                        | 200           | EDIBusMSSRSDS        |          |


  @pre-condition @ROC_MSSRS
  Scenario Outline: Configure plugins: SSRSScan, SSRSImport, SSRSPostprocess, SSRSReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                               | bodyFile                                                | path                                 | response code | response message           | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan | payloads/ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSFileSystemScan.configurations | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan |                                                         |                                      | 200           | RochadeMSSRSFileSystemScan |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSRSServerScan/RochadeMSSRSServerScan         | payloads/ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSServerScan.configurations     | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSRSServerScan/RochadeMSSRSServerScan         |                                                         |                                      | 200           | RochadeMSSRSServerScan     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSRSImport/RochadeMSSRSImport                 | payloads/ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSImport.configurations         | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSRSImport/RochadeMSSRSImport                 |                                                         |                                      | 200           | RochadeMSSRSImport         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSRSLink/RochadeMSSRSLink                     | payloads/ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSLink.configurations           | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSRSLink/RochadeMSSRSLink                     |                                                         |                                      | 200           | RochadeMSSRSLink           |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSRSReconcile/RochadeMSSRSReconcile           | payloads/ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.MSSRSReconcile.configurations      | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSRSReconcile/RochadeMSSRSReconcile           |                                                         |                                      | 200           | RochadeMSSRSReconcile      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_MSSRS                            | payloads/ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.EDIBus.configurations              | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_MSSRS                            |                                                         |                                      | 200           | EDIBus_MSSRS               |          |


  #################################################### Plugin Run #####################################################
  @ROC_MSSRS
  Scenario Outline: Run SSRSImport, SSRSPostprocess, SSRSReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "10000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile | path | response code | response message | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSServerScan/RochadeMSSRSServerScan         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSServerScan')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSRSServerScan/RochadeMSSRSServerScan          |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSServerScan/RochadeMSSRSServerScan         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSServerScan')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSImport/RochadeMSSRSImport                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSImport')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSRSImport/RochadeMSSRSImport                  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSImport/RochadeMSSRSImport                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSImport')].status         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSFileSystemScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSFileSystemScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSImport/RochadeMSSRSImport                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSImport')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSRSImport/RochadeMSSRSImport                  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSImport/RochadeMSSRSImport                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSImport')].status         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSLink/RochadeMSSRSLink                     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSLink')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSRSLink/RochadeMSSRSLink                      |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSLink/RochadeMSSRSLink                     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSLink')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSReconcile/RochadeMSSRSReconcile           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSReconcile')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSRSReconcile/RochadeMSSRSReconcile            |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSRSReconcile/RochadeMSSRSReconcile           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSRSReconcile')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MSSRS                              |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MSSRS')].status               |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_MSSRS                               |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MSSRS                              |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MSSRS')].status               |


  ##################################################### Verifications #####################################################
  @ROC_MSSRS @TEST_MLPQA-19840 @MLPQA-19639
  Scenario: Verify the Logging Enhancements - Analysis logs for MSSRSServerScan, MSSRSFileSystemScan, MSSRSImport, MSSRSLink, MSSRSReconcile
    Given Analysis log "rochade/MSSRSServerScan/RochadeMSSRSServerScan/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                           | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                     | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:MSSRSServerScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSRSServerScan | ANALYSIS-0071 | MSSRSServerScan | Plugin Version |
      | INFO | Plugin MSSRSServerScan Start Time:2021-02-12 06:21:27.990, End Time:2021-02-12 06:21:40.370, Processed Count:0, Errors:0, Warnings:0                                                               | ANALYSIS-0072 | MSSRSServerScan |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                          | ANALYSIS-0020 |                 |                |
    Given Analysis log "rochade/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                   | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                             | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:MSSRSFileSystemScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSRSFileSystemScan | ANALYSIS-0071 | MSSRSFileSystemScan | Plugin Version |
      | INFO | ANALYSIS-0072: Plugin MSSRSFileSystemScan Start Time:2021-02-12 06:10:37.892, End Time:2021-02-12 06:10:38.298, Processed Count:0, Errors:0, Warnings:0                                                    | ANALYSIS-0072 | MSSRSFileSystemScan |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                  | ANALYSIS-0020 |                     |                |
    And Analysis log "rochade/MSSRSImport/RochadeMSSRSImport/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                   | logCode       | pluginName  | removableText  |
      | INFO | Plugin started                                                                                                                                                                             | ANALYSIS-0019 |             |                |
      | INFO | Plugin Name:MSSRSImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSRSImport | ANALYSIS-0071 | MSSRSImport | Plugin Version |
      | INFO | Plugin MSSRSImport Start Time:2021-02-11 09:05:08.993, End Time:2021-02-11 09:05:15.642, Processed Count:0, Errors:0, Warnings:0                                                           | ANALYSIS-0072 | MSSRSImport |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                  | ANALYSIS-0020 |             |                |
    And Analysis log "rochade/MSSRSLink/RochadeMSSRSLink/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                               | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                         | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:MSSRSLink, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSRSLink | ANALYSIS-0071 | MSSRSLink  | Plugin Version |
      | INFO | Plugin MSSRSLink Start Time:2021-02-12 06:11:21.570, End Time:2021-02-12 06:11:24.724, Processed Count:0, Errors:0, Warnings:0                                                         | ANALYSIS-0072 | MSSRSLink  |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                              | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/MSSRSReconcile/RochadeMSSRSReconcile/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                         | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                   | ANALYSIS-0019 |                |                |
      | INFO | Plugin Name:MSSRSReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSRSReconcile | ANALYSIS-0071 | MSSRSReconcile | Plugin Version |
      | INFO | Plugin MSSRSReconcile Start Time:2021-02-12 06:11:41.919, End Time:2021-02-12 06:11:47.469, Processed Count:0, Errors:0, Warnings:0                                                              | ANALYSIS-0072 | MSSRSReconcile |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                        | ANALYSIS-0020 |                |                |


  @webtest @ROC_MSSRS @TEST_MLPQA-19842 @MLPQA-19639
  Scenario: Verify the availability of HTML file under analysis items for plugins: MSSRSServerScan, MSSRSImport, MSSRSLink
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSRS" and clicks on search
    And user performs "facet selection" in "SSRS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSRS" should get displayed for the column "rochade/MSSRSServerScan/RochadeMSSRSServerScan/%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSRSServerScan/RochadeMSSRSServerScan/%"
    Then user performs click and verify in new window
      | Table | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSRS-ScanLog.log | verify widget contains | No               |             |
    And user enters the search text "SSRS" and clicks on search
    And user performs "facet selection" in "SSRS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSRS" should get displayed for the column "rochade/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan/%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan/%"
    Then user performs click and verify in new window
      | Table | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSRS-ScanLog.log | verify widget contains | No               |             |
    And user enters the search text "SSRS" and clicks on search
    And user performs "facet selection" in "SSRS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSRS" should get displayed for the column "rochade/MSSRSImport/RochadeMSSRSImport/%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSRSImport/RochadeMSSRSImport/%"
    Then user performs click and verify in new window
      | Table | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSRS-ImportLog.html | verify widget contains |                  |             |
    And user enters the search text "SSRS" and clicks on search
    And user performs "facet selection" in "SSRS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSRS" should get displayed for the column "rochade/MSSRSLink/RochadeMSSRSLink/%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSRSLink/RochadeMSSRSLink/%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSRS-DBLinkerLog.html | verify widget contains |                  |             |
    And user enters the search text "SSRS" and clicks on search
    And user performs "facet selection" in "SSRS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSRS" should get displayed for the column "rochade/MSSRSReconcile/RochadeMSSRSReconcile/%"
    And user should be able logoff the IDC


  @ROC_MSSRS
  Scenario Outline:  user retrieves facets and respective counts of SSRS wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                     | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCMSSRSPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCMSSRSPayloads/facetWiseCount.json |          |


  @ROC_MSSRS @TEST_MLPQA-19847 @MLPQA-19639
  Scenario: Verify MSSRS Rochade items are replicated to DD after running EDIBus plugin
    And user gets the items count from json
      | filePath                                          | jsonPath                                                 |
      | payloads/ida/ROCMSSRSPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='ReportPackage')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | METAAPPS    | PRODUCTION         | XNAME * *  ~/ @* AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_PACKAGE ) |
    And user gets the items count from json
      | filePath                                          | jsonPath                                                |
      | payloads/ida/ROCMSSRSPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='ReportSchema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_SCHEMA ) |
    And user gets the items count from json
      | filePath                                          | jsonPath                                          |
      | payloads/ida/ROCMSSRSPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Report')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_REPORT ) |
    And user gets the items count from json
      | filePath                                          | jsonPath                                             |
      | payloads/ida/ROCMSSRSPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='DataField')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_FIELD ) |


  @webtest @ROC_MSSRS @TEST_MLPQA-19843 @MLPQA-19639 @TEST_MLPQA-19844 @MLPQA-19639
  Scenario: 1. Verify the breadcrumb hierarchy appears correctly when MSSRSServerScan Rochade items are replicated to DD after running EDIBus plugin
  2. Verify the breadcrumb hierarchy appears correctly when MSSRSFileSystemScan Rochade items are replicated to DD after running EDIBus plugin.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSRS" and clicks on search
    And user performs "facet selection" in "SSRS" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis      |
      | DataField     |
      | ReportPackage |
      | DataType      |
      | Report        |
      | ReportSchema  |
    And user enters the search text "DataSet1.Name" and clicks on search
    And user performs "facet selection" in "DataField" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "DIQROCHADE01V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DataSet1.Name" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | DIQROCHADE01V     |
      | D:                |
      | MSSRS_TestScripts |
      | subfolder         |
      | Sample2016        |
      | DataSet1.Name     |
    And user enters the search text "DataSet1.Name" and clicks on search
    And user performs "facet selection" in "DataField" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "DIDROCHADE04V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DataSet1.Name" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | DIDROCHADE04V |
      | /             |
      | Sample2019    |
      | DataSet1.Name |
    And user should be able logoff the IDC


  @ROC_MSSRS @TEST_MLPQA-19846 @MLPQA-19639
  Scenario: Metadata verification for items collected after executing MSSRS plugins
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                   | jsonPath                          | Action                    | query              | ClusterName       | ServiceName | DatabaseName | SchemaName            | TableName/Filename | columnName/FieldName | specialCharacters |
      | Description | ida/ROCMSSRSPayloads/expectedMetadata.json | $.ReportPackageQuery.Description1 | metadataAttributePresence | ReportPackageQuery | DIQROCHADE01V     |             |              |                       |                    |                      |                   |
      | Description | ida/ROCMSSRSPayloads/expectedMetadata.json | $.ReportPackageQuery.Description2 | metadataValuePresence     | ReportPackageQuery | DIQROCHADE01V     |             |              |                       |                    |                      |                   |
      | Description | ida/ROCMSSRSPayloads/expectedMetadata.json | $.ReportSchemaQuery.Description1  | metadataAttributePresence | ReportSchemaQuery  | MSSRS_TestScripts | subfolder   |              |                       |                    |                      |                   |
      | Description | ida/ROCMSSRSPayloads/expectedMetadata.json | $.ReportSchemaQuery.Description2  | metadataValuePresence     | ReportSchemaQuery  | MSSRS_TestScripts | subfolder   |              |                       |                    |                      |                   |
      | Description | ida/ROCMSSRSPayloads/expectedMetadata.json | $.DataTypeQuery.Description1      | metadataAttributePresence | DataTypeQuery      | MSSRS_TestScripts | subfolder   | Sample2016   |                       |                    |                      |                   |
      | Description | ida/ROCMSSRSPayloads/expectedMetadata.json | $.DataTypeQuery.Description2      | metadataValuePresence     | DataTypeQuery      | MSSRS_TestScripts | subfolder   | Sample2016   |                       |                    |                      |                   |
      | Description | ida/ROCMSSRSPayloads/expectedMetadata.json | $.DataFieldQuery.Description1     | metadataAttributePresence | DataFieldQuery     | MSSRS_TestScripts | subfolder   | Sample2016   | DataSet1.DepartmentID |                    |                      |                   |
      | Statistics  | ida/ROCMSSRSPayloads/expectedMetadata.json | $.DataFieldQuery.Description2     | metadataAttributePresence | DataFieldQuery     | MSSRS_TestScripts | subfolder   | Sample2016   | DataSet1.DepartmentID |                    |                      |                   |
      | Statistics  | ida/ROCMSSRSPayloads/expectedMetadata.json | $.DataFieldQuery.Description3     | metadataValuePresence     | DataFieldQuery     | MSSRS_TestScripts | subfolder   | Sample2016   | DataSet1.DepartmentID |                    |                      |                   |
      | Description | ida/ROCMSSRSPayloads/expectedMetadata.json | $.ReportQuery.Description1        | metadataAttributePresence | ReportQuery        | MSSRS_TestScripts | subfolder   | Sample2016   |                       |                    |                      |                   |


  @ROC_MSSRS @TEST_MLPQA-19841 @MLPQA-19639    @TEST_MLPQA-19845 @MLPQA-19639
  Scenario: 1.  Verify the Technology tags for Analysis item for MSSRSServerScan, MSSRSFileSystemScan, MSSRSFileSystemScan, MSSRSImport, MSSRSLink, MSSRSReconcile
  2. Verify Technology tags for replicated items after running MSSRS related & EDIBus plugin
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName       | ServiceName | DatabaseName | SchemaName            | TableName/Filename                                       | Column | Tags     | Query              | Action      |
      | DIQROCHADE01V     |             |              |                       |                                                          |        | SSRS,ROC | ReportPackageQuery | TagAssigned |
      | MSSRS_TestScripts | subfolder   |              |                       |                                                          |        | SSRS,ROC | ReportSchemaQuery  | TagAssigned |
      | MSSRS_TestScripts | subfolder   | Sample2016   |                       |                                                          |        | SSRS,ROC | DataTypeQuery      | TagAssigned |
      | MSSRS_TestScripts | subfolder   | Sample2016   | DataSet1.DepartmentID |                                                          |        | SSRS,ROC | DataFieldQuery     | TagAssigned |
      | MSSRS_TestScripts | subfolder   | Sample2016   |                       |                                                          |        | SSRS,ROC | ReportQuery        | TagAssigned |
      |                   |             |              |                       | rochade/MSSRSServerScan/RochadeMSSRSServerScan/%         |        | SSRS,ROC | AnalysisQuery      | TagAssigned |
      |                   |             |              |                       | rochade/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan/% |        | SSRS,ROC | AnalysisQuery      | TagAssigned |
      |                   |             |              |                       | rochade/MSSRSImport/RochadeMSSRSImport/%                 |        | SSRS,ROC | AnalysisQuery      | TagAssigned |
      |                   |             |              |                       | rochade/MSSRSLink/RochadeMSSRSLink%                      |        | SSRS,ROC | AnalysisQuery      | TagAssigned |
      |                   |             |              |                       | rochade/MSSRSReconcile/RochadeMSSRSReconcile%            |        | SSRS,ROC | AnalysisQuery      | TagAssigned |
      |                   |             |              |                       | bulk/EDIBus/EDIBus_MSSRS/%                               |        | SSRS,ROC | AnalysisQuery      | TagAssigned |

  ##################################################### Post Conditions #####################################################
  @post-condition @ROC_MSSRS
  Scenario Outline: Configure EDIBus plugin to perform clean up
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | bodyFile                                                | path                           | response code | response message | jsonPath                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_MSSRS                            | payloads/ida/ROCMSSRSPayloads/RocMSSRSPluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_MSSRS                            |                                                         |                                | 200           | EDIBus_MSSRS     |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MSSRS |                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MSSRS')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_MSSRS  |                                                         |                                | 200           |                  |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MSSRS |                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MSSRS')].status |


  @webtest @post-condition @ROC_MSSRS @TEST_MLPQA-19848 @MLPQA-19639
  Scenario: Verify all item types collected from MSSRS Rochade items are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSRS" and clicks on search
    And user performs "facet selection" in "SSRS" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | DataField     |
      | ReportPackage |
      | DataType      |
      | Report        |
      | ReportSchema  |
    And user should be able logoff the IDC


  @post-condition @ROC_MSSRS
  Scenario: PS_Clearing the EDI subject area after running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @post-condition @ROC_MSSRS
  Scenario:  Delete the analysis items for plugins: SSRSScan, SSRSImport, SSRSPostprocess, SSRSReconcile, EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                          | type     | query | param |
      | MultipleIDDelete | Default | rochade/MSSRSServerScan/%     | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/MSSRSFileSystemScan/% | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/MSSRSImport/%         | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/MSSRSLink/%           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/MSSRSReconcile/%      | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_MSSRS%     | Analysis |       |       |
      | MultipleIDDelete | Default | datasource/ROCMSSRS%          | Analysis |       |       |


  @post-condition @ROC_MSSRS
  Scenario Outline:  Delete Credentials, Datasource and plugin config for SSRSScan, SSRSImport, SSRSPostprocess, SSRSReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                               | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSRSServerScan/RochadeMSSRSServerScan         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSRSFileSystemScan/RochadeMSSRSFileSystemScan |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSRSImport/RochadeMSSRSImport                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSRSLink/RochadeMSSRSLink                     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSRSReconcile/RochadeMSSRSReconcile           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_MSSRS                            |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCMSSRSDataSource                             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCMSSRSSADataSource                           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusMSSRSDS                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeMSSRSCredentials                      |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeMSSRSSACredentials                    |          |      | 200           |                  |          |
