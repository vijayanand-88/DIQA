@MLP-836
Feature: MLP-836: As a User I want to see item content
  Decription: User can Access an item Detail view via the preview and detail view panel. The view is defined by
  Navigation area for Topics with the Option to jump to the area of interest
  Header area with item and Quality Information
  Information area, which is defined by a selection of components
  assigned tags
  creation and update Information
  item content

  @MLP-836 @webtest @itemlist @sanity @positive
  Scenario:MLP-836: Verify the close button functionality of the item full view page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on close button in the item full view page
    Then items list page should open with pagination
    And user should be able logoff the IDC

  @MLP-836 @webtest @itemlist @sanity @positive
  Scenario:MLP-836: Verify the display of access points in the item full view page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user enters the search text for table and clicks on search
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user clicks on first item on the item list page
    Then access points should get displayed in the item full view page
    And user should be able logoff the IDC

