@MLPQA-18215
Feature: Verification of Rochade-DD wrapper plugins for TableauLocalWorkbook such as TableauLocalWorkbookScan, TableauImport, TableauLinker, TableauReconcile
#  Stories: @MLP-32462

  #################################################### Pre-Conditions #####################################################
  @pre-condition @ROC_TableauLocalWorkbook
  Scenario: Pre: Clearing the EDI subject area before running the Rochade TableauLocalWorkbook wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @pre-condition @ROC_TableauLocalWorkbook
  Scenario:Headless EDI Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                                                     | jsonPath                                                | node            |
      | ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.TableauLocalWorkbookScan.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.TableauImport.configurations.nodeCondition            | HeadlessEDINode |
      | ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.TableauLinker.configurations.nodeCondition            | HeadlessEDINode |
      | ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.TableauReconcile.configurations.nodeCondition         | HeadlessEDINode |

  @pre-condition @ROC_TableauLocalWorkbook
  Scenario Outline: Configure Credentials, Data Source for TableauLocalWorkbook wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                          | bodyFile                                                                             | path                     | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ROCTableauSACredentials | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookCredentials.json | $.SACredentials          | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ROCTableauSACredentials |                                                                                      |                          | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCTableauSADataSource    | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookDataSource.json  | $.ROCTableauSADataSource | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCTableauSADataSource    |                                                                                      |                          | 200           | RochadeTableauSA_DS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource          | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookDataSource.json  | $.EDIBusDataSource       | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource          |                                                                                      |                          | 200           | EDIBusTableauDS     |          |

  @pre-condition @ROC_TableauLocalWorkbook
  Scenario Outline: Configure plugins: TableauLocalWorkbookScan, TableauImport, TableauLinker, TableauReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                 | bodyFile                                                                              | path                                      | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TableauLocalWorkbookScan/RochadeTableauLocalScan | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.TableauLocalWorkbookScan.configurations | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TableauLocalWorkbookScan/RochadeTableauLocalScan |                                                                                       |                                           | 200           | RochadeTableauLocalScan |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TableauImport/RochadeTableauImport               | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.TableauImport.configurations            | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TableauImport/RochadeTableauImport               |                                                                                       |                                           | 200           | RochadeTableauImport    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TableauLinker/RochadeTableauLinker               | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.TableauLinker.configurations            | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TableauLinker/RochadeTableauLinker               |                                                                                       |                                           | 200           | RochadeTableauLinker    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/TableauReconcile/RochadeTableauReconcile         | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.TableauReconcile.configurations         | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/TableauReconcile/RochadeTableauReconcile         |                                                                                       |                                           | 200           | RochadeTableauReconcile |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_Tableau                            | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.EDIBus.configurations                   | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_Tableau                            |                                                                                       |                                           | 200           | EDIBus_Tableau          |          |

  @webtest @ROC_TableauLocalWorkbook @TEST_MLPQA-18193 @MLPQA-18084 @TEST_MLPQA-18195 @MLPQA-18084 @TEST_MLPQA-18196 @MLPQA-18084
  Scenario:Verify the datasource test connection is successful for ROCTableauSADataSource in HeadlessEDINode
  2. Verify proper error message is shown if mandatory fields are not filled in ROCTableauSADataSource plugin configuration
  3. Verify captions and tool tip text is displayed for all the fields in ROCTableauSADataSource configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute              |
      | Data Source Type | ROCTableauSADataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                 |
      | Label                 |
      | Scan output path*     |
      | Tableau version path* |
      | Credential            |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                  | Plugin configuration name                                                                                                                                        |
      | Label                 | Plugin configuration extended label and description                                                                                                              |
      | Scan output path*     | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | Tableau version path* | Path part name for ScanTableau version                                                                                                                           |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName             | attribute |
      | Tableau version path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName            | errorMessage                                   |
      | Name                 | Name field should not be empty                 |
      | Scan output path     | Scan output path field should not be empty     |
      | Tableau version path | Tableau version path field should not be empty |
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName             | attribute                           |
      | Name                  | ROCTableauSADataSourceTest          |
      | Label                 | ROCTableauSADataSourceTest          |
      | Scan output path      | ${rochade.project.home}/scantableau |
      | Teradata version path | V200                                |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute               |
      | Credential | ROCTableauSACredentials |
      | Node       | ROCIDANode              |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  @webtest @ROC_TableauLocalWorkbook @TEST_MLPQA-18197 @MLPQA-18084 @TEST_MLPQA-18198 @MLPQA-18084
  Scenario: Verify proper error message is shown if mandatory fields are not filled in TableauLocalWorkbookScan plugin configuration
  2. Verify captions and tool tip text is displayed for all the fields in TableauLocalWorkbookScan configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | Rochade                  |
      | Plugin    | TableauLocalWorkbookScan |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                        |
      | Label                        |
      | Business Application         |
      | Source Paths*                |
      | Expand Relative File Paths   |
      | Go into subfolders and ZIPs' |
      | Scan output path*            |
      | Tableau version path*        |
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
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                        | Plugin configuration name                                                                                                                                        |
      | Label                       | Plugin configuration extended label and description                                                                                                              |
      | Business Application        | Business Application                                                                                                                                             |
      | Source Paths*               | Path of local workbook files or folders                                                                                                                          |
      | Expand Relative File Paths  | Select whether to use full wokbook file paths                                                                                                                    |
      | Go into subfolders and ZIPs | Select whether to process sub folders and nested ZIPs                                                                                                            |
      | Scan output path*           | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | Tableau version path*       | Path part name for ScanTableau version                                                                                                                           |
      | Plugin version              | Required plugin version                                                                                                                                          |
      | Logging Level               | Logging Level                                                                                                                                                    |
      | Java memory setting         | Maximum Java memory setting                                                                                                                                      |
      | ClassPath                   | Classpath                                                                                                                                                        |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName             | attribute |
      | Tableau version path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName            | errorMessage                                   |
      | Name                 | Name field should not be empty                 |
      | Scan output path     | Scan output path field should not be empty     |
      | Tableau version path | Tableau version path field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_TableauLocalWorkbook @TEST_MLPQA-18199 @MLPQA-18084 @TEST_MLPQA-18200 @MLPQA-18084
  Scenario: Verify proper error message is shown if mandatory fields are not filled in TableauImport plugin configuration
  2. Verify captions and tool tip text is displayed for all the fields in TableauImport configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute     |
      | Type      | Rochade       |
      | Plugin    | TableauImport |
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

  @webtest @ROC_TableauLocalWorkbook @TEST_MLPQA-18201 @MLPQA-18084 @TEST_MLPQA-18202 @MLPQA-18084
  Scenario: Verify proper error message is shown if mandatory fields are not filled in TableauLinker plugin configuration
  2. Verify captions and tool tip text is displayed for all the fields in TableauLinker configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute     |
      | Type      | Rochade       |
      | Plugin    | TableauLinker |
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

  @webtest @ROC_TableauLocalWorkbook @TEST_MLPQA-18203 @MLPQA-18084 @TEST_MLPQA-18204 @MLPQA-18084
  Scenario: Verify proper error message is shown if mandatory fields are not filled in TableauReconcile plugin configuration
  2. Verify captions and tool tip text is displayed for all the fields in TableauReconcile configuration page

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Rochade          |
      | Plugin    | TableauReconcile |
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
      | Auto start             |
      | Tags                   |
      | Java memory setting    |
      | ClassPath              |
      | Number of threads used |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                   | Plugin configuration name                                                                               |
      | Label                  | Plugin configuration extended label and description                                                     |
      | Business Application   | Business Application                                                                                    |
      | Plugin version         | Required plugin version                                                                                 |
      | Java memory setting    | Maximum Java memory setting                                                                             |
      | ClassPath              | Classpath                                                                                               |
      | Number of threads used | Number of threads used for multi-threading, recommended to set to number of processor kernels available |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #################################################### Plugin Run #####################################################
  @ROC_TableauLocalWorkbook
  Scenario Outline: Run TableauLocalWorkbookScan, TableauImport, TableauLinker, TableauReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TableauLocalWorkbookScan/RochadeTableauLocalScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTableauLocalScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TableauLocalWorkbookScan/RochadeTableauLocalScan  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TableauLocalWorkbookScan/RochadeTableauLocalScan |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTableauLocalScan')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TableauImport/RochadeTableauImport               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTableauImport')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TableauImport/RochadeTableauImport                |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TableauImport/RochadeTableauImport               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTableauImport')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TableauLinker/RochadeTableauLinker               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTableauLinker')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TableauLinker/RochadeTableauLinker                |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TableauLinker/RochadeTableauLinker               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTableauLinker')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TableauReconcile/RochadeTableauReconcile         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTableauReconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/TableauReconcile/RochadeTableauReconcile          |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/TableauReconcile/RochadeTableauReconcile         |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeTableauReconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Tableau                              |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Tableau')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Tableau                               |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Tableau                              |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Tableau')].status          |

  ##################################################### Verifications #####################################################
  @ROC_TableauLocalWorkbook @TEST_MLPQA-18205 @MLPQA-18084 @TEST_MLPQA-18206 @MLPQA-18084
  Scenario: Verify the Logging Enhancements - Analysis logs for TableauLocalWorkbookScan, TableauImport, TableauLinker, TableauReconcile
    Given Analysis log "rochade/TableauLocalWorkbookScan/RochadeTableauLocalScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                     | logCode       | pluginName               | removableText  |
      | INFO | Plugin started                                                                                                                                                                                               | ANALYSIS-0019 |                          |                |
      | INFO | Plugin Name:TableauLocalWorkbookScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeTableauLocalScan | ANALYSIS-0071 | TableauLocalWorkbookScan | Plugin Version |
      | INFO | Plugin TableauLocalWorkbookScan Start Time:2021-01-05 11:06:04.394, End Time:2021-01-05 11:06:19.075, Processed Count:0, Errors:0, Warnings:0                                                                | ANALYSIS-0072 | TableauLocalWorkbookScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                               | ANALYSIS-0020 |                          |                |
    And Analysis log "rochade/TableauImport/RochadeTableauImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                       | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                 | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:TableauImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeTableauImport | ANALYSIS-0071 | TableauImport | Plugin Version |
      | INFO | Plugin TableauImport Start Time:2021-01-05 11:06:47.527, End Time:2021-01-05 11:06:55.753, Processed Count:0, Errors:0, Warnings:0                                                             | ANALYSIS-0072 | TableauImport |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                 | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/TableauLinker/RochadeTableauLinker%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                       | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                 | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:TableauLinker, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeTableauLinker | ANALYSIS-0071 | TableauLinker | Plugin Version |
      | INFO | Plugin TableauLinker Start Time:2021-01-05 11:08:57.389, End Time:2021-01-05 11:09:02.532, Processed Count:0, Errors:0, Warnings:0                                                             | ANALYSIS-0072 | TableauLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                 | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/TableauReconcile/RochadeTableauReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                             | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                       | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:TableauReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeTableauReconcile | ANALYSIS-0071 | TableauReconcile | Plugin Version |
      | INFO | Plugin TableauReconcile Start Time:2021-01-05 11:10:07.763, End Time:2021-01-05 11:11:01.954, Processed Count:0, Errors:0, Warnings:0                                                                | ANALYSIS-0072 | TableauReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                       | ANALYSIS-0020 |                  |                |

  @webtest @ROC_TableauLocalWorkbook @TEST_MLPQA-18208 @MLPQA-18084
  Scenario: Verify the availability of HTML file under analysis items for plugins: TableauLocalWorkbookScan, TableauImport, TableauLinker
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "rochade/TableauLocalWorkbookScan" and clicks on search
    And user performs "facet selection" in "Tableau" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/TableauLocalWorkbookScan/RochadeTableauLocalScan%"
    Then user performs click and verify in new window
      | Table | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Tableau-ScanLog.html | verify widget contains | No               |             |
    And user enters the search text "rochade/TableauImport" and clicks on search
    And user performs "facet selection" in "Tableau" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/TableauImport/RochadeTableauImport%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Tableau-ImportLog.html | verify widget contains | No               |             |
    And user enters the search text "rochade/TableauLinker" and clicks on search
    And user performs "facet selection" in "Tableau" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/TableauLinker/RochadeTableauLinker%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | Tableau-LinkerLog.html | verify widget contains |                  |             |
    And user should be able logoff the IDC

  @ROC_TableauLocalWorkbook @TEST_MLPQA-18210 @MLPQA-18084
  Scenario: Verify the items in EDI matched with items in DD UI after executing TableauLocalWorkbook related plugins
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_PACKAGE ) | 8         |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                        | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_SCHEMA ) | 40        |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_STRUCTURE ) | 105       |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_REPORT ) | 109       |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_RPT_FIELD ) | 371       |

  @webtest @ROC_TableauLocalWorkbook @TEST_MLPQA-18209 @MLPQA-18084 @TEST_MLPQA-18213 @MLPQA-18084
  Scenario: Verify TableauLocalWorkbook Rochade items are replicated to DD after running EDIBus plugin like ReportPackage, ReportSchema, Report, DataType, DataField
  2. Verify the breadcrumb hierarchy appears correctly when TableauLocalWorkbook Rochade items are replicated to DD after running EDIBus plugin

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Tableau" and clicks on search
#    And user performs "facet selection" in "Tableau" attribute under "Technology" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | ReportPackage |
#      | ReportSchema  |
#      | Report        |
#      | DataType      |
#      | DataField     |
    And user enters the search text "" and clicks on search
    And user performs "facet selection" in "DataField" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Chapter 1 - First Workbook [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "[Sample - Superstore - English (Extract)].[Sales]" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | Chapter 1 - First Workbook                        |
      | Worksheets                                        |
      | Sales by Continent/Department                     |
      | [Sample - Superstore - English (Extract)].[Sales] |
    And user should be able logoff the IDC

  @ROC_TableauLocalWorkbook @TEST_MLPQA-18212 @MLPQA-18084
  Scenario: Metadata verification for ReportPackage, ReportSchema, Report, DataType, DataField items after executing TableauLocalWorkbook related plugins.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                  | jsonPath                           | Action                    | query              | ClusterName                | ServiceName | DatabaseName                  | SchemaName                                        | TableName/Filename | columnName/FieldName |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.ReportPackageMetadata.Attributes | metadataAttributePresence | ReportPackageQuery | Chapter 1 - First Workbook |             |                               |                                                   |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.ReportPackageMetadata.Values     | metadataValuePresence     | ReportPackageQuery | Chapter 1 - First Workbook |             |                               |                                                   |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.ReportSchemaMetadata.Attributes  | metadataAttributePresence | ReportSchemaQuery  | Chapter 1 - First Workbook | Worksheets  |                               |                                                   |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.ReportSchemaMetadata.Values      | metadataValuePresence     | ReportSchemaQuery  | Chapter 1 - First Workbook | Worksheets  |                               |                                                   |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.DataTypeMetadata.Attributes      | metadataAttributePresence | DataTypeQuery      | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department |                                                   |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.DataTypeMetadata.Values          | metadataValuePresence     | DataTypeQuery      | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department |                                                   |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.DataFieldMetadata.Attributes1    | metadataAttributePresence | DataFieldQuery     | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department | [Sample - Superstore - English (Extract)].[Sales] |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.DataFieldMetadata.Values1        | metadataValuePresence     | DataFieldQuery     | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department | [Sample - Superstore - English (Extract)].[Sales] |                    |                      |
      | Statistics  | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.DataFieldMetadata.Attributes2    | metadataAttributePresence | DataFieldQuery     | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department | [Sample - Superstore - English (Extract)].[Sales] |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.ReportMetadata.Attributes        | metadataAttributePresence | ReportQuery        | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department |                                                   |                    |                      |
      | Description | ida/ROCTableauLocalWorkbookPayloads/expectedMetadata.json | $.ReportMetadata.Values            | metadataValuePresence     | ReportQuery        | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department |                                                   |                    |                      |

  @ROC_TableauLocalWorkbook @TEST_MLPQA-18211 @MLPQA-18084 @TEST_MLPQA-18207 @MLPQA-18084
  Scenario: Verify Technology tags for replicated items after running TableauLocalWorkbook related & EDIBus plugin
  Verify the Technology tags for Analysis item for TableauLocalWorkbookScan, TableauImport, TableauLinker, TableauReconcile - ROC, Tableau

    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                | ServiceName | DatabaseName                  | SchemaName                                        | TableName/Filename                                        | Column | Tags        | Query              | Action      |
      | Chapter 1 - First Workbook |             |                               |                                                   |                                                           |        | ROC,Tableau | ReportPackageQuery | TagAssigned |
      | Chapter 1 - First Workbook | Worksheets  |                               |                                                   |                                                           |        | ROC,Tableau | ReportSchemaQuery  | TagAssigned |
      | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department |                                                   |                                                           |        | ROC,Tableau | DataTypeQuery      | TagAssigned |
      | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department | [Sample - Superstore - English (Extract)].[Sales] |                                                           |        | ROC,Tableau | DataFieldQuery     | TagAssigned |
      | Chapter 1 - First Workbook | Worksheets  | Sales by Continent/Department |                                                   |                                                           |        | ROC,Tableau | ReportQuery        | TagAssigned |
      |                            |             |                               |                                                   | rochade/TableauLocalWorkbookScan/RochadeTableauLocalScan% |        | ROC,Tableau | AnalysisQuery      | TagAssigned |
      |                            |             |                               |                                                   | rochade/TableauImport/RochadeTableauImport%               |        | ROC,Tableau | AnalysisQuery      | TagAssigned |
      |                            |             |                               |                                                   | rochade/TableauLinker/RochadeTableauLinker%               |        | ROC,Tableau | AnalysisQuery      | TagAssigned |
      |                            |             |                               |                                                   | rochade/TableauReconcile/RochadeTableauReconcile%         |        | ROC,Tableau | AnalysisQuery      | TagAssigned |
      |                            |             |                               |                                                   | bulk/EDIBus/EDIBus_Tableau%                               |        | ROC,Tableau | AnalysisQuery      | TagAssigned |

  ##################################################### Post Conditions #####################################################
  @ROC_TableauLocalWorkbook
  Scenario Outline: Configure EDIBus plugin to perform clean up the data loaded after running TableauLocalWorkbook plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                              | path                           | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_Tableau                            | payloads/ida/ROCTableauLocalWorkbookPayloads/RocTableauLocalWorkbookPluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_Tableau                            |                                                                                       |                                | 200           | EDIBus_Tableau   |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Tableau |                                                                                       |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Tableau')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Tableau  |                                                                                       |                                | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Tableau |                                                                                       |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Tableau')].status |

  @webtest @ROC_TableauLocalWorkbook @TEST_MLPQA-18214 @MLPQA-18084
  Scenario: Verify all item types collected from TableauLocalWorkbook Rochade are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Tableau" and clicks on search
    And user performs "facet selection" in "Tableau" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | ReportPackage |
      | ReportSchema  |
      | Report        |
      | DataType      |
      | DataField     |
    And user should be able logoff the IDC

  @post-condition @ROC_TableauLocalWorkbook
  Scenario: PS_Clearing the EDI subject area after running the Rochade TableauLocalWorkbook wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @post-condition @ROC_TableauLocalWorkbook
  Scenario:  Delete the analysis items for plugins: TableauLocalWorkbookScan, TableauImport, TableauLinker, TableauReconcile, EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                      | type     | query | param |
      | MultipleIDDelete | Default | rochade/TableauLocalWorkbookScan/RochadeTableauLocalScan% | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TableauImport/RochadeTableauImport%               | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TableauLinker/RochadeTableauLinker%               | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/TableauReconcile/RochadeTableauReconcile%         | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_Tableau%                               | Analysis |       |       |

  @post-condition @ROC_TableauLocalWorkbook
  Scenario Outline:  Delete Credentials, Datasource and plugin config for TableauLocalWorkbookScan, TableauImport, TableauLinker, TableauReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                 | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TableauLocalWorkbookScan/RochadeTableauLocalScan |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TableauImport/RochadeTableauImport               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TableauLinker/RochadeTableauLinker               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TableauReconcile/RochadeTableauReconcile         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_Tableau                            |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCTableauSADataSource                           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ROCTableauSACredentials                        |          |      | 200           |                  |          |
