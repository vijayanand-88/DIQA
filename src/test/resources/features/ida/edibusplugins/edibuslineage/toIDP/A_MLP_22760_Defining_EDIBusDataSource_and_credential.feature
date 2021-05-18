Feature: MLP-22760 Define EDI data source/destination separately and use in definition of configurations

   #################################PreConditions################################

  @edibus @mlp-3101 @positive @release10.0 @sanity
  Scenario: To update license key with lineage
    Given user connects Rochade Server and "licenseUpdate" the items in EDI subject areas
      | databaseName | licenseInfo    |
      | AP-DATA      | windowsLineage |

  @precondition @sanity
  Scenario:SC1#Update credential payload json for EDIBus
    Given User update the below "ediBus credentials" in following files using json path
      | filePath                                              | username                           | password                           |
      | idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusValidCredentials..userName | $.edibusValidCredentials..password |
    And User update the below "ediBus host" in following files using json path
      | filePath                                                  | username                             | password                             |
      | idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAutoDataSource..['EDI host'] | $.EDIBusAutoDataSource..['EDI port'] |


  @MLP-22760 @edibus @sanity
  Scenario Outline: SC1#-Set the Credentials for EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                               | bodyFile                                                       | path                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials       | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusValidCredentials       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials       |                                                                |                                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusUserInValidCredentials | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusUserInvalidCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusUserInValidCredentials |                                                                |                                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusEmptyCredentials       | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusEmptyCredentials       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusEmptyCredentials       |                                                                |                                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusReportCredentials      | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusReportCredentials      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusReportCredentials      |                                                                |                                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusInValidCredentials     | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusInValidCredentials     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusInValidCredentials     |                                                                |                                | 200           |                  |          |


  @edibus @sanity
  Scenario Outline: Set the Default DataSource license
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url              | body                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license | ida\hbasePayloads\DataSource\license_DS.json | 204           |                  |          |

  @edibus @sanity
  Scenario: Set the Default DataSource for EDIBus toIDPCases
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                 | body                                                             | response code | response message | jsonPath |
      | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource | idc/EdiBusPayloads/DataSource/EDIBusDataSourceDefaultConfig.json | 204           |                  |          |

      #############################################UI Validations##########################################################
  ##7095877##7199394#
  @webtest @toIDP @mlp-26841
  Scenario: SC1#Verify captions and tool tip text in EDIBusDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | EDIBusDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source Type*              |
      | Name*                          |
#      | Plugin version                 |
      | Label                          |
      | EDI host*                      |
      | EDI port*                      |
      | EDI database*                  |
      | EDI subject area name*         |
      | EDI subject area version*      |
#      | Glossary Name                  |
      | EDI subject area access roles* |
      | Credential*                    |
      | Node                           |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                          | Plugin configuration name                                                                                                                                             |
#      | Plugin version                 | Required plugin version                                                                               |
      | Label                         | Plugin configuration extended label and description                                                                                                                   |
      | EDI host*                     | The host name of the EDI Server.                                                                                                                                      |
      | EDI port*                     | The port number of the EDI Server.                                                                                                                                    |
      | EDI database*                 | The name of the EDI database.                                                                                                                                         |
      | EDI subject area name*        | The name of the EDI subject area.                                                                                                                                     |
      | EDI subject area version*     | The version of the EDI subject area.                                                                                                                                  |
#      | Glossary Name                  | The name of the Glossary where the PII Items are stored (Modes: toIDPGDPR and toEDIGDPRTag).          |
      | EDI subject area access roles | Please specify concrete roles granting access to the specified EDI subject area or '*' for any roles. In a standard EDI environment you may specify the role 'Batch'. |
      | Credential*                   | Credential to be used                                                                                                                                                 |


  ##7095904##
  @webtest @precondition @testconnection @toIDP @sanity
  Scenario: SC2#: Verify whether the background of the panel is displayed in green when test connection for EDIBusDataSource with valid credentials
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem          |
      | mouse hover | Settings Icon       |
      | click       | Settings Icon       |
      | mouse hover | Manage Data Sources |
      | click       | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute        |
      | Data Source Type | EDIBusDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName                | attribute               |
      | Name                     | EDIBusDS                |
      | Label                    | EDIBusDS                |
      | EDI host                 | usyp5thirmoga1v.asg.com |
      | EDI port                 | 9292                    |
      | EDI subject area name    | AUTOMATION              |
      | EDI subject area version | 1.0                     |
    And user "click" on "Add EDIRoles Button" button in "Add Data Sources Page"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | role      | RBR_ADM   |
    And user "click" on "Add Role Button" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute              |
      | Credential | EDIBusValidCredentials |
      | Node       | LocalNode              |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"

  ##7095895##
  @webtest @toIDP
  Scenario: SC3#Verify captions and tool tip text in EDIBus plugin Configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button    | actionItem   |
      | Open Node | InternalNode |
    And user "click" on "Add Configuration" button under "InternalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Type      | Bulk      |
      | Plugin    | EDIBus    |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*            |
      | Function*        |
      | Incremental      |
      | Batch size       |
      | Thread count     |
      | Data Source*     |
      | Credential*      |
      | EDI types        |
      | EDI technologies |
