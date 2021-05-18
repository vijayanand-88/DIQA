@crossicon
Feature: This feature verifies the dismiss functionality of notification

  @webtest @login  @sanity @positive
  Scenario:To verify the display of Warning message for dismissing a notification
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And user clicks on dismiss for any notification
    Then user clicks on Yes button in warning message
    And the notification should not be present in new Notifications
    And user clicks on logout button


