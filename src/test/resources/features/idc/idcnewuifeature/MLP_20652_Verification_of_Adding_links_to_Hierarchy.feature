@MLP-20652 @MLP-20553
Feature:MLP-20652: This feature is to verify the adding links to hierarchy

   ##7026010##
  @MLP-20652 @webtest @regression @positive
  Scenario: SC1#:MLP-20652: Verify the user is able to view the hierarchy as link in item vie
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                       | ActionItem |
      | Verify Hierarchy items are links |            |

    ##7026011##7026013##
  @MLP-20652 @webtest @regression @positive
  Scenario: SC2#:MLP-20652: Verify the user is able to click the item from hierarchy component
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                       | ActionItem |
      | Verify Hierarchy items are links |            |
    And User performs following actions in the Item view Page
      | Actiontype           | ActionItem   |
      | Click Hierarchy link | Cluster Demo |
    Then user performs click and verify in new window
      | Table         | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Data Packages | Cluster Demo | verify widget contains | No               |             |

   ##7026014##7026446##
  @MLP-20652 @webtest @regression @positive
  Scenario: SC3#:MLP-20652: Verify the selected item in search results is highlighted with green color
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customers" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "firstItemCheckbox" button in "Item Search Results" page
    And User performs following actions in the Item view Page
      | Actiontype                          | ActionItem |
      | verify selected Item is Highlighted |            |
    And user "click" on "firstItemCheckbox" button in "Item Search Results" page
    And User performs following actions in the Item view Page
      | Actiontype                                | ActionItem |
      | verify unselected Item is not Highlighted |            |

  ##7026024##7026025##
  @MLP-20553 @webtest @regression @positive
  Scenario: SC#4:20553: Verify the user is able to view policies menu in admin page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"

  ##7026039##7026040##
  @MLP-20553 @webtest @regression @positive
  Scenario: SC#5:20553: Verify the user is able to navigate to corresponding page by clicking the sub menus
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user verifies the "Trust Policy" pop up is "displayed"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Trust Policy |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Trust Policy |

  ##7026042## ##Descoped##
#  @MLP-20553 @webtest @regression @positive
#  Scenario: SC6#:MLP-20553: Verify only admin user has the right to view the Policy menu
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Admin" role
##    And user clicks on "Close popup" link in the "Landing page when logged in as Data Admin"
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Trust Policy  |
#    And user verifies the "ERROR" pop up is "displayed"







