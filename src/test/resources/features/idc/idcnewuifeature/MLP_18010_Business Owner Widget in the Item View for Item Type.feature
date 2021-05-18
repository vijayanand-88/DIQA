Feature: MLP-18010:To verify Business Owner Widget in the Item View for Item Type

  @MLP-18010 @webtest @regression @positive
  Scenario:MLP-18010:Crea te an Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Test_NW   |
    And user "click" on "Save" button in "Create Item Page"

  # 6958863
  @MLP-18010 @webtest @regression @positive
  Scenario:MLP-18010:SC#1_Verify that Business Owner Widget is displayed for Business Application item types.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_NW" and clicks on search
    And user performs "item click" on "Test_NW" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem      |
      | Verifies Section Displayed | Business Owners |

#    # 6960696 # DeScoped#
#  @MLP-18010 @webtest @regression @positive
#  Scenario:MLP-18010:SC#2_Verify that the Edit option is available for Business Owner Widget.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Test_NW" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_NW" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype       | ActionItem     |
#      | Verify Edit Icon | Business Owner |


    # 6960752 # 6960772
  @MLP-18010 @webtest @regression @positive
  Scenario:MLP-18010:SC#4_Verify the widget displays an information message if no owner is assigned to the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_NW" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test_NW" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem      |
      | Collapse   | Business Owners |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem      |
      | Expand     | Business Owners |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem      | ItemName          |
      | Verify Business Owner Widget value | Business Owners | No data available |

## 6960765 # 6960777 # DeScoped#
#  @MLP-18010 @webtest @regression @positive
#  Scenario:MLP-18010:SC#6_Verify the application shows available users when you satrt typing inside the widget to assign a owner.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Test_NW" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_NW" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype      | ActionItem     |
#      | Click Edit Icon | Business Owner |
#    And User performs following actions in the Item view Page
#      | Actiontype               | ActionItem     | ItemName        |
#      | Verify Edit Widget value | Business Owner | Start typing... |
#    And User performs following actions in the Item view Page
#      | Actiontype           | ActionItem     | ItemName        |
#      | Enter Business Owner | Business Owner | Test Data Admin |
#    And user clicks on first item in Business Owner list
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem     | ItemName |
#      | Click      | Business Owner | Save     |
#    And User performs following actions in the Item view Page
#      | Actiontype                         | ActionItem     | ItemName        |
#      | Verify Business Owner Widget value | Business Owner | Test Data Admin |

#    # 6960765 # DeScoped#
#  @MLP-18010 @webtest @regression @positive
#  Scenario:MLP-18010:SC#7_Verify that the application allows to remove a business owner.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Test_NW" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_NW" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype      | ActionItem     |
#      | Click Edit Icon | Business Owner |
#    And User performs following actions in the Item view Page
#      | Actiontype           | ActionItem     | ItemName         |
#      | Enter Business Owner | Business Owner | Test Guest Owner |
#    And user clicks on first item in Business Owner list
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem     | ItemName |
#      | Click      | Business Owner | Save     |
#    And User performs following actions in the Item view Page
#      | Actiontype      | ActionItem     |
#      | Click Edit Icon | Business Owner |
#    And User removes Business Owner from list
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem     | ItemName |
#      | Click      | Business Owner | Save     |

## 6960768 # DeScoped#
#  @MLP-18010 @webtest @regression @positive
#  Scenario:MLP-18010:SC#8_Verify the user can assign multiple owners to an item.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Test_NW" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_NW" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype      | ActionItem     |
#      | Click Edit Icon | Business Owner |
#    And User performs following actions in the Item view Page
#      | Actiontype               | ActionItem     | ItemName        |
#      | Verify Edit Widget value | Business Owner | Start typing... |
#    And User performs following actions in the Item view Page
#      | Actiontype           | ActionItem     | ItemName        |
#      | Enter Business Owner | Business Owner | Test Data Admin |
#    And user clicks on first item in Business Owner list
#    And User performs following actions in the Item view Page
#      | Actiontype           | ActionItem     | ItemName                  |
#      | Enter Business Owner | Business Owner | Test System Administrator |
#    And user clicks on first item in Business Owner list
#    And User performs following actions in the Item view Page
#      | Actiontype           | ActionItem     | ItemName        |
#      | Enter Business Owner | Business Owner | Test Guest User |
#    And user clicks on first item in Business Owner list
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem     | ItemName |
#      | Click      | Business Owner | Save     |
#    And User performs following actions in the Item view Page
#      | Actiontype                         | ActionItem     | ItemName        |
#      | Verify Business Owner Widget value | Business Owner | Test Data Admin |
#    And User performs following actions in the Item view Page
#      | Actiontype                         | ActionItem     | ItemName                  |
#      | Verify Business Owner Widget value | Business Owner | Test System Administrator |
#    And User performs following actions in the Item view Page
#      | Actiontype                         | ActionItem     | ItemName        |
#      | Verify Business Owner Widget value | Business Owner | Test Guest User |
#    And User performs following actions in the Item view Page
#      | Actiontype      | ActionItem     |
#      | Click Edit Icon | Business Owner |
#    And User removes Business Owner from list
#    And User removes Business Owner from list
#    And User removes Business Owner from list
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem     | ItemName |
#      | Click      | Business Owner | Save     |


  @MLP-18010  @regression @positive
  Scenario:MLP-18010:Delete an Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name    | type                | query | param |
      | SingleItemDelete | Default | Test_NW | BusinessApplication |       |       |











