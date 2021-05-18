@MLPQA-17714
Feature: Verification of Rochade-DD wrapper plugins for TeradataScript such as TeradataScriptScan, TeradataScriptImport, TeradataScriptPostprocess, TeradataScriptReconcile
#  Stories: @MLP-31019

  @pre-condition @ROC_TeradataScript
  Scenario: Pre: Clearing the EDI subject area before running the Rochade TeradataScript wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @pre-condition @ROC_TeradataScript
  Scenario:Headless EDI Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                                         | jsonPath                                                   | node            |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScan.configurations.nodeCondition                | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataImport.configurations.nodeCondition              | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataPostprocess.configurations.nodeCondition         | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataReconcile.configurations.nodeCondition           | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScan.configurations.nodeCondition          | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScanFilterSC1.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScanFilterSC2.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScanFilterSC3.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScanFilterSC4.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptImport.configurations.nodeCondition        | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptPostprocess.configurations.nodeCondition   | HeadlessEDINode |
      | ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptReconcile.configurations.nodeCondition     | HeadlessEDINode |

  @pre-condition @ROC_TeradataScript
  Scenario Outline: Configure Credentials, Data Source for TeradataScript wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                           | bodyFile                                                                 | path                      | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ROCTeradataCredentials   | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptCredentials.json | $.TeradataCredentials     | 200           |                        |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ROCTeradataCredentials   |                                                                          |                           | 200           |                        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ROCTeradataSACredentials | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptCredentials.json | $.EDICredentials          | 200           |                        |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ROCTeradataSACredentials |                                                                          |                           | 200           |                        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCTeradataDataSource      | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptDataSource.json  | $.ROCTeradataDataSource   | 204           |                        |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCTeradataDataSource      |                                                                          |                           | 200           | RochadeTeradataDS      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCTeradataSADataSource    | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptDataSource.json  | $.ROCTeradataSADataSource | 204           |                        |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCTeradataSADataSource    |                                                                          |                           | 200           | RochadeTeradataSADS    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource           | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptDataSource.json  | $.EDIBusDataSource        | 204           |                        |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource           |                                                                          |                           | 200           | EDIBusTeradataScriptDS |          |

  @pre-condition @ROC_TeradataScript
  Scenario Outline: Configure plugins: TeradataScan, TeradataImport, TeradataPostprocess, TeradataReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                               | bodyFile                                                                  | path                                 | response code | response message           | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScan/RochadeTeradataScan               | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScan.configurations        | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScan/RochadeTeradataScan               |                                                                           |                                      | 200           | RochadeTeradataScan        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataImport/RochadeTeradataImport           | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataImport.configurations      | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataImport/RochadeTeradataImport           |                                                                           |                                      | 200           | RochadeTeradataImport      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataPostprocess/RochadeTeradataPostprocess | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataPostprocess.configurations | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataPostprocess/RochadeTeradataPostprocess |                                                                           |                                      | 200           | RochadeTeradataPostprocess |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataReconcile/RochadeTeradataReconcile     | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataReconcile.configurations   | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataReconcile/RochadeTeradataReconcile     |                                                                           |                                      | 200           | RochadeTeradataReconcile   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_TeradataScript                   | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.EDIBus.configurations              | 204           |                            |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_TeradataScript                   |                                                                           |                                      | 200           | EDIBus_TeradataScript      |          |

  @pre-condition @ROC_TeradataScript
  Scenario Outline: Configure plugins: TeradataScriptScan, TeradataScriptImport, TeradataScriptPostprocess, TeradataScriptReconcile
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                           | bodyFile                                                                  | path                                       | response code | response message                 | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScan               | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScan.configurations        | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScan               |                                                                           |                                            | 200           | RochadeTeradataScriptScan        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScriptImport/RochadeTeradataScriptImport           | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptImport.configurations      | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScriptImport/RochadeTeradataScriptImport           |                                                                           |                                            | 200           | RochadeTeradataScriptImport      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptPostprocess.configurations | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess |                                                                           |                                            | 200           | RochadeTeradataScriptPostprocess |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScriptReconcile/RochadeTeradataScriptReconcile     | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptReconcile.configurations   | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScriptReconcile/RochadeTeradataScriptReconcile     |                                                                           |                                            | 200           | RochadeTeradataScriptReconcile   |          |

  @pre-condition @ROC_TeradataScript
  Scenario Outline: Configure plugins: TeradataScriptScan for different filter scenarios
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                      | bodyFile                                                                  | path                                         | response code | response message                   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScanFilterSC1 | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScanFilterSC1.configurations | 204           |                                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScanFilterSC1 |                                                                           |                                              | 200           | RochadeTeradataScriptScanFilterSC1 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScanFilterSC2 | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScanFilterSC2.configurations | 204           |                                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScanFilterSC2 |                                                                           |                                              | 200           | RochadeTeradataScriptScanFilterSC2 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScanFilterSC3 | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScanFilterSC3.configurations | 204           |                                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScanFilterSC3 |                                                                           |                                              | 200           | RochadeTeradataScriptScanFilterSC3 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScanFilterSC4 | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.TeradataScriptScanFilterSC4.configurations | 204           |                                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TeradataScriptScan/RochadeTeradataScriptScanFilterSC4 |                                                                           |                                              | 200           | RochadeTeradataScriptScanFilterSC4 |          |

  #################### DataSource TestConnection - UI Validation Error in Mandatory Fields ####################
  @webtest @ROC_TeradataScript @TEST_MLPQA-17691 @MLPQA-17471
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in TeradataScriptScan plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Rochade            |
      | Plugin    | TeradataScriptScan |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Business Application       |
      | ComponentName*             |
      | xmlFileEncoding            |
      | Directories to be scanned* |
      | Associated databases list  |
      | Data Source*               |
      | Credential                 |
      | Plugin version             |
      | Event condition            |
      | Event class                |
      | Maximum work size          |
      | Node condition             |
      | Auto start                 |
      | Tags                       |
      | Logging Level              |
      | Java memory setting        |
      | ClassPath                  |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                      | Plugin configuration name                                                                                                                                                                                                                                                                                                                             |
      | Label                     | Plugin configuration extended label and description                                                                                                                                                                                                                                                                                                   |
      | Business Application      | Business Application                                                                                                                                                                                                                                                                                                                                  |
      | ComponentName             | All scrips are stored inside a component.                                                                                                                                                                                                                                                                                                             |
      | xmlFileEncoding           | XML file encoding of the script files                                                                                                                                                                                                                                                                                                                 |
      | Directories to be scanned | Directories to be scanned by teradata Script scanner Enter a list of directories (with file filter) that should be scanned If a single entry is prefixed with SUB: the subdirectories are also scanned The names may contain wildcards (* and ?) Examples: Scann all subdirectories of C:\Users\*\Script for *.SQL files: SUB:C:\Users\*\Script\*.SQL |
      | Associated databases list | Associated databases for teradata Script scanner                                                                                                                                                                                                                                                                                                      |
      | Plugin version            | Required plugin version                                                                                                                                                                                                                                                                                                                               |
      | Logging Level             | Logging Level                                                                                                                                                                                                                                                                                                                                         |
      | Java memory setting       | Maximum Java memory setting                                                                                                                                                                                                                                                                                                                           |
      | ClassPath                 | Classpath                                                                                                                                                                                                                                                                                                                                             |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute |
      | ComponentName |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName     | errorMessage                            |
      | Name          | Name field should not be empty          |
      | ComponentName | ComponentName field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_TeradataScript @TEST_MLPQA-17692 @MLPQA-17471
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in TeradataScriptImport plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute            |
      | Type      | Rochade              |
      | Plugin    | TeradataScriptImport |
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

  @webtest @ROC_TeradataScript @TEST_MLPQA-17693 @MLPQA-17471
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in TeradataScriptPostprocess plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                 |
      | Type      | Rochade                   |
      | Plugin    | TeradataScriptPostprocess |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                                 |
      | Label                                 |
      | Business Application                  |
      | Data Source*                          |
      | Credential                            |
      | Plugin version                        |
      | Event condition                       |
      | Event class                           |
      | Maximum work size                     |
      | Node condition                        |
      | Auto start                            |
      | Tags                                  |
      | Logging Level                         |
      | Java memory setting                   |
      | ClassPath                             |
      | Log Suspicious SQL                    |
      | Log Suspicious SQL Path               |
      | teradata Script postprocess Arguments |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                                  | Plugin configuration name                                                                                |
      | Label                                 | Plugin configuration extended label and description                                                      |
      | Business Application                  | Business Application                                                                                     |
      | Plugin version                        | Required plugin version                                                                                  |
      | Logging Level                         | Logging Level                                                                                            |
      | Java memory setting                   | Maximum Java memory setting                                                                              |
      | ClassPath                             | Classpath                                                                                                |
      | Log Suspicious SQL                    | Exports SQL to specified folder that caused errors and returned informational messages during processing |
      | Log Suspicious SQL Path               | Path for export of suspicious SQL                                                                        |
      | teradata Script postprocess Arguments | Overrides default teradata Script postprocess parameters                                                 |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_TeradataScript @TEST_MLPQA-17694 @MLPQA-17471
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in TeradataScriptReconcile plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute               |
      | Type      | Rochade                 |
      | Plugin    | TeradataScriptReconcile |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                                |
      | Label                                |
      | Business Application                 |
      | Component Seed item (root namespace) |
      | Data Source*                         |
      | Credential                           |
      | Plugin version                       |
      | Event condition                      |
      | Event class                          |
      | Maximum work size                    |
      | Node condition                       |
      | Auto start                           |
      | Tags                                 |
      | Java memory setting                  |
      | ClassPath                            |
      | Number of threads used               |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                                 | Plugin configuration name                                                                               |
      | Label                                | Plugin configuration extended label and description                                                     |
      | Business Application                 | Business Application                                                                                    |
      | Component Seed item (root namespace) | Specify the Component transformation start item                                                         |
      | Plugin version                       | Required plugin version                                                                                 |
      | Java memory setting                  | Maximum Java memory setting                                                                             |
      | ClassPath                            | Classpath                                                                                               |
      | Number of threads used               | Number of threads used for multi-threading, recommended to set to number of processor kernels available |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #################################################### Plugin Run #####################################################
  @ROC_TeradataScript
  Scenario Outline: Run TeradataScan, TeradataImport, TeradataPostprocess, TeradataReconcile Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile | path | response code | response message | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScan/RochadeTeradataScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScan/RochadeTeradataScan                |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScan/RochadeTeradataScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataImport/RochadeTeradataImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataImport/RochadeTeradataImport            |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataImport/RochadeTeradataImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataPostprocess/RochadeTeradataPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataPostprocess/RochadeTeradataPostprocess  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataPostprocess/RochadeTeradataPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataReconcile/RochadeTeradataReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataReconcile/RochadeTeradataReconcile      |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataReconcile/RochadeTeradataReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataReconcile')].status   |

  @ROC_TeradataScript
  Scenario Outline: Run TeradataScriptScan, TeradataScriptImport, TeradataScriptPostprocess, TeradataScriptReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                        | bodyFile | path | response code | response message | jsonPath                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScan                |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport            |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess  |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptReconcile/RochadeTeradataScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptReconcile/RochadeTeradataScriptReconcile      |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptReconcile/RochadeTeradataScriptReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_TeradataScript                                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_TeradataScript')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_TeradataScript                                  |          |      | 200           |                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_TeradataScript                                 |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_TeradataScript')].status            |

  #WorkAround
  @ROC_TeradataScript
  Scenario Outline: Configure EDIBus plugin & run it to add EDI Types for TeradataScript
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | bodyFile                                                                  | path                             | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_TeradataScript                            | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.EDIBusWithTypes.configurations | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_TeradataScript                            |                                                                           |                                  | 200           | EDIBus_TeradataScript |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_TeradataScript |                                                                           |                                  | 200           | IDLE                  | $.[?(@.configurationName=='EDIBus_TeradataScript')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_TeradataScript  |                                                                           |                                  | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_TeradataScript |                                                                           |                                  | 200           | IDLE                  | $.[?(@.configurationName=='EDIBus_TeradataScript')].status |

##################################################### Verifications #####################################################
  @ROC_TeradataScript @TEST_MLPQA-17695 @MLPQA-17471
  Scenario: Verify the Logging Enhancements - Analysis logs for TeradataScriptScan, TeradataScriptImport, TeradataScriptPostprocess, TeradataScriptReconcile
    Given Analysis log "rochade/TeradataScriptScan/RochadeTeradataScriptScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                 | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                                           | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:TeradataScriptScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeTeradataScriptScan | ANALYSIS-0071 | TeradataScriptScan | Plugin Version |
      | INFO | Plugin TeradataScriptScan Start Time:2020-12-09 10:20:16.694, End Time:2020-12-09 10:20:17.827, Processed Count:0, Errors:0, Warnings:0                                                                  | ANALYSIS-0072 | TeradataScriptScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                           | ANALYSIS-0020 |                    |                |
    And Analysis log "rochade/TeradataScriptImport/RochadeTeradataScriptImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                     | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                                               | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:TeradataScriptImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeTeradataScriptImport | ANALYSIS-0071 | TeradataScriptImport | Plugin Version |
      | INFO | Plugin TeradataScriptImport Start Time:2020-12-09 10:20:40.129, End Time:2020-12-09 10:20:43.808, Processed Count:0, Errors:0, Warnings:0                                                                    | ANALYSIS-0072 | TeradataScriptImport |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                               | ANALYSIS-0020 |                      |                |
    And Analysis log "rochade/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                               | logCode       | pluginName                | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                         | ANALYSIS-0019 |                           |                |
      | INFO | Plugin Name:TeradataScriptPostprocess, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeTeradataScriptPostprocess | ANALYSIS-0071 | TeradataScriptPostprocess | Plugin Version |
      | INFO | Plugin TeradataScriptPostprocess Start Time:2020-12-09 10:21:02.126, End Time:2020-12-09 10:21:09.224, Processed Count:0, Errors:0, Warnings:0                                                                         | ANALYSIS-0072 | TeradataScriptPostprocess |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                         | ANALYSIS-0020 |                           |                |
    And Analysis log "rochade/TeradataScriptReconcile/RochadeTeradataScriptReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                           | logCode       | pluginName              | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                     | ANALYSIS-0019 |                         |                |
      | INFO | Plugin Name:TeradataScriptReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeTeradataScriptReconcile | ANALYSIS-0071 | TeradataScriptReconcile | Plugin Version |
      | INFO | Plugin TeradataScriptReconcile Start Time:2020-12-09 10:21:24.076, End Time:2020-12-09 10:21:36.425, Processed Count:0, Errors:0, Warnings:0                                                                       | ANALYSIS-0072 | TeradataScriptReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                     | ANALYSIS-0020 |                         |                |

  @webtest @ROC_TeradataScript @TEST_MLPQA-17697 @MLPQA-17471
  Scenario: Verify the availability of HTML file under analysis items for plugins: TeradataScriptScan, TeradataScriptImport, TeradataScriptPostprocess
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "rochade/TeradataScriptScan" and clicks on search
    And user performs "facet selection" in "Teradata" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    Then the following tags "ROC,Teradata" should get displayed for the column "rochade/TeradataScan/RochadeTeradataScan"
    And user performs "latest analysis click" in Item Results page for "rochade/TeradataScriptScan/RochadeTeradataScriptScan%"
    Then user performs click and verify in new window
      | Table | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Teradata-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "rochade/TeradataScriptImport" and clicks on search
    And user performs "facet selection" in "Teradata" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/TeradataScriptImport/RochadeTeradataScriptImport%"
    Then user performs click and verify in new window
      | Table | value                   | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Teradata-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "rochade/TeradataScriptPostprocess" and clicks on search
    And user performs "facet selection" in "Teradata" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess%"
    Then user performs click and verify in new window
      | Table | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Teradata-PostLog.html | verify widget contains |                  |             |
    And user should be able logoff the IDC

  @ROC_TeradataScript @TEST_MLPQA-17699 @MLPQA-17471
  Scenario: Verify the items in EDI matched with items in DD UI after executing TeradataScript related plugins for scenario: Parent Directory with subdirectories, empty Associated databases.
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_SYSTEM ) | 4         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                                        |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_SYSTEM ) | TeradataSQL,D:\,TeradataSQL_TestScripts,childdir |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TASK ) | 23        |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/COMPONENT ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemNames   |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/COMPONENT ) | TeradataSQL |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/DIRECTORY ) | 3         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemNames                            |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/DIRECTORY ) | D:\,TeradataSQL_TestScripts,childdir |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/SQL-SCRIPT ) | 23        |

  @webtest @ROC_TeradataScript @TEST_MLPQA-17698 @MLPQA-17471 @TEST_MLPQA-17702 @MLPQA-17471
  Scenario: Verify TeradataScript Rochade items are replicated to DD after running EDIBus plugin like Service, Operation
  2. Verify the breadcrumb hierarchy appears correctly when TeradataScript Rochade items are replicated to DD after running EDIBus plugin.

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Teradata" and clicks on search
    And user performs "facet selection" in "Teradata" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Operation  |
      | Routine    |
      | Schema     |
      | Database   |
      | Constraint |
      | Analysis   |
      | Service    |
    And user enters the search text "table_to_table_atd.sql" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "table_to_table_atd.sql" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | TeradataSQL≫Operation             |
      | D:\≫Operation                     |
      | TeradataSQL_TestScripts≫Operation |
      | table_to_table_atd.sql            |
    And user should be able logoff the IDC

  @ROC_TeradataScript @TEST_MLPQA-17701 @MLPQA-17471
  Scenario: Verify the Metadata for Service, Operation items after executing TeradataScript related plugins.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                          | Action                    | query                      | ClusterName | ServiceName                       | DatabaseName | SchemaName | TableName/Filename     | columnName/FieldName |
      | Description | ida/ROCTeradataScriptPayloads/expectedMetadata.json | $.Service1Metadata.Description1   | metadataAttributePresence | ServiceQueryWithoutCluster |             | TeradataSQL≫Operation             |              |            |                        |                      |
      | Description | ida/ROCTeradataScriptPayloads/expectedMetadata.json | $.Service2Metadata.Description1   | metadataAttributePresence | ServiceQueryWithoutCluster |             | D:\≫Operation                     |              |            |                        |                      |
      | Description | ida/ROCTeradataScriptPayloads/expectedMetadata.json | $.Service3Metadata.Description1   | metadataAttributePresence | ServiceQueryWithoutCluster |             | TeradataSQL_TestScripts≫Operation |              |            |                        |                      |
      | Description | ida/ROCTeradataScriptPayloads/expectedMetadata.json | $.Service3Metadata.Description2   | metadataValuePresence     | ServiceQueryWithoutCluster |             | TeradataSQL_TestScripts≫Operation |              |            |                        |                      |
      | Description | ida/ROCTeradataScriptPayloads/expectedMetadata.json | $.Service4Metadata.Description1   | metadataAttributePresence | ServiceQueryWithoutCluster |             | childdir≫Operation                |              |            |                        |                      |
      | Description | ida/ROCTeradataScriptPayloads/expectedMetadata.json | $.Service4Metadata.Description2   | metadataValuePresence     | ServiceQueryWithoutCluster |             | childdir≫Operation                |              |            |                        |                      |
      | Description | ida/ROCTeradataScriptPayloads/expectedMetadata.json | $.Operation1Metadata.Description1 | metadataAttributePresence | OperationQuery             |             |                                   |              |            | table_to_table_atd.sql |                      |
      | Description | ida/ROCTeradataScriptPayloads/expectedMetadata.json | $.Operation1Metadata.Description2 | metadataValuePresence     | OperationQuery             |             |                                   |              |            | table_to_table_atd.sql |                      |

  @ROC_TeradataScript @TEST_MLPQA-17700 @MLPQA-17471 @TEST_MLPQA-17696 @MLPQA-17471
  Scenario: Verify Technology tags for replicated items after running TeradataScript related & EDIBus plugin
  Verify the Technology tags for Analysis item for TeradataScriptScan, TeradataScriptImport, TeradataScriptPostprocess, TeradataScriptReconcile - ROC, Teradata

    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName                       | DatabaseName | SchemaName | TableName/Filename                                                  | Column | Tags         | Query                      | Action      |
      |             | TeradataSQL≫Operation             |              |            |                                                                     |        | Teradata,ROC | ServiceQueryWithoutCluster | TagAssigned |
      |             | D:\≫Operation                     |              |            |                                                                     |        | Teradata,ROC | ServiceQueryWithoutCluster | TagAssigned |
      |             | TeradataSQL_TestScripts≫Operation |              |            |                                                                     |        | Teradata,ROC | ServiceQueryWithoutCluster | TagAssigned |
      |             | childdir≫Operation                |              |            |                                                                     |        | Teradata,ROC | ServiceQueryWithoutCluster | TagAssigned |
      |             |                                   |              |            | table_to_table_atd.sql                                              |        | Teradata,ROC | OperationQuery             | TagAssigned |
      |             |                                   |              |            | rochade/TeradataScriptScan/RochadeTeradataScriptScan%               |        | Teradata,ROC | AnalysisQuery              | TagAssigned |
      |             |                                   |              |            | rochade/TeradataScriptImport/RochadeTeradataScriptImport%           |        | Teradata,ROC | AnalysisQuery              | TagAssigned |
      |             |                                   |              |            | rochade/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess% |        | Teradata,ROC | AnalysisQuery              | TagAssigned |
      |             |                                   |              |            | rochade/TeradataScriptReconcile/RochadeTeradataScriptReconcile%     |        | Teradata,ROC | AnalysisQuery              | TagAssigned |
      |             |                                   |              |            | bulk/EDIBus/EDIBus_TeradataScript%                                  |        | Teradata,ROC | AnalysisQuery              | TagAssigned |

  @ROC_TeradataScript @TEST_MLPQA-17703 @MLPQA-17471 @TEST_MLPQA-17704 @MLPQA-17471 @TEST_MLPQA-17705 @MLPQA-17471 @TEST_MLPQA-17706 @MLPQA-17471 @TEST_MLPQA-17707 @MLPQA-17471 @TEST_MLPQA-17708 @MLPQA-17471 @TEST_MLPQA-17709 @MLPQA-17471
  Scenario: Verify Lineage is established after executing TeradataScript related plugins for the scenario: Table to Table(through procedure)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name               | asg_scopeid | targetFile                                                | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TAB_TO_TAB1        |             | response/RochadeTeradataScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | VIEW_TO_TABLE1     |             | response/RochadeTeradataScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TAB_TO_FUNC1       |             | response/RochadeTeradataScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | VIEWTOTABLEDYNAMIC |             | response/RochadeTeradataScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TAB_TAB_NOVARS1    |             | response/RochadeTeradataScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | JOIN_TO_SINGLE     |             | response/RochadeTeradataScript/Lineage/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | EMP_JOIN_INDEX     |             | response/RochadeTeradataScript/Lineage/lineageHopIDs.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                    | bodyFile                                                  | path                                 | response code | response message | jsonPath | targetFile                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeTeradataScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.TAB_TO_TAB1        | 200           |                  | edges    | response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeTeradataScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.VIEW_TO_TABLE1     | 200           |                  | edges    | response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeTeradataScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.TAB_TO_FUNC1       | 200           |                  | edges    | response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeTeradataScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.VIEWTOTABLEDYNAMIC | 200           |                  | edges    | response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeTeradataScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.TAB_TAB_NOVARS1    | 200           |                  | edges    | response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeTeradataScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.JOIN_TO_SINGLE     | 200           |                  | edges    | response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response/RochadeTeradataScript/Lineage/lineageHopIDs.json | $.lineagePayLoads.EMP_JOIN_INDEX     | 200           |                  | edges    | response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                      | JsonPath           |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | TAB_TO_TAB1        |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | VIEW_TO_TABLE1     |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | TAB_TO_FUNC1       |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | VIEWTOTABLEDYNAMIC |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | TAB_TAB_NOVARS1    |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | JOIN_TO_SINGLE     |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | EMP_JOIN_INDEX     |

  @ROC_TeradataScript
  Scenario Outline:  Lineage Hops End to End Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                   | actual_json                                                                                   | item               |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/expectedTeradataScriptLineageHops.json | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | TAB_TO_TAB1        |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/expectedTeradataScriptLineageHops.json | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | VIEW_TO_TABLE1     |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/expectedTeradataScriptLineageHops.json | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | TAB_TO_FUNC1       |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/expectedTeradataScriptLineageHops.json | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | VIEWTOTABLEDYNAMIC |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/expectedTeradataScriptLineageHops.json | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | TAB_TAB_NOVARS1    |
      | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/expectedTeradataScriptLineageHops.json | Constant.REST_DIR/response/RochadeTeradataScript/Lineage/actualTeradataScriptLineageHops.json | JOIN_TO_SINGLE     |

  ##################################################### Filter scenarios #####################################################
  @ROC_TeradataScript
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Parent Directory alone
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_TeradataScript
  Scenario Outline: Run TeradataScriptScan with filters for scenario: Parent Directory alone
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | bodyFile | path | response code | response message | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC2 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptScanFilterSC2')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC2  |          |      | 200           |                  |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC2 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptScanFilterSC2')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport       |          |      | 200           |                  |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptImport')].status        |

  @ROC_TeradataScript @TEST_MLPQA-17711 @MLPQA-17471
  Scenario: Verify the items in EDI matched with items in DD UI after executing TeradataScript related plugins for scenario: Parent Directory alone
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/COMPONENT ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemNames   |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/COMPONENT ) | TeradataSQL |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/DIRECTORY ) | 2         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemNames                   |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/DIRECTORY ) | D:\,TeradataSQL_TestScripts |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/SQL-SCRIPT ) | 19        |

  @ROC_TeradataScript
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Sub-Directory alone
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_TeradataScript
  Scenario Outline: Run TeradataScriptScan with filters for scenario: Sub-Directory alone
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | bodyFile | path | response code | response message | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC3 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptScanFilterSC3')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC3  |          |      | 200           |                  |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC3 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptScanFilterSC3')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport       |          |      | 200           |                  |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptImport')].status        |

  @ROC_TeradataScript @TEST_MLPQA-17712 @MLPQA-17471
  Scenario: Verify the items in EDI matched with items in DD UI after executing TeradataScript related plugins for scenario: Sub-Directory alone
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/COMPONENT ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemNames   |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/COMPONENT ) | TeradataSQL |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/DIRECTORY ) | 3         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemNames                            |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/DIRECTORY ) | D:\,TeradataSQL_TestScripts,childdir |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/SQL-SCRIPT ) | 4         |

  @ROC_TeradataScript
  Scenario: Clearing the EDI subject area after running the Rochade wrapper plugins from DD for scenario: Directory with wildcard
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_TeradataScript
  Scenario Outline: Run TeradataScriptScan with filters for scenario: Directory with wildcard
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | bodyFile | path | response code | response message | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC4 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptScanFilterSC4')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC4  |          |      | 200           |                  |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptScan/RochadeTeradataScriptScanFilterSC4 |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptScanFilterSC4')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptImport')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport       |          |      | 200           |                  |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TeradataScriptImport/RochadeTeradataScriptImport      |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTeradataScriptImport')].status        |

  @ROC_TeradataScript @TEST_MLPQA-17713 @MLPQA-17471
  Scenario: Verify the items in EDI matched with items in DD UI after executing TeradataScript related plugins for scenario: Directory with wildcard
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/COMPONENT ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemNames   |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/COMPONENT ) | TeradataSQL |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/DIRECTORY ) | 3         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemNames                            |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/DIRECTORY ) | D:\,TeradataSQL_TestScripts,childdir |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = TDATA/SQL-SCRIPT ) | 4         |

  ##################################################### Post Conditions #####################################################
  @ROC_TeradataScript
  Scenario Outline: Configure EDIBus plugin to perform clean up the data loaded after running TeradataScript plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | bodyFile                                                                  | path                                    | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_TeradataScript                            | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.EDIBusCleanUpWithTypes.configurations | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_TeradataScript                            |                                                                           |                                         | 200           | EDIBus_TeradataScript |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_TeradataScript |                                                                           |                                         | 200           | IDLE                  | $.[?(@.configurationName=='EDIBus_TeradataScript')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_TeradataScript  |                                                                           |                                         | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_TeradataScript |                                                                           |                                         | 200           | IDLE                  | $.[?(@.configurationName=='EDIBus_TeradataScript')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_TeradataScript                            | payloads/ida/ROCTeradataScriptPayloads/RocTeradataScriptPluginConfig.json | $.EDIBusCleanup.configurations          | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_TeradataScript                            |                                                                           |                                         | 200           | EDIBus_TeradataScript |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_TeradataScript |                                                                           |                                         | 200           | IDLE                  | $.[?(@.configurationName=='EDIBus_TeradataScript')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_TeradataScript  |                                                                           |                                         | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_TeradataScript |                                                                           |                                         | 200           | IDLE                  | $.[?(@.configurationName=='EDIBus_TeradataScript')].status |

  @webtest @ROC_TeradataScript @TEST_MLPQA-17710 @MLPQA-17471
  Scenario: Verify all item types collected from TeradataScript Rochade are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Teradata" and clicks on search
    And user performs "facet selection" in "Teradata" attribute under "Tags" facets in Item Search results page
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

  @post-condition @ROC_TeradataScript
  Scenario: PS_Clearing the EDI subject area after running the Rochade TeradataScript wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @post-condition @ROC_TeradataScript
  Scenario:  Delete the analysis items for plugins: TeradataScan, TeradataImport, TeradataPostprocess, TeradataReconcile, TeradataScriptScan, TeradataScriptImport, TeradataScriptPostprocess, TeradataScriptReconcile, EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                | type     | query | param |
      | MultipleIDDelete | Default | rochade/TeradataScan/RochadeTeradataScan%                           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TeradataImport/RochadeTeradataImport%                       | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TeradataPostprocess/RochadeTeradataPostprocess%             | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TeradataReconcile/RochadeTeradataReconcile%                 | Analysis |       |       |
      | MultipleIDDelete | Default | datasource/ROCTeradataSADataSource/%                                | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TeradataScriptScan/RochadeTeradataScriptScan%               | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TeradataScriptImport/RochadeTeradataScriptImport%           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess% | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TeradataScriptReconcile/RochadeTeradataScriptReconcile%     | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_TeradataScript%                                  | Analysis |       |       |

  @post-condition @ROC_TeradataScript
  Scenario Outline:  Delete Credentials, Datasource and plugin config for TeradataScan, TeradataImport, TeradataPostprocess, TeradataReconcile, TeradataScriptScan, TeradataScriptImport, TeradataScriptPostprocess, TeradataScriptReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                           | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TeradataScan                                               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TeradataImport/RochadeTeradataImport                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TeradataPostprocess/RochadeTeradataPostprocess             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TeradataReconcile/RochadeTeradataReconcile                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TeradataScriptScan                                         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TeradataScriptImport/RochadeTeradataScriptImport           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TeradataScriptPostprocess/RochadeTeradataScriptPostprocess |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TeradataScriptReconcile/RochadeTeradataScriptReconcile     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_TeradataScript                               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCTeradataDataSource                                      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCTeradataSADataSource                                    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                                           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ROCTeradataCredentials                                   |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ROCTeradataSACredentials                                 |          |      | 200           |                  |          |
