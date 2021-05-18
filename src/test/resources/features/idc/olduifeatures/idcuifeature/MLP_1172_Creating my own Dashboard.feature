@MLP-1172
Feature:MLP-1172: This feature is to verify creating our own Dashboard as an Administrator/Data Administrator/User

  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that System Administrator can create his own dashboard with a title
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on Add(+) button
    And User types title for the new dashboard
    And user clicks on save button on the dashboard
    Then Newly added Dashboard should be displayed on the application
    And user clicks on logout button

  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that Data Administrator can create his own dashboard with a title
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When User clicks on Add(+) button
    And User types title for the new dashboard
    And user clicks on save button on the dashboard
    Then Newly added Dashboard should be displayed on the application
    And user clicks on logout button

  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that Information User can create his own dashboard with a title
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    When User clicks on Add(+) button
    And User types title for the new dashboard
    And user clicks on save button on the dashboard
    Then Newly added Dashboard should be displayed on the application
    And user clicks on logout button

  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that System Administrator can edit the dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on the dashboard name mentioned in the json config file twice
    And User clicks on Edit button
    And User edits the title of the selected dashboard
    And user clicks on save button on the dashboard
    Then the edited value should be updated for the dashboard
    And user clicks on logout button

  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that Data Administrator can edit the dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When user "click" on "QAAutDashBoard" dashboard
    And user "click" on "QAAutDashBoard" dashboard
    And User clicks on Edit button
    And User edits the title of the selected dashboard
    And user clicks on save button on the dashboard
    And user clicks on logout button

  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that Information User can edit the dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    When User clicks on the dashboard name mentioned in the json config file twice
    And User clicks on Edit button
    And User edits the title of the selected dashboard
    And user clicks on save button on the dashboard
    Then the edited value should be updated for the dashboard
    And user clicks on logout button

  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that System Administrator can delete a dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on the dashboard name to be deleted mentioned in the json config file twice
    And user clicks on Delete button
    Then deleted dashboard mentioned in json config file should not get listed
    And user clicks on logout button


  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that Data Administrator can delete a dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When User clicks on the dashboard name to be deleted mentioned in the json config file twice
    And user clicks on Delete button
    Then deleted dashboard mentioned in json config file should not get listed
    And user clicks on logout button

  @MLP-1172 @webtest @dashboard @regression @positive
  Scenario:MLP-1172: To Verify that Information User can delete a dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    When User clicks on the dashboard name to be deleted mentioned in the json config file twice
    And user clicks on Delete button
    Then deleted dashboard mentioned in json config file should not get listed
    And user clicks on logout button