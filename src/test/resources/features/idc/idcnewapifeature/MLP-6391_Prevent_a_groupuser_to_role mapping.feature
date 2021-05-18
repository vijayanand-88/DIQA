@MLP-6391
Feature: MLP-6391: This feature is to verify the RoleMapping are no longer additive between levels, No role definition on catalog level

  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-6391: Deleting TestSystem role mappings/tenant
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "rolemappings/tenant?username=TestSystem"
    Then Status code 204 must be returned

#  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive#descoped
#  Scenario:MLP-6391: Verification of rolemappings tenant level to prevent a User
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-6391_PreventAccess.json"
#    When user makes a REST Call for PUT request with url "rolemappings/tenant?usergroup=System"
#    Then Status code 403 must be returned
#    And response message contains value "Access denied to perform this operation"

#  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive#descoped
#  Scenario:MLP-6391: Verification of rolemappings at catalog level to prevent a User
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-6391_PreventAccess.json"
#    When user makes a REST Call for PUT request with url "rolemappings/catalog/Default?usergroup=System"
#    Then Status code 403 must be returned
#    And response message contains value "Access denied to perform this operation"

#  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive#descoped
#  Scenario:MLP-6391: Verification of PUT_rolemappings to prevent a User
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-6391_PreventAccess.json"
#    When user makes a REST Call for PUT request with url "rolemappings?usergroup=System"
#    Then Status code 403 must be returned
#    And response message contains value "Access denied to perform this operation"

  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-6391: Verification of POST_rolemappings at tenant level to prevent a User
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-6391_PreventAccess.json"
    When user makes a REST Call for POST request with url "rolemappings/tenant"
    Then Status code 403 must be returned
    And response message contains value "Access denied to perform this operation"

  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-6391: Verification of POST_rolemappings at catalog level to prevent a User
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-6391_PreventAccess.json"
    When user makes a REST Call for POST request with url "rolemappings/catalog/Default"
    Then Status code 403 must be returned
    And response message contains value "Access denied to perform this operation"

  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-6391: Verification of POST_rolemappings to prevent a User
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-6391_PreventAccess.json"
    When user makes a REST Call for POST request with url "rolemappings"
    Then Status code 403 must be returned
    And response message contains value "Access denied to perform this operation"

#  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive#descoped
#  Scenario:MLP-6391: Verification of rolemappings at tenant level to prevent deleting entire role mappings
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    When user makes a REST Call for DELETE request with url "rolemappings/tenant?usergroup=System"
#    Then Status code 403 must be returned
#    And response message contains value "Access denied to perform this operation"

  @MLP-6391 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-6391: Verification of rolemappings to prevent deleting entire role mappings
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "rolemappings"
    Then Status code 403 must be returned
    And response message contains value "Access denied to perform this operation"




