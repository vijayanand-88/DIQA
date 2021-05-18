@MLP-1937
Feature:MLP-1937: This feature is to verify new Administration dashboard is present for System Admins

  @MLP-1937 @webtest @dashboard @regression @positive
  Scenario:MLP-1937: To Verify that TestService is having Administration Dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    Then all available widgets should be displayed
    And user should be able logoff the IDC

  @MLP-1937 @webtest @dashboard @regression @positive
  Scenario:MLP-1937: To Verify that TestSystem is having Administration Dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    Then all available widgets should be displayed
    And user should be able logoff the IDC

  @MLP-1937 @webtest @dashboard @regression @positive
  Scenario:MLP-1937: To Verify that Data Administrator is having Administration Dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    Then Administration dashboard is "not displayed"
    And user should be able logoff the IDC

  @MLP-1937 @webtest @dashboard @regression @positive
  Scenario:MLP-1937: To Verify that Information User is not having Administration Dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    Then Administration dashboard is "not displayed"
    And user should be able logoff the IDC


