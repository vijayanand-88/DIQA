@MLP-1278
Feature:MLP-1278: This feature is to verify Pagination on dashboard

  @MLP-1278 @webtest @dashboard @sanity @positive
  Scenario:MLP-1278: To Verify that Pagination feature is displayed on Dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Quickstart Dashoboard
    And User clicks on Edit button
    Then Pagination feature should be displayed on the Dashboard
    And user should be able logoff the IDC

  @MLP-1278 @webtest @dashboard @sanity @positive
  Scenario:MLP-1278: To Verify pagination to last page in the Dashbaord.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Quickstart Dashoboard
    And User clicks on Edit button
    Then Pagination to last page should be successfull
    And user should be able logoff the IDC

  @MLP-1278 @webtest @dashboard @sanity @positive
  Scenario:MLP-1278: To Verify pagination to first page in the Dashbaord.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Quickstart Dashoboard
    And User clicks on Edit button
    Then Pagination to first page should be successfull
    And user should be able logoff the IDC