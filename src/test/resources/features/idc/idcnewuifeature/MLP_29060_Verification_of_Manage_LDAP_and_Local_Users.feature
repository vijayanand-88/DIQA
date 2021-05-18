@MLP-29060 @e2e
Feature:MLP-29060: Manage Access, Add navigation for access, display available roles

  ##7243026##7243027##7243028## #7245920#7246760#7246761#7246762
  @MLP-29060 @webtest @regression @positive
  Scenario: SC#1: MLP-29060: Verify the Column 'Type' is removed in both the Manage LDAP and Manage Local Users
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click" on "Add Local User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Create Local User"
    And users performs following actions in Manage access
      | Actiontype           | ActionItem | ItemName                    |
      | Enter Text in field  | Name       | TestAutomationUser1         |
      | Enter Text in field  | Username   | TestAutomationUser1         |
      | Enter Text in field  | Password   | AutomationUser1             |
      | Enter Text in field  | Email      | TestAutomationUser1@asg.com |
      | Select Role          | Roles      | Business Owner              |
      | Close Dropdown Popup |            |                             |
    And user "click" on "Save Local User" in Manage Access page
    And user "click" on "Click Filter" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype               | ActionItem          | ItemName       |
      | Verify absence of Column | Type                |                |
      | Select Filter            | Role(s)             | Business Owner |
      | Verify Users List        | TestAutomationUser1 |                |
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName           | option              |
      | Edit the local user | TestAutomationUser1 |
    And users performs following actions in Manage access
      | Actiontype          | ActionItem | ItemName                  |
      | Enter Text in field | Name       | TestAutomationUser1Edited |
    And user "click" on "Save Local User" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype        | ActionItem                | ItemName |
      | Verify Users List | TestAutomationUser1Edited |          |
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName             | option              |
      | Delete the local user | TestAutomationUser1 |
    And user "click" on "Confirm" button in "Manage Local Users"
    And users performs following actions in Manage access
      | Actiontype                  | ActionItem | ItemName                  |
      | Verifies User not Displayed |            | TestAutomationUser1Edited |


    ##7243026##7243027##7243028## 7246394#7246395#7246397
  @MLP-29060 @webtest @regression @positive
  Scenario: SC#2: MLP-29060:Verify the filters should be on 'Role(s)' in both the manage LDAP users and local users
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And user "click" on "Add LDAP User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Add User"
    And users performs following actions in Manage access
      | Actiontype           | ActionItem | ItemName       |
      | Enter Text in field  | LDAP User  | Becubic Build  |
      | Select Role          | Role       | Business Owner |
      | Close Dropdown Popup |            |                |
    And user "click" on "Save Local User" in Manage Access page
    And user "click" on "Click Filter" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype               | ActionItem    | ItemName       |
      | Verify absence of Column | Type          |                |
      | Select Filter            | Role(s)       | Business Owner |
      | Verify Users List        | Becubic Build |                |
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName          | option        |
      | Edit the ldap user | Becubic Build |
    And users performs following actions in Manage access
      | Actiontype           | ActionItem | ItemName   |
      | Select Role          | Roles      | Select all |
      | Close Dropdown Popup |            |            |
    And user "click" on "Save Local User" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype        | ActionItem    | ItemName         |
      | Select Filter     | Role(s)       | Compliance Owner |
      | Verify Users List | Becubic Build |                  |
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName            | option        |
      | Delete the ldap user | Becubic Build |
    And user "click" on "Confirm" button in "Manage Local Users"
    And users performs following actions in Manage access
      | Actiontype                  | ActionItem | ItemName      |
      | Verifies User not Displayed |            | Becubic Build |