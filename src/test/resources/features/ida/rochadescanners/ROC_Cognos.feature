@MLPQA-19289
Feature: Verification of Rochade-DD wrapper plugins for Cognos DataSource
#  Stories: @MLP-32338

  @pre-condition @ROC_Cognos
  Scenario: Pre: Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_Cognos
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                         | jsonPath                                                | node            |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.SQLServerScan.configurations.nodeCondition            | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.SQLServerImport.configurations.nodeCondition          | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.SQLServerReconcile.configurations.nodeCondition       | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosScan.configurations.nodeCondition               | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosImport.configurations.nodeCondition             | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosLink1.configurations.nodeCondition              | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosReconcile1.configurations.nodeCondition         | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLScan.configurations.nodeCondition            | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLImport.configurations.nodeCondition          | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLCubeAnalyzer.configurations.nodeCondition    | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLCubePackageLink.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLLink.configurations.nodeCondition            | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosLink2.configurations.nodeCondition              | HeadlessEDINode |
      | ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosReconcile2.configurations.nodeCondition         | HeadlessEDINode |


  @pre-condition @ROC_Cognos
  Scenario Outline: Configure Credentials, Data Source for Cognos wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | bodyFile                                                 | path                       | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeCognosCredentials    | payloads/ida/ROCCognosPayloads/RocCognosCredentials.json | $.CognosCrdentials         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeCognosCredentials    |                                                          |                            | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeSQLServerCredentials | payloads/ida/ROCCognosPayloads/RocCognosCredentials.json | $.SQLServerCredentials     | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeSQLServerCredentials |                                                          |                            | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeCognosSACredentials  | payloads/ida/ROCCognosPayloads/RocCognosCredentials.json | $.EDICredentials           | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeCognosSACredentials  |                                                          |                            | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCCognosDataSource           | payloads/ida/ROCCognosPayloads/RocCognosDataSource.json  | $.ROCCognosDataSource      | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCCognosDataSource           |                                                          |                            | 200           | ROCCognosDS          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCCognosSADataSource         | payloads/ida/ROCCognosPayloads/RocCognosDataSource.json  | $.ROCCognosSADataSource    | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCCognosSADataSource         |                                                          |                            | 200           | ROCCognosSADS        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCCognosMDLSADataSource      | payloads/ida/ROCCognosPayloads/RocCognosDataSource.json  | $.ROCCognosMDLSADataSource | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCCognosMDLSADataSource      |                                                          |                            | 200           | ROCCognosMDLSADS     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource              | payloads/ida/ROCCognosPayloads/RocCognosDataSource.json  | $.EDIBusDataSource         | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource              |                                                          |                            | 200           | EDIBusCognosDS       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCSQLServerDataSource        | payloads/ida/ROCCognosPayloads/RocCognosDataSource.json  | $.SQLServerScanDS          | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCSQLServerDataSource        |                                                          |                            | 200           | ROCSQLServerScanDS   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCSQLServerSADataSource      | payloads/ida/ROCCognosPayloads/RocCognosDataSource.json  | $.SQLServerImportDS        | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCSQLServerSADataSource      |                                                          |                            | 200           | ROCSQLServerImportDS |          |

  @pre-condition @ROC_Cognos
  Scenario Outline: Configure plugins: CognosScan, CognosImport, CognosPostprocess, CognosReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                         | bodyFile                                                  | path                                      | response code | response message                | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/SQLServerScan/RochadeSQLServerScan                       | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.SQLServerScan.configurations            | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/SQLServerScan/RochadeSQLServerScan                       |                                                           |                                           | 200           | RochadeSQLServerScan            |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/SQLServerImport/RochadeSQLServerImport                   | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.SQLServerImport.configurations          | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/SQLServerImport/RochadeSQLServerImport                   |                                                           |                                           | 200           | RochadeSQLServerImport          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/SQLServerReconcile/RochadeSQLServerReconcile             | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.SQLServerReconcile.configurations       | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/SQLServerReconcile/RochadeSQLServerReconcile             |                                                           |                                           | 200           | RochadeSQLServerReconcile       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosScan/RochadeCognosScan                             | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosScan.configurations               | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosScan/RochadeCognosScan                             |                                                           |                                           | 200           | RochadeCognosScan               |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosImport/RochadeCognosImport                         | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosImport.configurations             | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosImport/RochadeCognosImport                         |                                                           |                                           | 200           | RochadeCognosImport             |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosLink/RochadeCognosLink1                            | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosLink1.configurations              | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosLink/RochadeCognosLink1                            |                                                           |                                           | 200           | RochadeCognosLink1              |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosReconcile/RochadeCognosReconcile1                  | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosReconcile1.configurations         | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosReconcile/RochadeCognosReconcile1                  |                                                           |                                           | 200           | RochadeCognosReconcile1         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosMDLScan/RochadeCognosMDLScan                       | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLScan.configurations            | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosMDLScan/RochadeCognosMDLScan                       |                                                           |                                           | 200           | RochadeCognosMDLScan            |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosMDLImport/RochadeCognosMDLImport                   | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLImport.configurations          | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosMDLImport/RochadeCognosMDLImport                   |                                                           |                                           | 200           | RochadeCognosMDLImport          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer       | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLCubeAnalyzer.configurations    | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer       |                                                           |                                           | 200           | RochadeCognosMDLCubeAnalyzer    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLCubePackageLink.configurations | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink |                                                           |                                           | 200           | RochadeCognosMDLCubePackageLink |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosMDLLink/RochadeCognosMDLLink                       | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosMDLLink.configurations            | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosMDLLink/RochadeCognosMDLLink                       |                                                           |                                           | 200           | RochadeCognosMDLLink            |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosLink/RochadeCognosLink2                            | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosLink2.configurations              | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosLink/RochadeCognosLink2                            |                                                           |                                           | 200           | RochadeCognosLink2              |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CognosReconcile/RochadeCognosReconcile2                  | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.CognosReconcile2.configurations         | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CognosReconcile/RochadeCognosReconcile2                  |                                                           |                                           | 200           | RochadeCognosReconcile2         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_Cognos                                     | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.EDIBus.configurations                   | 204           |                                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_Cognos                                     |                                                           |                                           | 200           | EDIBus_Cognos                   |          |


  #################################################### Plugin Run #####################################################

  @ROC_Cognos
  Scenario Outline: Run CognosScan Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "30000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosScan/RochadeCognosScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosScan/RochadeCognosScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosScan/RochadeCognosScan  |          |      | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosScan/RochadeCognosScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosScan')].status |


  @ROC_Cognos
  Scenario Outline: Run CognosImport, CognosPostprocess, CognosReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | bodyFile | path | response code | response message | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosScan/RochadeCognosScan                             |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosScan')].status               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosImport/RochadeCognosImport                         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosImport')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosImport/RochadeCognosImport                          |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosImport/RochadeCognosImport                         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosImport')].status             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosLink/RochadeCognosLink1                            |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosLink1')].status              |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosLink/RochadeCognosLink1                             |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosLink/RochadeCognosLink1                            |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosLink1')].status              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosReconcile/RochadeCognosReconcile1                  |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosReconcile1')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosReconcile/RochadeCognosReconcile1                   |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosReconcile/RochadeCognosReconcile1                  |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosReconcile1')].status         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLScan/RochadeCognosMDLScan                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLScan')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosMDLScan/RochadeCognosMDLScan                        |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLScan/RochadeCognosMDLScan                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLScan')].status            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLImport/RochadeCognosMDLImport                   |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLImport')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosMDLImport/RochadeCognosMDLImport                    |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLImport/RochadeCognosMDLImport                   |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLImport')].status          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLCubeAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer        |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLCubeAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLCubePackageLink')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink  |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLCubePackageLink')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLLink/RochadeCognosMDLLink                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLLink')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosMDLLink/RochadeCognosMDLLink                        |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosMDLLink/RochadeCognosMDLLink                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosMDLLink')].status            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosLink/RochadeCognosLink2                            |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosLink2')].status              |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosLink/RochadeCognosLink2                             |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosLink/RochadeCognosLink2                            |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosLink2')].status              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosReconcile/RochadeCognosReconcile2                  |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosReconcile2')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/CognosReconcile/RochadeCognosReconcile2                   |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/CognosReconcile/RochadeCognosReconcile2                  |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeCognosReconcile2')].status         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Cognos                                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Cognos')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Cognos                                        |          |      | 200           |                  |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Cognos                                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Cognos')].status                   |


  ##################################################### Verifications #####################################################
  @ROC_Cognos @TEST_MLPQA-19273 @MLPQA-18084
  Scenario: Verify the Logging Enhancements - Analysis logs for CognosScan, CognosImport, CognosLink, CognosReconcile, CognosMDLScan, CognosMDLImport, CognosMDLCubeAnalyzer, CognosMDLPackageLink, CognosMDLLink, CognosODBCTool
    Given Analysis log "rochade/CognosScan/RochadeCognosScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                 | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                           | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:CognosScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosScan | ANALYSIS-0071 | CognosScan | Plugin Version |
      | INFO | Plugin CognosScan Start Time:2020-11-24 07:38:33.752, End Time:2020-11-24 07:39:50.714, Processed Count:0, Errors:0, Warnings:0                                                          | ANALYSIS-0072 | CognosScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                           | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/CognosImport/RochadeCognosImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                     | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                               | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:CognosImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosImport | ANALYSIS-0071 | CognosImport | Plugin Version |
      | INFO | Plugin CognosImport Start Time:2020-11-24 07:40:06.244, End Time:2020-11-24 07:40:50.591, Processed Count:0, Errors:0, Warnings:0                                                            | ANALYSIS-0072 | CognosImport |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                               | ANALYSIS-0020 |              |                |
    And Analysis log "rochade/CognosLink/RochadeCognosLink1%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                  | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                            | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:CognosLink, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosLink1 | ANALYSIS-0071 | CognosLink | Plugin Version |
      | INFO | Plugin CognosLink Start Time:2021-01-18 11:39:10.947, End Time:2021-01-18 11:39:22.156, Processed Count:0, Errors:0, Warnings:0                                                           | ANALYSIS-0072 | CognosLink |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                            | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/CognosReconcile/RochadeCognosReconcile1%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                            | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                      | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:CognosReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosReconcile1 | ANALYSIS-0071 | CognosReconcile | Plugin Version |
      | INFO | Plugin CognosReconcile Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                                | ANALYSIS-0072 | CognosReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                      | ANALYSIS-0020 |                 |                |
    And Analysis log "rochade/CognosMDLScan/RochadeCognosMDLScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                       | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                 | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:CognosMDLScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosMDLScan | ANALYSIS-0071 | CognosMDLScan | Plugin Version |
      | INFO | Plugin CognosMDLScan Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                             | ANALYSIS-0072 | CognosMDLScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                 | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/CognosMDLImport/RochadeCognosMDLImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                           | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                     | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:CognosMDLImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosMDLImport | ANALYSIS-0071 | CognosMDLImport | Plugin Version |
      | INFO | Plugin CognosMDLImport Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                               | ANALYSIS-0072 | CognosMDLImport |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                     | ANALYSIS-0020 |                 |                |
    And Analysis log "rochade/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                       | logCode       | pluginName            | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                 | ANALYSIS-0019 |                       |                |
      | INFO | Plugin Name:CognosMDLCubeAnalyzer, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosMDLCubeAnalyzer | ANALYSIS-0071 | CognosMDLCubeAnalyzer | Plugin Version |
      | INFO | Plugin CognosMDLCubeAnalyzer Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                                     | ANALYSIS-0072 | CognosMDLCubeAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                 | ANALYSIS-0020 |                       |                |
    And Analysis log "rochade/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                             | logCode       | pluginName               | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                       | ANALYSIS-0019 |                          |                |
      | INFO | Plugin Name:CognosMDLCubePackageLink, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosMDLCubePackageLink | ANALYSIS-0071 | CognosMDLCubePackageLink | Plugin Version |
      | INFO | Plugin CognosMDLCubePackageLink Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                                        | ANALYSIS-0072 | CognosMDLCubePackageLink |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                       | ANALYSIS-0020 |                          |                |
    And Analysis log "rochade/CognosMDLLink/RochadeCognosMDLLink%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                       | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                 | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:CognosMDLLink, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeCognosMDLLink | ANALYSIS-0071 | CognosMDLLink | Plugin Version |
      | INFO | Plugin CognosMDLLink Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                             | ANALYSIS-0072 | CognosMDLLink |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                 | ANALYSIS-0020 |               |                |

  @webtest @ROC_Cognos @TEST_MLPQA-19275 @MLPQA-18084
  Scenario: Verify the availability of HTML file under analysis items for plugins: CognosScan, CognosImport, CognosLink
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Cognos BI" should get displayed for the column "rochade/CognosScan/RochadeCognosScan%"
    And user performs "latest analysis click" in Item Results page for "rochade/CognosScan/RochadeCognosScan%"
    Then user performs click and verify in new window
      | Table | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | CognosDB-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Cognos BI" should get displayed for the column "rochade/CognosImport/RochadeCognosImport%"
    And user performs "latest analysis click" in Item Results page for "rochade/CognosImport/RochadeCognosImport%"
    Then user performs click and verify in new window
      | Table | value                   | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | CognosDB-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Cognos BI" should get displayed for the column "rochade/CognosLink/RochadeCognosLink1%"
    And user performs "latest analysis click" in Item Results page for "rochade/CognosLink/RochadeCognosLink1%"
    Then user performs click and verify in new window
      | Table | value                     | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | CognosDB-DBLinkerLog.html | verify widget contains |                  |             |
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Cognos BI" should get displayed for the column "rochade/CognosMDLScan/RochadeCognosMDLScan/%"
    And user performs "latest analysis click" in Item Results page for "rochade/CognosMDLScan/RochadeCognosMDLScan/%"
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Cognos BI" should get displayed for the column "rochade/CognosMDLImport/RochadeCognosMDLImport/%"
    And user performs "latest analysis click" in Item Results page for "rochade/CognosMDLImport/RochadeCognosMDLImport/%"
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Cognos BI" should get displayed for the column "rochade/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer/%"
    And user performs "latest analysis click" in Item Results page for "rochade/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer/%"
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Cognos BI" should get displayed for the column "rochade/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink/%"
    And user performs "latest analysis click" in Item Results page for "rochade/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink/%"
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Cognos BI" should get displayed for the column "rochade/CognosMDLLink/RochadeCognosMDLLink/%"
    And user performs "latest analysis click" in Item Results page for "rochade/CognosMDLLink/RochadeCognosMDLLink/%"
    And user should be able logoff the IDC

  @ROC_Cognos
  Scenario Outline:  user retrieves facets and respective counts of Cognos wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                      | response code | response message | filePath                                           | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCCognosPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCCognosPayloads/facetWiseCount.json |          |

  @ROC_Cognos
  Scenario: Verify the items in EDI matched with items in DD UI
    And user gets the items count from json
      | filePath                                           | jsonPath                                           |
      | payloads/ida/ROCCognosPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Service')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DB_SYSTEM ) |
    And user gets the items count from json
      | filePath                                           | jsonPath                                          |
      | payloads/ida/ROCCognosPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Column')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_COLUMN ) |
    And user gets the items count from json
      | filePath                                           | jsonPath                                         |
      | payloads/ida/ROCCognosPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Table')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user gets the items count from json
      | filePath                                           | jsonPath                                          |
      | payloads/ida/ROCCognosPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Schema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_SCHEMA ) |
    And user gets the items count from json
      | filePath                                           | jsonPath                                            |
      | payloads/ida/ROCCognosPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Database')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND  ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DATABASE ) |
    And user gets the items count from json
      | filePath                                           | jsonPath                                                    |
      | payloads/ida/ROCCognosPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='AggregationLevel')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_LEVEL ) |
    And user gets the items count from json
      | filePath                                           | jsonPath                                           |
      | payloads/ida/ROCCognosPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Measure')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_MEMBER ) |

  @webtest @ROC_Cognos @TEST_MLPQA-19279 @MLPQA-18084
  Scenario: Verify Cognos Rochade items are replicated to DD after running EDIBus plugin like Service, Database, Schema, Table, Column
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Service          |
      | Column           |
      | Table            |
      | Schema           |
      | Database         |
      | Analysis         |
      | Dimension        |
      | OlapSchema       |
      | OlapPackage      |
      | Cube             |
      | Dimension        |
      | Hierachy         |
      | AggregationLevel |
      | Measure          |
    And user enters the search text "ADDRESS1" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "/Samples/Models/GO sales (analysis) [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "ADDRESS1" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | $$DefaultScanCognos≫DB              |
      | /Samples/Models/GO sales (analysis) |
      | gosales                             |
      | BRANCH                              |
      | ADDRESS1                            |
    And user should be able logoff the IDC

  @ROC_Cognos @TEST_MLPQA-19278 @MLPQA-18084
  Scenario: Metadata verification for Service, Database, Schema, Table, Column after executing Cognos plugins
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                    | jsonPath                        | Action                    | query                       | ClusterName | ServiceName            | DatabaseName                        | SchemaName | TableName/Filename | columnName/FieldName | specialCharacters |
      | Description | ida/ROCCognosPayloads/expectedMetadata.json | $.DatabaseMetadata.Description1 | metadataAttributePresence | DatabaseQueryWithoutCluster |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) |            |                    |                      |                   |
      | Description | ida/ROCCognosPayloads/expectedMetadata.json | $.DatabaseMetadata.Description2 | metadataValuePresence     | DatabaseQueryWithoutCluster |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) |            |                    |                      | yes               |
      | Description | ida/ROCCognosPayloads/expectedMetadata.json | $.SchemaMetadata.Description1   | metadataAttributePresence | SchemaQueryWithoutCluster   |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    |                    |                      |                   |
      | Description | ida/ROCCognosPayloads/expectedMetadata.json | $.SchemaMetadata.Description2   | metadataValuePresence     | SchemaQueryWithoutCluster   |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    |                    |                      | yes               |
      | Description | ida/ROCCognosPayloads/expectedMetadata.json | $.TableMetadata.Description1    | metadataAttributePresence | TableQueryWithoutCluster    |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    | BRANCH             |                      |                   |
      | Lifecycle   | ida/ROCCognosPayloads/expectedMetadata.json | $.TableMetadata.Lifecycle1      | metadataAttributePresence | TableQueryWithoutCluster    |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    | BRANCH             |                      |                   |
      | Description | ida/ROCCognosPayloads/expectedMetadata.json | $.TableMetadata.Description2    | metadataValuePresence     | TableQueryWithoutCluster    |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    | BRANCH             |                      | yes               |
      | Lifecycle   | ida/ROCCognosPayloads/expectedMetadata.json | $.ColumnMetadata.Lifecycle      | metadataAttributePresence | ColumnQueryWithoutCluster   |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    | BRANCH             | ADDRESS1             |                   |
      | Description | ida/ROCCognosPayloads/expectedMetadata.json | $.ColumnMetadata.Description    | metadataValuePresence     | ColumnQueryWithoutCluster   |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    | BRANCH             | ADDRESS1             |                   |
      | Statistics  | ida/ROCCognosPayloads/expectedMetadata.json | $.ColumnMetadata.Statistics     | metadataValuePresence     | ColumnQueryWithoutCluster   |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    | BRANCH             | ADDRESS1             |                   |

  @ROC_Cognos @TEST_MLPQA-19274 @MLPQA-18084 @TEST_MLPQA-19277 @MLPQA-18084
  Scenario: 1. Verify the Technology tags for Analysis item for CognosScan, CognosImport, CognosLink, CognosReconcile, CognosMDLScan, CognosMDLImport, CognosMDLCubeAnalyzer, CognosMDLPackageLink, CognosMDLLink, CognosODBCTool
  2. Verify Technology tags for replicated items after running Cognos related & EDIBus plugin
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName            | DatabaseName                        | SchemaName | TableName/Filename                                               | Column   | Tags          | Query                       | Action      |
      |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) |            |                                                                  |          | Cognos BI,ROC | DatabaseQueryWithoutCluster | TagAssigned |
      |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    |                                                                  |          | Cognos BI,ROC | SchemaQueryWithoutCluster   | TagAssigned |
      |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    | BRANCH                                                           |          | Cognos BI,ROC | TableQueryWithoutCluster    | TagAssigned |
      |             | $$DefaultScanCognos≫DB | /Samples/Models/GO sales (analysis) | gosales    | BRANCH                                                           | ADDRESS1 | Cognos BI,ROC | ColumnQueryWithoutCluster   | TagAssigned |
      |             |                        |                                     |            | rochade/CognosScan/RochadeCognosScan%                            |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | rochade/CognosImport/RochadeCognosImport%                        |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | rochade/CognosLink/RochadeCognosLink1%                           |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | rochade/CognosReconcile/RochadeCognosReconcile1%                 |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | rochade/CognosMDLScan/RochadeCognosMDLScan                       |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | rochade/CognosMDLImport/RochadeCognosMDLImport                   |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | rochade/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer       |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | rochade/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | rochade/CognosMDLLink/RochadeCognosMDLLink                       |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |
      |             |                        |                                     |            | bulk/EDIBus/EDIBus_Cognos%                                       |          | Cognos BI,ROC | AnalysisQuery               | TagAssigned |

  ##################################################### Post Conditions #####################################################
  @post-condition @ROC_Cognos
  Scenario Outline: Configure EDIBus plugin to perform clean up
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | bodyFile                                                  | path                           | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_Cognos                            | payloads/ida/ROCCognosPayloads/RocCognosPluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_Cognos                            |                                                           |                                | 200           | EDIBus_Cognos    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Cognos |                                                           |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Cognos')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Cognos  |                                                           |                                | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Cognos |                                                           |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Cognos')].status |

  @webtest @post-condition @ROC_Cognos @TEST_MLPQA-19280 @MLPQA-18084
  Scenario: Verify all item types collected from Cognos Rochade are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Column   |
      | Table    |
      | Routine  |
      | Schema   |
      | Database |
      | Service  |
    And user should be able logoff the IDC

  @post-condition @ROC_Cognos
  Scenario: PS_Clearing the EDI subject area after running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @post-condition @ROC_Cognos
  Scenario:  Delete the analysis items for plugins: CognosScan, CognosImport, CognosPostprocess, CognosReconcile, EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                              | type     | query | param |
      | MultipleIDDelete | Default | rochade/CognosScan/RochadeCognosScan%                             | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosImport/RochadeCognosImport%                         | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosLink/RochadeCognosLink1%                            | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosLink/RochadeCognosLink2%                            | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosReconcile/RochadeCognosReconcile1%                  | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosReconcile/RochadeCognosReconcile2%                  | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosMDLScan/RochadeCognosMDLScan%                       | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosMDLImport/RochadeCognosMDLImport%                   | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer%       | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink% | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/CognosMDLLink/RochadeCognosMDLLink%                       | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_Cognos%                                        | Analysis |       |       |


  @post-condition @ROC_Cognos
  Scenario Outline:  Delete Credentials, Datasource and plugin config for CognosScan, CognosImport, CognosPostprocess, CognosReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                         | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosScan/RochadeCognosScan                             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosImport/RochadeCognosImport                         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosLink/RochadeCognosLink1                            |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosLink/RochadeCognosLink2                            |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosReconcile/RochadeCognosReconcile1                  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosReconcile/RochadeCognosReconcile2                  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosMDLScan/RochadeCognosMDLScan                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosMDLImport/RochadeCognosMDLImport                   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosMDLCubeAnalyzer/RochadeCognosMDLCubeAnalyzer       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosMDLCubePackageLink/RochadeCognosMDLCubePackageLink |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CognosMDLLink/RochadeCognosMDLLink                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScan                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerImport/RochadeSQLServerImport                   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerReconcile/RochadeSQLServerReconcile             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_Cognos                                     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCCognosDataSource                                      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCCognosSADataSource                                    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCCognosMDLSADataSource                                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCSQLServerDataSource/ROCSQLServerScanDS                |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCSQLServerSADataSource/ROCSQLServerImportDS            |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusCognosDS                          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeCognosCredentials                               |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeCognosSACredentials                             |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeSQLServerCredentials                            |          |      | 200           |                  |          |
