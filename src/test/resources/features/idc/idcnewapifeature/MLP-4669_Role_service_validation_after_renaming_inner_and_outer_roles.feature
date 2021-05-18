@MLP-4669
Feature: MLP-4669: This feature is to verify the role service after the renaming of inner and outer roles

  @MLP-4669 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4669: Verification of user's role service after renaming outer role to user groups
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for Get request with url "users/usergroups"
    Then Status code 200 must be returned
    And response message contains value "System"

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of Tenant service after renaming inner role to roles
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "users/roles/tenant"
    Then Status code 200 must be returned
    And response body should have "SYSTEM_ADMIN" message

  @MLP-4669 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4669: Verification of setting a rolemapping service after renaming inner role to roles
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-4669_Roles.json"
    And user makes a REST Call for POST request with url "roles"
    Then Status code 204 must be returned
    And supply payload with file name "idc/MLP-4669_RolesAfterRename.json"
    When user makes a REST Call for PUT request with url "rolemappings"
    Then Status code 204 must be returned

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of rolemapping service after renaming inner role to roles
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "rolemappings"
    Then Status code 200 must be returned
    And response body should have "role" message
#    And response body should have "userGroup" message#usergroupsDescoped

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of Delete service for role mapping for System user
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "rolemappings"
    And response message contains value "Access denied to perform this operation"

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of Role service after renaming inner role to roles
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "users/roles"
    Then Status code 200 must be returned
    And response body should have "SYSTEM_ADMIN" message

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of Listing all known roles service after renaming inner roles to roles
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "roles"
    Then Status code 200 must be returned
    Then user verifies whether the value is present in response using json path "$..['roles']..['name']"
      | jsonValues     |
      | DATA_ADMIN     |
      | GUEST_USER     |
      | SYSTEM_ADMIN   |

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of getting roles at catalog level service after renaming inner roles to roles
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "users/roles/catalog/Default"
    Then Status code 200 must be returned
    And response body should have "SYSTEM_ADMIN" message

  @MLP-4669 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4669: Verification of rolemapping for tenant service after renaming inner role to roles with System User
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-4669_RolesAfterRename.json"
    When user makes a REST Call for PUT request with url "rolemappings/tenant"
    Then Status code 204 must be returned

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of rolemapping for tenant service
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "rolemappings/tenant"
    Then Status code 200 must be returned
    And response body should have "role" message
#    And response body should have "userGroup" message#usergroupsDescoped

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of Delete service for role mapping
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "rolemappings/tenant"
    And response message contains value "Access denied to perform this operation"


  @MLP-4669 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-4669: Verification of rolemapping for tenant service after renaming inner role to roles
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-4669_RolesAfterRename.json"
    When user makes a REST Call for PUT request with url "rolemappings/catalog/Default"
    Then Status code 204 must be returned

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of rolemapping for catalog with catalogname
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "rolemappings/catalog/Default"
    Then Status code 200 must be returned
    And response body should have "role" message
#    And response body should have "userGroup" message#usergroupsDescoped

  @MLP-4669 @sanity @regression @rolevisibilitymanagement
  Scenario: Verification of rolemapping for catalog with catalogname
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "rolemappings/catalog/Default"
    Then Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "roles/NEW_ROLE"
    Then Status code 204 must be returned