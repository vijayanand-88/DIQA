@MLP-1541 @crossicon
Feature: MLP-1541 This feature verifies the comments section functionality

  @MLP-1541 @webtest @login  @sanity @positive
  Scenario:To verify the the comments section functionality
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemView_Table" and click on visual composer button
    And User drag and drop a "COMMENTS WIDGET" widget to the page from the displayed widget sets
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on Quickstart Dashoboard
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on anywhere in the comments block
    Then comments section should get displayed
    And user should be able logoff the IDC

  @MLP-1541 @webtest @addingcomments @regression @positive
  Scenario: MLP-1541 Verification of Deleting the item
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemView_Table" and click on visual composer button
    And user removes widget "COMMENTS WIDGET" from the visual composer for the item
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user should be able logoff the IDC