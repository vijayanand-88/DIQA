@BugTestCases
Feature: This feature is about all the bugs encountered during IDC9.0 Release

  @webtest @login @negative
  Scenario:Verification of Incorrect Username, Password and no entries message
    Given User launch browser and traverse to login page
    When user enter credentials for "Invalid Administrator" role
    Then login must be failed and display error message

  @webtest @login @negative
  Scenario:MLP-1456_Verification of creating subject area with out name
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Invalid Name"
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and special characters are forbidden."

  @webtest @login @positive
  Scenario:Verification of selection box on top should be by default restricted to the catalog search
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    Then "BigData" should be displayed in the serach catalog dropdown

#  @webtest @login
#  Scenario:Verification of warning message while changing a Subject Area name in the widget
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user edits the BigData Widget
#    And user mouse hovers on the warning message icon
#    Then "This changes will be only for dashboard widget" should get displayed as a tool tip


#  @webtest @login
#  Scenario:MLP-1459_Verification of Save button
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And User click on Subject Area Manager link on the Dashboard page
#    And user clicks on Create Button in Subject Area Management page
#    Then The user verifies the Save button is disabled on the New Catalog panel
#    And user clicks on home button
#    And user click on Ingestion Configurations link
#    And user click on create button
#    Then The user verifies the Save button is disabled on the New Catalog panel

  @webtest @login @positive
  Scenario:Verification of drop down list refresh in the search area
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    And user clicks on choose icon button in new Subject Area page
    And user selects any icon for the subject area in Subject Area Icon page
    And user clicks on save button in New Subject Area page
    Then created subject area should get displayed under Subject Areas in the Subject Area Management page
    And user clicks on mentioned Subject Area to be deleted "Test Data1" in json config file
    And user clicks on Delete button in the New Subject Area page
    Then deleted subject area mentioned in json config file should not get listed
    And deleted subject area should not get listed in the serach catalog dropdown
    And user should be able logoff the IDC



