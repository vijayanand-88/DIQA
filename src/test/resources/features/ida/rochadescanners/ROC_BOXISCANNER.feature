@MLPQA-19490
Feature: Verification of Rochade-DD wrapper plugins for BOXI DataSource
#Stories: @MLP-32296

  @pre-condition @ROC_BOXI
  Scenario: Pre: Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_BOXI
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                     | jsonPath                                     | node            |
      | ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXISCANNER.configurations.nodeCondition   | HeadlessEDINode |
      | ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXIEXTRACTOR.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXIIMPORT.configurations.nodeCondition    | HeadlessEDINode |
      | ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXIDBLINKER.configurations.nodeCondition  | HeadlessEDINode |
      | ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXILINKER.configurations.nodeCondition    | HeadlessEDINode |
      | ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXIRECONCILE.configurations.nodeCondition | HeadlessEDINode |


  @pre-condition @ROC_BOXI
  Scenario Outline: Configure Credentials, Data Source for BOXI wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                  | bodyFile                                             | path                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/BOXICredentials                 | payloads/ida/ROCBOXIPayloads/ROCBOXICredentials.json | $.BOXICredentials          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/BOXICredentials                 |                                                      |                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/BOXISACredentials               | payloads/ida/ROCBOXIPayloads/ROCBOXICredentials.json | $.BOXISACredentials        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/BOXISACredentials               |                                                      |                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/BOXIEXTRACTCredentials          | payloads/ida/ROCBOXIPayloads/ROCBOXICredentials.json | $.BOXIEXTRACTCredentials   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/BOXIEXTRACTCredentials          |                                                      |                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/BOXISARECONCredentials          | payloads/ida/ROCBOXIPayloads/ROCBOXICredentials.json | $.BOXISARECONCredentials   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/BOXISARECONCredentials          |                                                      |                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EDICredentials                  | payloads/ida/ROCBOXIPayloads/ROCBOXICredentials.json | $.EDICredentials           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EDICredentials                  |                                                      |                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCBoxiDataSource/BOXIDS          | payloads/ida/ROCBOXIPayloads/ROCBOXIDataSource.json  | $.ROCBOXIDataSource        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCBoxiDataSource/BOXIDS          |                                                      |                            | 200           | BOXIDS           |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCBoxiDataSource/BOXIDSExtract   | payloads/ida/ROCBOXIPayloads/ROCBOXIDataSource.json  | $.ROCBOXIExtractDataSource | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCBoxiDataSource/BOXIDSExtract   |                                                      |                            | 200           | BOXIDSExtract    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCBoxiSADataSource/BOXISADS      | payloads/ida/ROCBOXIPayloads/ROCBOXIDataSource.json  | $.ROCBOXISADataSource      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCBoxiSADataSource/BOXISADS      |                                                      |                            | 200           | BOXISADS         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCBoxiSADataSource/BOXISADSRecon | payloads/ida/ROCBOXIPayloads/ROCBOXIDataSource.json  | $.ROCBOXISAReconDataSource | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCBoxiSADataSource/BOXISADSRecon |                                                      |                            | 200           | BOXISADSRecon    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource/EDIBusDataSource | payloads/ida/ROCBOXIPayloads/ROCBOXIDataSource.json  | $.EDIBusDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource                  |                                                      |                            | 200           | EDIBusDataSource |          |

  @pre-condition @ROC_BOXI
  Scenario Outline: Configure plugins: BOXIScan, BOXIEXTRACTOR, BOXIIMPORT, BOXIDBLINKER, BOXILINKER, BOXIRECONCILE, EDIBUS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | bodyFile                                              | path                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/BoxiScan/BOXISCAN           | payloads/ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXISCANNER.configurations   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/BoxiScan/BOXISCAN           |                                                       |                                | 200           | BOXISCAN         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/BoxiExtractor/BOXIEXTRACTOR | payloads/ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXIEXTRACTOR.configurations | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/BoxiExtractor/BOXIEXTRACTOR |                                                       |                                | 200           | BOXIEXTRACTOR    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/BoxiImport/BOXIIMPORT       | payloads/ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXIIMPORT.configurations    | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/BoxiImport/BOXIIMPORT       |                                                       |                                | 200           | BOXIIMPORT       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/BoxiDBLinker/BOXIDBLINKER   | payloads/ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXIDBLINKER.configurations  | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/BoxiDBLinker/BOXIDBLINKER   |                                                       |                                | 200           | BOXIDBLINKER     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/BoxiLinker/BOXILINKER       | payloads/ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXILINKER.configurations    | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/BoxiLinker/BOXILINKER       |                                                       |                                | 200           | BOXILINKER       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/BoxiReconcile/BOXIRECONCILE | payloads/ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.BOXIRECONCILE.configurations | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/BoxiReconcile/BOXIRECONCILE |                                                       |                                | 200           | BOXIRECONCILE    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/BOXIEDIBUS           | payloads/ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.EDIBUS.configurations        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/BOXIEDIBUS           |                                                       |                                | 200           | BOXIEDIBUS       |          |


  @ROC_BOXI
  Scenario Outline: Run BOXIScan, BOXIEXTRACTOR, BOXIIMPORT, BOXIDBLINKER, BOXILINKER, BOXIRECONCILE, EDIBUS Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | bodyFile | path | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiScan/BOXISCAN           |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXISCAN')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/BoxiScan/BOXISCAN            |          |      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiScan/BOXISCAN           |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXISCAN')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiExtractor/BOXIEXTRACTOR |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIEXTRACTOR')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/BoxiExtractor/BOXIEXTRACTOR  |          |      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiExtractor/BOXIEXTRACTOR |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIEXTRACTOR')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiImport/BOXIIMPORT       |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIIMPORT')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/BoxiImport/BOXIIMPORT        |          |      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiImport/BOXIIMPORT       |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIIMPORT')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiDBLinker/BOXIDBLINKER   |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIDBLINKER')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/BoxiDBLinker/BOXIDBLINKER    |          |      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiDBLinker/BOXIDBLINKER   |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIDBLINKER')].status  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiLinker/BOXILINKER       |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXILINKER')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/BoxiLinker/BOXILINKER        |          |      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiLinker/BOXILINKER       |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXILINKER')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiReconcile/BOXIRECONCILE |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIRECONCILE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/BoxiReconcile/BOXIRECONCILE  |          |      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/BoxiReconcile/BOXIRECONCILE |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIRECONCILE')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/BOXIEDIBUS             |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIEDIBUS')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/BOXIEDIBUS              |          |      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/BOXIEDIBUS             |          |      | 200           | IDLE             | $.[?(@.configurationName=='BOXIEDIBUS')].status    |


  @ROC_BOXI @TEST_MLPQA-19413 @MLPQA-18085
  Scenario: Verify the Logging Enhancements - Analysis logs for BOXI Scan, BOXI Extractor, BOXI Import, BOXI DBLinker, BOXI Linker, BOXI Reconcile
    Given Analysis log "rochade/BoxiScan/BOXISCAN%" should display below info/error/warning
      | type | logValue                                                                                                                                                                     | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                               | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:BoxiScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:BOXISCAN | ANALYSIS-0071 | BoxiScan   | Plugin Version |
      | INFO | Plugin BoxiScan Start Time:2020-11-24 07:38:33.752, End Time:2020-11-24 07:39:50.714, Processed Count:0, Errors:0, Warnings:0                                                | ANALYSIS-0072 | BoxiScan   |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                               | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/BoxiExtractor/BOXIEXTRACTOR%" should display below info/error/warning
      | type | logValue                                                                                                                                                                               | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                         | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:BoxiExtractor, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:BOXIEXTRACTOR | ANALYSIS-0071 | BoxiExtractor | Plugin Version |
      | INFO | Plugin BoxiExtractor Start Time:2020-11-24 07:40:06.244, End Time:2020-11-24 07:40:50.591, Processed Count:0, Errors:0, Warnings:0                                                     | ANALYSIS-0072 | BoxiExtractor |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                         | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/BoxiImport/BOXIIMPORT%" should display below info/error/warning
      | type | logValue                                                                                                                                                                         | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                   | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:BoxiImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:BOXIIMPORT | ANALYSIS-0071 | BoxiImport | Plugin Version |
      | INFO | Plugin BoxiImport Start Time:2021-01-18 11:39:10.947, End Time:2021-01-18 11:39:22.156, Processed Count:0, Errors:0, Warnings:4                                                  | ANALYSIS-0072 | BOXIIMPORT |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                   | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/BoxiDBLinker/BOXIDBLINKER%" should display below info/error/warning
      | type | logValue                                                                                                                                                                             | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                       | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:BoxiDBLinker, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:BOXIDBLINKER | ANALYSIS-0071 | BoxiDBLinker | Plugin Version |
      | INFO | Plugin BoxiDBLinker Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                    | ANALYSIS-0072 | BoxiDBLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                       | ANALYSIS-0020 |              |                |
    And Analysis log "rochade/BoxiLinker/BOXILINKER%" should display below info/error/warning
      | type | logValue                                                                                                                                                                         | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                   | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:BoxiLinker, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:BOXILINKER | ANALYSIS-0071 | BoxiLinker | Plugin Version |
      | INFO | Plugin BoxiLinker Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                  | ANALYSIS-0072 | BoxiLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                   | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/BoxiReconcile/BOXIRECONCILE%" should display below info/error/warning
      | type | logValue                                                                                                                                                                               | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                         | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:BoxiReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:BOXIRECONCILE | ANALYSIS-0071 | BoxiReconcile | Plugin Version |
      | INFO | Plugin BoxiReconcile Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                     | ANALYSIS-0072 | BoxiReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                         | ANALYSIS-0020 |               |                |


  @webtest @ROC_BOXI @TEST_MLPQA-19419 @MLPQA-18085
  Scenario: Verify the availability of HTML file under analysis items for plugins: BOXI SCAN,BOXI EXTRACTOR,BOXI IMPORT,BOXI DBLINKER,BOXI LINKER,BOXI RECONCILE
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "BOXISCAN" and clicks on search
    And user performs "facet selection" in "Business Objects" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Business Objects" should get displayed for the column "rochade/BoxiScan/BOXISCAN%"
    And user performs "latest analysis click" in Item Results page for "rochade/BoxiScan/BOXISCAN%"
    Then user performs click and verify in new window
      | Table | value              | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | _ScanBOXI-log.html | verify widget contains | No               |             |
    And user enters the search text "BOXIDBLINKER" and clicks on search
    And user performs "facet selection" in "Business Objects" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Business Objects" should get displayed for the column "rochade/BoxiDBLinker/BOXIDBLINKER%"
    And user performs "latest analysis click" in Item Results page for "rochade/BoxiDBLinker/BOXIDBLINKER%"
    Then user performs click and verify in new window
      | Table | value                   | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | _boxi_dblinker-log.html | verify widget contains | No               |             |
    And user should be able logoff the IDC

  @ROC_BOXI
  Scenario Outline:  user retrieves facets and respective counts of BOXI wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                    | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCBOXIPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCBOXIPayloads/facetWiseCount.json |          |

  @ROC_BOXI @TEST_MLPQA-19418 @MLPQA-18085
  Scenario: Verify BOXI items are replicated to DD after running EDIBus plugin
    And user gets the items count from json
      | filePath                                         | jsonPath                                               |
      | payloads/ida/ROCBOXIPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='OlapPackage')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_OLAP_PACKAGE ) |
    And user gets the items count from json
      | filePath                                         | jsonPath                                              |
      | payloads/ida/ROCBOXIPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='OlapSchema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_OLAP_SCHEMA ) |
    And user gets the items count from json
      | filePath                                         | jsonPath                                                 |
      | payloads/ida/ROCBOXIPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='ReportPackage')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_PACKAGE ) |
    And user gets the items count from json
      | filePath                                         | jsonPath                                             |
      | payloads/ida/ROCBOXIPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Dimension')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_DIMENSION ) |
    And user gets the items count from json
      | filePath                                         | jsonPath                                           |
      | payloads/ida/ROCBOXIPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Measure')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_DIMENSION_MAP ) |

  @webtest @ROC_BOXI @TEST_MLPQA-19417 @MLPQA-18085
  Scenario: Verify the breadcrumb hierarchy appears correctly when BOXI items are replicated to DD after running EDIBus plugin.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Business Objects" and clicks on search
    And user performs "facet selection" in "Business Objects" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | ReportPackage |
      | Analysis      |
      | OlapSchema    |
      | OlapPackage   |
      | Dimension     |
      | Measure       |
    And user enters the search text "Business Objects" and clicks on search
    And user performs "facet selection" in "Business Objects" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "/UNIVERSES/IslandUnx [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Island Resorts Marketing.unx" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | didbbboxi42v.did.dev.asgint.loc |
      | /UNIVERSES/IslandUnx            |
      | Island Resorts Marketing.unx    |
    And user should be able logoff the IDC

  @ROC_BOXI @TEST_MLPQA-19416 @MLPQA-18085
  Scenario: Verify the Metadata for items after executing BOXI related plugins.And Verify the metadata properties of the item types via api call
  | widgetName  | filePath                                  | jsonPath                         | Action                    | query              | ClusterName                     | ServiceName | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
  | Description | ida/ROCBOXIPayloads/expectedMetadata.json | $.BOXIDefaultSystem.Description1 | metadataAttributePresence | ReportPackageQuery | didbbboxi42v.did.dev.asgint.loc |             |              |            |                    |                      |
  | Description | ida/ROCBOXIPayloads/expectedMetadata.json | $.BOXIDefaultSystem.Description2 | metadataValuePresence     | ReportPackageQuery | didbbboxi42v.did.dev.asgint.loc |             |              |            |                    |                      |


  @ROC_BOXI @TEST_MLPQA-19415 @MLPQA-18085
  Scenario: Verify the Technology tags for Analysis item for BOXI SCAN,BOXI EXTRACTOR,BOXI IMPORT,BOXI DBLINKER,BOXI LINKER,BOXI RECONCILE - ROC, BOXI SCANNER
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName | SchemaName | TableName/Filename | Column | Tags                 | Query              | Action      |
      | didbbboxi42v.did.dev.asgint.loc |             |              |            |                    |        | Business Objects,ROC | ReportPackageQuery | TagAssigned |

 ##################################################### Post Conditions #####################################################
  @post-condition @ROC_BOXI
  Scenario Outline: Configure EDIBus plugin to perform clean up
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                             | bodyFile                                              | path                           | response code | response message | jsonPath                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/BOXIEDIBUS                            | payloads/ida/ROCBOXIPayloads/ROCBOXIPluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/BOXIEDIBUS                            |                                                       |                                | 200           | BOXIEDIBUS       |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/BOXIEDIBUS |                                                       |                                | 200           | IDLE             | $.[?(@.configurationName=='BOXIEDIBUS')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/BOXIEDIBUS  |                                                       |                                | 200           |                  |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/BOXIEDIBUS |                                                       |                                | 200           | IDLE             | $.[?(@.configurationName=='BOXIEDIBUS')].status |

  @webtest @ROC_BOXI @TEST_MLPQA-19414 @MLPQA-18085
  Scenario: Verify all item types collected from BOXI Scanner are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Business Objects" and clicks on search
    And user performs "facet selection" in "Business Objects" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | ReportPackage |
      | Analysis      |
      | OlapSchema    |
      | OlapPackage   |
      | Dimension     |
      | Measure       |
    And user should be able logoff the IDC

  @post-condition @ROC_BOXI
  Scenario: PS_Clearing the EDI subject area after running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @post-condition @ROC_BOXI
  Scenario Outline:  Delete Credentials, Datasource and plugin config for BOXI SCAN,BOXI EXTRACTOR,BOXI IMPORT,BOXI DBLINKER,BOXI LINKER,BOXI RECONCILE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                  | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/BoxiScan/BOXISCAN                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/BoxiExtractor/BOXIEXTRACTOR       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/BoxiImport/BOXIIMPORT             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/BoxiDBLinker/BOXIDBLINKER         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/BoxiLinker/BOXILINKER             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/BoxiReconcile/BOXIRECONCILE       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/BOXIEDIBUS                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCBoxiDataSource/BOXIDS          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCBoxiSADataSource/BOXISADS      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCBoxiDataSource/BOXIDSExtract   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCBoxiSADataSource/BOXISADSRecon |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusDataSource |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/BOXICredentials                 |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/BOXISACredentials               |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/BOXIEXTRACTCredentials          |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/BOXISARECONCredentials          |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EDICredentials                  |          |      | 200           |                  |          |