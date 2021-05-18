@MLP-814
Feature: MLP-814: Review Design and content Item list and view
  Decription: Review of current implementation and improvements ins usability and Content.
  Tasks and acceptance criterias will be created during Review Meetings in this sprint.

  @MLP-814 @webtest @itemlist @regression @positive
  Scenario:MLP-814: Verify item preview page is getting displayed after clicking on any row in the item list page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user click on item type "0" from item list
    Then preview page of that item should get displayed
    And user should be able logoff the IDC

  @MLP-814 @webtest @itemlist  @regression @positive
  Scenario:MLP-814: Verify item full view page is getting displayed after clicking on any item name in the item list page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    Then full view page of that item should get displayed
    And user should be able logoff the IDC

  @MLP-814 @webtest @itemlist @sanity @positive
  Scenario:MLP-814: Verify item list is enabled even after when the item preview page is displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user click on item type "0" from item list
    And user clicks on close button in the item full view page
    And user click on item type "1" from item list
    Then preview page of that item should get displayed
    And user should be able logoff the IDC

#  @MLP-814 @webtest @itemlist @sanity @positive
#  Scenario:MLP-814: Verify navigation panel is enabled even after when the item list page is displayed
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user selects "BigData" catalog from catalog list
#    And user selects the "Table" from the Type
#    And user checks the Data Analysis checkbox in the BigData Subject Area Structure page
#    Then items list page should open with pagination
#    And user should be able logoff the IDC

