@MLPQA-19443
Feature: Verification of Rochade-DD wrapper plugins for UDB DB such as UDBScan, UDBImport, UDBPostprocess, UDBReconcile
#  Stories: @MLP-33342

  @pre-condition @ROC_UDBScript
  Scenario: Pre: Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @pre-condition @ROC_UDBScript
  Scenario: Headless EDI Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                         | jsonPath                                            | node            |
      | ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScan.configurations.nodeCondition              | HeadlessEDINode |
      | ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBImport.configurations.nodeCondition            | HeadlessEDINode |
      | ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBPostprocess.configurations.nodeCondition       | HeadlessEDINode |
      | ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBReconcile.configurations.nodeCondition         | HeadlessEDINode |
      | ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScriptScan.configurations.nodeCondition        | HeadlessEDINode |
      | ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScriptImport.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScriptPostprocess.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScriptReconcile.configurations.nodeCondition   | HeadlessEDINode |

  @pre-condition @ROC_UDBScript
  Scenario Outline: Configure Credentials, Data Source for UDB wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | bodyFile                                                 | path                 | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeUDBScanCredentials | payloads/ida/ROCUDBScriptPayloads/RocUDBCredentials.json | $.UDBCredentials     | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeUDBScanCredentials |                                                          |                      | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeUDBSACredentials   | payloads/ida/ROCUDBScriptPayloads/RocUDBCredentials.json | $.EDICredentials     | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeUDBSACredentials   |                                                          |                      | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCUDBDataSource            | payloads/ida/ROCUDBScriptPayloads/RocUDBDataSource.json  | $.ROCUDBDataSource   | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCUDBDataSource            |                                                          |                      | 200           | RochadeUDBScanDS   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCUDBSADataSource          | payloads/ida/ROCUDBScriptPayloads/RocUDBDataSource.json  | $.ROCUDBSADataSource | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCUDBSADataSource          |                                                          |                      | 200           | RochadeUDBImportDS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource            | payloads/ida/ROCUDBScriptPayloads/RocUDBDataSource.json  | $.EDIBusDataSource   | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource            |                                                          |                      | 200           | EDIBusUDBDS        |          |

  @pre-condition @ROC_UDBScript
  Scenario Outline: Configure plugins: UDBScan, UDBImport, UDBPostprocess, UDBReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                                  | path                            | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBScan/RochadeUDBScan               | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScan.configurations        | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBScan/RochadeUDBScan               |                                                           |                                 | 200           | RochadeUDBScan        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBImport/RochadeUDBImport           | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBImport.configurations      | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBImport/RochadeUDBImport           |                                                           |                                 | 200           | RochadeUDBImport      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBPostprocess/RochadeUDBPostprocess | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBPostprocess.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBPostprocess/RochadeUDBPostprocess |                                                           |                                 | 200           | RochadeUDBPostprocess |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBReconcile/RochadeUDBReconcile     | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBReconcile.configurations   | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBReconcile/RochadeUDBReconcile     |                                                           |                                 | 200           | RochadeUDBReconcile   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_UDB                    | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.EDIBus.configurations         | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_UDB                    |                                                           |                                 | 200           | EDIBus_UDB            |          |

  @pre-condition @ROC_UDBScript
  Scenario Outline: Configure plugins: UDBScirptScan, UDBScriptImport, UDBScriptstprocess, UDBScriptReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                 | bodyFile                                                  | path                                  | response code | response message            | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBScriptScan/RochadeUDBScriptScan               | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScriptScan.configurations        | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBScriptScan/RochadeUDBScriptScan               |                                                           |                                       | 200           | RochadeUDBScriptScan        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBScriptImport/RochadeUDBScriptImport           | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScriptImport.configurations      | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBScriptImport/RochadeUDBScriptImport           |                                                           |                                       | 200           | RochadeUDBScriptImport      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBScriptPostprocess/RochadeUDBScriptPostprocess | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScriptPostprocess.configurations | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBScriptPostprocess/RochadeUDBScriptPostprocess |                                                           |                                       | 200           | RochadeUDBScriptPostprocess |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBScriptReconcile/RochadeUDBScriptReconcile     | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.UDBScriptReconcile.configurations   | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBScriptReconcile/RochadeUDBScriptReconcile     |                                                           |                                       | 200           | RochadeUDBScriptReconcile   |          |


  #################################################### Plugin Run #####################################################

  @ROC_UDBScript
  Scenario Outline: Run UDBScan Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "60000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | bodyFile | path | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScan/RochadeUDBScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScan/RochadeUDBScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBScan/RochadeUDBScan  |          |      | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScan/RochadeUDBScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScan')].status |

  @ROC_UDBScript
  Scenario Outline: Run UDBScan, UDBImport, UDBPostprocess, UDBReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | bodyFile | path | response code | response message | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScan/RochadeUDBScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScan/RochadeUDBScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBImport/RochadeUDBImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBImport/RochadeUDBImport            |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBImport/RochadeUDBImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBImport/RochadeUDBImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBPostprocess/RochadeUDBPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBPostprocess/RochadeUDBPostprocess  |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBPostprocess/RochadeUDBPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBPostprocess/RochadeUDBPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBReconcile/RochadeUDBReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBReconcile/RochadeUDBReconcile      |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBReconcile/RochadeUDBReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBReconcile/RochadeUDBReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBReconcile')].status   |

  @ROC_UDBScriptScript
  Scenario Outline: Run UDBScriptScan Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "60000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | bodyFile | path | response code | response message | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptScan/RochadeUDBScriptScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBScriptScan/RochadeUDBScriptScan  |          |      | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptScan/RochadeUDBScriptScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptScan/RochadeUDBScriptScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptScan')].status |

  @ROC_UDBScriptScript
  Scenario Outline: Run UDBScriptScan, UDBScriptImport, UDBScriptPostprocess, UDBScriptReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | bodyFile | path | response code | response message | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptScan/RochadeUDBScriptScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptScan/RochadeUDBScriptScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptScan/RochadeUDBScriptScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptImport/RochadeUDBScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBScriptImport/RochadeUDBScriptImport            |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptImport/RochadeUDBScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptImport/RochadeUDBScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptPostprocess/RochadeUDBScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBScriptPostprocess/RochadeUDBScriptPostprocess  |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptPostprocess/RochadeUDBScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptPostprocess/RochadeUDBScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptReconcile/RochadeUDBScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBScriptReconcile/RochadeUDBScriptReconcile      |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptReconcile/RochadeUDBScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScriptReconcile/RochadeUDBScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_UDB                                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_UDB')].status                  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_UDB                                  |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_UDB                                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_UDB')].status                  |


  @ROC_UDBScript
  Scenario Outline: Sync Solr
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | searches/fulltext/synchronize/Default |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post   | searches/fulltext/synchronize/Default |          |      | 200           |                  |          |


  ##################################################### Verifications #####################################################
  @ROC_UDBScript @TEST_MLPQA-19437 @MLPQA-18085
  Scenario: Verify the Logging Enhancements - Analysis logs for UDBScriptScan UDBScriptImport, UDBScriptLink, UDBScriptReconcile plugins
    Given Analysis log "rochade/UDBScriptScan/RochadeUDBScriptScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                       | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                 | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:UDBScriptScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeUDBScriptScan | ANALYSIS-0071 | UDBScriptScan | Plugin Version |
      | INFO | Plugin UDBScriptScan Start Time:2020-11-24 07:38:33.752, End Time:2020-11-24 07:39:50.714, Processed Count:0, Errors:0, Warnings:0                                                             | ANALYSIS-0072 | UDBScriptScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                 | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/UDBScriptImport/RochadeUDBScriptImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                           | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                     | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:UDBScriptImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeUDBScriptImport | ANALYSIS-0071 | UDBScriptImport | Plugin Version |
      | INFO | Plugin UDBScriptImport Start Time:2020-11-24 07:40:06.244, End Time:2020-11-24 07:40:50.591, Processed Count:0, Errors:0, Warnings:0                                                               | ANALYSIS-0072 | UDBScriptImport |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                     | ANALYSIS-0020 |                 |                |
    And Analysis log "rochade/UDBScriptPostprocess/RochadeUDBScriptPostprocess%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                     | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                                               | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:UDBScriptPostprocess, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeUDBScriptPostprocess | ANALYSIS-0071 | UDBScriptPostprocess | Plugin Version |
      | INFO | Plugin UDBScriptPostprocess Start Time:2020-11-24 07:41:08.602, End Time:2020-11-24 07:44:22.364, Processed Count:0, Errors:0, Warnings:0                                                                    | ANALYSIS-0072 | UDBScriptPostprocess |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                               | ANALYSIS-0020 |                      |                |
    And Analysis log "rochade/UDBScriptReconcile/RochadeUDBScriptReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                 | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                                           | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:UDBScriptReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeUDBScriptReconcile | ANALYSIS-0071 | UDBScriptReconcile | Plugin Version |
      | INFO | Plugin UDBScriptReconcile Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                                  | ANALYSIS-0072 | UDBScriptReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                           | ANALYSIS-0020 |                    |                |

  @webtest @ROC_UDBScript @TEST_MLPQA-19435 @MLPQA-18085
  Scenario: Verify the availability of HTML file under analysis items for plugins: UDBScriptScan, UDBScriptImport, UDBScriptPostprocess
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/UDBScriptScan/RochadeUDBScriptScan/%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | UDBScript-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/UDBScriptImport/RochadeUDBScriptImport%"
    Then user performs click and verify in new window
      | Table | value                    | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | UDBScript-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/UDBScriptPostprocess/RochadeUDBScriptPostprocess%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | UDBScript-PostLog.html | verify widget contains |                  |             |
    And user should be able logoff the IDC

  @ROC_UDBScript
  Scenario Outline:  user retrieves facets and respective counts of UDB wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                         | response code | response message | filePath                                              | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCUDBScriptPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCUDBScriptPayloads/facetWiseCount.json |          |

  @ROC_UDBScript @TEST_MLPQA-19434 @MLPQA-18085
  Scenario: Verify the UDBScritp items in EDI matched with items in DD UI
    And user gets the items count from json
      | filePath                                              | jsonPath                                          |
      | payloads/ida/ROCUDBScriptPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Schema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_SCHEMA ) |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = UDB/SQL-SCRIPT ) | 5         |

  @webtest @ROC_UDBScript @TEST_MLPQA-19433 @MLPQA-18085
  Scenario: Verify the breadcrumb hierarchy appears correctly when UDBScript Rochade items are replicated to DD after running EDIBus plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Operation  |
      | Routine    |
      | Trigger    |
      | Schema     |
      | Database   |
      | Constraint |
      | Analysis   |
      | Service    |
    And user enters the search text "basecityview_sql.sql" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "basecityview_sql.sql" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | comp1≫Operation              |
      | D:\≫Operation                |
      | UDBSQL_TestScripts≫Operation |
      | basecityview_sql.sql         |
    And user should be able logoff the IDC

  @ROC_UDBScript @TEST_MLPQA-19432 @MLPQA-18085 @TEST_MLPQA-19436 @MLPQA-18085
  Scenario: Verify Technology tags for replicated items after running UDBScript related & EDIBus plugin
  2. Verify the Technology tags for Analysis item for UDBScriptScan, UDBScriptImport, UDBScriptLink, UDBScriptReconcile plugins
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName | SchemaName | TableName/Filename                                        | Column | Tags    | Query         | Action      |
      |             |             |              |            | rochade/UDBScriptScan/RochadeUDBScriptScan%               |        | DB2,ROC | AnalysisQuery | TagAssigned |
      |             |             |              |            | rochade/UDBScriptImport/RochadeUDBScriptImport%           |        | DB2,ROC | AnalysisQuery | TagAssigned |
      |             |             |              |            | rochade/UDBScriptPostprocess/RochadeUDBScriptPostprocess% |        | DB2,ROC | AnalysisQuery | TagAssigned |
      |             |             |              |            | rochade/UDBScriptReconcile/RochadeUDBScriptReconcile%     |        | DB2,ROC | AnalysisQuery | TagAssigned |
      |             |             |              |            | bulk/EDIBus/EDIBus_UDB%                                   |        | DB2,ROC | AnalysisQuery | TagAssigned |
      |             |             |              |            | basecityview_sql.sql                                      |        | DB2,ROC | AnalysisQuery | TagAssigned |
      |             |             |              |            | comp1≫Operation                                           |        | DB2,ROC | AnalysisQuery | TagAssigned |

  #################################################### Post Conditions #####################################################
  @post-condition @ROC_UDBScript
  Scenario Outline: Configure EDIBus plugin to perform clean up
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                             | bodyFile                                                  | path                           | response code | response message | jsonPath                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_UDB                            | payloads/ida/ROCUDBScriptPayloads/RocUDBPluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_UDB                            |                                                           |                                | 200           | EDIBus_UDB       |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_UDB |                                                           |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_UDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_UDB  |                                                           |                                | 200           |                  |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_UDB |                                                           |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_UDB')].status |

  @webtest @post-condition @ROC_UDBScript @TEST_MLPQA-19442 @MLPQA-18085
  Scenario: Verify all item types collected from UDBScript Rochade are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Routine    |
      | Schema     |
      | Database   |
      | Constraint |
      | Service    |
    And user should be able logoff the IDC

  @post-condition @ROC_UDBScript
  Scenario: PS_Clearing the EDI subject area after running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @post-condition @ROC_UDBScript
  Scenario:  Delete the analysis items for plugins: UDBScan, UDBImport, UDBPostprocess, UDBReconcile, EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                      | type     | query | param |
      | MultipleIDDelete | Default | rochade/UDBScan/RochadeUDBScan%                           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBImport/RochadeUDBImport%                       | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBPostprocess/RochadeUDBPostprocess%             | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBReconcile/RochadeUDBReconcile%                 | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBScriptScan/RochadeUDBScriptScan%               | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBScriptImport/RochadeUDBScriptImport%           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBScriptPostprocess/RochadeUDBScriptPostprocess% | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBScriptReconcile/RochadeUDBScriptReconcile%     | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_UDB%                                   | Analysis |       |       |


  @post-condition @ROC_UDBScript
  Scenario Outline:  Delete Credentials, Datasource and plugin config for UDBScan, UDBImport, UDBPostprocess, UDBReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                 | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBScan                                          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBImport/RochadeUDBImport                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBPostprocess/RochadeUDBPostprocess             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBReconcile/RochadeUDBReconcile                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBScriptScan                                    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBScriptImport/RochadeUDBScriptImport           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBScriptPostprocess/RochadeUDBScriptPostprocess |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBScriptReconcile/RochadeUDBScriptReconcile     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_UDB                                |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCUDBDataSource                                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCUDBSADataSource                               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeUDBScanCredentials                      |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeUDBSACredentials                        |          |      | 200           |                  |          |
