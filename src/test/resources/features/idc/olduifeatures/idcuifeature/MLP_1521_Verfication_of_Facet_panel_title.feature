@MLP-1521
Feature:MLP-1521: Verification of Facet panel and Result panel title

  @MLP-1521 @webtest @positive
  Scenario: MLP-1521 Verification of Facet panel and Result panel title
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on search icon
    Then user verifies the facet panel and result panel title
    And user clicks on logout button



