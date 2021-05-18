@MLP-13697
Feature:MLP-13697: This feature is to verify whether as an IDA ADMIN I want to be able to designate a default view so that I can see it at login

  ##6832642##6832643####6832645####6832646####6832647####6832648####6832649####6832650## #7245910
  @MLP-13697 @webtest @regression @positive @e2e
  Scenario:SC#1:MLP-13697: Verify when user login for the first time the welcome page should be the default view
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-13697_Default_empty_view.json"
    When user makes a REST Call for POST request with url "settings/preferences/form"
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "AGREE" button in "License page"
    And user verifies "Welcome message under settings icon" is "displayed" in "Welcome page"
    And user clicks on logout button
    And logout must be success and display login page
    When user enter credentials for "System Administrator1" role
    And user verifies "Welcome message under settings icon" is "displayed" in "Welcome page"
    And user performs following actions in the header
      | actionType | actionItem    |
      | click      | Profile Image |
      | click      | Profile       |
    And user verifies "Save button" is "enabled" in "Profile setting page"
    And user "select dropdown" in "Profile Setting" Page
      | fieldName    | option                |
      | Default View | Manage Configurations |
      | Default View | Manage Credentials    |
      | Default View | Manage Data Sources   |
      | Default View | Manage Configurations |
    And user "click" on "Save button" button in "Profile setting page"
    And user clicks on logout button
    And logout must be success and display login page
    When user enter credentials for "System Administrator1" role
    And user "verifies presence" of following "Capture and Import Data page Title" in "" page
      | Manage Configurations |
    And user performs following actions in the header
      | actionType | actionItem    |
      | click      | Profile Image |
      | click      | Profile       |
    And user "select dropdown" in "Profile Setting" Page
      | fieldName    | option |
      | Default View | Home   |
    And user "click" on "Save button" button in "Profile setting page"