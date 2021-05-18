#@MLP-5915#usergroupsDescoped
#Feature: MLP-5915: Verification of group to role mapping on repository level overwrites for a certain catalog with a different mapping

#  @MLP-5915 @positive @regression @rolemapping#descoped
#  Scenario:MLP-5915 Verification of getting role details and getting roles for a given role at catalog level
#    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And user makes a REST Call for DELETE request with url "roles/TestRole"
#    And supply payload with file name "idc/MLP-5915_CreateRole.json"
#    And user makes a REST Call for POST request with url "roles"
#    And Status code 204 must be returned
#    And supply payload with file name "idc/MLP-5915_CreateCatalog.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And supply payload with file name "idc/MLP-5915_AddNewRolemappings.json"
#    And user makes a REST Call for PUT request with url "rolemappings"
#    And Status code 204 must be returned
#    And supply payload with file name "idc/MLP-5915_AddNewRolemappings.json"
#    And user makes a REST Call for PUT request with url "rolemappings/catalog/UserGroupCatalog"
#    And Status code 204 must be returned
#    And user makes a REST Call for Get request with url "rolemappings/catalog/UserGroupCatalog"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues     | jsonPath         |
#      | System,Service | $..['userGroup'] |
#    And user makes a REST Call for Get request with url "roles/catalog/UserGroupCatalog/TestRole"
#    And Status code 200 must be returned
#    And user compares the following value from response using json path
#      | jsonValues | jsonPath    |
#      | TestRole   | $..['name'] |
#    And user makes a REST Call for DELETE request with url "settings/catalogs/UserGroupCatalog?deleteData=true"
#
#  @MLP-5915 @positive @regression @rolemapping
#  Scenario:MLP-5915 Verification of getting role details for a given role at catalog level with invalid role
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "roles/catalog/Default/InvalidRole"
#    And Status code 404 must be returned
#    Then response message contains the following values
#      | responseMessage                 |
#      | Role InvalidRole does not exist |
#
#  @MLP-4669 @sanity @regression @rolevisibilitymanagement @positive
#  Scenario:MLP-5920: Creating NOAccess role
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-5915_NoAccess_Role.json"
#    And user makes a REST Call for POST request with url "roles"
#    Then Status code 204 must be returned
#
#  @MLP-5920 @positive @regression @rolemapping
#  Scenario:MLP-5920 Verification of "No Access" role by default
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "roles/NOACCESS"
#    And Status code 200 must be returned
#    Then  response message contains value ""permissions" : [ ]"
#
#  @MLP-5920 @positive @regression @rolemapping
#  Scenario:MLP-5920 Deleting NOAccess role
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "roles/NOACCESS"
#    And Status code 204 must be returned
#
#
#



