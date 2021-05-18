@MLP-650
Feature:MLP-650: As a User I want to see notifications on the DIS UI
  Description: In the IDC UI there is an entry point to open the list of notifications. the user can open and delete notifications.

  @MLP-650 @webtest @notifications @sanity  @positive
  Scenario:MLP-650: Verify notification icon in the dashboard page
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    Then notifications icon should display in the left panel
    And user clicks on logout button

  @MLP-650 @webtest @notifications @sanity @positive
  Scenario:MLP-650: Verify notification list with newer and older notifications displays on clicking the notification icon in the dashboard page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on notification icon in the left panel
    Then notification list with newer and older notifications should get displayed
    And user clicks on logout button

  @MLP-650 @webtest @notifications @regression @positive
  Scenario:MLP-650: Verify whether the user is able to open the notification and view the subject area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "/settings/catalogs/qaTestTag"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Catalog manager
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data3"
    And user clicks on save button in New Subject Area page
    When user clicks on notification icon in the left panel
    And user clicks on first open area link in all notification
    Then user validates the title text in left panel is "SEARCH IN "QATESTTAG"
    And user clicks on home button
    And user clicks on Administration widget
    And user clicks on Catalog manager
    And user clicks on mentioned Subject Area to be deleted "qaTestTag" in json config file
    And user clicks on Delete button in the New Subject Area page
    And user clicks on logout button

  @MLP-650 @webtest @notifications @regression @positive
  Scenario:MLP-650: Verify whether the time stamp is getting displayed in the notifications
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on notification icon in the left panel
    Then notification list should get displayed with time stamp
    And user clicks on logout button

  @MLP-650 @webtest @notifications @regression @positive
  Scenario:MLP-650: Verify mark all read button functionality in the notifications tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on notification icon in the left panel
    And user clicks on mark all read button in the notifications tab
    Then new notifications list should be empty
    And user clicks on logout button

  @MLP-650 @webtest @notifications @regression @positive
  Scenario:MLP-650: Verify dismiss all button functionality in the notifications tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on notification icon in the left panel
    And user clicks on dismiss all button in the notifications tab
    Then new and old notifications list should be empty
    And user clicks on logout button
