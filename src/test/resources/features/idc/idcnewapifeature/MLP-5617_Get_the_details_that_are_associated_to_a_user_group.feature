#@MLP-5617#usergroupsDescoped
#Feature: MLP-5617: This feature is to verify the details that are associated to a user group

#  @MLP-5617 @sanity @regression @rolevisibilitymanagement @positive#descoped
#  Scenario:MLP-5617: Verification of getting rolemappings for new userGroup
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-4761_RoleCreation.json"
#    When user makes a REST Call for POST request with url "roles"
#    Then Status code 204 must be returned
#    And supply payload with file name "idc/MLP-5617_GroupRoleMapping.json"
#    And user makes a REST Call for PUT request with url "rolemappings"
#    Then Status code 204 must be returned
#    And user makes a REST Call for Get request with url "rolemappings?usergroup=Testing%20Dept"
#    Then Status code 200 must be returned
#    And response body should have "NEW_ROLE" message
#    And response body should have "Testing Dept" message


#  @MLP-4761 @sanity @regression @rolevisibilitymanagement @positive#descoped
#  Scenario:MLP-5617: Verification of deleting role mappings
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    When user makes a REST Call for DELETE request with url "rolemappings?rolename=NEW_ROLE&usergroup=Testing%20Dept"
#    Then Status code 204 must be returned
#    When user makes a REST Call for DELETE request with url "roles/NEW_ROLE"
#    Then Status code 204 must be returned

#  @MLP-5617 @sanity @regression @rolevisibilitymanagement @positive#descoped
#  Scenario:MLP-5617: Verification of assigning existing role for new usergroup
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    When supply payload with file name "idc/MLP-5617_SystemAdminNewRoleMapping.json"
#    And user makes a REST Call for PUT request with url "rolemappings"
#    Then Status code 204 must be returned
#    And user makes a REST Call for Get request with url "rolemappings?rolename=SYSTEM_ADMIN"
#    And response body should have "Testing Dept" message
#
#





