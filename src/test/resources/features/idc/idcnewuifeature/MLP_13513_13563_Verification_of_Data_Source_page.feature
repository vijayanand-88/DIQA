@MLP-13513 @MLP-13563 @14171 @MLP-14860 @MLP-14658
Feature:MLP-13513 MLP-13563 14171 MLP-14860 MLP-14658: This feature is to verify whether As an IDA Admin, I want to see the configuration of plugin, data source and credential in the popup and to load the child configuration on same popup
  As an IDA Admin, I want see the data source and credentials sections while configuring plugins
  Add Filter in manage credentials and data source page

#  ##6789361##6789363###descoped
#  @MLP-13513 @webtest @regression @positive
#  Scenario:SC#1:MLP-13513: Verify the Add DataSource popup is displayed when clicking add Datasource button
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
#    When user makes a REST Call for POST request with url "settings/eula/accept"
#    And Status code 204 must be returned
#    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-13697_Default_empty_view.json"
#    When user makes a REST Call for POST request with url "settings/preferences/form"
#    And Status code 204 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "AGREE" button in "License page"
#    And user verifies "START" is "displayed" in "Welcome page"
#    And user "click" on "START" button in "Welcome page"
#    And user verifies "Step1 Add Data Source pop up" is "displayed"
#    And user verifies "Data Source Configuration properties" is "not displayed"

#  ##6789365###descoped
#  @MLP-13513 @webtest @regression @positive
#  Scenario:SC#2:MLP-13513: Verify the dynamic form of plugin configuration is displayed based on the plugin and its type selection
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
#    When user makes a REST Call for POST request with url "settings/eula/accept"
#    And Status code 204 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "AGREE" button in "License page"
#    And user "click" on "START" button in "Welcome page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute                |
#      | Data Source Type | AmazonRedshiftDataSource |
#    And user verifies "Data Source Configuration properties" is "displayed"
#    And user verifies the "Dynamic form" for "AmazonRedshiftDataSource" in Add Data Sources Page
#      | Name           |
#      | Plugin Version |
#      | Label          |
#      | Catalog Name   |
#      | URL            |
#      | User Name      |
#      | Password       |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName | attribute          |
#      | Type      | AmazonS3DataSource |
#    And user verifies "Data Source Configuration properties" is "displayed"
#    And user verifies the "Dynamic form" for "AmazonS3DataSource" in Add Data Sources Page
#      | Name           |
#      | Plugin Version |
#      | Label          |
#      | Catalog Name   |
#      | Region         |
#      | Access Key     |
#      | Secret Key     |

  ##6814920##6814922##6832637##6832638##
  @MLP-13563 @14171 @webtest @regression @positive
  Scenario:SC#3:MLP-13563 MLP-14171: Verify user able to select the existing data source and Credential and able to see the list of data sources and list of credentials
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/TestDataSource"
    And user makes a REST Call for DELETE request with url "settings/credentials/TestCredential"
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | GitCollectorDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                 |
      | Name      | TestDataSource                                            |
      | Label     | TestDataSource                                            |
      | URL       | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute      |
      | Credential | Add credential |
    And user "enter text" in Add Data Source Page
      | fieldName       | attribute      |
      | Credential Name | TestCredential |
    And user "enter credentials" for "GitCollectorDataSource" in "Add Data Sources" Page
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute |
      | Deployment | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user "click" on "Save" button in "Add Data Sources pop up"
    And user "Verify the presence of Data Source from the List" in "Manage DataSource popup"
      | TestDataSource |
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "verifies presence" of following "Credentials list" in "Manage Credentials" page
      | TestCredential |
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute      |
      | Type        | Collector      |
      | Plugin      | GitCollector   |
      | Data Source | TestDataSource |
      | Credential  | TestCredential |

#  ##6852316##6852317##6852318##6852321##6852322##6852334##6852336###descoped
#  @MLP-14860 @webtest @regression @positive
#  Scenario:SC#4:MLP-14860 : Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
#    When user makes a REST Call for POST request with url "settings/eula/accept"
#    And Status code 204 must be returned
#    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-13697_Default_empty_view.json"
#    When user makes a REST Call for POST request with url "settings/preferences/form"
#    And Status code 204 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "AGREE" button in "License page"
#    And user verifies "START" is "displayed" in "Welcome page"
#    And user "click" on "START" button in "Welcome page"
#    And user verifies "Step1 Add Data Source pop up" is "displayed"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | GitCollectorDataSource |
#    And user "enter text" in Add Data Source Page
#      | fieldName       | attribute                                                 |
#      | Name            | AutoQADataSource                                          |
#      | Label           | AutoQADataSource                                          |
#      | URL             | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
#      | Credential Name | AutoTestCredential                                        |
#      | User Name       | becubic_build                                             |
#      | Password        | laguna-2012                                               |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute |
#      | Deployment | LocalNode |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user verifies "Next Button" is "enabled" in "Step1 Add Data Source pop up"

#  ##6852335###descoped
#  @MLP-14860 @webtest @regression @positive
#  Scenario:SC#5:MLP-14860 : Verify whether the background of the panel is displayed in red when connection is failed  in Step1 pop up when user logs in for the first time
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
#    When user makes a REST Call for POST request with url "settings/eula/accept"
#    And Status code 204 must be returned
#    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-13697_Default_empty_view.json"
#    When user makes a REST Call for POST request with url "settings/preferences/form"
#    And Status code 204 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "AGREE" button in "License page"
#    And user verifies "START" is "displayed" in "Welcome page"
#    And user "click" on "START" button in "Welcome page"
#    And user verifies "Step1 Add Data Source pop up" is "displayed"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | GitCollectorDataSource |
#    And user "enter text" in Add Data Source Page
#      | fieldName       | attribute                                                  |
#      | Name            | AutoQADataSource                                           |
#      | Label           | AutoQADataSource                                           |
#      | URL             | https://source-team.asg.com/scm/di/pythonanalyzerdemo1.git |
#      | Credential Name | AutoTestCredential                                         |
#      | User Name       | becubic_build1                                             |
#      | Password        | laguna-2013                                                |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute |
#      | Deployment | LocalNode |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user verifies "Next Button" is "disabled" in "Step1 Add Data Source pop up"
    