Feature: MLP_18011_Description widget to enter the description of the on boarded business application

  @MLP-18011 @webtest @regression @positive
  Scenario:MLP-18011:Create an Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute        |
      | Item Name | Test_BusAPP_Item |
    And user "click" on "Save" button in "Create Item Page"

   # 6952077
  @MLP-18011 @webtest @regression @positive
  Scenario:MLP-18011:SC#1_Verify that the Description section is displayed in the itemview for a Business Application item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_BusAPP_Item" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test_BusAPP_Item" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem  |
      | Verifies Section Displayed | Description |

#    # 6952081 # DeScoped#
#  @MLP-18011 @webtest @regression @positive
#  Scenario:MLP-18011:SC#2_Verify that the Edit buttion with a pen icon is placed near to the Description header.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Test_BusAPP_Item" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_BusAPP_Item" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype       | ActionItem  |
#      | Verify Edit Icon | Description |

#     # 6952086 # DeScoped#
#  @MLP-18011 @webtest @regression @positive
#  Scenario:MLP-18011:SC#3_Verify that the user can edit a description.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Test_BusAPP_Item" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_BusAPP_Item" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype      | ActionItem  |
#      | Click Edit Icon | Description |
#    And User performs following actions in the Item view Page
#      | Actiontype        | ActionItem  | ItemName                      |
#      | Enter Description | Description | Description Value Now Changed |
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem  | ItemName |
#      | Click      | Description | Save     |
#    And User performs following actions in the Item view Page
#      | Actiontype             | ActionItem  | ItemName                      |
#      | Verifies Item Presence | Description | Description Value Now Changed |

#    # 6952079 # DeScoped#
#  @MLP-18011 @webtest @regression @positive
#  Scenario:MLP-18011:SC#4_Verify that the description section can be expanded or collapsed.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Test_BusAPP_Item" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_BusAPP_Item" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem  |
#      | Collapse   | Description |
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem  |
#      | Expand     | Description |
#    And User performs following actions in the Item view Page
#      | Actiontype             | ActionItem  | ItemName                      |
#      | Verifies Item Presence | Description | Description Value Now Changed |

#  # 6952089 # DeScoped#
#  @MLP-18011 @webtest @regression @positive
#  Scenario:MLP-18011:SC#5_Verify the Cancel functionality in the description section during edit.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Test_BusAPP_Item" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_BusAPP_Item" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype      | ActionItem  |
#      | Click Edit Icon | Description |
#    And User performs following actions in the Item view Page
#      | Actiontype        | ActionItem  | ItemName |
#      | Enter Description | Description | Test     |
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem  | ItemName |
#      | Click      | Description | Cancel   |
#    And user "click" on "Yes" button in "Popup Window"
#    And User performs following actions in the Item view Page
#      | Actiontype             | ActionItem  | ItemName                      |
#      | Verifies Item Presence | Description | Description Value Now Changed |

  @MLP-18011  @regression @positive
  Scenario:MLP-18010:Delete an Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name             | type                | query | param |
      | SingleItemDelete | Default | Test_BusAPP_Item | BusinessApplication |       |       |
