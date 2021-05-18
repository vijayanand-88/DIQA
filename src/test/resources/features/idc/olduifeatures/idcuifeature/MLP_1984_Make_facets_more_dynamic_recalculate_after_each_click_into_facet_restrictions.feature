@MLP-1984

Feature:MLP-1984: Make facets more dynamic / recalculate after each click into facet restrictions
  Description: Facets should be re-calculated after each click on a facet restriction to avoid empty results. (Baur-like search https://www.baur.de/)
  The search service already re-calculates the item counters for facets each time you search for items. The task is just to use this information each time you click on a facet to refresh the UI.
  Some background info to understand what happens: The item counters of a facet are the result of the conditions of all other facets. Assuming we have n facets then the n-1 other facet conditions are used to calculate the item counters for facet n. So, each time we search, the facet algorithm in service runs internally n times with the n-1 other facet conditions to determine item counters for facets.
# Author: Venkata Sai

  @MLP-1984 @webtest @sanity @positive
  Scenario:MLP-1984: Verification zero item counters
    Given Delete all records in the table "E_rating"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And user clicks on search icon
    And user selects the "Column" from the Type
    And item counters should be present for each facet
    And user click on any of the item and assign "Trustworthy" tag to the item.
    And user refreshes the application
    And user click Show All button in Tag facets
    Then user validate whether the "Trustworthy" tag is listed in Tag facet
    And user checks the child checkbox "Trustworthy" in Tags
#    And user click Show All button in type facets
    And user checks the checkbox for "Column" in Type
#    And user checks the checkbox for "Cluster Demo [Cluster]" in Parent hierarchy
    And user clicks on first item name link on the item list page
    And user gives "4" rating to the clicked item
    And user clicks on close button in the item preview page
    And user refreshes the application
    Then "Rating" facet should be present
    And "Date Modified" facet should be present

  @MLP-1984 @webtest @sanity @positive
  Scenario:MLP-1984: Verification of un checking the checked facet item
    Given Delete all records in the table "E_rating"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user click Show All button in Tag facets
    And user checks the child checkbox "Trustworthy" in Tags
    And user unchecks the child checkbox "Trustworthy" in Tags
    Then items list page should open with pagination

