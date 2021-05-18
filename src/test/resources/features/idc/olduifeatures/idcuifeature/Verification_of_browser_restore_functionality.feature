@loginfeature
Feature: This featureverifies the functionality of browser restore button

  @webtest @login @positive
  Scenario:To verify the secure connection of IDC URL in chrome
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And user clicks on Quickstart Dashoboard
    And User clicks on Edit button
    And user minimizes the browser window
    And user clicks on navigation bar toggle  button
    Then all the widgets should get aligned properly for the minimized window

