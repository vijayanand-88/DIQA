@MLPQA-20530
Feature: Verify the OracleWrapper Plugins functionality (ROC_OracleWrapper19C.feature)
  #Stories-@MLP-29502

  @pre-condition @ROC_OracleWrapper
  Scenario:Precondions Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @pre-condition @ROC_OracleWrapper
  Scenario:Headless EDI Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                                    | jsonPath                                         | node            |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.oracleScan.nodeCondition                       | HeadlessEDINode |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.oracleImport.nodeCondition                     | HeadlessEDINode |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.oraclePostprocess.nodeCondition                | HeadlessEDINode |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.oracleReconcile.nodeCondition                  | HeadlessEDINode |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanIncludeWildcard.nodeCondition | HeadlessEDINode |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanExcludeWildcard.nodeCondition | HeadlessEDINode |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanIncludeRegEx.nodeCondition    | HeadlessEDINode |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanExcludeRegEx.nodeCondition    | HeadlessEDINode |
      | ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanDateFilter.nodeCondition      | HeadlessEDINode |

  @sanity @positive @regression @ROC_OracleWrapper
  Scenario Outline: SC#1-Set Credentials, Data Source for OracleScript wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                            | bodyFile                                                                | path                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/RochadeOraclePDBCredentials               | payloads/ida/OracleWrapperPayloads/configs/credentials/credentials.json | $.rochadeOraclePDBCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/RochadeOracleCDBCredentials               | payloads/ida/OracleWrapperPayloads/configs/credentials/credentials.json | $.rochadeOracleCDBCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/RochadeCredentials                        | payloads/ida/OracleWrapperPayloads/configs/credentials/credentials.json | $.rochadeCredentials          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ROCOracleDataSource/RochadeOracleScanDS     | payloads/ida/OracleWrapperPayloads/configs/datasource/datasource.json   | $.oracleScanDS                | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ROCOracleDataSource/oracleScanFilterDS      | payloads/ida/OracleWrapperPayloads/configs/datasource/datasource.json   | $.oracleScanFilterDS          | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ROCOracleSADataSource/RochadeOracleImportDS | payloads/ida/OracleWrapperPayloads/configs/datasource/datasource.json   | $.oracleImportDS              | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusOracleDS             | payloads/ida/OracleWrapperPayloads/configs/datasource/datasource.json   | $.ediBusOracleDS              | 204           |                  |          |

  @pre-condition @ROC_OracleWrapper
  Scenario Outline:SC#1-Configure plugins: OracleScan, OracleImport, OraclePostprocess, OracleReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                                             | path                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleScan/RochadeOracleScan               | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.oracleScan        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleImport/RochadeOracleImport           | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.oracleImport      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OraclePostprocess/RochadeOraclePostprocess | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.oraclePostprocess | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleReconcile/RochadeOracleReconcile     | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.oracleReconcile   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBus/EDIBus_Oracle1                      | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.ediBusOracle1     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBus/EDIBus_Oracle2                      | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.ediBusOracle2     | 204           |                  |          |

  @pre-condition @ROC_OracleWrapper
  Scenario Outline:SC#1-Configure plugins: OracleScan for filter scenarios
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                            | bodyFile                                                             | path                               | response code | response message                 | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleScan/RochadeOracleScanIncludeWildcard | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanIncludeWildcard | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScan/RochadeOracleScanIncludeWildcard |                                                                      |                                    | 200           | RochadeOracleScanIncludeWildcard |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleScan/RochadeOracleScanExcludeWildcard | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanExcludeWildcard | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScan/RochadeOracleScanExcludeWildcard |                                                                      |                                    | 200           | RochadeOracleScanExcludeWildcard |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleScan/RochadeOracleScanIncludeRegEx    | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanIncludeRegEx    | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScan/RochadeOracleScanIncludeRegEx    |                                                                      |                                    | 200           | RochadeOracleScanIncludeRegEx    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleScan/RochadeOracleScanExcludeRegEx    | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanExcludeRegEx    | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScan/RochadeOracleScanExcludeRegEx    |                                                                      |                                    | 200           | RochadeOracleScanExcludeRegEx    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleScan/RochadeOracleScanDateFilter      | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.RochadeOracleScanDateFilter      | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScan/RochadeOracleScanDateFilter      |                                                                      |                                    | 200           | RochadeOracleScanDateFilter      |          |


 #################################################### Plugin Run #####################################################


  @ROC_OracleWrapper
  Scenario Outline:SC#1-Run OracleScan Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "30000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScan/RochadeOracleScan  |          |      | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status |

  @ROC_OracleWrapper
  Scenario Outline:SC#1-Run OracleScan, OracleImport, OraclePostprocess, OracleReconcile & EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "10000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile | path | response code | response message | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleImport/RochadeOracleImport            |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OraclePostprocess/RochadeOraclePostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOraclePostprocess')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OraclePostprocess/RochadeOraclePostprocess  |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OraclePostprocess/RochadeOraclePostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOraclePostprocess')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleReconcile/RochadeOracleReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleReconcile')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleReconcile/RochadeOracleReconcile      |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleReconcile/RochadeOracleReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleReconcile')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Oracle1                        |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Oracle1')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Oracle1                         |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Oracle1                        |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Oracle1')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Oracle2                        |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Oracle2')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Oracle2                         |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Oracle2                        |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Oracle2')].status           |


  ##################################################### Verifications #####################################################
  #7276159#
  @TEST_MLPQA-2901 @MLPQA-20377 @7276159
  Scenario: SC#2:Verify the Logging Enhancements - Analysis logs for OracleScan, OracleImport, OraclePostprocess, OracleReconcile
    Given Analysis log "rochade/OracleScan/RochadeOracleScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                 | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                           | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:OracleScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeOracleScan | ANALYSIS-0071 | OracleScan | Plugin Version |
      | INFO | Plugin OracleScan Start Time:2020-11-30 08:08:25.089, End Time:2020-11-30 08:08:48.965, Errors:0, Warnings:0                                                          | ANALYSIS-0072 | OracleScan |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                           | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/OracleImport/RochadeOracleImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                     | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                               | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:OracleImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeOracleImport | ANALYSIS-0071 | OracleImport | Plugin Version |
      | INFO | Plugin OracleImport Start Time:2020-11-30 08:11:13.288, End Time:2020-11-30 08:11:25.698, Errors:0, Warnings:0                                                            | ANALYSIS-0072 | OracleImport |                |
    And Analysis log "rochade/OraclePostprocess/RochadeOraclePostprocess%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                               | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                         | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:OraclePostprocess, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeOraclePostprocess | ANALYSIS-0071 | OraclePostprocess | Plugin Version |
      | INFO | Plugin OraclePostprocess Start Time:2020-11-24 07:41:08.602, End Time:2020-11-24 07:44:22.364, Errors:0, Warnings:0                                                                 | ANALYSIS-0072 | OraclePostprocess |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                         | ANALYSIS-0020 |                   |                |
    And Analysis log "rochade/OracleReconcile/RochadeOracleReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                           | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                     | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:OracleReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeOracleReconcile | ANALYSIS-0071 | OracleReconcile | Plugin Version |
      | INFO | Plugin OracleReconcile Start Time:2020-11-30 08:13:56.190, End Time:2020-11-30 08:14:16.414, Errors:0, Warnings:0                                                               | ANALYSIS-0072 | OracleReconcile |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                     | ANALYSIS-0020 |                 |                |


  ################### DataSource TestConnection - UI Validation Error in Mandatory Fields ####################
  @webtest @ROC_OracleWrapper  @TEST_MLPQA-2925 @MLPQA-20377 @7276125 @TEST_MLPQA-2929 @MLPQA-20377 @7276120 @TEST_MLPQA-2934 @MLPQA-20377 @7276112 @TEST_MLPQA-2935 @MLPQA-20377 @7276110 @TEST_MLPQA-2927 @MLPQA-20377 @7276122
  Scenario: SC#3: UI Validation for ROCOracleDataSource in HeadlessEDINode
  1. Verify the datasource test connection is successful for ROCOracleDataSource in HeadlessEDINode
  2. Verify captions and tool tip text is displayed for all the fields in ROCOracleDataSource configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute           |
      | Data Source Type | ROCOracleDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Database Url*              |
      | Database JDBC driver path* |
      | Scan output path*          |
      | Oracle version path*       |
      | Credential                 |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                       | Plugin configuration name                                                                                                                                        |
      | Label                      | Plugin configuration extended label and description                                                                                                              |
      | Database Url*              | JDBC url or the JDBC connection string in format : jdbc:oracle:thin:@[HOST][:PORT]/SERVICE                                                                       |
      | Database JDBC driver path* | Path that points to the Database JDBC driver path                                                                                                                |
      | Scan output path*          | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | Oracle version path*       | Path part name for ScanOracle version                                                                                                                            |
    And user "enter text" in Add Data Source Page
      | fieldName                  | attribute                                                      |
      | Name                       | ROCOracleDataSourceTest                                        |
      | Label                      | ROCOracleDataSourceTest                                        |
      | Database Url*              | jdbc:oracle:thin:@diqscanora01v.diq.qa.asgint.loc:1522:orcl19c |
      | Database JDBC driver path* | D:\JDBC_Drivers\ojdbc8.jar                                     |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                   |
      | Credential | RochadeOraclePDBCredentials |
      | Node       | ROCIDANode                  |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  #7276112#
  @webtest @ROC_OracleWrapper  @TEST_MLPQA-2924 @MLPQA-20377 @7276127
  Scenario: SC3#:UI Validation for ROCOracleSADataSource in HeadlessEDINode
  1. Verify the datasource test connection is successful for ROCOracleSADataSource in HeadlessEDINode
  2. Verify proper error message is shown if mandatory fields are not filled in ROCOracleSADataSource plugin configuration
  3. Verify captions and tool tip text is displayed for all the fields in ROCOracleSADataSource configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | ROCOracleSADataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Scan output path*    |
      | Oracle version path* |
      | Credential           |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                 | Plugin configuration name                                                                                                                                        |
      | Label                | Plugin configuration extended label and description                                                                                                              |
      | Scan output path*    | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | Oracle version path* | Path part name for ScanOracle version                                                                                                                            |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName            | attribute |
      | Oracle version path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName           | errorMessage                                  |
      | Name                | Name field should not be empty                |
      | Scan output path    | Scan output path field should not be empty    |
      | Oracle version path | Oracle version path field should not be empty |
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                 |
      | Name      | ROCOracleSADataSourceTest |
      | Label     | ROCOracleSADataSourceTest |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute          |
      | Credential | RochadeCredentials |
      | Node       | ROCIDANode         |


  @TEST_MLPQA-2933 @MLPQA-20377 @7276113
  @webtest @ROC_OracleWrapper
  Scenario: SC3#:UI Validation in OracleScan plugin configuration
  1. Verify proper error message is shown if mandatory fields are not filled in OracleScan plugin configuration
  2. Verify captions and tool tip text is displayed for all the fields in OracleScan configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | ROCIDANode  |
    And user "click" on "Add Configuration" button under "ROCIDANode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute  |
      | Type      | Rochade    |
      | Plugin    | OracleScan |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                    |
      | Label                    |
      | Business Application     |
      | Data Source*             |
      | Credential               |
      | Plugin version           |
      | Event condition          |
      | Event class              |
      | Maximum work size        |
      | Node condition           |
      | Auto start               |
      | Tags                     |
      | Logging Level            |
      | Java memory setting      |
      | ClassPath                |
      | Process PDB's in CDB     |
      | Skip Inaccessible PDB's' |
      | Limit to Include List    |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                  | Plugin configuration name                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | Label                 | Plugin configuration extended label and description                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Business Application  | Business Application                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
      | Plugin version        | Required plugin version                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
      | Logging Level         | Logging Level                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | Java memory setting   | Maximum Java memory setting                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | ClassPath             | Classpath                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | Limit to Include List | When you use an include filter, the Limit to include list option affects to which objects SCANORAC creates links: - If you enable this option, SCANORAC creates links only to objects that are also considered by the include filter. - If you disable this option, SCANORAC creates links to all referenced objects that are not excluded, independently from the include filter objects. The Limit to include list option only takes effect if you specify include filters. |
      | Oracle scan Arguments | Overrides default Oracle scan parameters                                                                                                                                                                                                                                                                                                                                                                                                                                      |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  @webtest @ROC_OracleWrapper  @TEST_MLPQA-2924 @MLPQA-20377 @7276127
  Scenario: SC3#:UI Validation in OracleImport plugin configuration
  1. Verify proper error message is shown if mandatory fields are not filled in OracleImport plugin configuration
  2. Verify captions and tool tip text is displayed for all the fields in OracleImport configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | ROCIDANode  |
    And user "click" on "Add Configuration" button under "ROCIDANode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Rochade      |
      | Plugin    | OracleImport |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                  |
      | Label                  |
      | Business Application   |
      | Data Source*           |
      | Credential             |
      | Reset dependency links |
      | Plugin version         |
      | Event condition        |
      | Event class            |
      | Maximum work size      |
      | Node condition         |
      | Auto start             |
      | Tags                   |
      | Logging Level          |
      | Java memory setting    |
      | ClassPath              |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                   | Plugin configuration name                           |
      | Label                  | Plugin configuration extended label and description |
      | Business Application   | Business Application                                |
      | Reset dependency links | Should the dependency links be reset?               |
      | Plugin version         | Required plugin version                             |
      | Logging Level          | Logging Level                                       |
      | Java memory setting    | Maximum Java memory setting                         |
      | ClassPath              | Classpath                                           |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #7276130#
  @webtest @ROC_OracleWrapper @TEST_MLPQA-2922 @MLPQA-20377 @7276130
  Scenario: SC3#:UI Validation in OraclePostprocess plugin configuration
  1. Verify proper error message is shown if mandatory fields are not filled in OraclePostprocess plugin configuration
  2. Verify captions and tool tip text is displayed for all the fields in OraclePostprocess configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | ROCIDANode  |
    And user "click" on "Add Configuration" button under "ROCIDANode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute         |
      | Type      | Rochade           |
      | Plugin    | OraclePostprocess |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                        |
      | Label                        |
      | Business Application         |
      | Data Source*                 |
      | Credential                   |
      | Plugin version               |
      | Event condition              |
      | Event class                  |
      | Maximum work size            |
      | Node condition               |
      | Auto start                   |
      | Tags                         |
      | Logging Level                |
      | Java memory setting          |
      | ClassPath                    |
      | Log Suspicious SQL           |
      | Log Suspicious SQL Path      |
      | Oracle postprocess Arguments |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                         | Plugin configuration name                                                                                |
      | Label                        | Plugin configuration extended label and description                                                      |
      | Business Application         | Business Application                                                                                     |
      | Plugin version               | Required plugin version                                                                                  |
      | Logging Level                | Logging Level                                                                                            |
      | Java memory setting          | Maximum Java memory setting                                                                              |
      | ClassPath                    | Classpath                                                                                                |
      | Log Suspicious SQL           | Exports SQL to specified folder that caused errors and returned informational messages during processing |
      | Log Suspicious SQL Path      | Path for export of suspicious SQL                                                                        |
      | Oracle postprocess Arguments | Overrides default Oracle postprocess parameters                                                          |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  @webtest @ROC_OracleWrapper @TEST_MLPQA-2906 @MLPQA-20377 @7276153
  Scenario: SC3#:UI Validation in OracleReconcile plugin configuration
  1. Verify proper error message is shown if mandatory fields are not filled in OracleReconcile plugin configuration
  2. Verify captions and tool tip text is displayed for all the fields in OracleReconcile configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | ROCIDANode  |
    And user "click" on "Add Configuration" button under "ROCIDANode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Rochade         |
      | Plugin    | OracleReconcile |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                               |
      | Label                               |
      | Business Application                |
      | Database Seed item (root namespace) |
      | Data Source*                        |
      | Credential*                         |
      | Plugin version                      |
      | Event condition                     |
      | Event class                         |
      | Maximum work size                   |
      | Node condition                      |
      | Auto start                          |
      | Tags                                |
      | Java memory setting                 |
      | Number of threads used              |
      | ClassPath                           |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                                | Plugin configuration name                                                                               |
      | Label                               | Plugin configuration extended label and description                                                     |
      | Business Application                | Business Application                                                                                    |
      | Database Seed item (root namespace) | Specify the Database transformation start item (required only for reconcile by database option)         |
      | Plugin version                      | Required plugin version                                                                                 |
      | Java memory setting                 | Maximum Java memory setting                                                                             |
      | ClassPath                           | Classpath                                                                                               |
      | Number of threads used              | Number of threads used for multi-threading, recommended to set to number of processor kernels available |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user "enter text" in Add Data Source Page
      | fieldName                           | attribute |
      | Database Seed item (root namespace) | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |


  Scenario: SC4-User retrieves Lineage data for Lineage hops E2E Validation
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                                             | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | Oracleviewtosingletable                          |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | Oracleviewtomultipletable                        |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OraclemultipletableForceView                     |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleSingleViewtoView                           |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewfromViewToViewViewToTable              |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewToMultipleTableWithJoin                |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewToMultipleTableWithJoinhavingCondition |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewToMultipleTableGroupbyHaving           |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewWithUnionAll                           |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewFromMultipleTableUsingInnerJoin        |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewNaturaljoin                            |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewSubqueryUsingWhere                     |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewFromComplexStatement                   |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewSubqueryUsingWhereExist                |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OraclecityviewOrderBy                            |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | sales_mv                                         |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleObjectView                                 |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewFromRangePartionedTable                |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewFromListPartionedTable                 |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewFromHashPartionedTable                 |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewfromIndexOrganizedTables               |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewfromMultipleTableWithCondt             |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewfromMultipleView                       |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewToMultipleTableWithJoinDiffSchema      |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcaViewFromDiffSchema                           |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcaViewFromDiffSchemaWithCondt                  |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OracleViewWithClause                             |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                    | bodyFile                          | path                                                               | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.Oracleviewtosingletable                          | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.Oracleviewtomultipletable                        | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OraclemultipletableForceView                     | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleSingleViewtoView                           | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewfromViewToViewViewToTable              | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewToMultipleTableWithJoin                | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewToMultipleTableWithJoinhavingCondition | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewToMultipleTableGroupbyHaving           | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewWithUnionAll                           | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewFromMultipleTableUsingInnerJoin        | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewNaturaljoin                            | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewSubqueryUsingWhere                     | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewFromComplexStatement                   | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewSubqueryUsingWhereExist                | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OraclecityviewOrderBy                            | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.sales_mv                                         | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleObjectView                                 | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewFromRangePartionedTable                | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewFromListPartionedTable                 | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewFromHashPartionedTable                 | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewfromIndexOrganizedTables               | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewfromMultipleTableWithCondt             | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewfromMultipleView                       | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewToMultipleTableWithJoinDiffSchema      | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OrcaViewFromDiffSchema                           | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OrcaViewFromDiffSchemaWithCondt                  | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.OracleViewWithClause                             | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath                                         |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | Oracleviewtosingletable                          |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | Oracleviewtomultipletable                        |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OraclemultipletableForceView                     |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleSingleViewtoView                           |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewfromViewToViewViewToTable              |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewToMultipleTableWithJoin                |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewToMultipleTableWithJoinhavingCondition |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewToMultipleTableGroupbyHaving           |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewWithUnionAll                           |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromMultipleTableUsingInnerJoin        |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewNaturaljoin                            |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewSubqueryUsingWhere                     |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromComplexStatement                   |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewSubqueryUsingWhereExist                |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OraclecityviewOrderBy                            |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | sales_mv                                         |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleObjectView                                 |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromRangePartionedTable                |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromListPartionedTable                 |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromHashPartionedTable                 |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewfromIndexOrganizedTables               |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewfromMultipleTableWithCondt             |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewfromMultipleView                       |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewToMultipleTableWithJoinDiffSchema      |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OrcaViewFromDiffSchema                           |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OrcaViewFromDiffSchemaWithCondt                  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewWithClause                             |

  @ROC_OracleWrapper @MLPQA-20377 @TEST_MLPQA-2902  @7276157 @TEST_MLPQA-2918  @7276137 @TEST_MLPQA-2903  @7276156 	@TEST_MLPQA-2904  @7276155 	@TEST_MLPQA-2905  @7276154	@TEST_MLPQA-2908  @7276151 	@TEST_MLPQA-2909  @7276150 	@TEST_MLPQA-2912  @7276147  @TEST_MLPQA-2913  @7276146 @TEST_MLPQA-2914  @7276143 @TEST_MLPQA-2915  @7276141 @TEST_MLPQA-2916  @7276139 @TEST_MLPQA-2917  @7276138 @TEST_MLPQA-2919  @7276136 @TEST_MLPQA-2920  @7276134
  Scenario Outline: SC4-Lineage Hops End to End Final Validation using API for Views, Functions, Triggers, Procedures
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                          | actual_json                                               | item                                             |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | Oracleviewtosingletable                          |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | Oracleviewtomultipletable                        |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OraclemultipletableForceView                     |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleSingleViewtoView                           |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewfromViewToViewViewToTable              |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewToMultipleTableWithJoin                |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewToMultipleTableWithJoinhavingCondition |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewToMultipleTableGroupbyHaving           |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewWithUnionAll                           |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromMultipleTableUsingInnerJoin        |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewNaturaljoin                            |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewSubqueryUsingWhere                     |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromComplexStatement                   |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewSubqueryUsingWhereExist                |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OraclecityviewOrderBy                            |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | sales_mv                                         |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleObjectView                                 |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromRangePartionedTable                |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromListPartionedTable                 |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewFromHashPartionedTable                 |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewfromIndexOrganizedTables               |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewfromMultipleTableWithCondt             |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewfromMultipleView                       |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewToMultipleTableWithJoinDiffSchema      |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OrcaViewFromDiffSchema                           |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OrcaViewFromDiffSchemaWithCondt                  |
      | ida/OracleWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | OracleViewWithClause                             |


  @ROC_OracleWrapper @TEST_MLPQA-2907 @MLPQA-20377 @7276152
  Scenario: SC#5 Verify the metadata of the collected items
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                                 | Action                    | query                         | ClusterName | ServiceName              | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.OracleDefaultSystem.Description1       | metadataAttributePresence | ServiceQueryWithoutCluster    |             | $$OracleDefaultSystem≫DB |                            |                   |                           |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.OracleDefaultSystem.Description2       | metadataValuePresence     | ServiceQueryWithoutCluster    |             | $$OracleDefaultSystem≫DB |                            |                   |                           |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.PDBDB.Description1                     | metadataAttributePresence | DatabaseQueryWithoutCluster   |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC |                   |                           |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.PDBDB.Description2                     | metadataValuePresence     | DatabaseQueryWithoutCluster   |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC |                   |                           |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.Oracle12c_schema1.Description1         | metadataAttributePresence | SchemaQueryWithoutCluster     |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 |                           |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.Oracle12c_schema1.Description2         | metadataValuePresence     | SchemaQueryWithoutCluster     |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 |                           |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.city.Description1                      | metadataAttributePresence | TableQueryWithoutCluster      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | city                      |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.city.Description2                      | metadataValuePresence     | TableQueryWithoutCluster      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | city                      |                      |
      | Lifecycle   | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.city.Lifecycle1                        | metadataAttributePresence | TableQueryWithoutCluster      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | city                      |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.AREA.Description                       | metadataValuePresence     | ColumnQueryWithoutCluster     |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | city                      | AREA                 |
      | Lifecycle   | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.AREA.Lifecycle                         | metadataAttributePresence | ColumnQueryWithoutCluster     |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | city                      | AREA                 |
      | Statistics  | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.AREA.Statistics                        | metadataValuePresence     | ColumnQueryWithoutCluster     |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | city                      | AREA                 |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.PROV2T.Description                     | metadataValuePresence     | RoutineQueryWithoutCluster    |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | PROT2T≫Procedure          |                      |
      | Lifecycle   | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.PROV2T.Lifecycle                       | metadataAttributePresence | RoutineQueryWithoutCluster    |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | PROT2T≫Procedure          |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.FKEY11.Description                     | metadataValuePresence     | ConstraintQueryWithoutCluster |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | FKEY11                    |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.TRIGGER1.Description                   | metadataValuePresence     | TriggerQueryWithoutCluster    |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGER1                  |                      |
      | Lifecycle   | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.TRIGGER1.Lifecycle                     | metadataAttributePresence | TriggerQueryWithoutCluster    |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGER1                  |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.SQLSource_OCPPTESTFUNCTION.Description | metadataValuePresence     | ContentQuery                  |             |                          |                            |                   | OCPPTESTFUNCTION≫Function |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.SQLSource_PROV2T.Description           | metadataValuePresence     | ContentQuery                  |             |                          |                            |                   | PROV2T≫Procedure          |                      |
      | Description | ida/OracleWrapperPayloads/API/expectedMetadata.json | $.SQLSource_TRIGGER1.Description         | metadataValuePresence     | ContentQuery                  |             |                          |                            |                   | TRIGGER1                  |                      |


  #7276121#
  @ROC_OracleWrapper @TEST_MLPQA-2928 @MLPQA-20377 @7276121
  Scenario:SC#6-Verify Technology tags got assigned after Oracle Items - Tags:  Oracle, ROC
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName              | DatabaseName               | SchemaName        | TableName/Filename | Column | Tags       | Query                         | Action      |
      |             | $$OracleDefaultSystem≫DB |                            |                   |                    |        | Oracle,ROC | ServiceQueryWithoutCluster    | TagAssigned |
      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC |                   |                    |        | Oracle,ROC | DatabaseQueryWithoutCluster   | TagAssigned |
      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 |                    |        | Oracle,ROC | SchemaQueryWithoutCluster     | TagAssigned |
      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | Hospital           |        | Oracle,ROC | TableQueryWithoutCluster      | TagAssigned |
      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | Hospital           | CITY   | Oracle,ROC | ColumnQueryWithoutCluster     | TagAssigned |
      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | PROT2T≫Procedure   |        | Oracle,ROC | RoutineQueryWithoutCluster    | TagAssigned |
      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | FKEY11             |        | Oracle,ROC | ConstraintQueryWithoutCluster | TagAssigned |
      |             | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGER1           |        | Oracle,ROC | TriggerQueryWithoutCluster    | TagAssigned |


  @ROC_OracleWrapper @webtest @TEST_MLPQA-2910 @MLPQA-20377 @7276149
  Scenario:SC#7-Verify breadcrumb hierarchy for Oracle appears correctly for EDIBus collected items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CHECK_ID" and clicks on search
    And user performs "item click" on "CHECK_ID" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | $$OracleDefaultSystem≫DB   |
      | PDBDB19C.DIQ.QA.ASGINT.LOC |
      | ORACLE12C_SCHEMA1          |
      | ORACLE_CHECKTEST           |
      | CHECK_ID                   |


  @ROC_OracleWrapper @webtest @TEST_MLPQA-2925 @MLPQA-20377 @7276125
  Scenario:SC#8-Verify Oracle Wrapper items are collected in DD after running EDIBus plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "$$OracleDefaultSystem≫DB" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Constraint |
      | Trigger    |
      | Schema     |
      | Operation  |
      | Routine    |
      | Database   |
      | Service    |

  Scenario Outline: SC9-user retrieves facets and respective counts of Oracle wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                              | response code | response message | filePath                                                   | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/OracleWrapperPayloads/API/getFacetsCountRequest.json | 200           |                  | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json |          |


  @ROC_OracleWrapper @TEST_MLPQA-2911 @MLPQA-20377 @7276148
  Scenario:SC9#Verify Oracle items count available in DD against Rochade
    And user gets the items count from json
      | filePath                                                   | jsonPath                                          |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Column')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_COLUMN ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                         |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Table')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                           |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Trigger')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_TRIGGER ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                              |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Constraint')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_FOREIGN_KEY ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                          |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Schema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_SCHEMA ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                             |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Operation')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                            |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TRANSFORMATION ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                           |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Routine')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                  |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_FUNCTION OR TYPE = DWR_RDB_PROCEDURE ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                            |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Database')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DATABASE ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                           |
      | payloads/ida/OracleWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Service')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DB_SYSTEM ) |


  @sanity @positive @regression
  Scenario Outline: PostConditions-EDIBusCleanup - after Lineage Verification
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                             | path            | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/EDIBus/EDIBus_Oracle1                            | payloads/ida/OracleWrapperPayloads/configs/plugin/pluginconfigs.json | $.ediBusCleanUp | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Oracle1 |                                                                      |                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Oracle1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Oracle1  |                                                                      |                 | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Oracle1 |                                                                      |                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Oracle1')].status |


  @post-condition
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


