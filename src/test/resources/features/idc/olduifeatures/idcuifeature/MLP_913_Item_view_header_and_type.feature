@MLP-913
Feature: MLP-913: General redesign of the itemview header

  @MLP-913 @webtest @itemlist @sanity @positive
  Scenario:MLP-913: Verify the item header and type is displayed in the item preview page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user selects the "Table" from the Type
    Then user clicks on first item on the item list page and verifies its type in the preview page
    And user clicks on logout button
