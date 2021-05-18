@loginfeature
Feature: This feature verifies the serach widget functionalities



  @webtest @login @positive
  Scenario Outline:To verify the secure connection of IDC URL in chrome
    Given User launch browser and traverse to login page
    When user enter credentials for "<Role>" role
    And user clicks on Quickstart Dashoboard
    And User clicks on Edit button
    Then search widget box should get displayed with tooltip
    And user should be able logoff the IDC
    Examples:
      | Role                 |
      | System Administrator |
      | Data Administrator   |
      | Information User     |

  @webtest @login @positive
  Scenario Outline:To verify the widget serach functionality
    Given User launch browser and traverse to login page
    When user enter credentials for "<Role>" role
    And user clicks on Quickstart Dashoboard
    And User clicks on Edit button
    And user enters the "BigData" text in the search widget box
    Then "BigData" alone shoud get displayed in the Widgets layout
    Examples:
      | Role                 |
      | System Administrator |
      | Data Administrator   |
      | Information User     |



