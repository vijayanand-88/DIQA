@MLPQA-18357
Feature: Verification of Rochade-DD wrapper plugins for OracleScript such as OracleScriptScan, OracleScriptImport, OracleScriptPostprocess, OracleScriptReconcile
#  Stories: @MLP-32453

  @pre-condition @ROC_OracleScript
  Scenario: Pre: Clearing the EDI subject area before running the Rochade OracleScript wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @pre-condition @ROC_OracleScript
  Scenario:Headless EDI Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                                     | jsonPath                                               | node            |
      | ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScan.configurations.nodeCondition              | HeadlessEDINode |
      | ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleImport.configurations.nodeCondition            | HeadlessEDINode |
      | ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OraclePostprocess.configurations.nodeCondition       | HeadlessEDINode |
      | ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleReconcile.configurations.nodeCondition         | HeadlessEDINode |
      | ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScriptScan.configurations.nodeCondition        | HeadlessEDINode |
      | ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScriptImport.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScriptPostprocess.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScriptReconcile.configurations.nodeCondition   | HeadlessEDINode |

  @pre-condition @ROC_OracleScript
  Scenario Outline: Configure Credentials, Data Source for OracleScript wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | bodyFile                                                             | path                    | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ROCOracleCredentials   | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptCredentials.json | $.OracleCredentials     | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ROCOracleCredentials   |                                                                      |                         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ROCOracleSACredentials | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptCredentials.json | $.EDICredentials        | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ROCOracleSACredentials |                                                                      |                         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCOracleDataSource      | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptDataSource.json  | $.ROCOracleDataSource   | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCOracleDataSource      |                                                                      |                         | 200           | RochadeOracleDS      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCOracleSADataSource    | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptDataSource.json  | $.ROCOracleSADataSource | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCOracleSADataSource    |                                                                      |                         | 200           | RochadeOracleSADS    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource         | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptDataSource.json  | $.EDIBusDataSource      | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource         |                                                                      |                         | 200           | EDIBusOracleScriptDS |          |

  @pre-condition @ROC_OracleScript
  Scenario Outline: Configure plugins: OracleScan, OracleImport, OraclePostprocess, OracleReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                                              | path                               | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleScan/RochadeOracleScan               | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScan.configurations        | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScan/RochadeOracleScan               |                                                                       |                                    | 200           | RochadeOracleScan        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleImport/RochadeOracleImport           | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleImport.configurations      | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleImport/RochadeOracleImport           |                                                                       |                                    | 200           | RochadeOracleImport      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OraclePostprocess/RochadeOraclePostprocess | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OraclePostprocess.configurations | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OraclePostprocess/RochadeOraclePostprocess |                                                                       |                                    | 200           | RochadeOraclePostprocess |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleReconcile/RochadeOracleReconcile     | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleReconcile.configurations   | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleReconcile/RochadeOracleReconcile     |                                                                       |                                    | 200           | RochadeOracleReconcile   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_OracleScript                 | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.EDIBus.configurations            | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_OracleScript                 |                                                                       |                                    | 200           | EDIBus_OracleScript      |          |

  @pre-condition @ROC_OracleScript
  Scenario Outline: Configure plugins: OracleScriptScan, OracleScriptImport, OracleScriptPostprocess, OracleScriptReconcile
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                       | bodyFile                                                              | path                                     | response code | response message               | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleScriptScan/RochadeOracleScriptScan               | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScriptScan.configurations        | 204           |                                |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScriptScan/RochadeOracleScriptScan               |                                                                       |                                          | 200           | RochadeOracleScriptScan        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleScriptImport/RochadeOracleScriptImport           | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScriptImport.configurations      | 204           |                                |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScriptImport/RochadeOracleScriptImport           |                                                                       |                                          | 200           | RochadeOracleScriptImport      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleScriptPostprocess/RochadeOracleScriptPostprocess | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScriptPostprocess.configurations | 204           |                                |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScriptPostprocess/RochadeOracleScriptPostprocess |                                                                       |                                          | 200           | RochadeOracleScriptPostprocess |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleScriptReconcile/RochadeOracleScriptReconcile     | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.OracleScriptReconcile.configurations   | 204           |                                |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScriptReconcile/RochadeOracleScriptReconcile     |                                                                       |                                          | 200           | RochadeOracleScriptReconcile   |          |

  Scenario Outline: Run OracleScan  Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "30000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScan/RochadeOracleScan  |          |      | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status |

  #################################################### Plugin Run #####################################################


  @ROC_OracleScript
  Scenario Outline: Run OracleScan, OracleImport, OraclePostprocess, OracleReconcile Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "7000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile | path | response code | response message | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleImport/RochadeOracleImport            |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OraclePostprocess/RochadeOraclePostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOraclePostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OraclePostprocess/RochadeOraclePostprocess  |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OraclePostprocess/RochadeOraclePostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOraclePostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleReconcile/RochadeOracleReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleReconcile/RochadeOracleReconcile      |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleReconcile/RochadeOracleReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleReconcile')].status   |

  @ROC_OracleScript
  Scenario Outline: Run OracleScriptScan Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "10000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptScan/RochadeOracleScriptScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScriptScan/RochadeOracleScriptScan  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptScan/RochadeOracleScriptScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptScan/RochadeOracleScriptScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptScan')].status |


  @ROC_OracleScript
  Scenario Outline: Run OracleScriptScan, OracleScriptImport, OracleScriptPostprocess, OracleScriptReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "5000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                    | bodyFile | path | response code | response message | jsonPath                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptScan/RochadeOracleScriptScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptImport/RochadeOracleScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScriptImport/RochadeOracleScriptImport            |          |      | 200           |                  |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptImport/RochadeOracleScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptScan/RochadeOracleScriptScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptPostprocess/RochadeOracleScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScriptPostprocess/RochadeOracleScriptPostprocess  |          |      | 200           |                  |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptPostprocess/RochadeOracleScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptReconcile/RochadeOracleScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScriptReconcile/RochadeOracleScriptReconcile      |          |      | 200           |                  |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScriptReconcile/RochadeOracleScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_OracleScript                               |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_OracleScript')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_OracleScript                                |          |      | 200           |                  |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_OracleScript                               |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_OracleScript')].status            |

  #WorkAround
  @ROC_OracleScript
  Scenario Outline: Configure EDIBus plugin & run it to add EDI Types for OracleScript
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                      | bodyFile                                                              | path                             | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_OracleScript                            | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.EDIBusWithTypes.configurations | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_OracleScript                            |                                                                       |                                  | 200           | EDIBus_OracleScript |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_OracleScript |                                                                       |                                  | 200           | IDLE                | $.[?(@.configurationName=='EDIBus_OracleScript')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_OracleScript  |                                                                       |                                  | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_OracleScript |                                                                       |                                  | 200           | IDLE                | $.[?(@.configurationName=='EDIBus_OracleScript')].status |

##################################################### Verifications #####################################################

  @ROC_OracleScript @TEST_MLPQA-18319 @MLPQA-18084
  Scenario: Verify the Logging Enhancements - Analysis logs for OracleScriptScan, OracleScriptImport, OracleScriptPostprocess, OracleScriptReconcile
    Given Analysis log "rochade/OracleScriptScan/RochadeOracleScriptScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                             | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                       | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:OracleScriptScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeOracleScriptScan | ANALYSIS-0071 | OracleScriptScan | Plugin Version |
      | INFO | Plugin OracleScriptScan Start Time:2020-12-09 10:20:16.694, End Time:2020-12-09 10:20:17.827, Errors:0, Warnings:0                                                                                   | ANALYSIS-0072 | OracleScriptScan |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                            | ANALYSIS-0020 |                  |                |
    And Analysis log "rochade/OracleScriptImport/RochadeOracleScriptImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                 | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                                           | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:OracleScriptImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeOracleScriptImport | ANALYSIS-0071 | OracleScriptImport | Plugin Version |
      | INFO | Plugin OracleScriptImport Start Time:2020-12-09 10:20:40.129, End Time:2020-12-09 10:20:43.808, Errors:0, Warnings:0                                                                                     | ANALYSIS-0072 | OracleScriptImport |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                | ANALYSIS-0020 |                    |                |
    And Analysis log "rochade/OracleScriptPostprocess/RochadeOracleScriptPostprocess%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                           | logCode       | pluginName              | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                     | ANALYSIS-0019 |                         |                |
      | INFO | Plugin Name:OracleScriptPostprocess, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeOracleScriptPostprocess | ANALYSIS-0071 | OracleScriptPostprocess | Plugin Version |
      | INFO | Plugin OracleScriptPostprocess Start Time:2020-12-09 10:21:02.126, End Time:2020-12-09 10:21:09.224, Errors:0, Warnings:0                                                                                          | ANALYSIS-0072 | OracleScriptPostprocess |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                          | ANALYSIS-0020 |                         |                |
    And Analysis log "rochade/OracleScriptReconcile/RochadeOracleScriptReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                       | logCode       | pluginName            | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                 | ANALYSIS-0019 |                       |                |
      | INFO | Plugin Name:OracleScriptReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeOracleScriptReconcile | ANALYSIS-0071 | OracleScriptReconcile | Plugin Version |
      | INFO | Plugin OracleScriptReconcile Start Time:2020-12-09 10:21:24.076, End Time:2020-12-09 10:21:36.425, Errors:0, Warnings:0                                                                                        | ANALYSIS-0072 | OracleScriptReconcile |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                      | ANALYSIS-0020 |                       |                |

  @webtest @ROC_OracleScript @TEST_MLPQA-18321 @MLPQA-18084
  Scenario: Verify the availability of HTML file under analysis items for plugins: OracleScriptScan, OracleScriptImport, OracleScriptPostprocess, OracleScriptReconcile
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "rochade/OracleScriptScan" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/OracleScriptScan/RochadeOracleScriptScan%"
    Then user performs click and verify in new window
      | Table | value                     | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | OracleScript-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "rochade/OracleScriptImport" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/OracleScriptImport/RochadeOracleScriptImport%"
    Then user performs click and verify in new window
      | Table | value                       | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | OracleScript-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "rochade/OracleScriptPostprocess" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/OracleScriptPostprocess/RochadeOracleScriptPostprocess%"
    Then user performs click and verify in new window
      | Table | value                     | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | OracleScript-PostLog.html | verify widget contains |                  |             |
    And user should be able logoff the IDC

  @webtest @TEST_MLPQA-18322 @MLPQA-18084 @TEST_MLPQA-18325 @MLPQA-18084
  Scenario: Verify OracleScript Rochade items are replicated to DD after running EDIBus plugin like Service, Operation
  2.  Verify the breadcrumb hierarchy appears correctly when OracleScript Rochade items are replicated to DD after running EDIBus plugin.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Operation  |
      | Trigger    |
      | Routine    |
      | Schema     |
      | Database   |
      | Constraint |
      | Analysis   |
      | Service    |
    And user enters the search text "procedure_prov2t_sql.sql" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "procedure_prov2t_sql.sql" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | comp1≫Operation              |
      | D:\≫Operation                |
      | Oracle_TestScripts≫Operation |
      | procedure_prov2t_sql.sql     |
    And user should be able logoff the IDC

  @ROC_OracleScript @TEST_MLPQA-18324 @MLPQA-18084
  Scenario: Metadata verification for Service, Operation items after executing OracleScript related plugins.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                          | jsonPath                          | Action                    | query                      | ClusterName | ServiceName                  | DatabaseName | SchemaName | TableName/Filename       | columnName/FieldName | specialCharacters |
      | Description | ida/ROCOracleScriptPayloads/expectedMetadata.json | $.Service1Metadata.Description1   | metadataAttributePresence | ServiceQueryWithoutCluster |             | $$OracleDefaultSystem≫DB     |              |            |                          |                      |                   |
      | Description | ida/ROCOracleScriptPayloads/expectedMetadata.json | $.Service3Metadata.Description1   | metadataAttributePresence | ServiceQueryWithoutCluster |             | Oracle_TestScripts≫Operation |              |            |                          |                      |                   |
      | Description | ida/ROCOracleScriptPayloads/expectedMetadata.json | $.Service3Metadata.Description2   | metadataValuePresence     | ServiceQueryWithoutCluster |             | Oracle_TestScripts≫Operation |              |            |                          |                      |                   |
      | Description | ida/ROCOracleScriptPayloads/expectedMetadata.json | $.Operation1Metadata.Description1 | metadataAttributePresence | OperationQuery             |             |                              |              |            | procedure_prov2t_sql.sql |                      |                   |
      | Description | ida/ROCOracleScriptPayloads/expectedMetadata.json | $.Operation1Metadata.Description2 | metadataValuePresence     | OperationQuery             |             |                              |              |            | procedure_prov2t_sql.sql |                      |                   |

  @ROC_OracleScript @TEST_MLPQA-18320 @MLPQA-18084    @TEST_MLPQA-18323 @MLPQA-18084
  Scenario: Verify the Technology tags for Analysis item for OracleScriptScan, OracleScriptImport, OracleScriptPostprocess, OracleScriptReconcile - ROC, Oracle
  2. Verify Technology tags for replicated items after running OracleScript related & EDIBus plugin
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName              | DatabaseName | SchemaName | TableName/Filename                                              | Column | Tags       | Query                      | Action      |
      |             | $$OracleDefaultSystem≫DB |              |            |                                                                 |        | Oracle,ROC | ServiceQueryWithoutCluster | TagAssigned |
      |             |                          |              |            | procedure_prov2t_sql.sql                                        |        | Oracle,ROC | OperationQuery             | TagAssigned |
      |             |                          |              |            | rochade/OracleScriptScan/RochadeOracleScriptScan%               |        | Oracle,ROC | AnalysisQuery              | TagAssigned |
      |             |                          |              |            | rochade/OracleScriptImport/RochadeOracleScriptImport%           |        | Oracle,ROC | AnalysisQuery              | TagAssigned |
      |             |                          |              |            | rochade/OracleScriptPostprocess/RochadeOracleScriptPostprocess% |        | Oracle,ROC | AnalysisQuery              | TagAssigned |
      |             |                          |              |            | rochade/OracleScriptReconcile/RochadeOracleScriptReconcile%     |        | Oracle,ROC | AnalysisQuery              | TagAssigned |
      |             |                          |              |            | bulk/EDIBus/EDIBus_OracleScript%                                |        | Oracle,ROC | AnalysisQuery              | TagAssigned |

  @ROC_OracleScript
  Scenario: Verify Lineage is established after executing OracleScript related plugins for the scenario: Table to Table(through procedure)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name         | asg_scopeid | targetFile                                              | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OCPPFT2T1    |             | response/RochadeOracleScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OCPPVIEW     |             | response/RochadeOracleScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TRIGGERTEST  |             | response/RochadeOracleScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OCPPVT       |             | response/RochadeOracleScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OCPPV2T      |             | response/RochadeOracleScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TRIGGERTEST1 |             | response/RochadeOracleScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OCPPFT2T2    |             | response/RochadeOracleScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OCPPDSVT     |             | response/RochadeOracleScript/Lineage/lineageHopIDs.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                    | bodyFile                                                | path                           | response code | response message | jsonPath | targetFile                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeOracleScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.TRIGGERTEST  | 200           |                  | edges    | response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeOracleScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.TRIGGERTEST1 | 200           |                  | edges    | response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeOracleScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.OCPPVT       | 200           |                  | edges    | response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeOracleScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.OCPPVIEW     | 200           |                  | edges    | response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeOracleScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.OCPPDSVT     | 200           |                  | edges    | response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeOracleScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.OCPPFT2T1    | 200           |                  | edges    | response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeOracleScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.OCPPV2T      | 200           |                  | edges    | response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeOracleScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.OCPPFT2T2    | 200           |                  | edges    | response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                  | JsonPath     |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | TRIGGERTEST  |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | TRIGGERTEST1 |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPVT       |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPVIEW     |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPDSVT     |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPFT2T1    |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPV2T      |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPFT2T2    |


  @ROC_OracleScript @TEST_MLPQA-18326 @MLPQA-18084    @TEST_MLPQA-18327 @MLPQA-18084    @TEST_MLPQA-18328 @MLPQA-18084    @TEST_MLPQA-18329 @MLPQA-18084    @TEST_MLPQA-18330 @MLPQA-18084
  Scenario Outline:  Lineage Hops End to End Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                               | actual_json                                                                               | item         |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/expectedOracleScriptLineageHops.json | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | TRIGGERTEST  |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/expectedOracleScriptLineageHops.json | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | TRIGGERTEST1 |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/expectedOracleScriptLineageHops.json | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPVT       |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/expectedOracleScriptLineageHops.json | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPVIEW     |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/expectedOracleScriptLineageHops.json | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPDSVT     |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/expectedOracleScriptLineageHops.json | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPFT2T1    |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/expectedOracleScriptLineageHops.json | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPV2T      |
      | Constant.REST_DIR/response/RochadeOracleScript/Lineage/expectedOracleScriptLineageHops.json | Constant.REST_DIR/response/RochadeOracleScript/Lineage/actualOracleScriptLineageHops.json | OCPPFT2T2    |


  ##################################################### Post Conditions #####################################################
  @ROC_OracleScript
  Scenario Outline: Configure EDIBus plugin to perform clean up the data loaded after running OracleScript plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                      | bodyFile                                                              | path                                    | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_OracleScript                            | payloads/ida/ROCOracleScriptPayloads/RocOracleScriptPluginConfig.json | $.EDIBusCleanup.configurations          | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_OracleScript                            |                                                                       |                                         | 200           | EDIBus_OracleScript |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_OracleScript |                                                                       |                                         | 200           | IDLE                | $.[?(@.configurationName=='EDIBus_OracleScript')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_OracleScript  |                                                                       |                                         | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_OracleScript |                                                                       |                                         | 200           | IDLE                | $.[?(@.configurationName=='EDIBus_OracleScript')].status |

  @webtest @ROC_OracleScript @TEST_MLPQA-18331 @MLPQA-18084
  Scenario: Verify all item types collected from OracleScript Rochade are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Operation  |
      | Routine    |
      | Schema     |
      | Database   |
      | Constraint |
      | Service    |
    And user should be able logoff the IDC

  @post-condition @ROC_OracleScript
  Scenario: PS_Clearing the EDI subject area after running the Rochade OracleScript wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @post-condition @ROC_OracleScript
  Scenario:  Delete the analysis items for plugins: OracleScan, OracleImport, OraclePostprocess, OracleReconcile, OracleScriptScan, OracleScriptImport, OracleScriptPostprocess, OracleScriptReconcile, EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | MultipleIDDelete | Default | rochade/OracleScan/RochadeOracleScan%                           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleImport/RochadeOracleImport%                       | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OraclePostprocess/RochadeOraclePostprocess%             | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleReconcile/RochadeOracleReconcile%                 | Analysis |       |       |
      | MultipleIDDelete | Default | datasource/ROCOracleSADataSource/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleScriptScan/RochadeOracleScriptScan%               | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleScriptImport/RochadeOracleScriptImport%           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleScriptPostprocess/RochadeOracleScriptPostprocess% | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleScriptReconcile/RochadeOracleScriptReconcile%     | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_OracleScript%                                | Analysis |       |       |

  @post-condition @ROC_OracleScript
  Scenario Outline:  Delete Credentials, Datasource and plugin config for OracleScan, OracleImport, OraclePostprocess, OracleReconcile, OracleScriptScan, OracleScriptImport, OracleScriptPostprocess, OracleScriptReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                       | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScan                                             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleImport/RochadeOracleImport                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OraclePostprocess/RochadeOraclePostprocess             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleReconcile/RochadeOracleReconcile                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScriptScan                                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScriptImport/RochadeOracleScriptImport           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScriptPostprocess/RochadeOracleScriptPostprocess |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScriptReconcile/RochadeOracleScriptReconcile     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_OracleScript                             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCOracleDataSource                                    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCOracleSADataSource                                  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ROCOracleCredentials                                 |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ROCOracleSACredentials                               |          |      | 200           |                  |          |
