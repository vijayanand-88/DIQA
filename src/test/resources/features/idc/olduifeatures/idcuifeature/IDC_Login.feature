@loginfeature
Feature: This feature is about login functionality to ensure different login works fine
  Also, need to evaluate multiple functionality in login page.


  @webtest
  @login @positive
  Scenario:Login Scenario   - To verify Data administrator login works fine
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    Then login must be success and display dashboard
    And user clicks on logout button

  @webtest  @login @positive
  Scenario:Login Scenario - To verify Information User login works fine
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    Then login must be success for Information User and display dashboard
    And user clicks on logout button

  @webtest  @login @regression @positive
  Scenario Outline:Login Scenario - To verify multiple login works fine for Data Driven test
    Given User launch browser and traverse to login page
    When  User type username as "<username>" and Password as "<password>"
    Then login must be successful for all users
    And user clicks on logout button

    Examples:
      | username        | password    |
      | TestSystem      | System      |
      | TestDataSteward | DataSteward |
      | TestGuestUser   | GuestUser   |
    
  @webtest @MLP-2558 @login @regression @positive
  Scenario Outline: MLP-2558 Verification of New error handling in Login page for username and password
    Given User launch browser and traverse to login page
    When  User type username as "<username>" and Password as "<password>"
    Then login must be failed and display error message

    Examples:
      | username      | password  |
      | TestSystem    | System123 |
      | TestSystem123 | System    |
