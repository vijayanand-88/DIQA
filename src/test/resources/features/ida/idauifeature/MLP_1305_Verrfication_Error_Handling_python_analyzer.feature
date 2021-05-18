@MLP-1305
Feature: MLP-1305: As a User I want to see properties of source tree.
  Decription: User can Access an item Detail view via the preview and detail view panel. The view is defined by
  Navigation area for Topics with the Option to jump to the area of interest
  Header area with item and Quality Information
  Information area, which is defined by source tree with syntax error details

  @MLP-1304 @webtest @positive
  Scenario:MLP-1305: Verify the source tree properties are displayed on detail view panel.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    When user clicks on Analysis widget title link in the dashboard page
    And user clicks on quicklink report on the Analysis Subject Area Structure page
    And user clicks on file mentioned in json config file from quick link page
    And user clicks on source tree of file mentioned in json config file from the item list page.
    Then items list page should open with pagination and source tree properties should have syntax error
    And user clicks on close button in the item full view page
    And user should be able logoff the IDC