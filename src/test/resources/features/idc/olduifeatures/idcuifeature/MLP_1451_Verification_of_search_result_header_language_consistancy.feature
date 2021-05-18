@crossicon
Feature: MLP-1451 This feature verifies search result header language consistancy

  @webtest @login  @sanity @positive
  Scenario: MLP-1451: To verify the search result header language consistancy
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user checks the checkbox for "Column" in Type
    And user clicks on first item on the item list page
    Then the fields NAME,TYPE and TAGS should be in capitals
