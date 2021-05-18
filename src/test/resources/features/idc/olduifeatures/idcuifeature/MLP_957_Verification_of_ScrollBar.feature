@MLP-957
Feature:MLP-957: This feature is to verify the scroll bar functionality
#Author : Sunil Kumar Ketha

  @MLP-957 @webtest @regression @negative
  Scenario:MLP-957: Verification of scroll bar when more panels are displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    Then user should not see the horizantal scroll bar
    And user should be able logoff the IDC

  @MLP-957 @webtest @regression @positive
  Scenario:MLP-957: Verification of whether the user can see the table name in the footer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on column type in the "COLUMNS" table
    And user should scroll to the left of the screen
    Then user should see the Item's Name from the previous results in the scroll bar
    And user should be able logoff the IDC

  @MLP-957 @webtest @regression @positive
  Scenario:MLP-957: Verification of whether the user can scroll towards left and Right Directions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on column type in the "COLUMNS" table
    And user should scroll to the left of the screen
    Then user should see the Item's Name from the previous results in the scroll bar
    And user should scroll to the right of the screen
    Then user should see the Results Pane in the scroll bar
    And user should be able logoff the IDC