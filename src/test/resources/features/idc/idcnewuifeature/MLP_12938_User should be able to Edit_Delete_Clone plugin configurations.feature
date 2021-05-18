@MLP-129338
Feature:MLP-12938: As an IDA Admin in the Analyzer Configuration I want to be able to Edit / Delete/ Clone plugin configurations so that I can rapidly spin up specialized processing plugin versions

  @MLP-12938 @webtest @regression @positive
  Scenario:MLP-12938: Create a data source and a credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                    | body                                                                                      | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS    |                                                                                           |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig     |                                                                                           |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/DataCredential1                   |                                                                                           |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/DataCredential1?allowUpdate=false | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS    | idc/IDx_DataSource_Credentials_Payloads/MLP-18548_GitCollector_DS_Config.json             | 204           |                  |          |              |          |

    ##6820289####6820541##6820542##6820549####6820550##6820551##7248373#7248374
  @MLP-12938 @webtest @regression @positive
  Scenario: SC#1: MLP-12938: Verify user is able to clone the plugin configuration by clicking clone icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute       |
      | Type        | Collector       |
      | Plugin      | GitCollector    |
      | Data Source | TestGitDS       |
      | Credential  | DataCredential1 |
    And user "click" on "Add attribute" button under "Filters" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute          |
      | Name      | GitCollectorConfig |
      | Label     | GitCollectorConfig |
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"
    And user verifies the status of the deployment in Manage Configurations panel
      | pluginName | status  |
      | LocalNode  | running |
    And user performs "click" operation in Manage Configurations panel
      | button      | actionItem         |
      | Open Plugin | GitCollectorConfig |
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName               | option             |
      | Clone the configuration | GitCollectorConfig |
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute                 |
      | Name      | GitCollectorConfig cloned |
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user "click" on "ConfigSave" button in "Add Configuration page"
    And user verifies the status of the deployment in Manage Configurations panel
      | pluginName | status  |
      | LocalNode  | running |

    ##6820551##6820552##
  @MLP-12938 @webtest @regression @positive
  Scenario: SC#2: MLP-12938: Verify user is able to Start and Stop the plugin configuration by clicking Start_Stop icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute                 | itemName              |
      | LocalNode | Collector  | GitCollectorConfig cloned | Run the configuration |
    And user verifies the status of the deployment in Manage Configurations panel
      | pluginName | status  |
      | LocalNode  | running |
    And user "click" in "Manage Configurations Page"
      | fieldName                        | actionItem               | itemName                  |
      | click configuration menu buttons | Delete the configuration | GitCollectorConfig cloned |
    And user "click" on "Confirm" button in "Add Configuration page"

  @MLP-12938 @webtest @regression @positive
  Scenario:MLP-12938: Delete a data source and a credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig  |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/DataCredential1                |      |               |                  |          |              |          |