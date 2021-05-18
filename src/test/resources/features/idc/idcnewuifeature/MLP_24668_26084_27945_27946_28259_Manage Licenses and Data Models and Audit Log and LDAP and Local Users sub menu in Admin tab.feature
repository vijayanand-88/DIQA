@MLP-24668
Feature:MLP_24668_26084_27945_27946_28259_Manage Licenses and Data Models and Audit Log and LDAP and Local Users sub menu in Admin tab

  ##7132334##7132335##7132336##
  @MLP-24668 @webtest @regression @positive
  Scenario: SC#1:24668: Verify if Admin menu has "Manage Licenses" label displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Licenses |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Licenses |
    And user "verifies presence" of following "Page Subtitle" in "Manage Licenses" page
      | General licensing and status information |

  ######################################################################################################

  ###MLP-26084: To Verify the Data Model Admin menu and navigation

  ##7171061##7171062##7171064##7171065##7171066##
  @MLP-26084 @webtest @regression @positive
  Scenario: SC#1:26084: Verify if Admin menu has "Data Model - Itemtypes and Attributes" label displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user "verify sidebar menu items" of following "Data Model" in "Landing" page
      | Itemtypes and Attributes |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Data Model |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Itemtypes and Attributes |
    And user "verifies presence" of following "Page Subtitle" in "Data Model" page
      | Shows itemtypes, attributes and manage custom attributes |
    And user performs following actions in the header
      | actionType         | actionItem  |
      | displayed          | Itemtypes   |
      | displayed          | SchemaCount |

  ######################################################################################################

  ###MLP-27945: To Verify the Audit Log Admin menu and navigation

  ##7196570##7196571##7196573##
  @MLP-27945 @webtest @regression @positive
  Scenario: SC#1:27945: Verify if Admin menu has "Audit Log" label displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And user "verify sidebar menu items" of following "Audit Log" in "Landing" page
      | View Audit Log |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Audit Log |
    And user "verifies presence" of following "Page Subtitle" in "Audit Log" page
      | Shows the audit log records |

 ######################################################################################################

  ###MLP-27946: To Verify the Audit Table with Search

  ##7204205##7204206##7204207##
  @MLP-27946 @webtest @regression @positive
  Scenario: SC#1:27946: Verify if Verify if user can see the Audit table and Table headers
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    Then user "verify presence" of following "Audit Table Headers" in Audit Log Page
      | level      |
      | Date       |
      | Event      |
      | ItemType   |
      | Item       |
      | Component  |
      | User       |
    And users performs following actions in Audit Log page
      | Actiontype                   | ActionItem                 | ItemName                 | Section |
      | Enter Text in Search box     |                            | Error                    |         |
      | Verifies Item Displayed      | ERROR                      |                          |         |
      | Verifies Item Not Displayed  | INFO                       |                          |         |
      | Remove Text in Search box    |                            |                          |         |
      | Enter Text in Search box     |                            | ConfigurationChangeEvent |         |
      | Verifies Item Displayed      | ConfigurationChangeEvent   |                          |         |
      | Verifies Item Not Displayed  | LoginFailedEvent           |                          |         |

  ######################################################################################################

  ###MLP-28259: To verify User  management label changes

  ##7200308##7200309##7200310##7200311##7200312##
  @MLP-28259 @webtest @regression @positive
  Scenario: SC#1:28259:  Verify if admin link 'Manage Users & Groups' is renamed as 'Manage LDAP Users' and Add User page title
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage LDAP Users |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage LDAP Users |
    And user "verifies presence" of following "Page Subtitle" in "Manage Users & Groups" page
      | Give access to Data Discovery to LDAP Users |
    And user "click" on "Add users" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype     | ActionItem  | ItemName          | Section        |
      | Verify Header  | Add User    |                   |                |
    And user "click" on "Cancel button" button in "Add User Page"
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Local Users |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Local Users |
    And user "verifies presence" of following "Page Subtitle" in "Manage Users & Groups" page
      | Create/Edit a local user |
    And user "click" on "Add users" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype     | ActionItem         | ItemName          | Section        |
      | Verify Header  | Create Local User  |                   |                |




