@MLP-17330 @MLP-32753
Feature:MLP-17330: Manage Access - Add popover for Roles and MLP-31004 Less privileged account for plugins

  ##6943585##6943586##6943590## #7245920#72459257245929#7245931#
  @MLP-17330 @webtest @regression @positive @e2e
  Scenario: SC#1: MLP-17330: Verify that user can Add Role with No Special Characters and Permissions
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "click" on "Add Role" in Manage Access page
    And user "enter text" in "Add Roles" Manage Access Page
      | fieldName   | actionItem |
      | roleName    | Admin Role |
      | description | Test Role  |
    And user "click" on "Save Role" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype        | ActionItem | ItemName |
      | Verify Roles List | Admin Role |          |
    And user "click configuration menu buttons" in "Manage Roles" Page
      | fieldName     | option     |
      | Edit the role | Admin Role |
    And user "enter text" in "Edit Role" Manage Access Page
      | fieldName | actionItem        |
      | roleName  | Admin Role Edited |
    And user "click" on "Save Role" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype        | ActionItem        | ItemName |
      | Verify Roles List | Admin Role Edited |          |
    And user "click configuration menu buttons" in "Manage Roles" Page
      | fieldName      | option            |
      | Clone the role | Admin Role Edited |
    And user "enter text" in "Add Roles" Manage Access Page
      | fieldName | actionItem        |
      | roleName  | Admin Role Cloned |
    And user performs "click" operation in Manage Access Roles and Users list
      | button      | roleName        |
      | Permissions | ADMIN_EVENTS    |
      | Permissions | ADMIN_DASHBOARD |
    And user "click" on "Save Role" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype        | ActionItem        | ItemName |
      | Verify Roles List | Admin Role Cloned |          |
    And user verifies whether following parameters is "displayed" in Manage Access Roles page
      | button | roleName          |
      | Delete | Admin Role Cloned |
    And user performs "click" operation in Manage Access Roles and Users list
      | button | roleName          |
      | Delete | Admin Role Cloned |
    And user "click" on "Confirm" button in "Delete Role Popup"
    And user performs "click" operation in Manage Access Roles and Users list
      | button | roleName          |
      | Delete | Admin Role Edited |
    And user "click" on "Confirm" button in "Delete Role Popup"

  ##6943586##6943587##6943588##6943590##
  @MLP-17330 @webtest @regression @positive
  Scenario: SC#2: MLP-17330: Verify that user can Add Role with Special Characters and Permissions
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "click" on "Add Role" in Manage Access page
    And user "enter text" in "Add Roles" Manage Access Page
      | fieldName   | actionItem                  |
      | roleName    | @MultipleRolePermissions$   |
      | description | !@#MultipleRolePermissions$ |
    And user performs "click" operation in Manage Access Roles and Users list
      | button      | roleName        |
      | Permissions | ADMIN_EVENTS    |
      | Permissions | ADMIN_DASHBOARD |
      | Permissions | ADMIN_SEARCH    |
      | Permissions | ADMIN_ANALYSIS  |
    And user "click" on "Save Role" in Manage Access page
    And user verifies whether following parameters is "displayed" in Manage Access Roles page
      | button | roleName                  |
      | Delete | @MultipleRolePermissions$ |
    And user performs "click" operation in Manage Access Roles and Users list
      | button | roleName                  |
      | Delete | @MultipleRolePermissions$ |
    And user "click" on "Confirm" button in "Delete Role Popup"

  ##6943589##
  @MLP-17330 @webtest @regression @positive
  Scenario: SC#3: MLP-17330: Verify that user cannot Add Role without filling mandatory fields
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "click" on "Add Role" in Manage Access page
    And user "enter text" in "Add Roles" Manage Access Page
      | fieldName   | actionItem |
      | roleName    |            |
      | description | Test       |
    And user performs "click" operation in Manage Access Roles and Users list
      | button      | roleName     |
      | Permissions | ADMIN_SEARCH |
    And user verifies "Save Button" is "disabled" in "Add Role Page"

###############################################################################################################

  @TEST_MLPQA-17487 @TEST_MLPQA-17488 @TEST_MLPQA-17490 @MLPQA-17471
  @MLP-31004 @webtest @regression @positive
  Scenario: SC#1: MLP-31004: Verify Role 'Plugin Runtime' is displayed and 'ANALYSIS_RUNTIME' permission is enabled for this role
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user verifies whether following parameters is "displayed" in Manage Access Roles page
      | button | roleName       |
      | Edit   | Plugin Runtime |
    And user performs "click" operation in Manage Access Roles and Users list
      | button | roleName       |
      | Edit   | Plugin Runtime |
    And user performs "click" operation in Manage Access Roles and Users list
      | button      | roleName         |
      | Permissions | BASE_PERMISSION  |
      | Permissions | ANALYSIS_RUNTIME |
      | Permissions | ADMIN_EXTENSIONS |
    And user "click" on "Close" button in "Edit Role Screen"

  @TEST_MLPQA-17489 @MLPQA-17471
  @MLP-31004 @webtest @regression @positive
  Scenario: SC#2: MLP-31004: Verify if Local user with Role 'Plugin Runtime' can be created
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click" on "Add Local User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Create Local User"
    And users performs following actions in Manage access
      | Actiontype          | ActionItem | ItemName                    | Section |
      | Enter Text in field | Name       | PluginUser                  |         |
      | Enter Text in field | Username   | PluginUser                  |         |
      | Enter Text in field | Password   | PluginUser                  |         |
      | Enter Text in field | Email      | PluginUser@asg.com          |         |
      | Enter Text in field | Select Role| Plugin Runtime              |         |
    And user "click" on "Save Local User" in Manage Access page
    And user "Verifies popup" is "not displayed" for "ERROR"
    And user "click configuration menu buttons" on "Delete the local user" for "Plugin Runtime" in "Manage Local Users"
    And user clicks on "DELETE" link in the "Delete Local User"