#      | Business Application |
#      | IDA types            |
#      | IDA technologies     |
    Then user "Verify list of items in EDIBus function dropdown" in Plugin Configuration page
      | replicate |
      | cleanup   |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name         | Plugin configuration name                                                                                                       |
      | Label        | Plugin configuration extended label and description                                                                             |
      | Credential*  | Credential to be used                                                                                                           |
      | Data Source* | Data source connection to be used                                                                                               |
      | Function*    | The function to be executed: replicate: Replication from EDI to DD, cleanup: Deletion of all items replicated from EDI in DD. . |
      | Incremental  | How a replication is to be executed: Replicate only changed data, or replicate all data.                                        |
      | Batch size   | Optional: The number of items to be replication in one step. The default value is 3000, the maximum value is 8000.              |
      | Thread count | Optional: The number of threads used for the replication. The default value is 5, the maximum value is 8.                       |
    And user "enter text" in Add Data Source Page
      | fieldName  | attribute   |
      | Name       | EDIBusCheck |
      | Batch size | 1000        |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute              |
      | Data Source | EDIBusDS               |
      | Credential  | EDIBusValidCredentials |
      | Function    | replicate              |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Function  | cleanup   |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


##7095908#7095915##
  @webtest @precondition @testconnection @toIDP
  Scenario: SC4#:Verify whether the background of the panel is displayed in red when test connection for EDIBus with empty/invalid credentials
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem          |
      | mouse hover | Settings Icon       |
      | click       | Settings Icon       |
      | mouse hover | Manage Data Sources |
      | click       | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute        |
      | Data Source Type | EDIBusDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName                | attribute               |
      | Name                     | EDIBusDSCheck           |
      | Label                    | EDIBusDSCheck           |
      | EDI host                 | usyp5thirmoga1v.asg.com |
      | EDI port                 | 9292                    |
      | EDI subject area name    | AUTOMATION              |
      | EDI subject area version | 1.0                     |
    And user "click" on "Add EDIRoles Button" button in "Add Data Sources Page"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | role      | RBR_ADM   |
    And user "click" on "Add Role Button" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                |
      | Credential | EDIBusInValidCredentials |
      | Node       | LocalNode                |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute              |
      | Credential | EDIBusEmptyCredentials |
      | Node       | LocalNode              |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"

  ##7095923##
  @positive @sanity @webtest @toIDP
  Scenario:SC5#Verify proper error message is shown if mandatory fields are not filled in EDIBus DataSource Configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | EDIBusDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | EDI host  | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | EDI port  | 1         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName    | attribute |
      | EDI database | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName             | attribute |
      | EDI subject area name | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName                | attribute |
      | EDI subject area version | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName                | validationMessage                                  |
      | Name                     | Name field should not be empty                     |
      | EDI host                 | EDI host field should not be empty                 |
      | EDI port                 | EDI port field should not be empty                 |
      | EDI database             | EDI database field should not be empty             |
      | EDI subject area name    | EDI subject area name field should not be empty    |
      | EDI subject area version | EDI subject area version field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

 ##7115877##
  @webtest @git @precondition @testconnection @toIDP
  Scenario: SC6#: Verify that the specification of invalid connection parameters causes a failure of the connection test.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem          |
      | mouse hover | Settings Icon       |
      | click       | Settings Icon       |
      | mouse hover | Manage Data Sources |
      | click       | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute        |
      | Data Source Type | EDIBusDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName                | attribute               |
      | Name                     | EDIBusDS                |
      | Label                    | EDIBusDS                |
      | EDI host                 | usyp5thirmoga1v.asg.com |
      | EDI port                 | 9290                    |
      | EDI subject area name    | AUTOMATION              |
      | EDI subject area version | 1.0                     |
    And user "click" on "Add EDIRoles Button" button in "Add Data Sources Page"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | role      | RBR_ADM   |
    And user "click" on "Add Role Button" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute              |
      | Credential | EDIBusValidCredentials |
      | Node       | LocalNode              |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute               |
      | EDI host  | usyp5thirmoga2v.asg.com |
      | EDI port  | 9292                    |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName    | attribute               |
      | EDI host     | usyp5thirmoga1v.asg.com |
      | EDI database | AP-DATA2                |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName             | attribute   |
      | EDI database          | AP-DATA     |
      | EDI subject area name | AUTOMATIONS |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName                | attribute  |
      | EDI subject area version | Test       |
      | EDI subject area name    | AUTOMATION |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"


  @MLP-4256 @edibus
  Scenario Outline:SC7#Set the DataSource for EDIBus
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                           | path                                  | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusNodeDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusNodeDataSource.configurations | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                      |                                                                    |                                       | 200           | EDIBusNodeDataSource |          |

    #7123227#
  @edibus @webtest @toIDP
  Scenario:SC7#MLP-22760 Verify error is thrown when EDIBus data source is configured in local node and Plugin is run in Internal Node
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                       | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/IDXTOEDINodeConfig.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDINode |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDINode')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDINode  |                                            | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDINode |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDINode')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDINode%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    And Analysis log "bulk/EDIBus/IDXtoEDINode%" should display below info/error/warning
      | type  | logValue                                                                 | logCode      |
      | ERROR | No configuration EDIBusNodeDataSource found for plugin EDIBusDataSource. | EDIBUS-E0208 |

  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/IDXtoEDINode% | Analysis |       |       |


  @MLP-22760 @edibus
  Scenario: Delete Credentials for EDIBus
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                          | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusDS |      | 204           |                  |          |
      | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBusCheck        |      | 204           |                  |          |

  @MLP-4256 @edibus @sanity
  Scenario Outline: Set the DataSource for EDIBus toIDPCases
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                         | bodyFile                                                           | path                                     | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusIDPDataSource     | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusIDPDataSource.configurations     | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusIDPDataSource     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusOrcDataSource     | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusOrcDataSource.configurations     | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusOrcDataSource     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusMetaDataSource    | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusMetaDataSource.configurations    | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusMetaDataSource    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusCognosDataSource  | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusCognosDataSource.configurations  | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusCognosDataSource  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDBDataSource      | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDBDataSource.configurations      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusDBDataSource      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusIDCOrcDataSource  | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusIDCOrcDataSource.configurations  | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusIDCOrcDataSource  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusERDataSource      | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusERDataSource.configurations      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusERDataSource      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusStitchDataSource  | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusStitchDataSource.configurations  | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusStitchDataSource  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusLineageDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusLineageDataSource.configurations | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusLineageDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusReportDataSource  | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusReportDataSource.configurations  | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusReportDataSource  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusAutoDataSource    | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAutoDataSource.configurations    | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusAutoDataSource    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDBDataSource      | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDBDataSource.configurations      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusDBDataSource      |          |


  @edibus @webtest @toIDP
  Scenario:SC8#MLP-28288 Verify EDIBus plugin throws error with invalid credentials in plugin config and valid credentials in DataSource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                          | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/CredentialCheckConfig.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/InvalidCredInPlugin |                                               | 200           | IDLE             | $.[?(@.configurationName=='InvalidCredInPlugin')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/InvalidCredInPlugin  |                                               | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/InvalidCredInPlugin |                                               | 200           | IDLE             | $.[?(@.configurationName=='InvalidCredInPlugin')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/InvalidCredInPlugin%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then Analysis log "bulk/EDIBus/InvalidCredInPlugin%" should display below info/error/warning
      | type  | logValue                                                                            | logCode      |
      | ERROR | Access to EDI server usyp5thirmoga1v.asg.com at port 9292 denied for user ADMINTEST | EDIBUS-E0103 |


  @edibus @webtest @toIDP
  Scenario:SC9#MLP-28288 Verify EDIBus plugin runs successful with invalid credentials in Data source and valid credentials in Plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                     | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/CredentialConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/InvalidCredInDS |                                          | 200           | IDLE             | $.[?(@.configurationName=='InvalidCredInDS')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/InvalidCredInDS  |                                          | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/InvalidCredInDS |                                          | 200           | IDLE             | $.[?(@.configurationName=='InvalidCredInDS')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/InvalidCredInDS%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |

  @MLP-22760 @edibus
  Scenario: Delete Analysis for EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name          | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/% | Analysis |       |       |