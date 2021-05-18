@MLPQA-17669
Feature: Verify the SQLServerWrapper Plugins functionality (ROC_SQLServer.feature)
#@MLP-31492

  @ROC_SQLServer
  Scenario:Precondions Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                                       | jsonPath                                                               | node            |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.SQLServerScan.configurations.nodeCondition                           | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.SQLServerReconcile.configurations.nodeCondition                      | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.SQLServerPostprocess.configurations.nodeCondition                    | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.SQLServerImport.configurations.nodeCondition                         | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeonlyDB.configurations.nodeCondition                           | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeSchema.configurations.nodeCondition                           | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeSchemaWildcard.configurations.nodeCondition                   | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDandExcludeSchema.configurations.nodeCondition                | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ExcludeDBWildcard.configurations.nodeCondition                       | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDBWildcard.configurations.nodeCondition                       | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDandExcludeSchema.configurations.nodeCondition                | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ExcludeDB.configurations.nodeCondition                               | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ExcludeDBInclSchemaWildcard.configurations.nodeCondition             | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDBExclSchemaWildcard.configurations.nodeCondition             | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDBandIncludeSchema.configurations.nodeCondition               | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ExcludeDBandIncludediffdbSchema.configurations.nodeCondition         | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.WildcardIncludeDBandIncludeSchema.configurations.nodeCondition       | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.WildcardExcludeDBandIncludediffdbSchema.configurations.nodeCondition | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.RegexINCLUDE.configurations.nodeCondition                            | HeadlessEDINode |
      | ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.RegexEXCLUDE.configurations.nodeCondition                            | HeadlessEDINode |


  @ROC_SQLServer
  Scenario Outline: Set the Credentials and Datasources for SQLServerWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                  | bodyFile                                                                   | path                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/RochadeSQLServerCredentials                     | payloads/ida/SQLServerWrapperPayloads/configs/credentials/credentials.json | $.rochadeSQLServerCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/RochadeCredentials                              | payloads/ida/SQLServerWrapperPayloads/configs/credentials/credentials.json | $.rochadeCredentials                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ROCSQLServerDataSource/RochadeSQLServerScanDS     | payloads/ida/SQLServerWrapperPayloads/configs/datasource/datasource.json   | $.SQLServerScanDS                     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ROCSQLServerSADataSource/RochadeSQLServerImportDS | payloads/ida/SQLServerWrapperPayloads/configs/datasource/datasource.json   | $.SQLServerImportDS                   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusSQLServerDS                | payloads/ida/SQLServerWrapperPayloads/configs/datasource/datasource.json   | $.ediBusSQLServerDS                   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerScan/RochadeSQLServerScan                | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json    | $.SQLServerScan.configurations        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerImport/RochadeSQLServerImport            | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json    | $.SQLServerImport.configurations      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerPostprocess/RochadeSQLServerPostprocess  | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json    | $.SQLServerPostprocess.configurations | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerReconcile/RochadeSQLServerReconcile      | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json    | $.SQLServerReconcile.configurations   | 204           |                  |          |

  #################### DataSource TestConnection - UI Validation Error in Mandatory Fields ###################
  @webtest @ROC_SQLServer @TEST_MLPQA-17604 @MLPQA-17471 @TEST_MLPQA-17612 @MLPQA-17471
  Scenario: Verify the datasource test connection is successful for ROCSQLServerDataSource in HeadlessEDINode
  Verify captions and tool tip text is displayed for all the fields in ROCSQLServerDataSource configuration page

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
      | Data Source Type | ROCSQLServerDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Database Url*              |
      | Database JDBC driver path* |
      | Scan output path*          |
      | Sql Server version path*   |
      | Credential                 |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                       | Plugin configuration name                                                                                                                                        |
      | Label                      | Plugin configuration extended label and description                                                                                                              |
      | Database Url*              | JDBC url or the JDBC connection string in format : jdbc:sqlserver://[HOST]:[PORT];databaseName=[DATABASE NAME]                                                   |
      | Database JDBC driver path* | Path that points to the Database JDBC driver path                                                                                                                |
      | Scan output path*          | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | Sql Server version path*   | Path part name for ScanSqlServer version                                                                                                                         |
    And user "enter text" in Add Data Source Page
      | fieldName                  | attribute                                                                             |
      | Name                       | ROCSQLServerDataSourceTest                                                            |
      | Label                      | ROCSQLServerDataSourceTest                                                            |
      | Database Url*              | jdbc:sqlserver://diqbecsql1901v.did.dev.asgint.loc:1433;databaseName=IDATestDatabase; |
      | Database JDBC driver path* | D:\JDBC_Drivers\sqljdbc42.jar                                                         |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                   |
      | Credential | RochadeSQLServerCredentials |
      | Node       | HeadlessEDIRochade          |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  @webtest @ROC_SQLServer @TEST_MLPQA-17613 @MLPQA-17471 @TEST_MLPQA-17615 @MLPQA-17471 @TEST_MLPQA-17616 @MLPQA-17471
  Scenario: Verify the datasource test connection is successful for ROCSQLServerSADataSource in HeadlessEDINode
  Verify proper error message is shown if mandatory fields are not filled in ROCSQLServerSADataSource plugin configuration
  Verify captions and tool tip text is displayed for all the fields in ROCSQLServerSADataSource configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                |
      | Data Source Type | ROCSQLServerSADataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                    |
      | Label                    |
      | Scan output path*        |
      | Sql Server version path* |
      | Credential               |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*                    | Plugin configuration name                                                                                                                                        |
      | Label                    | Plugin configuration extended label and description                                                                                                              |
      | Scan output path*        | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | Sql Server version path* | Path part name for ScanSqlServer version                                                                                                                         |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName                | attribute |
      | Sql Server version path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName               | errorMessage                                      |
      | Name                    | Name field should not be empty                    |
      | Scan output path        | Scan output path field should not be empty        |
      | Sql Server version path | Sql Server version path field should not be empty |
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                    |
      | Name      | ROCSQLServerSADataSourceTest |
      | Label     | ROCSQLServerSADataSourceTest |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute          |
      | Credential | RochadeCredentials |
      | Node       | HeadlessEDIRochade |

  @webtest @ROC_SQLServer @TEST_MLPQA-17617 @MLPQA-17471 @TEST_MLPQA-17618 @MLPQA-17471
  Scenario: Verify proper error message is shown if mandatory fields are not filled in SQLServerScan plugin configuration
  Verify captions and tool tip text is displayed for all the fields in SQLServerScan  configuration page
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
      | fieldName | attribute     |
      | Type      | Rochade       |
      | Plugin    | SQLServerScan |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                 |
      | Label                 |
      | Business Application  |
      | Data Source*          |
      | Credential            |
      | Plugin version        |
      | Event condition       |
      | Event class           |
      | Maximum work size     |
      | Node condition        |
      | Auto start            |
      | Tags                  |
      | Logging Level         |
      | Java memory setting   |
      | ClassPath             |
      | Object Filter Type    |
      | Limit to Include List |
      | Dry Run               |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*                     | Plugin configuration name                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | Label                     | Plugin configuration extended label and description                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | Business Application      | Business Application                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | Plugin version            | Required plugin version                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
      | Logging Level             | Logging Level                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
      | Java memory setting       | Maximum Java memory setting                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
      | ClassPath                 | Classpath                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | Limit to Include List     | When you use an include filter, the Limit to include list option affects to which objects SCANSQLSRVR creates links: - If you enable this option, SCANSQLSRVR creates links only to objects that are also considered by the include filter. - If you disable this option, SCANSQLSRVR creates links to all referenced objects that are not excluded, independently from the include filter objects. The Limit to include list option only takes effect if you specify include filters. |
      | SQL Server scan Arguments | Overrides default SQL Server scan parameters                                                                                                                                                                                                                                                                                                                                                                                                                                           |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_SQLServer @TEST_MLPQA-17619 @MLPQA-17471 @TEST_MLPQA-17620 @MLPQA-17471
  Scenario: Verify proper error message is shown if mandatory fields are not filled in SQLServerImport plugin configuration
  Verify captions and tool tip text is displayed for all the fields in SQLServerImport configuration page
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
      | fieldName | attribute       |
      | Type*     | Rochade         |
      | Plugin*   | SQLServerImport |
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
      | Name*                  | Plugin configuration name                           |
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

  @webtest @ROC_SQLServer @TEST_MLPQA-17621 @MLPQA-17471 @TEST_MLPQA-17631 @MLPQA-17471
  Scenario: Verify proper error message is shown if mandatory fields are not filled in SQLServerPostProcess plugin configuration
  Verify captions and tool tip text is displayed for all the fields in SQLServerPostProcess configuration page
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
      | Type*     | Rochade              |
      | Plugin*   | SQLServerPostprocess |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                            |
      | Label                            |
      | Business Application             |
      | Data Source*                     |
      | Credential                       |
      | Plugin version                   |
      | Event condition                  |
      | Event class                      |
      | Maximum work size                |
      | Node condition                   |
      | Auto start                       |
      | Tags                             |
      | Logging Level                    |
      | Java memory setting              |
      | ClassPath                        |
      | Log Suspicious SQL               |
      | Log Suspicious SQL Path          |
      | SQL Server postprocess Arguments |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*                            | Plugin configuration name                                                                                |
      | Label                            | Plugin configuration extended label and description                                                      |
      | Business Application             | Business Application                                                                                     |
      | Plugin version                   | Required plugin version                                                                                  |
      | Logging Level                    | Logging Level                                                                                            |
      | Java memory setting              | Maximum Java memory setting                                                                              |
      | ClassPath                        | Classpath                                                                                                |
      | Log Suspicious SQL               | Exports SQL to specified folder that caused errors and returned informational messages during processing |
      | Log Suspicious SQL Path          | Path for export of suspicious SQL                                                                        |
      | SQL Server postprocess Arguments | Overrides default SQL Server postprocess parameters                                                      |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_SQLServer @TEST_MLPQA-17632 @MLPQA-17471 @TEST_MLPQA-17633 @MLPQA-17471
  Scenario: Verify proper error message is shown if mandatory fields are not filled in SQLServerReconcile plugin configuration
  Verify captions and tool tip text is displayed for all the fields in SQLServerReconcile configuration page
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
      | Type*     | Rochade            |
      | Plugin*   | SQLServerReconcile |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                               |
      | Label                               |
      | Business Application                |
      | Server Seed item (root namespace)*  |
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
      | Name*                               | Plugin configuration name                                                                               |
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

  @ROC_SQLServer
  Scenario Outline: Set and run the Plugins configurations for SQLServerWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile                                                                 | path                                  | response code | response message | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ROCSQLServerDataSource/RochadeSQLServerScanDS                                 | payloads/ida/SQLServerWrapperPayloads/configs/datasource/datasource.json | $.SQLServerScanDS                     | 204           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ROCSQLServerSADataSource/RochadeSQLServerImportDS                             | payloads/ida/SQLServerWrapperPayloads/configs/datasource/datasource.json | $.SQLServerImportDS                   | 204           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/EDIBusDataSource/EDIBusSQLServerDS                                            | payloads/ida/SQLServerWrapperPayloads/configs/datasource/datasource.json | $.ediBusSQLServerDS                   | 204           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScan                                            | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json  | $.SQLServerScan.configurations        | 204           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerImport/RochadeSQLServerImport                                        | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json  | $.SQLServerImport.configurations      | 204           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerPostprocess/RochadeSQLServerPostprocess                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json  | $.SQLServerPostprocess.configurations | 204           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerReconcile/RochadeSQLServerReconcile                                  | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json  | $.SQLServerReconcile.configurations   | 204           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/EDIBus/EDIBUS_SQLServer                                                       | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json  | $.EDIBUSSQLServer                     | 204           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScan               |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScan')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScan                |                                                                          |                                       | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScan               |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScan')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport           |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport            |                                                                          |                                       | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport           |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerPostprocess/RochadeSQLServerPostprocess |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerPostprocess')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerPostprocess/RochadeSQLServerPostprocess  |                                                                          |                                       | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerPostprocess/RochadeSQLServerPostprocess |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerPostprocess')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerReconcile/RochadeSQLServerReconcile     |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerReconcile')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerReconcile/RochadeSQLServerReconcile      |                                                                          |                                       | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerReconcile/RochadeSQLServerReconcile     |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerReconcile')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBUS_SQLServer                            |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='EDIBUS_SQLServer')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBUS_SQLServer                             |                                                                          |                                       | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBUS_SQLServer                            |                                                                          |                                       | 200           | IDLE             | $.[?(@.configurationName=='EDIBUS_SQLServer')].status            |

    ##################################################### Verifications #####################################################
  @ROC_SQLServer @TEST_MLPQA-17634 @MLPQA-17471
  Scenario: Verify the Logging Enhancements - Analysis logs for SQLServerScan, SQLServerImport, SQLServerPostprocess, SQLServerReconcile
    Given Analysis log "rochade/SQLServerScan/RochadeSQLServerScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                              | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                        | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:SQLServerScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:HeadlessEDIRochade, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeSQLServerScan | ANALYSIS-0071 | SQLServerScan | Plugin Version |
      | INFO | Plugin SQLServerScan Start Time:2020-11-30 08:08:25.089, End Time:2020-11-30 08:08:48.965, Processed Count:0, Errors:0, Warnings:0                                                                    | ANALYSIS-0072 | SQLServerScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                        | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/SQLServerImport/RochadeSQLServerImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                  | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                            | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:SQLServerImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:HeadlessEDIRochade, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeSQLServerImport | ANALYSIS-0071 | SQLServerImport | Plugin Version |
      | INFO | Plugin SQLServerImport Start Time:2020-11-30 08:11:13.288, End Time:2020-11-30 08:11:25.698, Processed Count:0, Errors:0, Warnings:0                                                                      | ANALYSIS-0072 | SQLServerImport |                |
    And Analysis log "rochade/SQLServerPostprocess/RochadeSQLServerPostprocess%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                            | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                      | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:SQLServerPostprocess, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:HeadlessEDIRochade, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeSQLServerPostprocess | ANALYSIS-0071 | SQLServerPostprocess | Plugin Version |
      | INFO | Plugin SQLServerPostprocess Start Time:2020-11-24 07:41:08.602, End Time:2020-11-24 07:44:22.364, Processed Count:0, Errors:0, Warnings:0                                                                           | ANALYSIS-0072 | SQLServerPostprocess |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                      | ANALYSIS-0020 |                      |                |
    And Analysis log "rochade/SQLServerReconcile/RochadeSQLServerReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                        | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                  | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:SQLServerReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:HeadlessEDIRochade, Host Name:DIQSERVER05V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeSQLServerReconcile | ANALYSIS-0071 | SQLServerReconcile | Plugin Version |
      | INFO | Plugin SQLServerReconcile Start Time:2020-11-30 08:13:56.190, End Time:2020-11-30 08:14:16.414, Processed Count:0, Errors:0, Warnings:0                                                                         | ANALYSIS-0072 | SQLServerReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                  | ANALYSIS-0020 |                    |                |

  @ROC_SQLServer @TEST_MLPQA-17670 @MLPQA-17471
  Scenario: Verify Lineage Hops End to End Validation is successfully
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                                                | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | sqlserverviewtomultipletablewithjoinhavingcondition |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | sqlserverviewtomultipletableinnerjoin               |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | sqlserverviewtomultipletablewithjoindiffschema      |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                    | bodyFile                          | path                                                                  | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.sqlserverviewtomultipletablewithjoinhavingcondition | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.sqlserverviewtomultipletableinnerjoin               | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=STITCH&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.sqlserverviewtomultipletablewithjoindiffschema      | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath                                            |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | sqlserverviewtomultipletablewithjoinhavingcondition |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | sqlserverviewtomultipletableinnerjoin               |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | sqlserverviewtomultipletablewithjoindiffschema      |

  @ROC_SQLServer
  Scenario Outline: Verify Lineage Hops End to End Validation is successfully
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                             | actual_json                                               | item                                                |
      | ida/SQLServerWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | sqlserverviewtomultipletablewithjoinhavingcondition |
      | ida/SQLServerWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | sqlserverviewtomultipletableinnerjoin               |
      | ida/SQLServerWrapperPayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | sqlserverviewtomultipletablewithjoindiffschema      |

  @ROC_SQLServer @TEST_MLPQA-17635 @MLPQA-17471
  Scenario: Verify SQLServer Rochade items are replicated to DD after running EDIBus plugin like Service, Database, Schema, Table, Column, Constraint
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                               | jsonPath                              | Action                    | query                         | ClusterName | ServiceName       | DatabaseName    | SchemaName       | TableName/Filename     | columnName/FieldName |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServerDefaultSystem.Description1 | metadataAttributePresence | ServiceQueryWithoutCluster    |             | diqbecsql1901v≫DB |                 |                  |                        |                      |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServerDefaultSystem.Description2 | metadataValuePresence     | ServiceQueryWithoutCluster    |             | diqbecsql1901v≫DB |                 |                  |                        |                      |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_DataBase.Description1     | metadataAttributePresence | DatabaseQueryWithoutCluster   |             | diqbecsql1901v≫DB | idatestdatabase |                  |                        |                      |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_DataBase.Description2     | metadataValuePresence     | DatabaseQueryWithoutCluster   |             | diqbecsql1901v≫DB | idatestdatabase |                  |                        |                      |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_schema.Description1       | metadataAttributePresence | SchemaQueryWithoutCluster     |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage |                        |                      |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_schema.Description2       | metadataValuePresence     | SchemaQueryWithoutCluster     |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage |                        |                      |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_Table.Description1        | metadataAttributePresence | TableQueryWithoutCluster      |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | addresses              |                      |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_Table.Description2        | metadataValuePresence     | TableQueryWithoutCluster      |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | addresses              |                      |
      | Lifecycle   | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_Table.Lifecycle1          | metadataAttributePresence | TableQueryWithoutCluster      |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | addresses              |                      |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_Column.Description        | metadataValuePresence     | ColumnQueryWithoutCluster     |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | addresses              | city                 |
      | Lifecycle   | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_Column.Lifecycle          | metadataAttributePresence | ColumnQueryWithoutCluster     |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | addresses              | city                 |
      | Statistics  | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_Column.Statistics         | metadataValuePresence     | ColumnQueryWithoutCluster     |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | addresses              | city                 |
      | Description | ida/SQLServerWrapperPayloads/API/expectedMetadata.json | $.SQLServer_Constraint.Description    | metadataValuePresence     | ConstraintQueryWithoutCluster |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | fkey1.sqlserverlineage |                      |

  @ROC_SQLServer @TEST_MLPQA-17637 @MLPQA-17471
  Scenario: Verify Technology tags for replicated items after running EDIBus plugin
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName       | DatabaseName    | SchemaName       | TableName/Filename     | Column    | Tags           | Query                         | Action      |
      |             | diqbecsql1901v≫DB |                 |                  |                        |           | SQL Server,ROC | ServiceQueryWithoutCluster    | TagAssigned |
      |             | diqbecsql1901v≫DB | idatestdatabase |                  |                        |           | SQL Server,ROC | DatabaseQueryWithoutCluster   | TagAssigned |
      |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage |                        |           | SQL Server,ROC | SchemaQueryWithoutCluster     | TagAssigned |
      |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | addresses              |           | SQL Server,ROC | TableQueryWithoutCluster      | TagAssigned |
      |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | city1                  | countryid | SQL Server,ROC | ColumnQueryWithoutCluster     | TagAssigned |
      |             | diqbecsql1901v≫DB | idatestdatabase | sqlserverlineage | fkey1.sqlserverlineage |           | SQL Server,ROC | ConstraintQueryWithoutCluster | TagAssigned |

  @webtest @ROC_SQLServer @TEST_MLPQA-17639 @MLPQA-17471
  Scenario: Verify the breadcrumb hierarchy appears correctly when SQLServer Rochade items are replicated to DD after running EDIBus plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sqlserverlineage" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqlserverlineage" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | diqbecsql1901v≫DB |
      | idatestdatabase   |
      | sqlserverlineage  |

  @webtest @ROC_SQLServer @TEST_MLPQA-17638 @MLPQA-17471
  Scenario: Metadata verification for Service, Database, Schema, Table, Column, Trigger, Constraint
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diqbecsql1901v≫DB" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Constraint |
      | Schema     |
      | Database   |
      | Service    |

  @ROC_SQLServer
  Scenario Outline: user retrieves facets and respective counts of SQLServer wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                                 | response code | response message | filePath                                                      | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/SQLServerWrapperPayloads/API/getFacetsCountRequest.json | 200           |                  | payloads/ida/SQLServerWrapperPayloads/API/facetWiseCount.json |          |

  @ROC_SQLServer @TEST_MLPQA-17640 @MLPQA-17471
  Scenario: Verify item count matches based when comparing DD and EDI Bus
    And user gets the items count from json
      | filePath                                                      | jsonPath                                          |
      | payloads/ida/SQLServerWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Column')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_COLUMN ) |
    And user gets the items count from json
      | filePath                                                      | jsonPath                                         |
      | payloads/ida/SQLServerWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Table')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user gets the items count from json
      | filePath                                                      | jsonPath                                              |
      | payloads/ida/SQLServerWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Constraint')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_FOREIGN_KEY ) |
    And user gets the items count from json
      | filePath                                                      | jsonPath                                          |
      | payloads/ida/SQLServerWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Schema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_SCHEMA ) |
    And user gets the items count from json
      | filePath                                                      | jsonPath                                            |
      | payloads/ida/SQLServerWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Database')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DATABASE ) |
    And user gets the items count from json
      | filePath                                                      | jsonPath                                           |
      | payloads/ida/SQLServerWrapperPayloads/API/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Service')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DB_SYSTEM ) |


  @ROC_SQLServer
  Scenario Outline: PostConditions-EDIBusCleanup - after Lineage Verification
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | bodyFile                                                                | path            | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/EDIBus/EDIBUS_SQLServer                            | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ediBusCleanUp | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBUS_SQLServer |                                                                         |                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBUS_SQLServer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBUS_SQLServer  |                                                                         |                 | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBUS_SQLServer |                                                                         |                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBUS_SQLServer')].status |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

