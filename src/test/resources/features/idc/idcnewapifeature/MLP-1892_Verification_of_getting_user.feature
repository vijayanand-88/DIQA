@MLP-1892
Feature: MLP-1892: This feature is for verifying getUser and getTenant service doesn't return wrong format

  Description:
  To verify the security services GET /user and GET /tenant return a simple string

  @positive
  Scenario:MLP-1892: Verification of getting system user
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    When user makes a REST Call for Get request with url "users"
    Then Status code 200 must be returned
    And response message should contain username as "TestSystem"

  @positive
  Scenario:MLP-1892: Verification of getting guest user
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdEd1ZXN0VXNlcjpHdWVzdFVzZXI= |
      | Content-Type  | application/json                       |
      | Accept        | application/json                       |
    When user makes a REST Call for Get request with url "users"
    Then Status code 200 must be returned
    And response message should contain username as "TestGuestUser"






