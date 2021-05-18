@loginfeature
Feature: This featureverifies the secure connection of the IDC URL's



  @webtest @login @positive
  Scenario:To verify the secure connection of IDC URL in chrome
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    Then the connection of the URL must be secure
    And user should be able logoff the IDC

  @webtest  @login @positive
  Scenario:To verify verify the secure connection of IDC Swagger URL in chrome
    Given User launch browser and traverse to IDC Swagger UI login page
    When user enter credentials for "System Administrator1" role in swagger UI
    Then the connection of the URL must be secure
