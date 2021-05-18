@MLPQA-20309
@REQ_MLP-30513
Feature: Verification of Rochade-DD wrapper plugins for MicroStrategy such as MicroStrategyScan, MicroStrategyImport, MicroStrategyLink, MicroStrategyReconcile
#  Stories: @MLP-32443

  #################################################### Pre-Conditions #####################################################
  @pre-condition @ROC_MicroStrategy
  Scenario: Pre: Clearing the EDI subject area before running the Rochade MicroStrategy wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @pre-condition @ROC_MicroStrategy
  Scenario:Headless EDI Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                                       | jsonPath                                          | node            |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.MicroStrategyScan.nodeCondition                 | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.MicroStrategyImport.nodeCondition               | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.MicroStrategyLink.nodeCondition                 | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.MicroStrategyReconcile.nodeCondition            | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC1.nodeCondition | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC2.nodeCondition | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC3.nodeCondition | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC4.nodeCondition | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC5.nodeCondition | HeadlessEDINode |
      | ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC6.nodeCondition | HeadlessEDINode |

  @pre-condition @ROC_MicroStrategy
  Scenario Outline: Configure Credentials, Data Source for MicroStrategy wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                                             | bodyFile                                                               | path                                       | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeMicroStrategyCredentials                                                            | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyCredentials.json | $.MicroStrategyCredentials                 | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeMicroStrategyCredentials                                                            |                                                                        |                                            | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeMicroStrategySACredentials                                                          | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyCredentials.json | $.SACredentials                            | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeMicroStrategySACredentials                                                          |                                                                        |                                            | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCMicroStrategyServerDatasource/RochadeMicroStrategyDS                                      | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyDataSource.json  | $.ROCMicroStrategyServerDatasource         | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCMicroStrategyServerDatasource/RochadeMicroStrategyDS                                      |                                                                        |                                            | 200           | RochadeMicroStrategyDS   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCMicroStrategySADataSource/RochadeMicroStrategySADS                                        | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyDataSource.json  | $.ROCMicroStrategySADataSource             | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCMicroStrategySADataSource/RochadeMicroStrategySADS                                        |                                                                        |                                            | 200           | RochadeMicroStrategySADS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource/EDIBusMicroStrategyDS                                                       | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyDataSource.json  | $.EDIBusDataSource                         | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource/EDIBusMicroStrategyDS                                                       |                                                                        |                                            | 200           | EDIBusMicroStrategyDS    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCMicroStrategyServerDatasource/ROCMicroStrategyServerDatasource_TEST_DEFAULT_CONFIGURATION | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyDataSource.json  | $.ROCMicroStrategyServerDatasource_Default | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCMicroStrategySADataSource/ROCMicroStrategySADataSource_TEST_DEFAULT_CONFIGURATION         | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyDataSource.json  | $.ROCMicroStrategySADataSource_Default     | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource/EDIBusDataSource_TEST_DEFAULT_CONFIGURATION                                 | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyDataSource.json  | $.EDIBusDataSource_Default                 | 204           |                          |          |

  @pre-condition @ROC_MicroStrategy
  Scenario Outline: Configure plugins: MicroStrategyScan, MicroStrategyImport, MicroStrategyLink, MicroStrategyReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                     | bodyFile                                                                | path                     | response code | response message              | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScan           | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.MicroStrategyScan      | 204           |                               |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScan           |                                                                         |                          | 200           | RochadeMicroStrategyScan      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyImport/RochadeMicroStrategyImport       | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.MicroStrategyImport    | 204           |                               |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyImport/RochadeMicroStrategyImport       |                                                                         |                          | 200           | RochadeMicroStrategyImport    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyLink/RochadeMicroStrategyLink           | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.MicroStrategyLink      | 204           |                               |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyLink/RochadeMicroStrategyLink           |                                                                         |                          | 200           | RochadeMicroStrategyLink      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyReconcile/RochadeMicroStrategyReconcile | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.MicroStrategyReconcile | 204           |                               |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyReconcile/RochadeMicroStrategyReconcile |                                                                         |                          | 200           | RochadeMicroStrategyReconcile |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_MicroStrategy                          | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.EDIBus                 | 204           |                               |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_MicroStrategy                          |                                                                         |                          | 200           | EDIBus_MicroStrategy          |          |

  @pre-condition @ROC_MicroStrategy
  Scenario Outline: Configure plugins: MicroStrategyScan filters scenarios
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                    | bodyFile                                                                | path                                | response code | response message                  | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC1 | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC1 | 204           |                                   |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC1 |                                                                         |                                     | 200           | RochadeMicroStrategyScanFilterSC1 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC2 | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC2 | 204           |                                   |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC2 |                                                                         |                                     | 200           | RochadeMicroStrategyScanFilterSC2 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC3 | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC3 | 204           |                                   |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC3 |                                                                         |                                     | 200           | RochadeMicroStrategyScanFilterSC3 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC4 | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC4 | 204           |                                   |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC4 |                                                                         |                                     | 200           | RochadeMicroStrategyScanFilterSC4 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC5 | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC5 | 204           |                                   |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC5 |                                                                         |                                     | 200           | RochadeMicroStrategyScanFilterSC5 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC6 | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.RochadeMicroStrategyScanFilterSC6 | 204           |                                   |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC6 |                                                                         |                                     | 200           | RochadeMicroStrategyScanFilterSC6 |          |


  #################################################### UI Validations #####################################################
  @webtest @ROC_MicroStrategy @TEST_MLPQA-20290 @REQ_MLP-32443 @MLPQA-20287 @TEST_MLPQA-20292 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify the datasource test connection is successful for ROCMicroStrategyServerDatasource in HeadlessEDINode
  2. Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in ROCMicroStrategyServerDatasource configuration

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                        |
      | Data Source Type | ROCMicroStrategyServerDatasource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                            |
      | Label                            |
      | Intelligence Server name or IP*  |
      | Intelligence Server port number* |
      | Scan output path*                |
      | MicroStrategy version path*      |
      | Credential                       |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                             | Plugin configuration name                                                                                                                                        |
      | Label                            | Plugin configuration extended label and description                                                                                                              |
      | Intelligence Server name or IP*  | Specify the MicroStrategy Intelligence Server's host name or IP address.                                                                                         |
      | Intelligence Server port number* | Specify the MicroStrategy Intelligence Server's port number. The default port number is 34952.                                                                   |
      | Scan output path*                | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | MicroStrategy version path       | Path part name for MicroStrategy version                                                                                                                         |
    And user "enter text" in Add Data Source Page
      | fieldName                       | attribute |
      | Name                            |           |
      | Intelligence Server name or IP* |           |
    And user "enter text" in Add Data Source Page
      | fieldName                        | attribute |
      | Intelligence Server port number* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute |
      | MicroStrategy version path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName                       | errorMessage                                              |
      | Name                            | Name field should not be empty                            |
      | Intelligence Server name or IP  | Intelligence Server name or IP field should not be empty  |
      | Intelligence Server port number | Intelligence Server port number field should not be empty |
      | Scan output path                | Scan output path field should not be empty                |
      | MicroStrategy version path      | MicroStrategy version path field should not be empty      |
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName                        | attribute                            |
      | Name                             | ROCMicroStrategyServerDataSourceTest |
      | Label                            | ROCMicroStrategyServerDataSourceTest |
      | Intelligence Server name or IP*  | 10.50.206.32                         |
      | Intelligence Server port number* | 34952                                |
      | Scan output path                 | ${rochade.project.home}/scanmcs      |
      | MicroStrategy version path       | V221                                 |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                       |
      | Credential | RochadeMicroStrategyCredentials |
      | Node       | ScanMCSNode                     |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20293 @REQ_MLP-32443 @MLPQA-20287 @TEST_MLPQA-20295 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify the datasource test connection is successful for ROCMicroStrategySADataSource in HeadlessEDINode
  2. Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in ROCMicroStrategySADataSource configuration

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                    |
      | Data Source Type | ROCMicroStrategySADataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                       |
      | Label                       |
      | Scan output path*           |
      | MicroStrategy version path* |
      | Credential                  |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                       | Plugin configuration name                                                                                                                                        |
      | Label                      | Plugin configuration extended label and description                                                                                                              |
      | Scan output path*          | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | MicroStrategy version path | Path part name for MicroStrategy version                                                                                                                         |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute |
      | MicroStrategy version path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName                  | errorMessage                                         |
      | Name                       | Name field should not be empty                       |
      | Scan output path           | Scan output path field should not be empty           |
      | MicroStrategy version path | MicroStrategy version path field should not be empty |
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName                  | attribute                        |
      | Name                       | ROCMicroStrategySADataSourceTest |
      | Label                      | ROCMicroStrategySADataSourceTest |
      | Scan output path           | ${rochade.project.home}/scanmcs  |
      | MicroStrategy version path | V221                             |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                         |
      | Credential | RochadeMicroStrategySACredentials |
      | Node       | ScanMCSNode                       |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20296 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in MicroStrategyScan plugin configuration

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem  |
      | Open Deployment | ScanMCSNode |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute         |
      | Type      | Rochade           |
      | Plugin    | MicroStrategyScan |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Business Application |
      | Include Filters      |
      | Exclude Filters      |
      | Data Source*         |
      | Credential*          |
      | Plugin version       |
      | Event condition      |
      | Event class          |
      | Maximum work size    |
      | Node condition       |
      | Auto start           |
      | Tags                 |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                 | Plugin configuration name                                     |
      | Label                | Plugin configuration extended label and description           |
      | Business Application | Business Application                                          |
      | Include Filters      | Added expressions will be used to filter project by its name  |
      | Exclude Filters      | Added expressions will be used to exclude project by its name |
      | Plugin version       | Required plugin version                                       |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20297 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in MicroStrategyImport plugin configuration

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem  |
      | Open Deployment | ScanMCSNode |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Type      | Rochade             |
      | Plugin    | MicroStrategyImport |
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
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                 | Plugin configuration name                           |
      | Label                | Plugin configuration extended label and description |
      | Business Application | Business Application                                |
      | Plugin version       | Required plugin version                             |
      | Logging Level        | Logging Level                                       |
      | Java memory setting  | Maximum Java memory setting                         |
      | ClassPath            | Classpath                                           |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20298 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in MicroStrategyLink plugin configuration

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem  |
      | Open Deployment | ScanMCSNode |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute         |
      | Type      | Rochade           |
      | Plugin    | MicroStrategyLink |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                  |
      | Label                  |
      | Business Application   |
      | Data Source*           |
      | Credential             |
      | Plugin version         |
      | Event condition        |
      | Event class            |
      | Maximum work size      |
      | Node condition         |
      | ODBC Scan result files |
      | Auto start             |
      | Tags                   |
      | Logging Level          |
      | Java memory setting    |
      | ClassPath              |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                   | Plugin configuration name                                                                                        |
      | Label                  | Plugin configuration extended label and description                                                              |
      | Business Application   | Business Application                                                                                             |
      | Plugin version         | Required plugin version                                                                                          |
      | Logging Level          | Logging Level                                                                                                    |
      | Java memory setting    | Maximum Java memory setting                                                                                      |
      | ClassPath              | Classpath                                                                                                        |
      | ODBC Scan result files | Name of the ODBC scan result file Specify a file name the ODBC scanner should use for the ODBC definitions scan. |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20299 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in MicroStrategyReconcile plugin configuration

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem  |
      | Open Deployment | ScanMCSNode |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | Rochade                |
      | Plugin    | MicroStrategyReconcile |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                   |
      | Label                   |
      | Business Application    |
      | Report Server seed item |
      | Data Source*            |
      | Credential              |
      | Plugin version          |
      | Event condition         |
      | Event class             |
      | Maximum work size       |
      | Node condition          |
      | Auto start              |
      | Tags                    |
      | Java memory setting     |
      | ClassPath               |
      | Number of threads used  |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                    | Plugin configuration name                                                                               |
      | Label                   | Plugin configuration extended label and description                                                     |
      | Business Application    | Business Application                                                                                    |
      | Report Server seed item | Specify the transformation start item name (for type MCS_REPORT_SERVER)                                 |
      | Plugin version          | Required plugin version                                                                                 |
      | Java memory setting     | Maximum Java memory setting                                                                             |
      | ClassPath               | Classpath                                                                                               |
      | Number of threads used  | Number of threads used for multi-threading, recommended to set to number of processor kernels available |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    
    
  #################################################### Plugin Run #####################################################
  @ROC_MicroStrategy
  Scenario Outline: Run MicroStrategyScan, MicroStrategyImport, MicroStrategyLink, MicroStrategyReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                  | bodyFile | path | response code | response message | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScan           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScan')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScan            |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScan           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScan')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport        |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyLink/RochadeMicroStrategyLink           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyLink')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyLink/RochadeMicroStrategyLink            |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyLink/RochadeMicroStrategyLink           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyLink')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyReconcile/RochadeMicroStrategyReconcile |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyReconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyReconcile/RochadeMicroStrategyReconcile  |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyReconcile/RochadeMicroStrategyReconcile |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyReconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MicroStrategy                            |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MicroStrategy')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_MicroStrategy                             |          |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MicroStrategy                            |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MicroStrategy')].status          |

    
  ##################################################### Verifications #####################################################
  @ROC_MicroStrategy @TEST_MLPQA-20300 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify the Logging Enhancements - Analysis logs for MicroStrategyScan, MicroStrategyImport, MicroStrategyLink, MicroStrategyReconcile
    Given Analysis log "rochade/MicroStrategyScan/RochadeMicroStrategyScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                 | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                           | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:MicroStrategyScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ScanMCSNode, Host Name:DIDMICROSC01V.DID.DEV.ASGINT.LOC, Plugin Configuration name:RochadeMicroStrategyScan | ANALYSIS-0071 | MicroStrategyScan | Plugin Version |
      | INFO | Plugin MicroStrategyScan Start Time:2021-03-09 00:28:19.847, End Time:2021-03-09 00:31:51.995, Errors:0, Warnings:1                                                                                      | ANALYSIS-0072 | MicroStrategyScan |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                | ANALYSIS-0020 |                   |                |
    And Analysis log "rochade/MicroStrategyImport/RochadeMicroStrategyImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                     | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                               | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:MicroStrategyImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ScanMCSNode, Host Name:DIDMICROSC01V.DID.DEV.ASGINT.LOC, Plugin Configuration name:RochadeMicroStrategyImport | ANALYSIS-0071 | MicroStrategyImport | Plugin Version |
      | INFO | Plugin MicroStrategyImport Start Time:2021-03-09 00:32:11.965, End Time:2021-03-09 00:33:19.743, Errors:0, Warnings:0                                                                                        | ANALYSIS-0072 | MicroStrategyImport |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                    | ANALYSIS-0020 |                     |                |
    And Analysis log "rochade/MicroStrategyLink/RochadeMicroStrategyLink%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                 | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                           | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:MicroStrategyLink, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ScanMCSNode, Host Name:DIDMICROSC01V.DID.DEV.ASGINT.LOC, Plugin Configuration name:RochadeMicroStrategyLink | ANALYSIS-0071 | MicroStrategyLink | Plugin Version |
      | INFO | Plugin MicroStrategyLink Start Time:2021-03-09 00:33:32.756, End Time:2021-03-09 00:33:47.020, Errors:2, Warnings:0                                                                                      | ANALYSIS-0072 | MicroStrategyLink |                |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:14.264)                                                                                                                               | ANALYSIS-0075 |                   |                |
    And Analysis log "rochade/MicroStrategyReconcile/RochadeMicroStrategyReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                           | logCode       | pluginName             | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                     | ANALYSIS-0019 |                        |                |
      | INFO | Plugin Name:MicroStrategyReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ScanMCSNode, Host Name:DIDMICROSC01V.DID.DEV.ASGINT.LOC, Plugin Configuration name:RochadeMicroStrategyReconcile | ANALYSIS-0071 | MicroStrategyReconcile | Plugin Version |
      | INFO | Plugin MicroStrategyReconcile Start Time:2021-03-09 00:34:03.249, End Time:2021-03-09 00:39:06.566, Errors:2, Warnings:0                                                                                           | ANALYSIS-0072 | MicroStrategyReconcile |                |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:14.264)                                                                                                                                         | ANALYSIS-0075 |                        |                |

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20302 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify the availability of HTML file under analysis items for plugins: MicroStrategyImport, MicroStrategyLink
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "rochade/MicroStrategyImport" and clicks on search
    And user performs "facet selection" in "MicroStrategy" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/MicroStrategyImport/RochadeMicroStrategyImport%"
    Then user performs click and verify in new window
      | Table | value                        | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MicroStrategy-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "rochade/MicroStrategyLink" and clicks on search
    And user performs "facet selection" in "MicroStrategy" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/MicroStrategyLink/RochadeMicroStrategyLink%"
    Then user performs click and verify in new window
      | Table | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MicroStrategy-DBLinkerLog.html | verify widget contains |                  |             |
    And user should be able logoff the IDC

  @ROC_MicroStrategy
  Scenario Outline:  user retrieves facets and respective counts of MicroStrategy wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                             | response code | response message | filePath                                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCMicroStrategyPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json |          |


  @ROC_MicroStrategy @TEST_MLPQA-20304 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify the items in EDI matched with items in DD UI after executing MicroStrategy related plugins
    Given user gets the items count from json
      | filePath                                                  | jsonPath                                             |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='DataField')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_FIELD ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                           |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Measure')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_MEMBER ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                          |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Report')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_REPORT ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                            |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='DataType')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_STRUCTURE ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                                 |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='ReportPackage')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_PACKAGE ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                                |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='ReportSchema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_SCHEMA ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                             |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Dimension')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_DIMENSION ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                              |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='OlapSchema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_OLAP_SCHEMA ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                                    |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='AggregationLevel')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_LEVEL ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                             |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Hierarchy')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_HIERARCHY ) |
    And  user gets the items count from json
      | filePath                                                  | jsonPath                                               |
      | payloads/ida/ROCMicroStrategyPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='OlapPackage')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_OLAP_PACKAGE ) |

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20303 @REQ_MLP-32443 @MLPQA-20287 @TEST_MLPQA-20307 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify MicroStrategy Rochade items are replicated to DD after running EDIBus plugin like OlapPackage, OlapSchema, Dimension, Measure
  2. Verify the breadcrumb hierarchy appears correctly when MicroStrategy Rochade items are replicated to DD after running EDIBus plugin.

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | DataField        |
      | Measure          |
      | Report           |
      | DataType         |
      | ReportPackage    |
      | ReportSchema     |
      | Dimension        |
      | OlapSchema       |
      | AggregationLevel |
      | Hierarchy        |
      | Analysis         |
      | OlapPackage      |
    And user enters the search text "F01" and clicks on search
    And user performs "facet selection" in "DataField" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "F01 [Filter]" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | MicroStrategy Tutorial              |
      | MicroStrategy Tutorial              |
      | Public Objects                      |
      | Reports                             |
      | MicroStrategy Platform Capabilities |
      | Advanced Analytics                  |
      | Statistics and Forecasting          |
      | Confidence Level                    |
      | Confidence Level                    |
      | Valuable Customers 01               |
      | F01 [Filter]                        |
    And user should be able logoff the IDC

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20306 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify the Metadata for  OlapPackage, OlapSchema, Dimension, Measure  items after executing MicroStrategy related plugins.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "10.50.206.32" and clicks on search
    And user performs "facet selection" in "OlapPackage" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "10.50.206.32" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue  | widgetName  |
      | Definition        | DssDBSQLServer | Description |
      | owner             | ADMIN          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | Description       | Description |
    And user enters the search text "BlackBerry" and clicks on search
    And user performs "facet selection" in "OlapSchema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BlackBerry" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                             | widgetName  |
      | Definition        | Folder \MicroStrategy Tutorial\Public Objects\Reports\MicroStrategy Platform Capabilities\MicroStrategy Mobile\BlackBerry | Description |
      | owner             | ADMIN                                                                                                                     | Description |
      | Description       | This folder contains reports used to demonstrate the functionality of MicroStrategy Mobile for a BlackBerry device.       | Description |
    And user enters the search text "Badge" and clicks on search
    And user performs "facet selection" in "Dimension" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Badge" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                              | widgetName  |
      | Definition        | Folder \Platform Analytics\Public Objects\Metrics\M01. Telemetry\Badge     | Description |
      | owner             | ADMIN                                                                      | Description |
      | Description       | This folder contains all metrics specific to MicroStrategy Badge analysis. | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | dimensionType     | Description |
      | query             | Description |
    And user enters the search text "BOH-QTD" and clicks on search
    And user performs "facet selection" in "Measure" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BOH-QTD [Metric]" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                   | widgetName  |
      | Definition        | Metric \MicroStrategy Tutorial\Public Objects\Metrics\Inventory Metrics\BOH-QTD | Description |
      | owner             | ADMIN                                                                           | Description |
      | Description       | Inventory at the start of the quarter                                           | Description |
      | dataLength        | 0                                                                               | Description |
      | dataMinimumLength | 0                                                                               | Description |
      | dataScale         | 0                                                                               | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | dataAllowedValues | Description |
      | dataDefaultValue  | Description |
      | isMeasure         | Description |
    And user enters the search text "Alias" and clicks on search
    And user performs "facet selection" in "ReportPackage" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Alias" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                              | widgetName  |
      | Definition        | Folder \MicroStrategy Tutorial\Public Objects\Reports\MicroStrategy Platform Capabilities\Ad hoc Reporting\Report Data Options\Alias       | Description |
      | owner             | ADMIN                                                                                                                                      | Description |
      | Description       | This folder contains report examples using report data options to modify the display alias for attributes and metrics at the report level. | Description |
    And user enters the search text "Alias" and clicks on search
    And user performs "facet selection" in "ReportSchema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Alias" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                              | widgetName  |
      | Definition        | Folder \MicroStrategy Tutorial\Public Objects\Reports\MicroStrategy Platform Capabilities\Ad hoc Reporting\Report Data Options\Alias       | Description |
      | owner             | ADMIN                                                                                                                                      | Description |
      | Description       | This folder contains report examples using report data options to modify the display alias for attributes and metrics at the report level. | Description |
    And user enters the search text "BSC" and clicks on search
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BSC Data" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                  | widgetName  |
      | Definition        | \MicroStrategy Tutorial\Public Objects\Reports\MicroStrategy Platform Capabilities\Extended Data Access\Query Builder\BSC Data | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | Description       | Description |
    And user enters the search text "Cox" and clicks on search
    And user performs "facet selection" in "DataField" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Cox Prediction (Imported) [Metric]" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                                                                                   | widgetName  |
      | Definition        | Metric \MicroStrategy Tutorial\Public Objects\Reports\MicroStrategy Platform Capabilities\MicroStrategy Data Mining Services\Imported PMML\Telco Churn\Cox Regression\Cox Prediction (Imported) | Description |
      | Description       | Predictive Metric created by MicroStrategy based on a model imported from a third party.                                                                                                        | Description |
      | dataLength        | 0                                                                                                                                                                                               | Statistics  |
      | dataMinimumLength | 0                                                                                                                                                                                               | Statistics  |
      | dataScale         | 0                                                                                                                                                                                               | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | dataDefaultValue  | Description |
      | dataAllowedValues | Description |
    And user enters the search text "Anemone" and clicks on search
    And user performs "facet selection" in "Report" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Anemone" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                              | widgetName  |
      | Definition        | \MicroStrategy Tutorial\Public Objects\Reports\Getting Started\MicroStrategy 10\10.8\Color Palette\Anemone | Description |
      | owner             | ADMIN                                                                                                      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | Description       | Description |
      | query             | Description |
    And user enters the search text "Brand" and clicks on search
    And user performs "facet selection" in "AggregationLevel" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Brand" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                              | widgetName  |
      | Definition        | Attribute \MicroStrategy Tutorial\Schema Objects\Attributes\Products\Brand | Description |
      | owner             | ADMIN                                                                      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | Description       | Description |
    And user enters the search text "Geography" and clicks on search
    And user performs "facet selection" in "Hierarchy" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Geography" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                        | widgetName  |
      | Definition        | Hierarchy \MicroStrategy Tutorial\Schema Objects\Hierarchies\Data Explorer\Geography | Description |
      | owner             | ADMIN                                                                                | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | Description       | Description |
    And user should be able logoff the IDC


  @ROC_MicroStrategy @TEST_MLPQA-20305 @REQ_MLP-32443 @MLPQA-20287 @TEST_MLPQA-20301 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify Technology tags for replicated items after running MicroStrategy related & EDIBus plugin
  2. Verify the Technology tags for Analysis item for MicroStrategyScan, MicroStrategyImport, MicroStrategyLink, MicroStrategyReconcile - ROC, MicroStrategy

    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName      | ServiceName                        | DatabaseName | SchemaName | TableName/Filename                                            | Column | Tags              | Query         | Action      |
      | OlapPackage      | 10.50.206.32                       |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | OlapSchema       | BlackBerry                         |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | Dimension        | Badge                              |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | Measure          | BOH-QTD [Metric]                   |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | ReportPackage    | Alias                              |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | ReportSchema     | Alias                              |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | DataType         | BSC Data                           |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | DataField        | Cox Prediction (Imported) [Metric] |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | Report           | Anemone                            |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | AggregationLevel | Brand                              |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      | Hierarchy        | Geography                          |              |            |                                                               |        | ROC,MicroStrategy | GenericQuery  | TagAssigned |
      |                  |                                    |              |            | rochade/MicroStrategyScan/RochadeMicroStrategyScan%           |        | ROC,MicroStrategy | AnalysisQuery | TagAssigned |
      |                  |                                    |              |            | rochade/MicroStrategyImport/RochadeMicroStrategyImport%       |        | ROC,MicroStrategy | AnalysisQuery | TagAssigned |
      |                  |                                    |              |            | rochade/MicroStrategyLink/RochadeMicroStrategyLink%           |        | ROC,MicroStrategy | AnalysisQuery | TagAssigned |
      |                  |                                    |              |            | rochade/MicroStrategyReconcile/RochadeMicroStrategyReconcile% |        | ROC,MicroStrategy | AnalysisQuery | TagAssigned |
      |                  |                                    |              |            | bulk/EDIBus/EDIBus_MicroStrategy%                             |        | ROC,MicroStrategy | AnalysisQuery | TagAssigned |

  #################################################### Filter Scenarios #####################################################
  @ROC_MicroStrategy
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Include project - direct name
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_MicroStrategy
  Scenario Outline: Run MicroStrategyScan, MicroStrategyImport for Filter Scenario: Include project - direct name
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile | path | response code | response message | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC1 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC1')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC1  |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC1 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC1')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport       |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |

  @ROC_MicroStrategy @TEST_MLPQA-20356 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify items in EDI are imported exactly with the filters provided in MicroStrategyScan for scenario: Include Project - plain text
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                 | itemNames              |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = MCS_PROJECT ) | MicroStrategy Tutorial |

  @ROC_MicroStrategy
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Exclude project - direct name
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_MicroStrategy
  Scenario Outline: Run MicroStrategyScan, MicroStrategyImport for Filter Scenario: Exclude project - direct name
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile | path | response code | response message | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC2 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC2')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC2  |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC2 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC2')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport       |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |

  @ROC_MicroStrategy @TEST_MLPQA-20357 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify items in EDI are imported exactly with the filters provided in MicroStrategyScan for scenario: Exclude Project - plain text
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                 | itemNames          |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = MCS_PROJECT ) | Platform Analytics |

  @ROC_MicroStrategy
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Include project - wildcard
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_MicroStrategy
  Scenario Outline: Run MicroStrategyScan, MicroStrategyImport for Filter Scenario: Include project - wildcard
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile | path | response code | response message | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC3 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC3')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC3  |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC3 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC3')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport       |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |

  @ROC_MicroStrategy @TEST_MLPQA-20358 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify items in EDI are imported exactly with the filters provided in MicroStrategyScan for scenario: Include Project - wildcard
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                 | itemNames              |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = MCS_PROJECT ) | MicroStrategy Tutorial |

  @ROC_MicroStrategy
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Exclude project - wildcard
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_MicroStrategy
  Scenario Outline: Run MicroStrategyScan, MicroStrategyImport for Filter Scenario: Exclude project - wildcard
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile | path | response code | response message | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC4 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC4')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC4  |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC4 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC4')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport       |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |

  @ROC_MicroStrategy @TEST_MLPQA-20359 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify items in EDI are imported exactly with the filters provided in MicroStrategyScan for scenario: Exclude Project - wildcard
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                 | itemNames          |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = MCS_PROJECT ) | Platform Analytics |

  @ROC_MicroStrategy
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Include project - regex
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_MicroStrategy
  Scenario Outline: Run MicroStrategyScan, MicroStrategyImport for Filter Scenario: Include project - regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile | path | response code | response message | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC5 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC5')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC5  |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC5 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC5')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport       |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |

  @ROC_MicroStrategy @TEST_MLPQA-20360 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify items in EDI are imported exactly with the filters provided in MicroStrategyScan for scenario: Include Project - regex
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                 | itemNames              |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = MCS_PROJECT ) | MicroStrategy Tutorial |

  @ROC_MicroStrategy
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Exclude project - regex
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_MicroStrategy
  Scenario Outline: Run MicroStrategyScan, MicroStrategyImport for Filter Scenario: Exclude project - regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile | path | response code | response message | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC6 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC6')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC6  |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyScan/RochadeMicroStrategyScanFilterSC6 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyScanFilterSC6')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport       |          |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MicroStrategyImport/RochadeMicroStrategyImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMicroStrategyImport')].status        |

  @ROC_MicroStrategy @TEST_MLPQA-20361 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify items in EDI are imported exactly with the filters provided in MicroStrategyScan for scenario: Exclude Project - regex
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                 | itemNames          |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = MCS_PROJECT ) | Platform Analytics |

  ##################################################### Post Conditions #####################################################
  @ROC_MicroStrategy
  Scenario Outline: Configure EDIBus plugin to perform clean up the data loaded after running MicroStrategy plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | bodyFile                                                                | path            | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_MicroStrategy                            | payloads/ida/ROCMicroStrategyPayloads/RocMicroStrategyPluginConfig.json | $.EDIBusCleanup | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_MicroStrategy                            |                                                                         |                 | 200           | EDIBus_MicroStrategy |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MicroStrategy |                                                                         |                 | 200           | IDLE                 | $.[?(@.configurationName=='EDIBus_MicroStrategy')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_MicroStrategy  |                                                                         |                 | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MicroStrategy |                                                                         |                 | 200           | IDLE                 | $.[?(@.configurationName=='EDIBus_MicroStrategy')].status |

  @webtest @ROC_MicroStrategy @TEST_MLPQA-20308 @REQ_MLP-32443 @MLPQA-20287
  Scenario: Verify all item types collected from MicroStrategy Rochade are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | DataField        |
      | Measure          |
      | Report           |
      | DataType         |
      | ReportPackage    |
      | ReportSchema     |
      | Dimension        |
      | OlapSchema       |
      | AggregationLevel |
      | Hierarchy        |
      | OlapPackage      |
    And user should be able logoff the IDC

  @post-condition @ROC_MicroStrategy
  Scenario: PS_Clearing the EDI subject area after running the Rochade MicroStrategy wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @post-condition @ROC_MicroStrategy
  Scenario:  Delete the analysis items for plugins: MicroStrategyScan, MicroStrategyImport, MicroStrategyLink, MicroStrategyReconcile, EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                          | type     | query | param |
      | MultipleIDDelete | Default | rochade/MicroStrategyScan/RochadeMicroStrategyScan%                           | Analysis |       |       |
      | MultipleIDDelete | Default | datasource/ROCMicroStrategyServerDatasource/ROCMicroStrategyServerDatasource% | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/MicroStrategyImport/RochadeMicroStrategyImport%                       | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/MicroStrategyLink/RochadeMicroStrategyLink%                           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/MicroStrategyReconcile/RochadeMicroStrategyReconcile%                 | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_MicroStrategy%                                             | Analysis |       |       |

  @post-condition @ROC_MicroStrategy
  Scenario Outline:  Delete Credentials, Datasource and plugin config for MicroStrategyScan, MicroStrategyImport, MicroStrategyLink, MicroStrategyReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                        | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScan              |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC1     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC2     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC3     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC4     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC5     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyScan/RochadeMicroStrategyScanFilterSC6     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyImport/RochadeMicroStrategyImport          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyLink/RochadeMicroStrategyLink              |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MicroStrategyReconcile/RochadeMicroStrategyReconcile    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_MicroStrategy                             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCMicroStrategyServerDatasource/RochadeMicroStrategyDS |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCMicroStrategySADataSource/RochadeMicroStrategySADS   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusMicroStrategyDS                  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeMicroStrategyCredentials                       |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeMicroStrategySACredentials                     |          |      | 200           |                  |          |