#################################################FILTER CONDITION############################################

  @ROC_SQLServer
  Scenario Outline: Simple DB and Schema Include DB only and run the Plugins for SQLServerWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile                                                                | path                           | response code | response message | jsonPath                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlyDB                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeonlyDB.configurations | 204           |                  |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlyDB |                                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSDSSIncludeonlyDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlyDB  |                                                                         |                                | 200           |                  |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlyDB |                                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSDSSIncludeonlyDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport              |                                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport               |                                                                         |                                | 200           |                  |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport              |                                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                |

  @ROC_SQLServer @TEST_MLPQA-17641 @MLPQA-17471
  Scenario: Verify Data base are filtered in simple DB and Schema filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SERVER ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: Simple DB and Schema Include Schema only and run the Plugins for SQLServerWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                     | bodyFile                                                                | path                           | response code | response message | jsonPath                                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlySchema                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeSchema.configurations | 204           |                  |                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlySchema |                                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSDSSIncludeonlySchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlySchema  |                                                                         |                                | 200           |                  |                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlySchema |                                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSDSSIncludeonlySchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                  |                                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                   |                                                                         |                                | 200           |                  |                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                  |                                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                    |

  @ROC_SQLServer @TEST_MLPQA-17642 @MLPQA-17471
  Scenario: Verify Schema are filtered in simple DB and Schema filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SERVER ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames        |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | sqlserverlineage |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: Simple DB and Schema Exclude DB only and run the Plugins for SQLServerWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile                                                                | path                       | response code | response message | jsonPath                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanSDSSExcludeonlyDB                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ExcludeDB.configurations | 204           |                  |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSExcludeonlyDB |                                                                         |                            | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSDSSExcludeonlyDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSExcludeonlyDB  |                                                                         |                            | 200           |                  |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSExcludeonlyDB |                                                                         |                            | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSDSSExcludeonlyDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport              |                                                                         |                            | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport               |                                                                         |                            | 200           |                  |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport              |                                                                         |                            | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                |

  @ROC_SQLServer @TEST_MLPQA-17643 @MLPQA-17471
  Scenario: Verify Database are excluded in simple DB and Schema filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SERVER ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: Simple DB and Schema - Include DB and Exclude few schema run the Plugins for SQLServerWrappers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                             | bodyFile                                                                | path                                      | response code | response message | jsonPath                                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanSDSSIncludeDBandExcludeSchema                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDandExcludeSchema.configurations | 204           |                  |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeDBandExcludeSchema |                                                                         |                                           | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSDSSIncludeDBandExcludeSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeDBandExcludeSchema  |                                                                         |                                           | 200           |                  |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSDSSIncludeDBandExcludeSchema |                                                                         |                                           | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSDSSIncludeDBandExcludeSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                          |                                                                         |                                           | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                           |                                                                         |                                           | 200           |                  |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                          |                                                                         |                                           | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                            |

  @ROC_SQLServer @TEST_MLPQA-17644 @MLPQA-17471
  Scenario: Verify Database Included and few schema excluded in simple DB and Schema filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | 10        |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames                                                                                                                                  |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | sqlserverlineage,db_owner,db_denydatawriter,db_denydatareader,db_ddladmin,db_datawriter,db_datareader,db_backupoperator,db_accessadmin,dbo |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: Wildcard Object Filter - Include DB and run Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                       | bodyFile                                                                | path                               | response code | response message | jsonPath                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardIncludeDBFilter                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDBWildcard.configurations | 204           |                  |                                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardIncludeDBFilter |                                                                         |                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardIncludeDBFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardIncludeDBFilter  |                                                                         |                                    | 200           |                  |                                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardIncludeDBFilter |                                                                         |                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardIncludeDBFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                    |                                                                         |                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                     |                                                                         |                                    | 200           |                  |                                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                    |                                                                         |                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                      |

  @ROC_SQLServer @TEST_MLPQA-17645 @MLPQA-17471
  Scenario: Verify Database Included  in Wildcard object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: Wildcard Object Filter - Exclude DB and run Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                       | bodyFile                                                                | path                               | response code | response message | jsonPath                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardExcludeDBFilter                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ExcludeDBWildcard.configurations | 204           |                  |                                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardExcludeDBFilter |                                                                         |                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardExcludeDBFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardExcludeDBFilter  |                                                                         |                                    | 200           |                  |                                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardExcludeDBFilter |                                                                         |                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardExcludeDBFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                    |                                                                         |                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                     |                                                                         |                                    | 200           |                  |                                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                    |                                                                         |                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                      |

  @ROC_SQLServer @TEST_MLPQA-17646 @MLPQA-17471
  Scenario: Verify Database Excluded  in Wildcard object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: Wildcard Object Filter - Include Schema and run Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                           | bodyFile                                                                | path                                   | response code | response message | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardIncludeSchemaFilter                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeSchemaWildcard.configurations | 204           |                  |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardIncludeSchemaFilter |                                                                         |                                        | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardIncludeSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardIncludeSchemaFilter  |                                                                         |                                        | 200           |                  |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardIncludeSchemaFilter |                                                                         |                                        | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardIncludeSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                        |                                                                         |                                        | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                         |                                                                         |                                        | 200           |                  |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                        |                                                                         |                                        | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                          |

  @ROC_SQLServer @TEST_MLPQA-17647 @MLPQA-17471
  Scenario: Verify Schema Included  in Wildcard object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames        |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | sqlserverlineage |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: Wildcard Object Filter - Include DB and Exclude few schema run Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                        | bodyFile                                                                | path                                         | response code | response message | jsonPath                                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardInclDBExclSchema                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDBExclSchemaWildcard.configurations | 204           |                  |                                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardInclDBExclSchema |                                                                         |                                              | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardInclDBExclSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardInclDBExclSchema  |                                                                         |                                              | 200           |                  |                                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardInclDBExclSchema |                                                                         |                                              | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardInclDBExclSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                     |                                                                         |                                              | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                      |                                                                         |                                              | 200           |                  |                                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                     |                                                                         |                                              | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                       |

  @ROC_SQLServer @TEST_MLPQA-17648 @MLPQA-17471
  Scenario: Verify Database Included  and few schema excluded in Wildcard object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | 10        |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames                                                                                                                                  |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | sqlserverlineage,db_owner,db_denydatawriter,db_denydatareader,db_ddladmin,db_datawriter,db_datareader,db_backupoperator,db_accessadmin,dbo |
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: simple Database plugin configuration and run the Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                        | bodyFile                                                                | path                                         | response code | response message | jsonPath                                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardExclDBInclSchema                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ExcludeDBInclSchemaWildcard.configurations | 204           |                  |                                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardExclDBInclSchema |                                                                         |                                              | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardExclDBInclSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardExclDBInclSchema  |                                                                         |                                              | 200           |                  |                                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanwildcardExclDBInclSchema |                                                                         |                                              | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanwildcardExclDBInclSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                     |                                                                         |                                              | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                      |                                                                         |                                              | 200           |                  |                                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                     |                                                                         |                                              | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                       |

  @ROC_SQLServerVerify @TEST_MLPQA-17649 @MLPQA-17471
  Scenario: Verify Database Excluded  and few schema Included in Wildcard object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | 5         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames                                                |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | testschema,sys,information_schema,guest,db_securityadmin |
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @ROC_SQLServer
  Scenario Outline: simple Database plugin configuration and run the Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                     | bodyFile                                                                | path                                       | response code | response message | jsonPath                                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanSimpleInclDBandSchema                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.IncludeDBandIncludeSchema.configurations | 204           |                  |                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleInclDBandSchema |                                                                         |                                            | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSimpleInclDBandSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleInclDBandSchema  |                                                                         |                                            | 200           |                  |                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleInclDBandSchema |                                                                         |                                            | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSimpleInclDBandSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                  |                                                                         |                                            | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                   |                                                                         |                                            | 200           |                  |                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                  |                                                                         |                                            | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                    |


  @ROC_SQLServer @TEST_MLPQA-17816 @MLPQA-17471
  Scenario: Verify Database Include  and few schema Included in Simple DB and Schema filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames        |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | sqlserverlineage |
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: simple Database plugin configuration and run the Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                             | bodyFile                                                                | path                                             | response code | response message | jsonPath                                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanSimpleExclDBandINCLdiffSchema                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.ExcludeDBandIncludediffdbSchema.configurations | 204           |                  |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleExclDBandINCLdiffSchema |                                                                         |                                                  | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSimpleExclDBandINCLdiffSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleExclDBandINCLdiffSchema  |                                                                         |                                                  | 200           |                  |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleExclDBandINCLdiffSchema |                                                                         |                                                  | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSimpleExclDBandINCLdiffSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                          |                                                                         |                                                  | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                           |                                                                         |                                                  | 200           |                  |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                          |                                                                         |                                                  | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                            |


  @ROC_SQLServer @TEST_MLPQA-17815 @MLPQA-17471
  Scenario: Verify Database Excluded  and few schema Included of Different DB in Simple DB and Schema filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames        |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | sqlserverlineage |
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: simple Database plugin configuration and run the Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                          | bodyFile                                                                | path                                               | response code | response message | jsonPath                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanWildcardIncludeDBandSchema                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.WildcardIncludeDBandIncludeSchema.configurations | 204           |                  |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanWildcardIncludeDBandSchema |                                                                         |                                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanWildcardIncludeDBandSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanWildcardIncludeDBandSchema  |                                                                         |                                                    | 200           |                  |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanWildcardIncludeDBandSchema |                                                                         |                                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanWildcardIncludeDBandSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                       |                                                                         |                                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                        |                                                                         |                                                    | 200           |                  |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                       |                                                                         |                                                    | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                         |


  @ROC_SQLServer @TEST_MLPQA-17814 @MLPQA-17471
  Scenario: Verify Database Include  and few schema Included in Wildcard object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames        |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | sqlserverlineage |
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: simple Database plugin configuration and run the Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                | bodyFile                                                                | path                                                     | response code | response message | jsonPath                                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerScanSimpleExcludeDBandINCLdiffSchema                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.WildcardExcludeDBandIncludediffdbSchema.configurations | 204           |                  |                                                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleExcludeDBandINCLdiffSchema |                                                                         |                                                          | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSimpleExcludeDBandINCLdiffSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleExcludeDBandINCLdiffSchema  |                                                                         |                                                          | 200           |                  |                                                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerScanSimpleExcludeDBandINCLdiffSchema |                                                                         |                                                          | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerScanSimpleExcludeDBandINCLdiffSchema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                             |                                                                         |                                                          | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                              |                                                                         |                                                          | 200           |                  |                                                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport                             |                                                                         |                                                          | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status                               |


  @ROC_SQLServer @TEST_MLPQA-17813 @MLPQA-17471
  Scenario: Verify Database Excluded  and few schema of different DB Included in Wildcard object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                | itemNames        |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/SCHEMA ) | sqlserverlineage |
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |

  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: simple Database plugin configuration and run the Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                          | response code | response message | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerRegexinclude                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.RegexINCLUDE.configurations | 204           |                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerRegexinclude |                                                                         |                               | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerRegexinclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerRegexinclude  |                                                                         |                               | 200           |                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerRegexinclude |                                                                         |                               | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerRegexinclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport     |                                                                         |                               | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport      |                                                                         |                               | 200           |                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport     |                                                                         |                               | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status       |


  @ROC_SQLServer @TEST_MLPQA-17636 @MLPQA-17471
  Scenario: Verify Database Include in Regular expression object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |


  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @ROC_SQLServer
  Scenario Outline: simple Database plugin configuration and run the Plugins for SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                          | response code | response message | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerScan/RochadeSQLServerRegexExclude                              | payloads/ida/SQLServerWrapperPayloads/configs/plugin/pluginconfigs.json | $.RegexEXCLUDE.configurations | 204           |                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerRegexExclude |                                                                         |                               | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerRegexExclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerRegexExclude  |                                                                         |                               | 200           |                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerScan/RochadeSQLServerRegexExclude |                                                                         |                               | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerRegexExclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport     |                                                                         |                               | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport      |                                                                         |                               | 200           |                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/SQLServerImport/RochadeSQLServerImport     |                                                                         |                               | 200           | IDLE             | $.[?(@.configurationName=='RochadeSQLServerImport')].status       |


  @ROC_SQLServer @TEST_MLPQA-17757 @MLPQA-17471
  Scenario: Verify Database Exclude in Regular expression object filter
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | 1         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames       |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = SQL/DATABASE ) | idatestdatabase |


  @ROC_SQLServer
  Scenario:PostConditions-Clearing the EDI subject area after running the Rochade wrapper plugins from DD - after Lineage Verification
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @ROC_SQLServer
  Scenario:PostConditions:Delete ids
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                          | type     | query | param |
      | MultipleIDDelete | Default | rochade/SQLServer%            | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBUS_SQLServer% | Analysis |       |       |

  @ROC_SQLServer
  Scenario Outline: PostConditions-Delete the Credentials, Data Sources and Cataloger, Collector, Parser, Lineage plugins Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScan                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerImport/RochadeSQLServerImport                             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerPostprocess/RochadeSQLServerPostprocess                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerReconcile/RochadeSQLServerReconcile                       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBUS_SQLServer                                            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlyDB                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanSDSSIncludeonlySchema            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanSDSSExcludeonlyDB                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanSDSSIncludeDBandExcludeSchema    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardIncludeDBFilter          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardExcludeDBFilter          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardIncludeSchemaFilter      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardInclDBExclSchema         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanwildcardExclDBInclSchema         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanSimpleInclDBandSchema            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanSimpleExclDBandINCLdiffSchema    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanWildcardIncludeDBandSchema       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerScanSimpleExcludeDBandINCLdiffSchema |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerRegexinclude                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerScan/RochadeSQLServerRegexExclude                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCSQLServerDataSource/RochadeSQLServerScanDS                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCSQLServerSADataSource/RochadeSQLServerImportDS                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusSQLServerDS                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeSQLServerCredentials                                      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeCredentials                                               |      | 200           |                  |          |