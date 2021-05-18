@MLP-1616
Feature:MLP-1616: Redesign searchbar in widget

  @MLP-1616 @webtest @positive
  Scenario: MLP-1616 Verification of redesign of Search bar in widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on search icon
    Then user verifies the default search text
    And user clicks on logout button



