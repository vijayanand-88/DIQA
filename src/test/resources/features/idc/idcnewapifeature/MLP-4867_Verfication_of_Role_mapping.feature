@MLP-4867
Feature: MLP-4867 - Verification of role mapping for existent and non-existent roles

  @MLP-4867 @regression @positive
  Scenario:MLP-4867 Verification of GET/roles/{roleName} with exitsing role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for Get request with url "roles/GUEST_USER"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    Then response of user groups should match with "idc/MLP_4867_user_permissions_list.json"

  @MLP-4867 @regression @negative
  Scenario:MLP-4867 Verification of GET/roles/{roleName} for incorrect role name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for Get request with url "roles/ADMIN"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 404             |
    Then user compares the value from response using json path "$['errorMessage']"
      | jsonValues                  |
      | "Role ADMIN does not exist" |

  @MLP-4867 @regression @negative
  Scenario:MLP-4867 Verification of PUT/roles/{roleMapping} for non existent role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for PUT request with url "roles/TEST"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 404             |
    Then user compares the value from response using json path "$['errorMessage']"
      | jsonValues                 |
      | "Role TEST does not exist" |

  @MLP-4867 @regression @positive
  Scenario:MLP-4867  Verification of PUT/roles/{roleMapping} for the existing role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP_4867_role_creation_with_base_permission.json"
    When user makes a REST Call for POST request with url "roles"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 204             |
    And supply payload with file name "idc/MLP_4867_role_updation.json"
    When user makes a REST Call for PUT request with url "roles/Test%20User"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 204             |
    Then user makes a REST Call for Get request with url "roles/Test%20User"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    And response message contains the following values
      | responseMessage   |
      | "BASE_PERMISSION" |
      | "TAG_SUGGEST"     |
      | "TAG_CREATE"      |
#    And user compares the value from response using json path "$['permissions']"
#      | jsonValues                                   |
#      | "BASE_PERMISSION","TAG_SUGGEST","TAG_CREATE" |

  @MLP-4867 @regression @negative
  Scenario:MLP-4867 Verification of DELETE/role/{roleMapping} for existing role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "roles/Test%20User"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 204             |
    Then user makes a REST Call for Get request with url "roles"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    Then response message not contains value "Test User"

  @MLP-4867 @regression @negative
  Scenario:MLP-4867 Verification of DELETE/roles/{roleMapping} for non-existent role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "roles/TEST"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 404             |
    Then user compares the value from response using json path "$['errorMessage']"
      | jsonValues                 |
      | "Role TEST does not exist" |

  @MLP-4867 @regression @positive
  Scenario:MLP-4867 Verification of creating roleMapping TEST_USER
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP_4867_role_creation_with_base_permission.json"
    When user makes a REST Call for POST request with url "roles"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 204             |
    Then user makes a REST Call for Get request with url "roles/Test%20User"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    Then response message contains value "Test User"
    When user makes a REST Call for DELETE request with url "roles/Test%20User"
    And Status code 204 must be returned

  @MLP-2787 @regression @positive
  Scenario:MLP-2787 Verification of setting/health service
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    Then user makes a REST Call for Get request with url "health"
    And response returns with the following items
      | description | searchItems | expectedResults |
      | Status Code |             | 200             |
    Then Json response message should contains the following value
      | responseMessage |
      | PlatformHealth  |
      | postgreSQLInfo  |
      | solrInfo        |
      | tomcatInfo      |
      | RabbitMQ        |
