@MLP-4761

Feature: MLP-4761: This feature is to verify the Services for Role/Permission assignments

  @MLP-4761 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of getting all known permissions
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a REST Call for Get request with url "permissions"
    And Status code 200 must be returned
    Then user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues          |
      | ADMIN_ANALYSIS      |
      | ADMIN_COMPONENTS    |
      | ADMIN_DASHBOARD     |
      | ADMIN_DERIVED_ATTS  |
      | ADMIN_DIAGRAM       |
      | ADMIN_EVENTS        |
      | ADMIN_EXTENSIONS    |
      | ADMIN_ITEM_VIEWS    |
      | ADMIN_NOTIFICATIONS |
      | ADMIN_QUERIES       |
      | ADMIN_SEARCH        |
      | ADMIN_SECURITY      |
      | ADMIN_STRUCTURE     |
      | ADMIN_TRUST         |
      | ADMIN_WIDGETS       |
      | ADMIN_XML_SCHEMA    |
      | BASE_PERMISSION     |
      | DATA_CREATE         |
      | DATA_DELETE         |
      | DATA_MODIFY         |
      | DATA_TAG            |
      | IMPORT_CREATE       |
      | IMPORT_DELETE       |
      | IMPORT_MODIFY       |
      | TAG_CREATE          |
      | TAG_DELETE          |
      | TRIGGER_ANALYSIS    |
      | TRIGGER_IMPORT      |


  @MLP-4761 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of getting all existing role details at tenant level
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a REST Call for Get request with url "roles/tenant"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues   |
      | DATA_ADMIN   |
      | GUEST_USER   |
      | SYSTEM_ADMIN |

  @MLP-4761 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of getting a role details for a given role at tenant level
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a REST Call for Get request with url "roles/tenant/DATA_ADMIN"
    Then Status code 200 must be returned
    And response body should have "DATA_ADMIN" message
    Then user verifies whether the value is present in response using json path "$..['permissions']"
      | jsonValues      |
      | DATA_TAG        |
      | BASE_PERMISSION |
      | TAG_DELETE      |
      | TAG_CREATE      |
      | DATA_MODIFY     |


  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4761: Verification of creating a Role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a REST Call for DELETE request with url "roles/NEW_ROLE"
    And supply payload with file name "idc/MLP-4761_RoleCreation.json"
    When user makes a REST Call for POST request with url "roles"
    Then Status code 204 must be returned

  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4761: Verification of fetching details of a specific role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a REST Call for Get request with url "roles/NEW_ROLE"
    Then Status code 200 must be returned
    And response body should have "NEW_ROLE" message

  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4761: Verification of modifying a role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-4761_UpdateRoleCreation.json"
    When user makes a REST Call for PUT request with url "roles/NEW_ROLE"
    Then Status code 204 must be returned

  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4761: Verification of deleting a role
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "roles/NEW_ROLE"
    Then Status code 204 must be returned

  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4761: Verification of adding role details for a role at tenant level
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-4761_TenantRoleCreation.json"
    When user makes a REST Call for POST request with url "roles/tenant"
    Then Status code 204 must be returned

  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4761: Verification of updating a role details for a given role at tenant level
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-4761_UpdateTenantRoleCreation.json"
    When user makes a REST Call for PUT request with url "roles/tenant/TENANT_ROLE"
    Then Status code 204 must be returned

  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4761: Verification of deleting a role details for a role at tenant level
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "roles/tenant/TENANT_ROLE"
    Then Status code 204 must be returned

  @MLP-4669 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4669: Verification of fetching role mappings at repository level
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for Get request with url "rolemappings?rolename=GUEST_USER"
    Then Status code 200 must be returned
    And response message contains value "GUEST_USER"
    And response message contains value "TestGuestUser"

  @MLP-4669 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4669: Verification of updating a Role which doesn't exist
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-4761_UpdateRoleCreation.json"
    When user makes a REST Call for PUT request with url "roles/NEW_ROLE"
    Then Status code 404 must be returned
    And response message contains value "Role NEW_ROLE does not exist"

  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4761: Verification of Deleting a role which is not existing
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "roles/newrole"
    Then Status code 404 must be returned
    And response message contains value "Role newrole does not exist"

  @MLP-4669 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4669: Verification of checking the response for a Role which is not existing
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for Get request with url "roles/testengineer"
    Then Status code 404 must be returned
    And response message contains value "Role testengineer does not exist"

  @MLP-4761 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of fetching all role details
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a REST Call for Get request with url "roles"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues   |
      | DATA_ADMIN   |
      | GUEST_USER   |
      | SYSTEM_ADMIN |
