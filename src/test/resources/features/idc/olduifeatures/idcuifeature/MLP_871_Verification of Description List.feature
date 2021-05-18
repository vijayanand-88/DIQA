@MLP-259
Feature:MLP-259: This feature is to verify the description are listed in the catalog management panel

  @MLP-259 @webtest @subjectAreaManagement @regression @positive
  Scenario:MLP-259: Verify creation of new Subject Area as a Data Administrator
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    And user clicks on save button in New Subject Area page
    Then description for new cataloger should be displayed
    And user should be able logoff the IDC



