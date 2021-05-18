@MLP-4644
Feature: MLP-4644 Adding route and List Roles and Groups pane

  @webtest @MLP-4644 @positive @RolesAndGroupManager @sanity @regression
  Scenario: MLP-4644_Verification of Roles and Group Manger in the new panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "ROLES AND GROUP MANAGER" link on the Dashboard page
    And user "verify displayed" the "ROLES AND GROUP MANAGER" in the new opening panel
    And user should be able logoff the IDC

  @webtest @MLP-4644 @positive @RolesAndGroupManager @sanity @regression
  Scenario: MLP-4644_Verification of fork icon for Roles and Groups list
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "ROLES AND GROUP MANAGER" link on the Dashboard page
    And user "verify displayed" the "Fork Icon" in the new opening panel
    And user should be able logoff the IDC

  @webtest @MLP-4644 @positive @RolesAndGroupManager @sanity
  Scenario: MLP-4644_Verification of New Role and Add a group button for Roles and Groups
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "ROLES AND GROUP MANAGER" link on the Dashboard page
    And user "verify displayed" the "Create New Role" in the new opening panel
    And user "verify displayed" the "Assign Group and User" in the new opening panel

  @webtest @MLP-4644 @positive @RolesAndGroupManager @sanity
  Scenario: MLP-4644_Verification of label and count displayed for Groups and roles
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "ROLES AND GROUP MANAGER" link on the Dashboard page
    Then user "verify displayed" the "Roles" list is displayed in the new opening panel
    Then user "verify displayed" the "Groups and Users" list is displayed in the new opening panel

