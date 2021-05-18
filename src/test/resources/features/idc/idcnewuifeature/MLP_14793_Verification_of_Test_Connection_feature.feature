@MLP-14793 @MLP-14348
Feature:A_MLP-14793 MLP-14348: As an IDA Admin, I want to be able to test a connection when I configure it so that I can ensure that it works prior to hooking up a plugin to it in plugin configuration page, and so that I am not wasting time and risking error

  #7248359
  @MLP-14793 @webtest @regression @positive @e2e
  Scenario:MLP-14793: Create a data source and a credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                       | body                                                                                  | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/AutomationQA_DS |                                                                                       |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/AutomationQADS  |                                                                                       |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/TestCredential11                     |                                                                                       |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/TestCredential11?allowUpdate=false   | idc/IDx_DataSource_Credentials_Payloads/MLP-18548_GitCollector_Credential_Config.json | 200           |                  |          |              |          |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | GitCollectorDataSource |
      | Credential       | TestCredential11       |
      | Deployment       | LocalNode              |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                 |
      | Name      | AutomationQA_DS                                           |
      | Label     | AutomationQA_DS                                           |
      | URL       | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user "click" on "Save" button in "Add Data Source pop up"

  ##6852599##6852606##6853432##
  @MLP-14793 @webtest @regression @positive
  Scenario:SC#1:MLP-14793: Verify that the Test Connection button is not enabled when manadatory fields are not entered in Add configuration page.
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
      | Data Source | AutomationQA_DS |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Name      | GitCollector11 |
    And user verifies "Test Connection" is "disabled" in Add Configuration Page
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute       |
      | Type        | Collector       |
      | Plugin      | GitCollector    |
      | Data Source | Add data source |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                                                                             |
      | Name             | GitCollector_Config                                                                   |
      | Data Source Name | AutomationTest_DS                                                                     |
      | URL              | jdbc:redshift://aws-redshift.c3iskdv9vipb.us-east-1.redshift.amazonaws.com:5439/world |
    And user "Validate the field Error Message" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           | pageName          |
      | URL       | UnSupported Git URL | Add Configuration |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Name      | GitCollector_Config |
    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute        |
      | Data Source | Add data source  |
      | Credential  | TestCredential11 |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                                                 |
      | Data Source Name | AutomationTest_DS                                         |
      | Label            | AutomationQA_DS                                           |
      | URL              | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And user verifies "Test Connection" is "enabled" in Add Configuration Page

  ##6852642##6852562##
  @MLP-14793 @webtest @regression @positive
  Scenario:SC#2:MLP-14793 MLP-14348: Verification of Test Connection with new credentials and new Data Source successfully in the Add configuration page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Name      | GitCollector_Config |
    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute       |
      | Data Source | Add data source |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                                                 |
      | Data Source Name | AutomationTest_DS                                         |
      | Label            | AutomationQA_DS                                           |
      | URL              | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute      |
      | Credential | Add credential |
    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName       | attribute         |
      | Credential Name | SampleCredential1 |
      | User Name       | becubic_build     |
      | Password        | laguna-2012       |
    And user verifies "Test Connection" is "enabled" in Add Configuration Page
    And user "click" on "Test Connection" button in Add Configuration Page
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page

  ##6852635##6853441##6852567##
  @MLP-14793 @webtest @regression @positive
  Scenario:SC#3:MLP-14793:Verification of Test Connection with existing credentials and existing data source in the Add configuration page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute        |
      | Type        | Collector        |
      | Plugin      | GitCollector     |
      | Data Source | AutomationQA_DS  |
      | Credential  | TestCredential11 |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Name      | GitCollector12 |
    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user verifies "Test Connection" is "enabled" in Add Configuration Page
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute       |
      | Type        | Collector       |
      | Plugin      | GitCollector    |
      | Data Source | AutomationQA_DS |
      | Credential  | Add credential  |
    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName       | attribute         |
      | Name            | GitCollector12    |
      | Credential Name | SampleCredential2 |
      | User Name       | becubic_build     |
      | Password        | laguna-2012       |
    And user verifies "Test Connection" is "enabled" in Add Configuration Page
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute       |
      | Type        | Collector       |
      | Plugin      | GitCollector    |
      | Data Source | AutomationQA_DS |
      | Credential  | Add credential  |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName       | attribute         |
      | Name            | GitCollector12    |
      | Credential Name | SampleCredential3 |
      | User Name       | becubic_build12   |
      | Password        | laguna-2012       |
    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "click" on "Test Connection" button in Add Configuration Page
    And user verifies "Failed datasource connection" is "displayed" in Add Configuration Page

  ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:SC#1: MLP-23675: Verify the discard popup works as expected in manage Datasources
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName            | option          |
      | Edit the data source | AutomationQA_DS |
    And user "Verifies popup" is "displayed" for "Edit Data Source"
    And user clicks on "Escape" key
    And user clicks on "Yes" link in the "Unsaved changes"
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName            | option          |
      | Edit the data source | AutomationQA_DS |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                  |
      | URL       | https://source-team.asg.com/scm/di/pythonanalyzerdemo1.git |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Cancel" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Close" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"

    ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:SC#2: MLP-23675: Verify the discard popup works as expected in manage credentials
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName           | option           |
      | Edit the credential | TestCredential11 |
    And user "Verifies popup" is "displayed" for "Edit Credential"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click configuration menu buttons" in "Manage Credentials" Page
      | fieldName           | option           |
      | Edit the credential | TestCredential11 |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute     |
      | User Name | becubic_build |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Cancel" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Close" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"

    ##7183173##7183174##7183175##
  @MLP-25532 @webtest @regression @positive
  Scenario:SC#1:MLP-25532: Verify that the Test Connection button is not enabled when manadatory fields are not entered in Add configuration page.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | GitCollectorDataSource |
      | Credential       | TestCredential11       |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                 |
      | Name      | AutomationQADS                                            |
      | Label     | AutomationQADS                                            |
      | URL       | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And user verifies "Save button" is "enabled" in "Add dataSourece popup"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Save button" is "enabled" in "Add dataSourece popup"
    And user "click" on "Save" button in "Add Data Source pop up"
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute        |
      | Type        | Collector        |
      | Plugin      | GitCollector     |
      | Data Source | AutomationQADS   |
      | Credential  | TestCredential11 |
    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute           |
      | Name      | GitCollectorConfig1 |
      | Label     | GitCollectorConfig  |
    And user verifies "Save button" is "enabled" in "Add Configuration popup"
    And user "click" on "Test Connection" button in "Add Configuration pop up"
    And user verifies "Save button" is "enabled" in "Add Configuration popup"

    ##7183176##7183177##
  @MLP-25532 @webtest @regression @positive
  Scenario:SC#2:MLP-25532: Verify whether Deployment field is renamed as Node in the Add DataSource popup
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | GitCollectorDataSource |
    Then user verifies the "Dynamic form" for "Add DataSource popup Labels" in Add Data Sources Page
      | Data Source Type | Name | Label | URL | Credential | Node |
    And user "verifies non mandatory field" in "Landing Page"
      | fieldName |
      | Node      |

  @MLP-14793 @regression @positive
  Scenario:MLP-14793: Delete data source and a credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                       | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/AutomationQA_DS |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/AutomationQADS  |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/TestCredential11                     |      |               |                  |          |              |          |