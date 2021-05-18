@Examples
Feature: MLP-12784:This feature file to add/update/Delete users to groups

  ##6778219##
  @MLP-12784  @regression @positive
  Scenario: Verify the user is able to GET  /managedusers/groups
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/managedusers/groups?username=TestSystem"
    Then Status code 200 must be returned
    And response message contains value "System"

  ##6778221##
  @MLP-12784 @regression @positive
  Scenario: Verify the user is able to GET  /managedusers/users
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/managedusers/users"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['username']"
      | jsonValues    |
      | TestDataAdmin |
      | TestGuestUser |
      | TestSystem    |

  ##6778222## ##6779993##
  @MLP-12784  @regression @positive
  Scenario: Verify is user able to POST new user via POST /managedusers/users and verify it in DB
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc\MLP-12784_users.json"
    And user makes a REST Call for POST request with url "managedusers/users"
    Then Status code 204 must be returned
    And user get the column "Teststory" id from the following query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | users     | id         | username     |

  ##6778223##
  @MLP-12784  @regression @positive
  Scenario: Verify the user is able to get particular user via GET /managedusers/users/{username}
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "managedusers/users/Teststory"
    Then Status code 200 must be returned
    And response message contains value "Teststory"

  ##6778224##
  @MLP-12784  @regression @positive
  Scenario: Verify the user is able to update the existing user details via PUT /managedusers/users/{username}
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc\MLP-12784_userupdate.json"
    And user makes a REST Call for PUT request with url "managedusers/users/Teststory"
    Then Status code 204 must be returned

  ##6778220##
  @MLP-12784  @regression @positive
  Scenario: Verify is able to update the groups via PUT /managedusers/groups
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc\MLP-12784_usergroups.json"
    And user makes a REST Call for PUT request with url "managedusers/groups"
    Then Status code 204 must be returned

  ##6779994##
  @MLP-12784  @regression
  Scenario: Verify the user is able to view not found error message when user tries to fetch invalid users
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "managedusers/users/Invaliduser"
    Then Status code 404 must be returned
    And response message contains value "User Invaliduser not found"

  ##6778225##
  @MLP-12784  @regression @positive
  Scenario:Verify the user is able to Delete the user via DELETE /managedusers/users/{username}
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "/managedusers/users/Teststory"
    Then Status code 204 must be returned