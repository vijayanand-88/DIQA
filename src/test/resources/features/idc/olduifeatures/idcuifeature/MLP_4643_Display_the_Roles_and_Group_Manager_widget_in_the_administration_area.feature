@MLP-4643
Feature: MLP-4643 Display the Roles and Group Manager widget in the administration area for creating roles

  @webtest @MLP-4643 @positive @RolesAndGroupManager @sanity @regression
  Scenario: MLP-4643_Verification of Roles and Group Manger
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And user "verify displayed" the "ROLES AND GROUP MANAGER" in the Administration dashboard
    And user "verify displayed" the "QUICK LINKS" in the Administration dashboard
    And user "verify displayed" the "RECENT" in the Administration dashboard
    And user "verify displayed" the "Manage roles and users here" in the Administration dashboard
    And user "verify displayed" the "Assign roles and permissions" in the Administration dashboard
    Then user resizes "RolesGroup Widget Resize" widget "1 x 1" and save it

  @webtest @MLP-4643 @positive @RolesAndGroupManager @sanity @regression
  Scenario: MLP-4643_Verification of Roles and Group Manager widget for Guest User
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    Then user verifies whether the "ROLES AND GROUP MANAGER" widget is not displayed in the QuickStart Dashboard

  @webtest @MLP-4643 @positive @RolesAndGroupManager @sanity @regression
  Scenario: MLP-4643_Verification of Roles and Group Manager widget for Data Steward
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    Then user verifies whether the "ROLES AND GROUP MANAGER" widget is not displayed in the QuickStart Dashboard

  @webtest @MLP-4643 @positive @RolesAndGroupManager @sanity @regression
  Scenario: MLP-4643_Verification of Roles and Group Manager widget for Data Custodian
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Custodian" role
    Then user verifies whether the "ROLES AND GROUP MANAGER" widget is not displayed in the QuickStart Dashboard

  @webtest @MLP-4643 @positive @RolesAndGroupManager @sanity @regression
  Scenario: MLP-4643_Verification of Roles and Group Manager widget for Data Consumer
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    Then user verifies whether the "ROLES AND GROUP MANAGER" widget is not displayed in the QuickStart Dashboard


