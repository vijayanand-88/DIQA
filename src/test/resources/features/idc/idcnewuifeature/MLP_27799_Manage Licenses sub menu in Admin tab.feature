@MLP-27799 @e2e
Feature:AA_MLP-27799_To Verify the Manage Licenses Admin menu and navigation

    ##7201699##7201700##7201701##7207205##
  @MLP-23718 @webtest @regression @positive
  Scenario: SC#1:27799: Verify if Admin menu has "Manage Licenses" label displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Licenses |
    And user "verifies presence" of following "Licenses" in "Manage Licenses" page
      | Data sources            |
      | Lineage Transformations |
      | Named Users             |
      | Nodes                   |
    And User performs following actions in the Manage Licenses Page
      | Actiontype     | ActionItem  |
      | Expand License | Named Users |
    And user "verifies License field presence" of following "Named Users" in "Manage Licenses" page
      | License Used  |
      | License Limit |
      | Status        |
    And User performs following actions in the Manage Licenses Page
      | Actiontype         | ActionItem    | ItemName    |
      | Enter Text         | License Limit | 102         |
      | Click              | Save Button   | Named Users |
      | Expand License     | Named Users   |             |
      | Verify Field Value | License Limit | 102         |

    ##7201702##7201703##
  @MLP-23718 @webtest @regression @positive
  Scenario: SC#2:27799: Verify if on deleting the LDAP and LOCAL user, License used cound should get decreased respectively
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And User performs following actions in the Manage Licenses Page
      | Actiontype        | ActionItem   |
      | Expand License    | Named Users  |
      | Store Field Value | License Used |
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click" on "Add Local User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Create Local User"
    And users performs following actions in Manage access
      | Actiontype          | ActionItem | ItemName                   | Section |
      | Enter Text in field | Name       | Automation User            |         |
      | Enter Text in field | Username   | TestAutomationUser         |         |
      | Enter Text in field | Password   | AutomationUser             |         |
      | Enter Text in field | Email      | TestAutomationUser@asg.com |         |
      | Enter Text in field | Role       | System Administrator       |         |
    And user "click" on "Save Local User" in Manage Access page
    And user "verifies presence" of following "Manage Local Users list" in "Manage Bundles" page
      | Test System Administrator |
      | Test Guest User           |
      | Test Data Admin           |
      | System Administrator      |
      | Automation User           |
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And User performs following actions in the Manage Licenses Page
      | Actiontype                        | ActionItem   |
      | Expand License                    | Named Users  |
      | Verify License limit is increased | License Used |

    ##7201704##7201705##7201770##
  @MLP-23718 @webtest @regression @positive
  Scenario: SC#3:27799: Verify if user can add a new LDAP User to DD (Eg: Becubic User")
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And User performs following actions in the Manage Licenses Page
      | Actiontype        | ActionItem   |
      | Expand License    | Named Users  |
      | Store Field Value | License Used |
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And user "click" on "Add LDAP User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Add User"
    And users performs following actions in Manage access
      | Actiontype          | ActionItem | ItemName             |
      | Enter Text in field | LDAP User  | Becubic Build        |
      | Enter Text in field | Role       | System Administrator |
    And user "click" on "Save Local User" in Manage Access page
    And user "click" on "Admin Link" for "Manage Licenses" in "Manage LDAP Users"
    And User performs following actions in the Manage Licenses Page
      | Actiontype                                  | ActionItem   | ItemName      |
      | Expand License                              | Named Users  |               |
      | Verify License limit is increased           | License Used |               |
      | Set license used and license limit as equal | License Used | License Limit |
      | Click                                       | Save Button  | Named Users   |
      | Verify license status                       | Save Button  | Named Users   |
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click" on "Add Local User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Create Local User"
    And users performs following actions in Manage access
      | Actiontype          | ActionItem | ItemName                    | Section |
      | Enter Text in field | Name       | Automation User1            |         |
      | Enter Text in field | Username   | TestAutomationUser1         |         |
      | Enter Text in field | Password   | AutomationUser1             |         |
      | Enter Text in field | Email      | TestAutomationUser1@asg.com |         |
      | Enter Text in field | Role       | System Administrator        |         |
    And user "click" on "Save Local User" in Manage Access page
    And user "Verifies popup content" is "displayed" for "License limit has reached maximum for entity Named Users"

    ##7201771##
  @MLP-23718 @webtest @regression @positive
  Scenario:SC#4:27799:Verify if Turning the Status as 'Inactive', does not have the license validation. User can add users even if 'License Limit' configured
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And User performs following actions in the Manage Licenses Page
      | Actiontype      | ActionItem  | ItemName    |
      | Expand License  | Named Users |             |
      | Select Dropdown | Status      | Inactive    |
      | Click           | Save Button | Named Users |
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click" on "Add Local User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Create Local User"
    And users performs following actions in Manage access
      | Actiontype          | ActionItem | ItemName                    | Section |
      | Enter Text in field | Name       | Automation User1            |         |
      | Enter Text in field | Username   | TestAutomationUser1         |         |
      | Enter Text in field | Password   | AutomationUser1             |         |
      | Enter Text in field | Email      | TestAutomationUser1@asg.com |         |
      | Enter Text in field | Role       | System Administrator        |         |
    And user "click" on "Save Local User" in Manage Access page
    And user "Verifies popup" is "not displayed" for "ERROR"
    And user "verifies presence" of following "Manage Local Users list" in "Manage Bundles" page
      | Test System Administrator |
      | Test Guest User           |
      | Test Data Admin           |
      | System Administrator      |
      | Automation User           |
      | Automation User1          |

    ##7201773##7201774##7201776##
  @MLP-23718 @webtest @regression @positive
  Scenario:SC#5:27799:Verify if on deleting the LDAP and LOCAL user, License used cound should get decreased respectively
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And User performs following actions in the Manage Licenses Page
      | Actiontype        | ActionItem   | ItemName |
      | Verify Status     | Nodes        | Inactive |
      | Expand License    | Named Users  |          |
      | Store Field Value | License Used |          |
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And user "click configuration menu buttons" on "Delete the ldap user" for "Becubic Build" in "Manage LDAP Users"
    And user clicks on "DELETE" link in the "Delete LDAP User"
    And user "click" on "Admin Link" for "Manage Licenses" in "Manage LDAP Users"
    And User performs following actions in the Manage Licenses Page
      | Actiontype                        | ActionItem   |
      | Expand License                    | Named Users  |
      | Verify License limit is decreased | License Used |
      | Store Field Value                 | License Used |
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click configuration menu buttons" on "Delete the local user" for "Automation User1" in "Manage LDAP Users"
    And user clicks on "DELETE" link in the "Delete Local User"
    And user "click configuration menu buttons" on "Delete the local user" for "Automation User" in "Manage LDAP Users"
    And user clicks on "DELETE" link in the "Delete Local User"
    And user "click" on "Admin Link" for "Manage Licenses" in "Manage LDAP Users"
    And User performs following actions in the Manage Licenses Page
      | Actiontype                        | ActionItem   |
      | Expand License                    | Named Users  |
      | Verify License limit is decreased | License Used |

      ##7201774##
  @MLP-23718 @webtest @regression @positive
  Scenario:SC#5:27799:Verify if on deleting the LDAP and LOCAL user, the user should not able to login
    And User launch browser and traverse to login page
    And user enter credentials for "Becubic User" role
    Then login must be failed and displays error message "Access denied because this user name was not granted access via roles"

    ##7201775##7201777##
  @MLP-23718 @webtest @regression @positive
  Scenario:SC#6:27799:Verify if 'License Limit' cannot be less than 'License Used', verify if system displays alert message 'License Limit should be greater than License Used'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And User performs following actions in the Manage Licenses Page
      | Actiontype           | ActionItem    | ItemName                                          |
      | Expand License       | Named Users   |                                                   |
      | Select Dropdown      | Status        | Active                                            |
      | Store Field Value    | License Used  |                                                   |
      | Set License limit    | License Used  | License Limit                                     |
      | Verify Error Message | License Limit | License Limit should be greater than License Used |
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And user "click" on "Add LDAP User" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype                                                 | ActionItem | ItemName |
      | Verify User Groups are not displayed in LDAP User dropdown | LDAP User  | DIQAALL  |

    ##7207214##7207215##
  @MLP-23718 @webtest @regression @positive
  Scenario:27799:SC#7:Verify if 'License Limit' and 'License Used' and 'Status' fields are displayed for Data Sources license and Lineage transformations and Set the default license limit
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And User performs following actions in the Manage Licenses Page
      | Actiontype     | ActionItem    | ItemName    |
      | Expand License | Named Users   |             |
      | Enter Text     | License Limit | 100         |
      | Click          | Save Button   | Named Users |
    And User performs following actions in the Manage Licenses Page
      | Actiontype     | ActionItem   |
      | Expand License | Data sources |
    And user "verifies License field presence" of following "Data sources" in "Manage Licenses" page
      | License Used  |
      | License Limit |
      | Status        |
    And User performs following actions in the Manage Licenses Page
      | Actiontype     | ActionItem              |
      | Expand License | Lineage Transformations |
    And user "verifies License field presence" of following "Lineage Transformations" in "Manage Licenses" page
      | License Used  |
      | License Limit |
      | Status        |

