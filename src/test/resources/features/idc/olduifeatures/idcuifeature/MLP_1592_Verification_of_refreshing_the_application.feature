@MLP-1592
Feature:MLP-1592: Verify that the application refreshes and should not throw 404 error.
  #Author: Venkata Sai

  @MLP-1592 @webtest @Views @regression @positive
  Scenario:MLP-1592: Verification of refreshing the application
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    Then login must be success and display dashboard
    And user refreshes the application
    Then login must be success and display dashboard
