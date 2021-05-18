@MLP-17258
Feature:MLP-17258: Manage Access, Add navigation for access, display available roles

  ##6924185##6924221##6931073##6931149##6924186##
  @MLP-17258 @webtest @regression @positive
  Scenario: SC#1: MLP-17258: Verify that Manage Access and Roles screen elements validation
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Roles |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Roles |
    And user "verifies presence" of following "Page Subtitle" in "Manage Tags" page
      | Set up new roles, edit roles or update permissions |
    Then user "verifies sorting order" of following "Roles are in descending order" in "Manage Access Roles" page
      |  |
    And user "click" on "Sort Icon" button in "Manage Access Roles"
    Then user "verifies sorting order" of following "Roles are in ascending order" in "Manage Access Roles" page
      |  |

  ##6931150##6924223##6924229##
  @MLP-17258 @webtest @regression @positive
  Scenario: SC#2: MLP-17258: Verify that user can Add Role and Delete it
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Roles |
    And user "click" on "Add Role" in Manage Access page
    And user "enter text" in "Add Roles" Manage Access Page
      | fieldName   | actionItem |
      | roleName    | TestRole1  |
      | description | Test       |
    And user performs "click" operation in Manage Access Roles and Users list
      | button      | roleName        |
      | Permissions | ADMIN_DASHBOARD |
    And user "click" on "Save Role" in Manage Access page
    And user verifies whether following parameters is "displayed" in Manage Access Roles page
      | button | roleName  |
      | Delete | TestRole1 |
    And user performs "click" operation in Manage Access Roles and Users list
      | button | roleName  |
      | Delete | TestRole1 |
    And user "click" on "Confirm" button in "Delete Role Popup"

  ##6924188##6924189##6931073##
  @MLP-17258 @webtest @regression @positive
  Scenario: SC#3: MLP-17258: Verify that Manage Access and Roles screen elements validation
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Roles |
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
#    And user "click" on "Manage Access title" button in "Manage Access Page"Desccoped
    Then user "verifies displayed" of following "labels" in Manage Access Page
      | Roles Table header and count |
      | Role Name                    |
      | Role Description             |
    And user verifies the "Roles" table with count is "displayed" in Manage Access page
    And user verifies the "Name" of Roles table "displayed" in Manage Access page
    And user verifies the "Description" of Roles table "displayed" in Manage Access page


