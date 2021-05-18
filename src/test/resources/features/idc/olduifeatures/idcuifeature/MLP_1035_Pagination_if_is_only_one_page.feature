@MLP-1035
Feature: MLP-1035: remove the navigation buttons into the pagination if it is only one page in the itemlist.
  Description: If the itemlist contains only one page the forward, backward buttons of the navigation should not displayed


  @MLP-1035 @webtest @pagination @sanity @positive
  Scenario:MLP-1035: Verify whether the pagination option is not getting displayed in the Item List page when there is only one page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user checks the checkbox for "Service" in Type
    Then items list page should open with out pagination if there is only one page
    And user should be able logoff the IDC

  @MLP-1035 @webtest @pagination @sanity @positive
  Scenario:MLP-1035: Verify whether the displayed page is highlighted when there is no pagination
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user checks the checkbox for "Service" in Type
    Then items list page should open with out pagination if there is only one page
    And the one page without pagination should be highlighted
    And user should be able logoff the IDC
