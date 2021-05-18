@MLP-1758
Feature:MLP-1758: This feature is to verify Error validation for Duplicate Cataloger

  @MLP-1758 @webtest @subjectArea @negative
  Scenario:MLP-1719: Verification of error message handling while creating a catalog with leading blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    And user clicks on save button in New Subject Area page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    Then Error message should be displayed as "A catalog with this name already exists. Please enter a different name."
    And The user verifies the Save button is disabled on the New Catalog panel
    And user clicks on logout button
    And user clicks on Yes button in warning message

#  @MLP-1758 @webtest @subjectArea @negative
#  Scenario:MLP-1719: Verification of error message handling while creating a catalog with leading blanks
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Administrator" role
#    And user clicks on Administration widget
#    And User click on Subject Area Manager link on the Dashboard page
#    And user clicks on Create Button in Subject Area Management page
#    And user enters Name and Description of New Subject Area using json config "Test Data1"
#    And user clicks on save button in New Subject Area page
#    And user clicks on Create Button in Subject Area Management page
#    And user enters Name and Description of New Subject Area using json config "Test Data1"
#    Then Error message should be displayed as "A catalog with this name already exists. Please enter a different name."
#    And The user verifies the Save button is disabled on the New Catalog panel
#    And user clicks on logout button
#    And user clicks on Yes button in warning message

  @MLP-1758 @webtest @subjectArea @negative
  Scenario:MLP-1719: Verification of error message handling while creating a catalog with leading blank
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    And user clicks on save button in New Subject Area page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    Then Error message should be displayed as "A catalog with this name already exists. Please enter a different name."
    And The user verifies the Save button is disabled on the New Catalog panel
    And user clicks on logout button
    And user clicks on Yes button in warning message

