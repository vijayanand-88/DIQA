Feature: MLP-1504 Rename of Tag facets

  @webtest @positive
  Scenario: MLP-1504 Validate visibility of tag facet after adding an item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user click on any of the item and assign "Trustworthy" tag to the item.
    And user refreshes the application
    And user selects the "Table" from the Type
    Then user validate whether the "Trustworthy" tag is listed in Tag facet
    And user enables tag facet checkbox
    And user click on item and unassign the tag from item

  @webtest @positive
  Scenario: MLP-1504 Validate invisibility of tag facet after removing from an item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user click on any of the item and assign "Trustworthy" tag to the item.
    And user refreshes the application
    And user selects the "Table" from the Type
    And user enables tag facet checkbox
    And user click on item and unassign the tag from item
    And user refreshes the application
    Then user validate whether the "Trustworthy" tag is removed from Tag facet

