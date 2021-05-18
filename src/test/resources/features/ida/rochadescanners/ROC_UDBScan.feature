@MLPQA-19482
Feature: Verification of Rochade - DD wrapper plugins for UDB DB such as UDBScan, UDBImport, UDBPostprocess, UDBReconcile
#  Stories: @MLP-33342

  @pre-condition @ROC_UDB
  Scenario: Pre: Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @pre-condition @ROC_UDBScript
  Scenario: Headless EDI Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                   | jsonPath                                            | node            |
      | ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.UDBScan.configurations.nodeCondition              | HeadlessEDINode |
      | ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.UDBImport.configurations.nodeCondition            | HeadlessEDINode |
      | ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.UDBPostprocess.configurations.nodeCondition       | HeadlessEDINode |
      | ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.UDBReconcile.configurations.nodeCondition         | HeadlessEDINode |

  @pre-condition @ROC_UDB
  Scenario Outline: Configure Credentials, Data Source for UDB wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | bodyFile                                           | path                 | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeUDBScanCredentials | payloads/ida/ROCUDBPayloads/RocUDBCredentials.json | $.UDBCredentials     | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeUDBScanCredentials |                                                    |                      | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeUDBSACredentials   | payloads/ida/ROCUDBPayloads/RocUDBCredentials.json | $.EDICredentials     | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeUDBSACredentials   |                                                    |                      | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCUDBDataSource            | payloads/ida/ROCUDBPayloads/RocUDBDataSource.json  | $.ROCUDBDataSource   | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCUDBDataSource            |                                                    |                      | 200           | RochadeUDBScanDS   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCUDBSADataSource          | payloads/ida/ROCUDBPayloads/RocUDBDataSource.json  | $.ROCUDBSADataSource | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCUDBSADataSource          |                                                    |                      | 200           | RochadeUDBImportDS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource            | payloads/ida/ROCUDBPayloads/RocUDBDataSource.json  | $.EDIBusDataSource   | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource            |                                                    |                      | 200           | EDIBusUDBDS        |          |

  @pre-condition @ROC_UDB
  Scenario Outline: Configure plugins: UDBScan, UDBImport, UDBPostprocess, UDBReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                            | path                            | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBScan/RochadeUDBScan               | payloads/ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.UDBScan.configurations        | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBScan/RochadeUDBScan               |                                                     |                                 | 200           | RochadeUDBScan        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBImport/RochadeUDBImport           | payloads/ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.UDBImport.configurations      | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBImport/RochadeUDBImport           |                                                     |                                 | 200           | RochadeUDBImport      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBPostprocess/RochadeUDBPostprocess | payloads/ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.UDBPostprocess.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBPostprocess/RochadeUDBPostprocess |                                                     |                                 | 200           | RochadeUDBPostprocess |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/UDBReconcile/RochadeUDBReconcile     | payloads/ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.UDBReconcile.configurations   | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/UDBReconcile/RochadeUDBReconcile     |                                                     |                                 | 200           | RochadeUDBReconcile   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_UDB                    | payloads/ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.EDIBus.configurations         | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_UDB                    |                                                     |                                 | 200           | EDIBus_UDB            |          |

  #################### DataSource TestConnection - UI Validation Error in Mandatory Fields ####################
  @webtest @ROC_UDB @TEST_MLPQA-19483 @MLPQA-18085
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in UDBScan Data source configuration

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | ROCUDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Database Url*              |
      | Database JDBC driver path* |
      | Scan output path*          |
      | UDB version path*          |
      | Credential                 |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                                  | Plugin configuration name                                                                                                                                        |
      | Label                                 | Plugin configuration extended label and description                                                                                                              |
      | Database Url*                         | JDBC url or the JDBC connection string in formats : jdbc:db2://ipaddress:port/subsys_or_db or jdbc:as400://server-address                                        |
      | Database JDBC driver path*            | Path that points to the Database JDBC driver path                                                                                                                |
      | Database JDBC driver license jar path | Path that points to the Database JDBC driver path                                                                                                                |
      | Scan output path*                     | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | UDB version path*                     | Path part name for ScanUDB version                                                                                                                               |
    And user "enter text" in Add Data Source Page
      | fieldName                  | attribute                            |
      | Name                       | ROCUDBDataSourceTest                 |
      | Label                      | ROCUDBDataSourceTest                 |
      | Database Url*              | jdbc:db2://DIQDB211501V:50000/SAMPLE |
      | Database JDBC driver path* | D:\JDBC_Drivers\db2jcc4.jar          |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                 |
      | Credential | RochadeUDBScanCredentials |
      | Node       | ROCIDANode                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Source pop up"

  @webtest @ROC_UDB @TEST_MLPQA-19484 @MLPQA-18085
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in UDBScan SA Data source configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute          |
      | Data Source Type | ROCUDBSADataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*             |
      | Label             |
      | Scan output path* |
      | UDB version path* |
      | Credential        |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name              | Plugin configuration name                                                                                                                                        |
      | Label             | Plugin configuration extended label and description                                                                                                              |
      | Scan output path* | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | UDB version path* | Path part name for ScanUDB version                                                                                                                               |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | UDB version path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName        | errorMessage                               |
      | Name             | Name field should not be empty             |
      | Scan output path | Scan output path field should not be empty |
      | UDB version path | UDB version path field should not be empty |
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName        | attribute                   |
      | Name             | ROCUDBSADataSourceTest      |
      | Label            | ROCUDBSADataSourceTest      |
      | Scan output path | ${rochade.project.home}/UDB |
      | UDB version path | V134                        |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute               |
      | Credential | RochadeUDBSACredentials |
      | Node       | ROCIDANode              |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Source pop up"


  @webtest @ROC_UDB @TEST_MLPQA-19477 @MLPQA-18085
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in UDBScan plugin configuration

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Settings Icon                |
      | click      | Capture And Import Data Icon |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | ROCIDANode |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Type      | Rochade   |
      | Plugin    | UDBScan   |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Business Application |
      | Data Source*         |
      | Credential           |
      | Plugin version       |
      | Event condition      |
      | Event class          |
      | Maximum work size    |
      | Node condition       |
      | Auto start           |
      | Tags                 |
      | Logging Level        |
      | Java memory setting  |
      | ClassPath            |
      | Filter type          |
      | Include Filter       |
      | Exclude Filter       |
      | Date Filter          |
      | udb scan Arguments   |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                 | Plugin configuration name                                                                                |
      | Label                | Plugin configuration extended label and description                                                      |
      | Business Application | Business Application                                                                                     |
      | Plugin version       | Required plugin version                                                                                  |
      | Logging Level        | Logging Level                                                                                            |
      | Java memory setting  | Maximum Java memory setting                                                                              |
      | ClassPath            | Classpath                                                                                                |
      | Date Filter          | Specify a date to scan only those objects that have been modified since this date (including this date). |
      | udb scan Arguments   | Overrides default udb scan parameters                                                                    |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_UDB @TEST_MLPQA-19478 @MLPQA-18085
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in UDBImport plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Settings Icon                |
      | click      | Capture And Import Data Icon |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Type      | Rochade   |
      | Plugin    | UDBImport |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                  |
      | Label                  |
      | Business Application   |
      | Reset dependency links |
      | Data Source*           |
      | Credential             |
      | Plugin version         |
      | Event condition        |
      | Event class            |
      | Maximum work size      |
      | Node condition         |
      | Auto start             |
      | Tags                   |
      | Java memory setting    |
      | Logging Level          |
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

  @webtest @ROC_UDB @TEST_MLPQA-19479 @MLPQA-18085
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in UDBPostprocess plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Settings Icon                |
      | click      | Capture And Import Data Icon |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Rochade        |
      | Plugin    | UDBPostprocess |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                     |
      | Label                     |
      | Business Application      |
      | Data Source*              |
      | Credential                |
      | Plugin version            |
      | Event condition           |
      | Event class               |
      | Maximum work size         |
      | Node condition            |
      | Auto start                |
      | Tags                      |
      | Logging Level             |
      | Java memory setting       |
      | ClassPath                 |
      | Log Suspicious SQL        |
      | Log Suspicious SQL Path   |
      | UDB postprocess Arguments |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                      | Plugin configuration name                                                                                |
      | Label                     | Plugin configuration extended label and description                                                      |
      | Business Application      | Business Application                                                                                     |
      | Plugin version            | Required plugin version                                                                                  |
      | Logging Level             | Logging Level                                                                                            |
      | Java memory setting       | Maximum Java memory setting                                                                              |
      | ClassPath                 | Classpath                                                                                                |
      | Log Suspicious SQL        | Exports SQL to specified folder that caused errors and returned informational messages during processing |
      | Log Suspicious SQL Path   | Path for export of suspicious SQL                                                                        |
      | UDB postprocess Arguments | Overrides default UDB postprocess parameters                                                             |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_UDB @TEST_MLPQA-19480 @MLPQA-18085
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in UDBReconcile plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Settings Icon                |
      | click      | Capture And Import Data Icon |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Rochade      |
      | Plugin    | UDBReconcile |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                               |
      | Label                               |
      | Business Application                |
      | Reconcile category                  |
      | Server Seed item (root namespace)*  |
      | Database Seed item (root namespace) |
      | Data Source*                        |
      | Credential                          |
      | Plugin version                      |
      | Event condition                     |
      | Event class                         |
      | Maximum work size                   |
      | Node condition                      |
      | Auto start                          |
      | Tags                                |
      | Java memory setting                 |
      | ClassPath                           |
      | Number of threads used              |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                                | Plugin configuration name                                                                               |
      | Label                               | Plugin configuration extended label and description                                                     |
      | Business Application                | Business Application                                                                                    |
      | Reconcile category                  | Reconcile category (UDB server or database)                                                             |
      | Server Seed item (root namespace)*  | Specify the Server transformation start item                                                            |
      | Database Seed item (root namespace) | Specify the Database transformation start item (required only for reconcile by database option)         |
      | Plugin version                      | Required plugin version                                                                                 |
      | Java memory setting                 | Maximum Java memory setting                                                                             |
      | ClassPath                           | Classpath                                                                                               |
      | Number of threads used              | Number of threads used for multi-threading, recommended to set to number of processor kernels available |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user "enter text" in Add Data Source Page
      | fieldName                          | attribute |
      | Server Seed item (root namespace)* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName                         | errorMessage                                                |
      | Name                              | Name field should not be empty                              |
      | Server Seed item (root namespace) | Server Seed item (root namespace) field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #################################################### Plugin Run #####################################################

  @ROC_UDB
  Scenario Outline: Run UDBScan Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "60000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | bodyFile | path | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScan/RochadeUDBScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScan/RochadeUDBScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/ROCIDANode/rochade/UDBScan/RochadeUDBScan  |          |      | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/ROCIDANode/rochade/UDBScan/RochadeUDBScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeUDBScan')].status |

  @ROC_UDB
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
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_UDB                     |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_UDB')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_UDB                      |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_UDB                     |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_UDB')].status            |

  @ROC_UDB
  Scenario Outline: Sync Solr
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | searches/fulltext/synchronize/Default |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post   | searches/fulltext/synchronize/Default |          |      | 200           |                  |          |


  ##################################################### Verifications #####################################################
  @ROC_UDB @TEST_MLPQA-19476 @MLPQA-18085
  Scenario: Verify the Logging Enhancements - Analysis logs for UDBScan UDBImport, UDBLink, UDBReconcile plugins
    Given Analysis log "rochade/UDBScan/RochadeUDBScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                           | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                     | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:UDBScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeUDBScan | ANALYSIS-0071 | UDBScan    | Plugin Version |
      | INFO | Plugin UDBScan Start Time:2020-11-24 07:38:33.752, End Time:2020-11-24 07:39:50.714, Processed Count:0, Errors:0, Warnings:0                                                       | ANALYSIS-0072 | UDBScan    |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                     | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/UDBImport/RochadeUDBImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                               | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                         | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:UDBImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeUDBImport | ANALYSIS-0071 | UDBImport  | Plugin Version |
      | INFO | Plugin UDBImport Start Time:2020-11-24 07:40:06.244, End Time:2020-11-24 07:40:50.591, Processed Count:0, Errors:0, Warnings:0                                                         | ANALYSIS-0072 | UDBImport  |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                         | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/UDBPostprocess/RochadeUDBPostprocess%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                         | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                   | ANALYSIS-0019 |                |                |
      | INFO | Plugin Name:UDBPostprocess, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeUDBPostprocess | ANALYSIS-0071 | UDBPostprocess | Plugin Version |
      | INFO | Plugin UDBPostprocess Start Time:2020-11-24 07:41:08.602, End Time:2020-11-24 07:44:22.364, Processed Count:0, Errors:0, Warnings:0                                                              | ANALYSIS-0072 | UDBPostprocess |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                   | ANALYSIS-0020 |                |                |
    And Analysis log "rochade/UDBReconcile/RochadeUDBReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                     | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                               | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:UDBReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeUDBReconcile | ANALYSIS-0071 | UDBReconcile | Plugin Version |
      | INFO | Plugin UDBReconcile Start Time:2020-11-24 07:44:42.731, End Time:2020-11-24 07:52:48.274, Processed Count:0, Errors:0, Warnings:0                                                            | ANALYSIS-0072 | UDBReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                               | ANALYSIS-0020 |              |                |

  @webtest @ROC_UDB @TEST_MLPQA-19474 @MLPQA-18085
  Scenario: Verify the availability of HTML file under analysis items for plugins: UDBScan, UDBImport, UDBPostprocess
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/UDBScan/RochadeUDBScan/%"
    Then user performs click and verify in new window
      | Table | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanUDB-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/UDBImport/RochadeUDBImport%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanUDB-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/UDBPostprocess/RochadeUDBPostprocess%"
    Then user performs click and verify in new window
      | Table | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanUDB-PostLog.html | verify widget contains |                  |             |
    And user should be able logoff the IDC

  @ROC_UDB
  Scenario Outline:  user retrieves facets and respective counts of UDB wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                   | response code | response message | filePath                                        | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCUDBPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCUDBPayloads/facetWiseCount.json |          |

  @ROC_UDB @TEST_MLPQA-19473 @MLPQA-18085
  Scenario: Verify the UDB items in EDI matched with items in DD UI
    And user gets the items count from json
      | filePath                                        | jsonPath                                          |
      | payloads/ida/ROCUDBPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Column')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_COLUMN ) |
    And user gets the items count from json
      | filePath                                        | jsonPath                                         |
      | payloads/ida/ROCUDBPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Table')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user gets the items count from json
      | filePath                                        | jsonPath                                              |
      | payloads/ida/ROCUDBPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Constraint')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_FOREIGN_KEY ) |
    And user gets the items count from json
      | filePath                                        | jsonPath                                          |
      | payloads/ida/ROCUDBPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Schema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_SCHEMA ) |
    And user gets the items count from json
      | filePath                                        | jsonPath                                             |
      | payloads/ida/ROCUDBPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Operation')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                            |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TRANSFORMATION ) |
    And user gets the items count from json
      | filePath                                        | jsonPath                                           |
      | payloads/ida/ROCUDBPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Routine')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                  |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_FUNCTION OR TYPE = DWR_RDB_PROCEDURE ) |
    And user gets the items count from json
      | filePath                                        | jsonPath                                            |
      | payloads/ida/ROCUDBPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Database')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                               |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ((TA DWR_RDB_DB_CATEGORY = STR UDB)) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DATABASE ) |
    And user gets the items count from json
      | filePath                                        | jsonPath                                           |
      | payloads/ida/ROCUDBPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Service')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DB_SYSTEM ) |

  @webtest @ROC_UDB @TEST_MLPQA-19472 @MLPQA-18085
  Scenario: 1. Verify the breadcrumb hierarchy appears correctly when UDB Rochade items are replicated to DD after running EDIBus plugin
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
    And user enters the search text "AGE" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "triggertable2 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "AGE" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | DIQDB211501V≫DB   |
      | SAMPLE            |
      | UDBWrapperLineage |
      | triggertable2     |
      | AGE               |
    And user enters the search text "childcityview" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "UDBWrapperLineage [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "childcityview" item from search results
    Then user performs click and verify in new window
      | Table        | value        | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | basecityview | verify widget contains | No               |             |
      | SQLSource    | SQLSource    | verify widget contains | No               |             |
    And user should be able logoff the IDC

  @ROC_UDB @TEST_MLPQA-19485 @MLPQA-18085
  Scenario: Metadata verification for Service, Database, Schema, Table, Column, Constraint, Routine (Function and Procedure)
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                 | jsonPath                         | Action                    | query                         | ClusterName | ServiceName     | DatabaseName | SchemaName        | TableName/Filename       | columnName/FieldName |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.ServiceMetadata.Description1   | metadataAttributePresence | ServiceQueryWithoutCluster    |             | DIQDB211501V≫DB |              |                   |                          |                      |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.ServiceMetadata.Description2   | metadataValuePresence     | ServiceQueryWithoutCluster    |             | DIQDB211501V≫DB |              |                   |                          |                      |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.DatabaseMetadata.Description1  | metadataAttributePresence | DatabaseQueryWithoutCluster   |             | DIQDB211501V≫DB | SAMPLE       |                   |                          |                      |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.DatabaseMetadata.Description2  | metadataValuePresence     | DatabaseQueryWithoutCluster   |             | DIQDB211501V≫DB | SAMPLE       |                   |                          |                      |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.SchemaMetadata.Description1    | metadataAttributePresence | SchemaQueryWithoutCluster     |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage |                          |                      |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.SchemaMetadata.Description2    | metadataValuePresence     | SchemaQueryWithoutCluster     |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage |                          |                      |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.TableMetadata.Description1     | metadataAttributePresence | TableQueryWithoutCluster      |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL                   |                      |
      | Lifecycle   | ida/ROCUDBPayloads/expectedMetadata.json | $.TableMetadata.Lifecycle1       | metadataAttributePresence | TableQueryWithoutCluster      |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL                   |                      |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.TableMetadata.Description2     | metadataValuePresence     | TableQueryWithoutCluster      |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL                   |                      |
      | Lifecycle   | ida/ROCUDBPayloads/expectedMetadata.json | $.ColumnMetadata.Lifecycle       | metadataAttributePresence | ColumnQueryWithoutCluster     |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL                   | SCHOOLID             |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.ColumnMetadata.Description     | metadataValuePresence     | ColumnQueryWithoutCluster     |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL                   | SCHOOLID             |
      | Statistics  | ida/ROCUDBPayloads/expectedMetadata.json | $.ColumnMetadata.Statistics      | metadataValuePresence     | ColumnQueryWithoutCluster     |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL                   | SCHOOLID             |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.RoutineMetadata.Description    | metadataValuePresence     | RoutineQueryWithoutCluster    |             | DIQDB211501V≫DB | SAMPLE       | DMITRYK           | BONUS_INCREASE≫Procedure |                      |
      | Lifecycle   | ida/ROCUDBPayloads/expectedMetadata.json | $.RoutineMetadata.Lifecycle      | metadataAttributePresence | RoutineQueryWithoutCluster    |             | DIQDB211501V≫DB | SAMPLE       | DMITRYK           | BONUS_INCREASE≫Procedure |                      |
      | Description | ida/ROCUDBPayloads/expectedMetadata.json | $.ConstraintMetadata.Description | metadataValuePresence     | ConstraintQueryWithoutCluster |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL.FKEY12            |                      |


  @ROC_UDB @TEST_MLPQA-19471 @MLPQA-18085 @TEST_MLPQA-19475 @MLPQA-18085
  Scenario: 1. Verify Technology tags for replicated items after running UDB related & EDIBus plugin
  2. Verify the Technology tags for Analysis item for UDBScan, UDBImport, UDBLink, UDBReconcile plugins
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName     | DatabaseName | SchemaName        | TableName/Filename                            | Column   | Tags    | Query                         | Action      |
      |             | DIQDB211501V≫DB |              |                   |                                               |          | DB2,ROC | ServiceQueryWithoutCluster    | TagAssigned |
      |             | DIQDB211501V≫DB | SAMPLE       |                   |                                               |          | DB2,ROC | DatabaseQueryWithoutCluster   | TagAssigned |
      |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage |                                               |          | DB2,ROC | SchemaQueryWithoutCluster     | TagAssigned |
      |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL                                        |          | DB2,ROC | TableQueryWithoutCluster      | TagAssigned |
      |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL                                        | SCHOOLID | DB2,ROC | ColumnQueryWithoutCluster     | TagAssigned |
      |             | DIQDB211501V≫DB | SAMPLE       | DMITRYK           | BONUS_INCREASE≫Procedure                      |          | DB2,ROC | RoutineQueryWithoutCluster    | TagAssigned |
      |             | DIQDB211501V≫DB | SAMPLE       | UDBWrapperLineage | SCHOOL.FKEY12                                 |          | DB2,ROC | ConstraintQueryWithoutCluster | TagAssigned |
      |             |                 |              |                   | rochade/UDBScan/RochadeUDBScan%               |          | DB2,ROC | AnalysisQuery                 | TagAssigned |
      |             |                 |              |                   | rochade/UDBImport/RochadeUDBImport%           |          | DB2,ROC | AnalysisQuery                 | TagAssigned |
      |             |                 |              |                   | rochade/UDBPostprocess/RochadeUDBPostprocess% |          | DB2,ROC | AnalysisQuery                 | TagAssigned |
      |             |                 |              |                   | rochade/UDBReconcile/RochadeUDBReconcile%     |          | DB2,ROC | AnalysisQuery                 | TagAssigned |
      |             |                 |              |                   | bulk/EDIBus/EDIBus_UDB%                       |          | DB2,ROC | AnalysisQuery                 | TagAssigned |

  ##################################################### Post Conditions #####################################################
  @post-condition @ROC_UDB
  Scenario Outline: Configure EDIBus plugin to perform clean up
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                             | bodyFile                                            | path                           | response code | response message | jsonPath                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_UDB                            | payloads/ida/ROCUDBPayloads/RocUDBPluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_UDB                            |                                                     |                                | 200           | EDIBus_UDB       |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_UDB |                                                     |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_UDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_UDB  |                                                     |                                | 200           |                  |                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_UDB |                                                     |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_UDB')].status |

  @webtest @post-condition @ROC_UDB @TEST_MLPQA-19481 @MLPQA-18085
  Scenario: Verify all item types collected from UDB Rochade are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
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

  @post-condition @ROC_UDB
  Scenario: PS_Clearing the EDI subject area after running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @post-condition @ROC_UDB
  Scenario:  Delete the analysis items for plugins: UDBScan, UDBImport, UDBPostprocess, UDBReconcile, EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | MultipleIDDelete | Default | rochade/UDBScan/RochadeUDBScan%               | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBImport/RochadeUDBImport%           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBPostprocess/RochadeUDBPostprocess% | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/UDBReconcile/RochadeUDBReconcile%     | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_UDB%                       | Analysis |       |       |
      | MultipleIDDelete | Default | datasource/ROCUDBSADataSource/%               | Analysis |       |       |


  @post-condition @ROC_UDB
  Scenario Outline:  Delete Credentials, Datasource and plugin config for UDBScan, UDBImport, UDBPostprocess, UDBReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                     | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBScan                              |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBImport/RochadeUDBImport           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBPostprocess/RochadeUDBPostprocess |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBReconcile/RochadeUDBReconcile     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_UDB                    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCUDBDataSource                     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCUDBSADataSource                   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeUDBScanCredentials          |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeUDBSACredentials            |          |      | 200           |                  |          |
