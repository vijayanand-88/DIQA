@MLP-1082
Feature:MLP-1082: As a user I want to keep an subject area open when working with notifications, Dashboard or Profile Settings.
  Description: This feature is about verifying warning message for multiple panels in Subject Area

  @MLP-1082 @webtest @subjectAreaWarnings @regression @positive
  Scenario:MLP-1082: To verify warning message is displayed when more than 2 panels are open in Item List page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And  user clicks on logout button
    Then warning message for multiple panels should be displayed
    And user should be able logoff the IDC

  @MLP-1082 @webtest @subjectAreaWarnings @regression @positive
  Scenario:MLP-1082: To verify logout should be successful when warning message is accepted
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And  user clicks on logout button
    And user clicks on Yes button in warning message
    Then logout must be success and display login page

  @MLP-1082 @webtest @subjectAreaWarnings @regression @positive
  Scenario:MLP-1082: To verify user should stay in subject area page when warning message is rejected
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And  user clicks on logout button
    And user clicks on Cancel button in warning message
    Then user validates the title text in left panel is "EDIT ASSIGNED TAGS"
    And user should be able logoff the IDC

  @MLP-1082 @webtest @subjectAreaWarnings @regression @positive
  Scenario:MLP-1082: To verify warning message is displayed for User when more than 2 panels are open in Item List page
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And  user clicks on logout button
    Then warning message for multiple panels should be displayed
    And user should be able logoff the IDC

  @MLP-1082 @webtest @subjectAreaWarnings @regression @positive
  Scenario:MLP-1082: To verify logout should be successful for User when warning message is accepted
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And  user clicks on logout button
    And user clicks on Yes button in warning message
    Then logout must be success and display login page

  @MLP-1082 @webtest @subjectAreaWarnings @regression @positive
  Scenario:MLP-1082: To verify user should stay in subject area page when warning message is rejected
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And  user clicks on logout button
    And user clicks on Cancel button in warning message
    Then user validates the title text in left panel is "EDIT ASSIGNED TAGS"
    And user should be able logoff the IDC

  @MLP-1082 @webtest @subjectAreaWarnings @regression @negative
  Scenario:MLP-1082: To verify warning message is not displayed when 2 panels are open in the Item List page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And  user clicks on logout button
    Then logout must be success and display login page