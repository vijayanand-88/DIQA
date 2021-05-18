Feature:MLP_18647_18595_19024_To Verify Trust Factor,Tag,Data tab Displayed in Business Application Items

  ##6963346##6963347##6963348##6973205##6973206##
  @MLP-18647 @webtest @regression @positive
  Scenario:MLP-18647:SC#1:Verify Trust Factor,Tag,Data tab Displayed in Business Application Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute              | option        |
      | BusinessApplication | BA_Widget_Verification | Save and Open |
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem  |
      | Verify Widget Presence | Trust Score |
      | Verify Widget Presence | Rating      |
      | Verify Widget Presence | Tags        |
      | Verify Tab Presence    | Capture     |
    And User performs following actions in the Item view Page
      | Actiontype                   | ActionItem                                                                                  | Section |
      | Verifies Information Message | Looks like there are no tags associated with this item. To add your own tag, click + above. | Tags    |
      | Verifies Information Message | Average                                                                                     | Rating  |
    And User performs following actions in the Item view Page
      | Actiontype       | ActionItem    | Section |
      | Icon not Present | Expand Icon   | Tags    |
      | Icon not Present | Collapse Icon | Tags    |

# 6968265
  @MLP-19024 @webtest @regression @positive
  Scenario:MLP-19024:SC#2_Verify the Rating widget is displayed for Table and File items by default
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem |
      | Verify Widget Presence | Rating     |
    And user navigates to previous page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem |
      | Verify Widget Presence | Rating     |

    ##bug- MLP-25776
    # 6968266
  @MLP-19024 @webtest @regression @positive
  Scenario:MLP-19024:SC#7_Verify the User is able to select the star by selecting the rating star
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user gives "3" rating in item view page
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on rating 3 checkbox and get item count
    And user clicks on first item on the item list page

  # 6968267
  @MLP-19024 @webtest @regression @positive
  Scenario:MLP-19024:SC#8_Verify if Average Rating displays the rating score, if only it has been rated by at least one user
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user gives "4" rating in item view page
    And user verifies average rating "4" in business application
    And user clicks on search icon
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on rating 4 checkbox and get item count
    And user clicks on first item on the item list page
    And user verifies average rating "4" in business application

  @MLP-19024 @regression @positive
  Scenario:Delete the BA
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type                | query | param |
      | SingleItemDelete | Default | BA_Widget_Verification | BusinessApplication |       |       |
