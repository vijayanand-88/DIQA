@MLP-1501
Feature:MLP-1501:Redesign catalog facet

  @MLP-1501 @webtest @positive
  Scenario: MLP-1501 Verification of redesign of catalog facet
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the solr search query name and clicks on search
      | queryName |
      | customers |
    Then facet header catalog should be displayed
    And user clicks on home button
    And user selects "BigData" catalog from catalog list
    When user enters the solr search query name and clicks on search
      | queryName |
      | customers |
    Then facet header catalog should not be displayed
    And user clicks on logout button



