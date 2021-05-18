@MLP-975
Feature:MLP-975: No scroll bar in the itemlist if the view port is reduced. No access the paging
  Description: This feature is about verifying pagination in the items list view

  @MLP-975 @webtest @pagination @sanity @positive
  Scenario:MLP-975: This scenario verifies whether the pagination option is getting displayed in the Item List page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    Then items list page should open with pagination
    And user should be able logoff the IDC

  @MLP-975 @webtest @pagination @sanity @positive
  Scenario:MLP-975: This scenario verifies whether the page is getting highlighted when user clicks on the page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user clicks on any page in the pagination tab
    Then the clicked page should get highlighted
    And user should be able logoff the IDC

  @MLP-975 @webtest @pagination @regression @positive
  Scenario:MLP-975: This scenario verifies whether the next page is getting highlighted and loaded when user clicks on the next button in pagination
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user clicks on "next" button in the pagination
    Then the "next" page should get highlighted and displayed
    And user should be able logoff the IDC

  @MLP-975 @webtest @pagination @regression @positive
  Scenario:MLP-975: This scenario verifies whether the previous page is getting highlighted and loaded when user clicks on the previous button in pagination
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects the BigData catalog from catalog list
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user clicks on "last" button in the pagination
    And user clicks on "previous" button in the pagination
    Then the "previous" page should get highlighted and displayed
    And user should be able logoff the IDC

  @MLP-975 @webtest @pagination @regression @positive
  Scenario:MLP-975: This scenario verifies whether the first page is getting highlighted and loaded when user clicks on the first button in pagination
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects the BigData catalog from catalog list
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user clicks on "next" button in the pagination
    And user clicks on "first" button in the pagination
    Then the "first" page should get highlighted and displayed
    And user should be able logoff the IDC

  @MLP-975 @webtest @pagination @regression @positive
  Scenario:MLP-975: This scenario verifies whether the last page is getting highlighted and loaded when user clicks on the last button in pagination
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects the BigData catalog from catalog list
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user clicks on "last" button in the pagination
    Then the "last" page should get highlighted and displayed
    And user should be able logoff the IDC

