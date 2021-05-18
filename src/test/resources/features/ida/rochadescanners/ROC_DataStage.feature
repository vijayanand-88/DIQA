@MLPQA-19168
Feature: Verification of Rochade-DD wrapper plugins for DataStage such as DataStageScan, DataStageImport, DataStageLink, DataStageReconcile
#  Stories: @MLP-32833

  #################################################### Pre-Conditions #####################################################
  @pre-condition @ROC_DataStage
  Scenario: Pre: Clearing the EDI subject area before running the Rochade DataStage wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @pre-condition @ROC_DataStage
  Scenario:Headless EDI Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                               | jsonPath                                          | node            |
      | ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.DataStageScan.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.DataStageImport.configurations.nodeCondition    | HeadlessEDINode |
      | ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.DataStageLink.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.DataStageReconcile.configurations.nodeCondition | HeadlessEDINode |

  @pre-condition @ROC_DataStage
  Scenario Outline: Configure Credentials, Data Source for DataStage wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | bodyFile                                                       | path                       | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ROCDataStageSACredentials | payloads/ida/ROCDataStagePayloads/RocDataStageCredentials.json | $.SACredentials            | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ROCDataStageSACredentials |                                                                |                            | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCDataStageSADataSource    | payloads/ida/ROCDataStagePayloads/RocDataStageDataSource.json  | $.ROCDataStageSADataSource | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCDataStageSADataSource    |                                                                |                            | 200           | RochadeDataStageSA_DS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource            | payloads/ida/ROCDataStagePayloads/RocDataStageDataSource.json  | $.EDIBusDataSource         | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource            |                                                                |                            | 200           | EDIBusDataStageDS     |          |

  @pre-condition @ROC_DataStage
  Scenario Outline: Configure plugins: DataStageScan, DataStageImport, DataStageLink, DataStageReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                             | bodyFile                                                        | path                                | response code | response message          | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/DataStageScan/RochadeDataStageScan           | payloads/ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.DataStageScan.configurations      | 204           |                           |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/DataStageScan/RochadeDataStageScan           |                                                                 |                                     | 200           | RochadeDataStageScan      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/DataStageImport/RochadeDataStageImport       | payloads/ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.DataStageImport.configurations    | 204           |                           |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/DataStageImport/RochadeDataStageImport       |                                                                 |                                     | 200           | RochadeDataStageImport    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/DataStageLink/RochadeDataStageLink           | payloads/ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.DataStageLink.configurations      | 204           |                           |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/DataStageLink/RochadeDataStageLink           |                                                                 |                                     | 200           | RochadeDataStageLink      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/DataStageReconcile/RochadeDataStageReconcile | payloads/ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.DataStageReconcile.configurations | 204           |                           |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/DataStageReconcile/RochadeDataStageReconcile |                                                                 |                                     | 200           | RochadeDataStageReconcile |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_DataStage                      | payloads/ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.EDIBus.configurations             | 204           |                           |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_DataStage                      |                                                                 |                                     | 200           | EDIBus_DataStage          |          |

  #################################################### UI Validations #####################################################
  @webtest @ROC_DataStage @TEST_MLPQA-19152 @MLPQA-18084 @TEST_MLPQA-19153 @MLPQA-18084
  Scenario: Verify the datasource test connection is successful for ROCDataStageSADataSource in HeadlessEDINode
  2. Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in ROCDataStageSADataSource configuration

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
      | Data Source Type | ROCDataStageSADataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Scan output path*          |
      | DataStage version path*    |
      | DataStage import file path |
      | Credential                 |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                       | Plugin configuration name                                                                                                                                        |
      | Label                      | Plugin configuration extended label and description                                                                                                              |
      | Scan output path*          | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | DataStage import file path | Path that points to the directory where the import files for Rochade can be stored.                                                                              |
      | DataStage version path     | Path part name for DataStage version                                                                                                                             |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user "enter text" in Add Data Source Page
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    And user "enter text" in Add Data Source Page
      | fieldName               | attribute |
      | DataStage version path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName              | errorMessage                                     |
      | Name                   | Name field should not be empty                   |
      | Scan output path       | Scan output path field should not be empty       |
      | DataStage version path | DataStage version path field should not be empty |
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName                  | attribute                         |
      | Name                       | ROCDataStageSADataSourceTest      |
      | Label                      | ROCDataStageSADataSourceTest      |
      | Scan output path           | ${rochade.project.home}/datastage |
      | DataStage import file path | ${rochade.project.home}/out       |
      | DataStage version path     | V170                              |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                 |
      | Credential | ROCDataStageSACredentials |
      | Node       | ROCIDANode                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  @webtest @ROC_DataStage @TEST_MLPQA-19154 @MLPQA-18084
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in DataStageScan plugin configuration

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
      | Plugin    | DataStageScan |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Business Application       |
      | DataStage export file path |
      | Data Source*               |
      | Credential*                |
      | Plugin version             |
      | Event condition            |
      | Event class                |
      | Maximum work size          |
      | Node condition             |
      | Auto start                 |
      | Tags                       |
      | Scanner Mode               |
      | Java memory setting        |
      | ClassPath                  |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                       | Plugin configuration name                                                        |
      | Label                      | Plugin configuration extended label and description                              |
      | Business Application       | Business Application                                                             |
      | DataStage export file path | Path that points to the directory where the DataStage export files can be found. |
      | Plugin version             | Required plugin version                                                          |
      | Java memory setting        | Maximum Java memory setting                                                      |
      | ClassPath                  | Classpath                                                                        |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_DataStage @TEST_MLPQA-19155 @MLPQA-18084
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in DataStageImport plugin configuration

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
      | fieldName | attribute       |
      | Type      | Rochade         |
      | Plugin    | DataStageImport |
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

  @webtest @ROC_DataStage @TEST_MLPQA-19156 @MLPQA-18084
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in DataStageLink plugin configuration

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
      | Plugin    | DataStageLink |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                                        |
      | Label                                        |
      | Business Application                         |
      | Data Source*                                 |
      | Credential                                   |
      | Plugin version                               |
      | Event condition                              |
      | Event class                                  |
      | Maximum work size                            |
      | Node condition                               |
      | Auto start                                   |
      | Tags                                         |
      | Logging Level                                |
      | Java memory setting                          |
      | Search sequential structure with column name |
      | Build sequential structure simple mode       |
      | Check database name from stage parameter     |
      | Handle Filepattern as Filenames              |
      | Use DB and User from Stage                   |
      | Environment Export File                      |
      | Environment Export File per Parameter        |
      | Environment Export File per Project          |
      | Job Call Parameter                           |
      | Job Call Parameter per Project               |
      | ClassPath                                    |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                                         | Plugin configuration name                                                                                                                                                                                                                                               |
      | Label                                        | Plugin configuration extended label and description                                                                                                                                                                                                                     |
      | Business Application                         | Business Application                                                                                                                                                                                                                                                    |
      | Plugin version                               | Required plugin version                                                                                                                                                                                                                                                 |
      | Logging Level                                | Logging Level                                                                                                                                                                                                                                                           |
      | Java memory setting                          | Maximum Java memory setting                                                                                                                                                                                                                                             |
      | ClassPath                                    | Classpath                                                                                                                                                                                                                                                               |
      | Search sequential structure with column name | A Boolean flag that specifies whether column names should be included in the search (i.e., true) or only the format will be considered (i.e., false).                                                                                                                   |
      | Build sequential structure simple mode       | A Boolean flag that specifies whether the DataStage Linker extracts only one structure per analyzed file, also if the file is used with different structures (i.e., true) or multiple structures should be created (i.e., false).                                       |
      | Check database name from stage parameter     | A Boolean flag that specifies whether the DataStage Linker will use the database name outside of Orchestrate code or the stage parameter (i.e., true) or the stage parameter *-dbname should not be supported (i.e., false).                                            |
      | Handle Filepattern as Filenames              | A Boolean flag that specifies whether the DataStage Linker will interpret patterns outside of Orchestrate code or the stage parameter as file names (i.e., true) or the pattern should be ignored (i.e., false).                                                        |
      | Use DB and User from Stage                   | A Boolean flag that specifies whether the DataStage Linker extracts the database name and the user ID (i.e., schema) from the corresponding items of type DS/STAGE-PARAM and uses these for the linking process (i.e., true) or should not be considered (i.e., false). |
      | Environment Export File                      | An environment file that the DataStage Linker uses to resolve variables.                                                                                                                                                                                                |
      | Environment Export File per Parameter        | A list of pairs of job parameter and environment file names separated by semicolons that the DataStage Linker uses to resolve variables specified in job parameters (e.g., jobparametername1;file1;jobparametername2;file2).                                            |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @ROC_DataStage @TEST_MLPQA-19157 @MLPQA-18084
  Scenario: Verify captions and tool tip text is displayed for all the fields and proper error message is shown if mandatory fields are not filled in DataStageReconcile plugin configuration

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
      | fieldName | attribute          |
      | Type      | Rochade            |
      | Plugin    | DataStageReconcile |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Advanced Settings |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                        |
      | Label                        |
      | Business Application         |
      | Reconcile seed item - Server |
      | Data Source*                 |
      | Credential                   |
      | Plugin version               |
      | Event condition              |
      | Event class                  |
      | Maximum work size            |
      | Node condition               |
      | Auto start                   |
      | Tags                         |
      | Java memory setting          |
      | ClassPath                    |
      | Number of threads used       |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                         | Plugin configuration name                                                                               |
      | Label                        | Plugin configuration extended label and description                                                     |
      | Business Application         | Business Application                                                                                    |
      | Reconcile seed item - Server | Specify the transformation start item name                                                              |
      | Plugin version               | Required plugin version                                                                                 |
      | Java memory setting          | Maximum Java memory setting                                                                             |
      | ClassPath                    | Classpath                                                                                               |
      | Number of threads used       | Number of threads used for multi-threading, recommended to set to number of processor kernels available |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #################################################### Plugin Run #####################################################
  @ROC_DataStage
  Scenario Outline: Run DataStageScan, DataStageImport, DataStageLink, DataStageReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/DataStageScan/RochadeDataStageScan           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeDataStageScan')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/DataStageScan/RochadeDataStageScan            |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/DataStageScan/RochadeDataStageScan           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeDataStageScan')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/DataStageImport/RochadeDataStageImport       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeDataStageImport')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/DataStageImport/RochadeDataStageImport        |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/DataStageImport/RochadeDataStageImport       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeDataStageImport')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/DataStageLink/RochadeDataStageLink           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeDataStageLink')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/DataStageLink/RochadeDataStageLink            |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/DataStageLink/RochadeDataStageLink           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeDataStageLink')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/DataStageReconcile/RochadeDataStageReconcile |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeDataStageReconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/DataStageReconcile/RochadeDataStageReconcile  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/DataStageReconcile/RochadeDataStageReconcile |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeDataStageReconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_DataStage                        |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_DataStage')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_DataStage                         |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_DataStage                        |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_DataStage')].status          |

  @ROC_DataStage
  Scenario Outline: Sync Solr
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | searches/fulltext/synchronize/Default |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post   | searches/fulltext/synchronize/Default |          |      | 200           |                  |          |

  ##################################################### Verifications #####################################################
  @ROC_DataStage @TEST_MLPQA-19159 @MLPQA-18084
  Scenario: Verify the Logging Enhancements - Analysis logs for DataStageScan, DataStageImport, DataStageLink, DataStageReconcile
    Given Analysis log "rochade/DataStageScan/RochadeDataStageScan%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                       | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                 | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:DataStageScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeDataStageScan | ANALYSIS-0071 | DataStageScan | Plugin Version |
      | INFO | Plugin DataStageScan Start Time:2021-01-05 11:06:04.394, End Time:2021-01-05 11:06:19.075, Processed Count:0, Errors:0, Warnings:0                                                             | ANALYSIS-0072 | DataStageScan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                 | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/DataStageImport/RochadeDataStageImport%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                           | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                     | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:DataStageImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeDataStageImport | ANALYSIS-0071 | DataStageImport | Plugin Version |
      | INFO | Plugin DataStageImport Start Time:2021-01-05 11:06:47.527, End Time:2021-01-05 11:06:55.753, Processed Count:0, Errors:0, Warnings:0                                                               | ANALYSIS-0072 | DataStageImport |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                     | ANALYSIS-0020 |                 |                |
    And Analysis log "rochade/DataStageLink/RochadeDataStageLink%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                       | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                 | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:DataStageLink, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeDataStageLink | ANALYSIS-0071 | DataStageLink | Plugin Version |
      | INFO | Plugin DataStageLink Start Time:2021-01-05 11:08:57.389, End Time:2021-01-05 11:09:02.532, Processed Count:0, Errors:0, Warnings:0                                                             | ANALYSIS-0072 | DataStageLink |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                 | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/DataStageReconcile/RochadeDataStageReconcile%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                 | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                                           | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:DataStageReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeDataStageReconcile | ANALYSIS-0071 | DataStageReconcile | Plugin Version |
      | INFO | Plugin DataStageReconcile Start Time:2021-01-05 11:10:07.763, End Time:2021-01-05 11:11:01.954, Processed Count:0, Errors:0, Warnings:0                                                                  | ANALYSIS-0072 | DataStageReconcile |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                           | ANALYSIS-0020 |                    |                |

  @webtest @ROC_DataStage @TEST_MLPQA-19160 @MLPQA-18084
  Scenario: Verify the availability of HTML file under analysis items for plugins: DataStageImport, DataStageLink
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "rochade/DataStageImport" and clicks on search
    And user performs "facet selection" in "DataStage" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/DataStageImport/RochadeDataStageImport%"
    Then user performs click and verify in new window
      | Table | value                                    | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | DatastageDB-ImportLog_Pjob_DW_TEST1.html | verify widget contains | No               |             |
    And user enters the search text "rochade/DataStageLink" and clicks on search
    And user performs "facet selection" in "DataStage" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "rochade/DataStageLink/RochadeDataStageLink%"
    Then user performs click and verify in new window
      | Table | value                        | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | DatastageDB-DBLinkerLog.html | verify widget contains |                  |             |
    And user should be able logoff the IDC

  @ROC_DataStage @TEST_MLPQA-19161 @MLPQA-18084
  Scenario: Verify the items in EDI matched with items in DD UI after executing DataStage related plugins
    Given user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_SYSTEM ) | 4         |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TASK ) | 6         |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                            | itemCount |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TRANSFORMATION ) | 6         |

  @webtest @ROC_DataStage @TEST_MLPQA-19162 @MLPQA-18084 @TEST_MLPQA-19163 @MLPQA-18084
  Scenario: Verify DataStage Rochade items are replicated to DD after running EDIBus plugin like Service, Operation
  2. Verify the breadcrumb hierarchy appears correctly when DataStage Rochade items are replicated to DD after running EDIBus plugin.

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DataStage" and clicks on search
    And user performs "facet selection" in "DataStage" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Service   |
      | Operation |
      | Analysis  |
      | DataType  |
      | DataField |
      | File      |
    And user enters the search text "" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "TPECSU04≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "$$Summarized" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | TPECSU04≫Operation |
      | AC_SIT≫Operation   |
      | Pjb_RCP_STG2AC     |
      | $$Summarized       |
    And user should be able logoff the IDC

  @ROC_DataStage @TEST_MLPQA-19164 @MLPQA-18084
  Scenario: Verify the Metadata for Service, Operation items after executing DataStage related plugins.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                       | jsonPath                        | Action                    | query                         | ClusterName | ServiceName            | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/ROCDataStagePayloads/expectedMetadata.json | $.Service1Metadata.Attributes   | metadataAttributePresence | ServiceQueryWithoutCluster    |             | ONCBSHAVM030≫Operation |              |            |                    |                      |
      | Description | ida/ROCDataStagePayloads/expectedMetadata.json | $.Service1Metadata.Values       | metadataValuePresence     | ServiceQueryWithoutCluster    |             | ONCBSHAVM030≫Operation |              |            |                    |                      |
      | Description | ida/ROCDataStagePayloads/expectedMetadata.json | $.Service2Metadata.Attributes   | metadataAttributePresence | ServiceQueryWithoutCluster    |             | PRE_PROD≫Operation     |              |            |                    |                      |
      | Description | ida/ROCDataStagePayloads/expectedMetadata.json | $.Service2Metadata.Values       | metadataValuePresence     | ServiceQueryWithoutCluster    |             | PRE_PROD≫Operation     |              |            |                    |                      |
      | Description | ida/ROCDataStagePayloads/expectedMetadata.json | $.Operation1Metadata.Attributes | metadataAttributePresence | OperationQuery                |             |                        |              |            | Pjb_RCP_STG2AC     |                      |
      | Description | ida/ROCDataStagePayloads/expectedMetadata.json | $.Operation1Metadata.Values     | metadataValuePresence     | OperationQuery                |             |                        |              |            | Pjb_RCP_STG2AC     |                      |
      | Description | ida/ROCDataStagePayloads/expectedMetadata.json | $.Operation2Metadata.Attributes | metadataAttributePresence | OperationWithinOperationQuery |             |                        |              |            | Pjb_RCP_STG2AC     | $$Summarized         |
      | Description | ida/ROCDataStagePayloads/expectedMetadata.json | $.Operation2Metadata.Values     | metadataValuePresence     | OperationWithinOperationQuery |             |                        |              |            | Pjb_RCP_STG2AC     | $$Summarized         |

  @ROC_DataStage @TEST_MLPQA-19165 @MLPQA-18084 @TEST_MLPQA-19166 @MLPQA-18084
  Scenario: Verify Technology tags for replicated items after running DataStage related & EDIBus plugin
  2. Verify the Technology tags for Analysis item for DataStageScan, DataStageImport, DataStageLink, DataStageReconcile - ROC, DataStage

    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName            | DatabaseName | SchemaName | TableName/Filename                                    | Column       | Tags          | Query                         | Action      |
      |             | ONCBSHAVM030≫Operation |              |            |                                                       |              | ROC,DataStage | ServiceQueryWithoutCluster    | TagAssigned |
      |             | PRE_PROD≫Operation     |              |            |                                                       |              | ROC,DataStage | ServiceQueryWithoutCluster    | TagAssigned |
      |             |                        |              |            | Pjb_RCP_STG2AC                                        |              | ROC,DataStage | OperationQuery                | TagAssigned |
      |             |                        |              |            | Pjb_RCP_STG2AC                                        | $$Summarized | ROC,DataStage | OperationWithinOperationQuery | TagAssigned |
      |             |                        |              |            | rochade/DataStageScan/RochadeDataStageScan%           |              | ROC,DataStage | AnalysisQuery                 | TagAssigned |
      |             |                        |              |            | rochade/DataStageImport/RochadeDataStageImport%       |              | ROC,DataStage | AnalysisQuery                 | TagAssigned |
      |             |                        |              |            | rochade/DataStageLink/RochadeDataStageLink%           |              | ROC,DataStage | AnalysisQuery                 | TagAssigned |
      |             |                        |              |            | rochade/DataStageReconcile/RochadeDataStageReconcile% |              | ROC,DataStage | AnalysisQuery                 | TagAssigned |
      |             |                        |              |            | bulk/EDIBus/EDIBus_DataStage%                         |              | ROC,DataStage | AnalysisQuery                 | TagAssigned |

  ##################################################### Post Conditions #####################################################
  @ROC_DataStage
  Scenario Outline: Configure EDIBus plugin to perform clean up the data loaded after running DataStage plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | bodyFile                                                        | path                           | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_DataStage                            | payloads/ida/ROCDataStagePayloads/RocDataStagePluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_DataStage                            |                                                                 |                                | 200           | EDIBus_DataStage |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_DataStage |                                                                 |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_DataStage')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_DataStage  |                                                                 |                                | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_DataStage |                                                                 |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_DataStage')].status |

  @webtest @ROC_DataStage @TEST_MLPQA-19167 @MLPQA-18084
  Scenario: Verify all item types collected from DataStage Rochade are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DataStage" and clicks on search
    And user performs "facet selection" in "DataStage" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Service     |
      | Operation   |
      | DataPackage |
      | DataType    |
      | DataField   |
      | File        |
    And user should be able logoff the IDC

  @post-condition @ROC_DataStage
  Scenario: PS_Clearing the EDI subject area after running the Rochade DataStage wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @post-condition @ROC_DataStage
  Scenario:  Delete the analysis items for plugins: DataStageScan, DataStageImport, DataStageLink, DataStageReconcile, EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | rochade/DataStageScan/RochadeDataStageScan%           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/DataStageImport/RochadeDataStageImport%       | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/DataStageLink/RochadeDataStageLink%           | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/DataStageReconcile/RochadeDataStageReconcile% | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_DataStage%                         | Analysis |       |       |

  @post-condition @ROC_DataStage
  Scenario Outline:  Delete Credentials, Datasource and plugin config for DataStageScan, DataStageImport, DataStageLink, DataStageReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                             | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DataStageScan/RochadeDataStageScan           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DataStageImport/RochadeDataStageImport       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DataStageLink/RochadeDataStageLink           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DataStageReconcile/RochadeDataStageReconcile |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_DataStage                      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCDataStageSADataSource                     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ROCDataStageSACredentials                  |          |      | 200           |                  |          |
