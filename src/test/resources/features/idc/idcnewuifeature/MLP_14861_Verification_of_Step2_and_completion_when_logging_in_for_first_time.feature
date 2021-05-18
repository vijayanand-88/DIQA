#@MLP-14861 @MLP-14866
#Feature:MLP-14861 MLP-14866 : This feature is to verify As an IDA admin want to go to step 2 directly when i first install and login into my IDC appication from Step 1 page
#  As an IDA admin i want to get a popup of initial information after i complete Step 2 in first login after install
#
  #descoped
#  ##6857598##6857602##6857656##6857657##6857658##6857660##6857661##
#  @MLP-14861 @webtest @regression @positive
#  Scenario:SC#1:MLP-14861: Verify that the user is able to go to step 2 of add configuration from step 1 when the user logins for the first time
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/credentials/AutoTestCredential1"
#    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector"
#    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/AutoQADataSource1"
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
#    And user verifies "Step 1: Add Data Source with Credential" is "displayed"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | GitCollectorDataSource |
#    And user "enter text" in Add Data Source Page
#      | fieldName       | attribute                                                 |
#      | Name            | AutoQADataSource1                                         |
#      | Label           | AutoQADataSource1                                         |
#      | URL             | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
#      | Credential Name | AutoTestCredential1                                       |
#      | User Name       | becubic_build                                             |
#      | Password        | laguna-2012                                               |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute |
#      | Deployment | LocalNode |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user "click" on "Next Button" button in "Step1 Add Data Source pop up"
#    And user verifies "Step 2: Add Configuration to LocalNode" is "displayed"
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Collector    |
#      | Plugin    | GitCollector |
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Name      | GitCollector |
#    And user verifies "AutoQADataSource1" is "displayed" in "under Data Source as default option in Step 2: Add Configuration to LocalNode popup"
#    And user verifies "AutoTestCredential1" is "displayed" in "under Credential as default option in Step 2: Add Configuration to LocalNode popup"
#    And user "click" on "Cancel button" button in "Step1 Add Data Source pop up"
#    And user verifies the "Unsaved changes" pop up is "displayed"
#    And user "click" on "No" button in "popup"
#    And user "click" on "Close button" button in "Step 2: Add Configuration to LocalNode popup"
#    And user verifies the "Unsaved changes" pop up is "displayed"
#
#  ##6857601##
#  @MLP-14861 @webtest @regression @positive
#  Scenario:SC#2:MLP-14861: Verify that the user is not taking to step 1 and then step two from the second login
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user verifies "START" is "not displayed" in "Welcome page"
#
#  ##6857579##6857580##6857581##6857582##6857583##6857584##
#  @MLP-14866 @webtest @regression @positive
#  Scenario:SC#3:MLP-14866: Verify popup of initial information after completing Step 2
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/credentials/AutoTestCredential1"
#    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/AutoQADataSource2"
#    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/GitCollector"
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
#    And user verifies "Step 1: Add Data Source with Credential" is "displayed"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | GitCollectorDataSource |
#    And user "enter text" in Add Data Source Page
#      | fieldName       | attribute                                                 |
#      | Name            | AutoQADataSource2                                         |
#      | Label           | AutoQADataSource2                                         |
#      | URL             | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
#      | Credential Name | AutoTestCredential1                                       |
#      | User Name       | becubic_build                                             |
#      | Password        | laguna-2012                                               |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute |
#      | Deployment | LocalNode |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user "click" on "Next Button" button in "Step1 Add Data Source pop up"
#    And user verifies "Step 2: Add Configuration to LocalNode" is "displayed"
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Collector    |
#      | Plugin    | GitCollector |
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Name      | GitCollector |
#    And user verifies "AutoQADataSource2" is "displayed" in "under Data Source as default option in Step 2: Add Configuration to LocalNode popup"
#    And user verifies "AutoTestCredential1" is "displayed" in "under Credential as default option in Step 2: Add Configuration to LocalNode popup"
#    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute |
#      | Branch    | master    |
#    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
#    And user verifies "Finish button" is "enabled" in Add Configuration Page
#    And user "click" on "Finish button" button in "Step 2: Add Configuration to LocalNode popup"
#    And user verifies the "Congratulations" pop up is "displayed"
#    And user "click" on "PopUp X" button in Add Configuration Page
#    And user verifies the "Congratulations" pop up is "not displayed"
#    And user verifies the "Manage Configurations" page is "displayed"
#    And user navigates to previous page
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Collector    |
#      | Plugin    | GitCollector |
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute     |
#      | Name      | GitCollector1 |
#    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute |
#      | Branch    | master    |
#    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
#    And user verifies "Finish button" is "enabled" in Add Configuration Page
#    And user "click" on "Finish button" button in "Step 2: Add Configuration to LocalNode popup"
#    And user "click" on "PopUp Close" button in Add Configuration Page
#    And user verifies the "Congratulations" pop up is "not displayed"
#    And user verifies the "Manage Configurations" page is "displayed"
#    And user navigates to previous page
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Collector    |
#      | Plugin    | GitCollector |
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute     |
#      | Name      | GitCollector2 |
#    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute |
#      | Branch    | master    |
#    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
#    And user verifies "Finish button" is "enabled" in Add Configuration Page
#    And user "click" on "Finish button" button in "Step 2: Add Configuration to LocalNode popup"
#    And user verifies the "Start and manage the configuration" link is "displayed"
#    And user verifies the "Add a configuration" link is "displayed"
#    And user verifies the "Add a data source" link is "displayed"
#    And user verifies the "Add a credential" link is "displayed"
#    And user clicks on "Add a configuration" link in the "Congratulations popup"
#    And user verifies the "Add Configuration to LocalNode" pop up is "displayed"
#    And user navigates to previous page
#    And user clicks on "Add a data source" link in the "Congratulations popup"
#    And user verifies the "Add Data Source" pop up is "displayed"
#
#  ##6857585##6857586##
#  @MLP-14866 @webtest @regression @positive
#  Scenario:SC#4:MLP-14866: Verify popup completion after Step 2
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/credentials/AutoTestCredential2"
#    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/GitCollector3"
#    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/AutoQADataSource3"
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
#    And user verifies "Step 1: Add Data Source with Credential" is "displayed"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | GitCollectorDataSource |
#    And user "enter text" in Add Data Source Page
#      | fieldName       | attribute                                                 |
#      | Name            | AutoQADataSource3                                         |
#      | Label           | AutoQADataSource3                                         |
#      | URL             | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
#      | Credential Name | AutoTestCredential2                                       |
#      | User Name       | becubic_build                                             |
#      | Password        | laguna-2012                                               |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute |
#      | Deployment | LocalNode |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user "click" on "Next Button" button in "Step1 Add Data Source pop up"
#    And user verifies "Step 2: Add Configuration to LocalNode" is "displayed"
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Collector    |
#      | Plugin    | GitCollector |
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute     |
#      | Name      | GitCollector3 |
#    And user "click" on "Add attribute" button under "Filter" in Manage Configurations
#    And user "enter text" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute |
#      | Branch    | master    |
#    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
#    And user verifies "Finish button" is "enabled" in Add Configuration Page
#    And user "click" on "Finish button" button in "Step 2: Add Configuration to LocalNode popup"
#    And user clicks on "Add a credential" link in the "Congratulations popup"
#    And user verifies the "Add Credential" pop up is "displayed"
#    And user navigates to previous page
#    And user "click" on "PopUp Close" button in Add Configuration Page
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#    And user "verify submenus" for the following submenus under "Admin" menu
#      | Manage Bundles        |
#      | Manage Configurations |
#      | Manage Credentials    |
#      | Manage Data Sources   |
#      | Manage Access         |
#
#
