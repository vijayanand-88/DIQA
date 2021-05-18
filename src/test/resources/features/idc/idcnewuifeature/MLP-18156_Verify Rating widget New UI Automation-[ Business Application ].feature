@MLP-18156
Feature: MLP-18156:To Verify Rating widget New UI Automation-[ Business Application ]

  @MLP-18156 @webtest @regression @positive @e2e
  Scenario:MLP-18156:Create an Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute        | option        |
      | BusinessApplication | Test_ABA_RATING2 | Save and Open |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute        | option        |
      | BusinessApplication | Test_ABA_RATING3 | Save and Open |

# 6965688
  @MLP-18156 @webtest @regression @positive
  Scenario:MLP-18156:SC#1_Verify if Rating widget is displayed in Business Application Item View
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_ABA_RATING2" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user verifies rating facet in item view

# 6965691 # 6965698
  @MLP-18156 @webtest @regression @positive @e2e
  Scenario:MLP-18156:SC#2_ Verify if user can rate the Business Application item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_ABA_RATING2" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user gives "4" rating in item view page
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on rating 4 checkbox and get item count
    And user verifies first item "Test_ABA_RATING2"in item list page

# 6965694
  @MLP-18156 @webtest @regression @positive
  Scenario:MLP-18156:SC#3_ Verify if multiple users can rate the same Business Application item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_ABA_RATING2" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user gives "4" rating in item view page
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on rating 4 checkbox and get item count
    And user verifies first item "Test_ABA_RATING2"in item list page
    And user clears and enters the text"Test_ABA_RATING3" in search text area
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user gives "3" rating in item view page
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on rating 3 checkbox and get item count
    And user verifies first item "Test_ABA_RATING3"in item list page

    # 6965696 # 6965698
  @MLP-18156 @webtest @regression @positive @e2e
  Scenario:MLP-18156:SC#4_ Verify if Average Rating displays the rating score, if only it has been rated by at least one user
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_ABA_RATING2" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user gives "4" rating in item view page
    And user verifies average rating "4" in business application
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on rating 4 checkbox and get item count
    And user clicks on first item on the item list page
    And user verifies average rating "4" in business application





