@loginfeature
Feature: This feature verifies the deletion of a page in dashboard

  @webtest @login @positive
  Scenario Outline:To verify the deletion of a page in dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "<Role>" role
    When User clicks on Add(+) button
    And User types title for the new dashboard
    And User drag and drop a "WELCOME" widget to the page from the displayed widget sets
    And User clicks on the plus button displayed below the page in the edit mode
    And User drag and drop a "BigData" widget to the page from the displayed widget in second page
    And user clicks on save button on the dashboard
    And Newly added Dashboard should be displayed on the application
    When User clicks on the dashboard name mentioned in the json config file once
    And User clicks on Edit button
    And user navigates to the second page
    And user removes the "BIGDATA" in the second page
    And user clicks on save button on the dashboard
    Then the pagination of the dashboard should not display
    And User clicks on the dashboard name mentioned in the json config file once
    And user clicks on Delete button

    Examples:
      | Role                 |
      | Information User     |
      | System Administrator |
      | Data Administrator   |