##################################################### Filter scenarios #####################################################
  @ROC_OracleWrapper
  Scenario:Filter1: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Includewildcard
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_OracleWrapper
  Scenario Outline:Filter1: Configure plugins: OracleScan, OracleImport for filter scenario: Includewildcard
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | bodyFile | path | response code | response message | jsonPath                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanIncludeWildcard |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanIncludeWildcard')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScan/RochadeOracleScanIncludeWildcard  |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanIncludeWildcard |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanIncludeWildcard')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport            |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status              |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleImport/RochadeOracleImport             |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport            |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status              |

  @ROC_OracleWrapper 	@TEST_MLPQA-2932 @MLPQA-20377 @7276115
  Scenario:Filter1: Verify items in EDI are imported exactly with the filters provided in OracleScan: Includewildcard
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames                                         |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = ORA_SCHEMA ) | ORACLE19C_LINEAGESCHEMA1,ORACLE19C_LINEAGESCHEMA2 |


  @ROC_OracleWrapper
  Scenario:Filter2: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Excludewildcard
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_OracleWrapper
  Scenario Outline:Filter2: Configure plugins: OracleScan, OracleImport for filter scenario: Excludewildcard
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | bodyFile | path | response code | response message | jsonPath                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanExcludeWildcard |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanExcludeWildcard')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScan/RochadeOracleScanExcludeWildcard  |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanExcludeWildcard |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanExcludeWildcard')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport            |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status              |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleImport/RochadeOracleImport             |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport            |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status              |

  @ROC_OracleWrapper @TEST_MLPQA-2930 @MLPQA-20377 @7276119
  Scenario:Filter2: Verify items in EDI are imported exactly with the filters provided in OracleScan: Excludewildcard
    And user connects Rochade Server and "verify itemNames notFound" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames                                         |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = ORA_SCHEMA ) | ORACLE19C_LINEAGESCHEMA1,ORACLE19C_LINEAGESCHEMA2 |


  @ROC_OracleWrapper
  Scenario:Filter3: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: IncludeRegex
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_OracleWrapper 	@TEST_MLPQA-2932 @MLPQA-20377 @7276115
  Scenario Outline:Filter3: Configure plugins: OracleScan, OracleImport for filter scenario: IncludeRegex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile | path | response code | response message | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanIncludeRegEx |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanIncludeRegEx')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScan/RochadeOracleScanIncludeRegEx  |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanIncludeRegEx |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanIncludeRegEx')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleImport/RochadeOracleImport          |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status           |

  @ROC_OracleWrapper
  Scenario:Filter3: Verify items in EDI are imported exactly with the filters provided in OracleScan: IncludeRegex
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames         |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = ORA_SCHEMA ) | ORACLE12C_SCHEMA1 |

  @ROC_OracleWrapper
  Scenario:Filter4: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: ExcludeRegex
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_OracleWrapper
  Scenario Outline:Filter4: Configure plugins: OracleScan, OracleImport for filter scenario: ExcludeRegex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile | path | response code | response message | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanExcludeRegEx |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanExcludeRegEx')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScan/RochadeOracleScanExcludeRegEx  |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanExcludeRegEx |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanExcludeRegEx')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleImport/RochadeOracleImport          |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status           |

  @ROC_OracleWrapper @TEST_MLPQA-2931 @MLPQA-20377 @7276117
  Scenario:Filter4: Verify items in EDI are imported exactly with the filters provided in OracleScan: ExcludeRegex
    And user connects Rochade Server and "verify itemNames notFound" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames         |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = ORA_SCHEMA ) | ORACLE12C_SCHEMA1 |


  @ROC_OracleWrapper
  Scenario:Filter5: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: DateFilter
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_OracleWrapper
  Scenario Outline:Filter5: Configure plugins: OracleScan, OracleImport for filter scenario: DateFilter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | bodyFile | path | response code | response message | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanDateFilter |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanDateFilter')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleScan/RochadeOracleScanDateFilter  |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleScan/RochadeOracleScanDateFilter |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScanDateFilter')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/OracleImport/RochadeOracleImport        |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/OracleImport/RochadeOracleImport       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport')].status         |

  @ROC_OracleWrapper
  Scenario:Filter5: Verify items in EDI are imported exactly with the filters provided in OracleScan: DateFilter
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames         |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = ORA_SCHEMA ) | ORACLE12C_SCHEMA1 |


  #7276123# #7276129# #7276132#
  @ROC_OracleWrapper @webtest @TEST_MLPQA-2926 @MLPQA-20377 @7276123 @TEST_MLPQA-2921 @MLPQA-20377 @7276132 @TEST_MLPQA-2923 @MLPQA-20377 @7276129
  Scenario: SC#13 - Verify the availability of HTML file under analysis items for plugins: OracleScan, OracleImport, OraclePostprocess
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RochadeOracleScanIncludeWildcard" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/OracleScan/RochadeOracleScanIncludeWildcard/%"
    Then user performs click and verify in new window
      | Table | value               | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Oracle-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "RochadeOracleImport" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/OracleImport/RochadeOracleImport/%"
    Then user performs click and verify in new window
      | Table | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Oracle-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "RochadeOraclePostprocess" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/OraclePostprocess/RochadeOraclePostprocess/%"
    Then user performs click and verify in new window
      | Table | value               | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Oracle-PostLog.html | verify widget contains |                  |             |

############################################################# Post Conditions ###########################################################################

  @sanity @positive
  Scenario:PostConditions:Delete ids
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | rochade/Oracle%            | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_Oracle% | Analysis |       |       |


  @cr-data @sanity @positive
  Scenario Outline: PostConditions-Delete the Credentials, Data Sources and Cataloger, Collector, Parser, Lineage plugins Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                            | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScan/RochadeOracleScan                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleImport/RochadeOracleImport            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OraclePostprocess/RochadeOraclePostprocess  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleReconcile/RochadeOracleReconcile      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScan/RochadeOracleScanIncludeWildcard |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScan/RochadeOracleScanExcludeWildcard |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScan/RochadeOracleScanIncludeRegEx    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScan/RochadeOracleScanExcludeRegEx    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScan/RochadeOracleScanDateFilter      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_Oracle1                       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_Oracle2                       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCOracleDataSource/RochadeOracleScanDS     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCOracleDataSource/oracleScanFilterDS      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCOracleSADataSource/RochadeOracleImportDS |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusOracleDS             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeOracleCDBCredentials               |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeOraclePDBCredentials               |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeCredentials                        |      | 200           |                  |          |

