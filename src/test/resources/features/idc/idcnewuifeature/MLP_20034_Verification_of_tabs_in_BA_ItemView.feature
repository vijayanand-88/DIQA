@MLP-20034 @MLP-20036
Feature:MLP-20034: This feature is to verify the tabs in the Item view page for BA.

#  @webtest @regression @positive
#  Scenario:Create an BA Item
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | CreateButton  |
#    And user "select dropdown" in Create new item page
#      | fieldName | attribute           |
#      | Item Type | BusinessApplication |
#    And user "enter text" in Create new item page
#      | fieldName | attribute |
#      | Item Name | SampleBA  |
#    And user "click" on "Save" button in "Create Item Page"

#   ##7015495##7015496##7015497##
#  @MLP-20034 @webtest @regression @positive
#  Scenario: SC1#:MLP-20034:Verify if user can select bulk search items of same type and check if "ASSIGN/UNASSIGN TAGS" button is enabled
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "enter text" in "Landing page"
#      | fieldName   | actionItem |
#      | Search Area | TestBA     |
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on first item on the item list page
#    And user verifies "Tabs Menu Icon" is "displayed" in "Item View" page
#    And user "click" on "Tabs Menu Icon" button in "Item View" page
#    And user verifies "Tabs submenus" is "displayed" in "Item View" page
#    And user "verify submenus" for the following submenus under "BA Multi tab" menu
#      | BusinessTab4 |
#      | BusinessTab5 |
#      | BusinessTab7 |
#      | new          |

   ##7021777##
  @MLP-20366 @webtest @regression @positive
  Scenario: SC2#:MLP-20366:Verify if user can select bulk search items of same type and check if "ASSIGN/UNASSIGN TAGS" button is enabled
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem    |
      | click      | Settings Icon |
    And user verifies "Sidebar Admin Links" is "not displayed" in "Landing page"

    ##7021778##7021780##
  @MLP-20366 @webtest @regression @positive
  Scenario: SC3#:MLP-20366: To verify the is user able to view the Manage configuration page by clicking admin menu
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Configurations |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Configurations |

  ##7021781##7021783##7021782##
  @MLP-20366 @webtest @regression @positive
  Scenario: SC4#:MLP-20366: Verify the Data Capture,Manage Access as Title with below menu items
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user "verify sidebar menu items" of following "Data Capture" in "Landing" page
      | Manage Configurations |
      | Manage Credentials    |
      | Manage Data Sources   |
      | Manage Bundles        |
    And user "verify sidebar menu items" of following "Excel Importer" in "Landing" page
      | Manage Excel Imports |
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "verify sidebar menu items" of following "Manage Access" in "Landing" page
      | Manage Roles       |
      | Manage LDAP Users  |
      | Manage Local Users |

