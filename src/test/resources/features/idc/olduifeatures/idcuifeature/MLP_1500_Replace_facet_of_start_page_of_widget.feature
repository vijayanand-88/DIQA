Feature: Redesign of item hierarchy facets

  @webtest @positive
  Scenario:Validate the search returns only column and table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text in top search text box
    Then user validates the title text in left panel is "SEARCH IN ALL"
    And user clicks on home button
    And user selects the BigData catalog from catalog list
    Then user validates the title text in left panel is "SEARCH IN BIGDATA"

    

