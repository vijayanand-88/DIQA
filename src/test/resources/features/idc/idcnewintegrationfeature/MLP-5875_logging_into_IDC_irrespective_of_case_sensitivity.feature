@MLP-5875
Feature: MLP-5875: This feature is to verify the User names by Ldap - provide account name and case in sensitive names

  @MLP-5875 @webtest  @login @regression @positive
  Scenario Outline:Verification of logging into IDC irrespective of case sensitivity
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-5875_BecubicRoleMapping.json"
    When user makes a REST Call for PUT request with url "rolemappings"
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    When  User type username as "<username>" and Password as "<password>"
    Then login must be successful for all users
    And user clicks on logout button

    Examples:
      | username      | password    |
      | BECUBIC_BUILD | laguna-2012 |
      | becubic_build | laguna-2012 |