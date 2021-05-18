@MLP-13894 @MLP-16114
Feature:MLP-13894 : configuration form elements to be grouped logically and option to show/hide advance settings
  MLP-16114:As a IDA Admin, I need to see multi select form field as per latest mock up so that it improves the usability

   ##6852562##
  @MLP-13894 @webtest @regression @positive
  Scenario:SC#1:MLP-13894: Verify user able to select the existing data source and Credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body                                                                                      | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS      |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential                   |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorTest         |                                                                                           |               |                  |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential?allowUpdate=false | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS      | idc/IDX_PluginPayloads/MLP-18457_GitCollector_DataSource_Config.json                      | 204           |                  |          |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute         |
      | Type        | Collector         |
      | Plugin      | GitCollector      |
      | Data Source | TestGitDS         |
      | Credential  | TestGitCredential |

    ##6801889##6801890##6801891##
  @MLP-13894 @webtest @regression @positive
  Scenario: SC#2: MLP-13894: Verify user is able to Add and View the plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute         |
      | Type        | Collector         |
      | Plugin      | GitCollector      |
      | Data Source | TestGitDS         |
      | Credential  | TestGitCredential |
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute          |
      | Name      | GitCollectorConfig |
      | Label     | GitCollectorConfig |
    And user "click" on "Show Advanced Settings" in Manage Configurations panel
    And user verifies the "Dynamic form" for "PluginConfiguration" in Add Manage Configuration Page
      | Event Condition |
      | Event Class     |
      | Node Condition  |
    And user "click" on "Hide Advanced Settings" in Manage Configurations panel

    ##6852635##6801892##6933944##
  @MLP-13894 @webtest @regression @positive
  Scenario: SC#3: MLP-13894: Verify user is able to Add Edit and Update the JDBC Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute         |
      | Type        | Collector         |
      | Plugin      | GitCollector      |
      | Data Source | TestGitDS         |
      | Credential  | TestGitCredential |
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute        |
      | Name      | GitCollectorTest |
      | Label     | GitCollectorTest |
    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "click" on "Show Advanced Settings" button in Add Configuration Page
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Tags      | Gender    |
    And user "click" on "Configuration Add" button under "Gender" in Manage Configurations
    And user waits for the final status to be reflected after "1500" milliseconds
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user "click" on "ConfigSave" button in "Add Configuration page"
    And user verifies the status of the deployment in Manage Configurations panel
      | pluginName | status  |
      | LocalNode  | running |

  ##6933946##
  @MLP-16114 @webtest @regression @positive
  Scenario: SC#4: MLP-16114: Verify that the user can type and add new item for configuration.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Cataloger       |
      | Plugin    | AvroS3Cataloger |
    And user "click" on "Expand Label" button under "Sub Directory Filter" in Manage Configurations
    And user "click" on "Expand Label" button under "File Filter" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName    | attribute   |
      | Bucket Names | Test Filter |
    And user "click" on "Configuration Add" button under "Bucket Names" in Manage Configurations
    And user verifies the "Newly added item" for "Bucket Names" in Add Manage Configuration Page
      | Test Filter |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName                  | attribute |
      | Directory Prefixes To Scan | Testing   |
    And user "click" on "Configuration Add" button under "Directory Prefixes To Scan" in Manage Configurations
    And user verifies the "Newly added item" for "Directory Prefixes To Scan" in Add Manage Configuration Page
      | Testing |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName               | attribute |
      | Directory Name Patterns | %Test     |
    And user "click" on "Configuration Add" button under "Directory Name Patterns" in Manage Configurations
    And user verifies the "Newly added item" for "Directory Name Patterns" in Add Manage Configuration Page
      | %Test |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName          | attribute |
      | File Name Patterns | %Test     |
    And user "click" on "Configuration Add" button under "File Name Patterns" in Manage Configurations
    And user verifies the "Newly added item" for "File Name Patterns" in Add Manage Configuration Page
      | %Test |

  ##6933948##Descoped
#  @MLP-16114 @webtest @regression @positive
#  Scenario: SC#6: MLP-16114: Verify that the user can type and add new Tag.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem            |
#      | click      | Settings Icon         |
#      | click      | Manage Configurations |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem |
#      | Open Deployment | LocalNode  |
#    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Collector    |
#      | Plugin    | GitCollector |
#    And user "click" on "Show Advanced Settings" button in Add Configuration Page
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute |
#      | Tags      | TestTag   |
#    And user "click" on "Configuration Add" button under "Tags" in Manage Configurations
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute |
#      | Tags      | TestTag   |
#    And user "click" on "Configuration Add" button under "Tags" in Manage Configurations
#    And user verifies the "verify duplicate item is added" for "Tags" in Add Manage Configuration Page
#      | TestTag |