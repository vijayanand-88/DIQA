@MLPQA-17668 @MLPQA-18283 @MLPQA-18288 @MLPQA-18289 @MLPQA-18296 @MLPQA-18297
Feature: MLP_30916_MLP_30591_MLP_30596_MLP_30614_MLP_30342 To verify the Keyboard focus events and actions and Tab Order for different screens

  @webtest
  Scenario: SC#1: Verify Tab Order navigation order in Manage Plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem                         |
      | Open Deployment | MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC |
    And user "click" on "Add Configuration" button under "MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | Collector                |
      | Plugin    | CAE_Collector_for_Oracle |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user press tab key and verifies the tab order
      | label                |
      | ×                    |
      | Type*                |
      | Plugin*              |
      | Name*                |
      | Label                |
      | Business Application |
      | Data Source*         |
      | Credential*          |
      | Plugin version       |
      | Event condition      |
      | Event class          |
      | Maximum work size    |
      | Tags                 |
      | DEBUG                |
      | JAVA_MEMORY_HEAP_1   |
      | JAVA_MEMORY_HEAP_2   |

  @TEST_MLPQA-17525 @TEST_MLPQA-17526 @TEST_MLPQA-17527 @TEST_MLPQA-17529 @MLPQA-17486
  @MLP-30916 @webtest @regression @positive
  Scenario:SC#2_Verify Tab order and Keyboard focus of Manage Tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user press Tab Key and verifies the focus of "Taborder ManageTags Validation"
      | fieldName         | actionItem  | itemName | section    | reverseTab |
      | General [Default] | Add         | Edit     | ManageTags |            |

  @TEST_MLPQA-17491 @TEST_MLPQA-17492 @TEST_MLPQA-17493 @TEST_MLPQA-17494 @MLPQA-17486
  @MLP-30591 @webtest @regression @positive
  Scenario:SC#3_Verify Tab order and Keyboard focus of Assign Tags screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user clicks on first item name link on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And user press Tab Key and verifies the focus of "Taborder AssignTags Validation"
      | fieldName     | actionItem  | itemName | section | reverseTab |
      | Create a tag  | General     | Cancel   |         | ASSIGN     |

  @TEST_MLPQA-18232 @TEST_MLPQA-18233 @TEST_MLPQA-18234 @TEST_MLPQA-18235 @TEST_MLPQA-18236 @MLPQA-17471
  @MLP-30596 @webtest @regression @positive
  Scenario:SC#4_Verify Tab order and Keyboard focus of Item View screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user clicks on first item name link on the item list page
    And user press Tab Key and verifies the focus of "Taborder ItemViewScreen Validation"
      | fieldName      | actionItem  | itemName | section                      | reverseTab |
      | Search Results |             |          | ItemViewBreadcrumbNavigation |            |
    And user clicks on first item name link on the item list page
    And user press Tab Key and verifies the focus of "Taborder ItemViewScreen Validation"
      | fieldName | actionItem  | itemName | section                             | reverseTab   |
      | Rating    |             |          | ItemViewScreenWidgetCollapseAndRate |              |

  @TEST_MLPQA-18237 @TEST_MLPQA-18238 @TEST_MLPQA-18239 @TEST_MLPQA-18240 @MLPQA-17471
  @MLP-30614 @webtest @regression @positive
  Scenario:SC#5_Verify Tab order and Keyboard focus of Item View Edit screen - Business Application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute   | option |
      | BusinessApplication | TabFocusBA  | Save   |
    And user "click" on "Close" button in "Create Item Screen"
    And user enters the search text "TabFocusBA" and clicks on search
    And user clicks on first item name link on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem            |
      | Click      | Item view Edit Button |
    And user press Tab Key and verifies the focus of "Taborder ItemViewBA Validation"
      | fieldName | actionItem  | itemName | section              | reverseTab |
      | Cancel    |             |          | BAItemViewOnEditing  | Save       |
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem           | ItemName |
      | Verify Details Widget Value | Business Criticality | High     |

  @TEST_MLPQA-18007 @TEST_MLPQA-18010 @TEST_MLPQA-18013 @TEST_MLPQA-18015 @TEST_MLPQA-18020 @TEST_MLPQA-18013
  @MLP-30342 @MLP-30654 @webtest @regression @positive
  Scenario:SC#6_Verify Tab order and Keyboard focus of Add Role and Edit Role screens
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "click" on "Add Role" in Manage Access page
    And user press Tab Key and verifies the focus of "Taborder Manage Roles validation"
      | fieldName | actionItem  | itemName | section           | reverseTab |
      |           |             |          | Add Role Screen   |            |
    And user "click" on "Save Role" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype        | ActionItem | ItemName |
      | Verify Roles List | Tab Role   |          |
    And user performs "click" operation in Manage Access Roles and Users list
      | button | roleName |
      | Edit   | Tab Role |
    And user press Tab Key and verifies the focus of "Taborder Manage Roles validation"
      | fieldName | actionItem  | itemName | section           | reverseTab |
      |           | SAVE        |          | Edit Role Screen  | Cancel     |
    And user performs "click" operation in Manage Access Roles and Users list
      | button | roleName |
      | Clone  | Tab Role |
    And user press Tab Key and verifies the focus of "Taborder Manage Roles validation"
      | fieldName | actionItem  | itemName | section           | reverseTab |
      |           | SAVE        |  Cancel  | Clone Role Screen | ×          |
    And user performs "click" operation in Manage Access Roles and Users list
      | button | roleName       |
      | Delete | Tab Role       |
      | Delete | Tab Role Clone |
    And user "click" on "Confirm" button in "Delete Role Popup"

  @MLPQA-18009 @MLPQA-18012 @MLPQA-18017 @TEST_MLPQA-18013
  @MLP-30342 @MLP-30654 @webtest @regression @positive
  Scenario:SC#7_Verify Tab order and Keyboard focus of Add LDAP and Edit LDAP users screens
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And user "click" on "Add LDAP User" in Manage Access page
    And user press Tab Key and verifies the focus of "Taborder Manage LDAP Users validation"
      | fieldName | actionItem  | itemName | section           | reverseTab |
      |           |             |          | Add LDAP Screen   |            |
    And users performs following actions in Manage access
      | Actiontype           | ActionItem | ItemName       |
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
    And user press Tab Key and verifies the focus of "Taborder Manage LDAP Users validation"
      | fieldName | actionItem  | itemName | section           | reverseTab |
      |           |             |          | Edit LDAP Screen  | Cancel     |
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName            | option        |
      | Delete the ldap user | Becubic Build |
    And user "click" on "Confirm" button in "Manage LDAP Users"

  @MLPQA-18008 @MLPQA-18011 @MLPQA-18018 @TEST_MLPQA-18013
  @MLP-30342 @MLP-30654 @webtest @regression @positive
  Scenario:SC#8_Verify Tab order and Keyboard focus of Add Local and Edit Local users screens
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click" on "Add Local User" in Manage Access page
    And user press Tab Key and verifies the focus of "Taborder Manage Local Users validation"
      | fieldName | actionItem  | itemName | section                | reverseTab |
      |           |             |          | Add Local User Screen  |            |
    And users performs following actions in Manage access
      | Actiontype           | ActionItem | ItemName         |
      | Select Role          | Roles      | Business Owner   |
    And user "click" on "Save Local User" in Manage Access page
    And user "click" on "Click Filter" in Manage Access page
    And users performs following actions in Manage access
      | Actiontype               | ActionItem | ItemName           |
      | Verify absence of Column | Type       |                    |
      | Select Filter            | Role(s)    | Business Owner     |
      | Verify Users List        | LocalUser  |                    |
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName           | option    |
      | Edit the local user | LocalUser |
    And user press Tab Key and verifies the focus of "Taborder Manage Local Users validation"
      | fieldName | actionItem  | itemName | section                | reverseTab |
      |           |             |          | Edit Local User Screen | Cancel     |
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName             | option    |
      | Delete the local user | LocalUser |
    And user "click" on "Confirm" button in "Manage Local Users"

  @MLPQA-18014 @MLPQA-18016 @MLPQA-18019 @TEST_MLPQA-18013
  @MLP-30342 @MLP-30654 @webtest @regression @positive
  Scenario:SC#9_Verify Tab order and Keyboard focus of Manage Roles LDAP and Local User screens
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user press Tab Key and verifies the focus of "Taborder Manage Roles LDAP and Local User validation"
      | fieldName  | actionItem  | itemName | section              | reverseTab |
      | Add Role   |             |          | Manage Roles Screen  |            |
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And user press Tab Key and verifies the focus of "Taborder Manage Roles LDAP and Local User validation"
      | fieldName      | actionItem | itemName | section                   | reverseTab |
      | Add LDAP User  |            |          | Manage LDAP Users Screen  |            |
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user press Tab Key and verifies the focus of "Taborder Manage Roles LDAP and Local User validation"
      | fieldName      | actionItem | itemName | section                   | reverseTab |
      | Add Local User |            |          | Manage Local Users Screen |            |



