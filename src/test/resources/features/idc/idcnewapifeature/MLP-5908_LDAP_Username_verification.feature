@MLP-5908
Feature: MLP-5908: Verification of getting usernames from LDAP

  @MLP-5908 @regression @positive @userdetails
  Scenario:MLP-5908 Verification of getting the user details for the account names (Mix of  upper and lower cases) from LDAP
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc\MLP-5875_BecubicRoleMapping.json"
    When user makes a REST Call for PUT request with url "rolemappings"
    And Status code 204 must be returned
    And user add "becubic_BUILD" JsonArray value in payload "idc/MLP-5908_Usernames.json" to "0" index
    And supply payload with file name "idc\MLP-5908_Usernames.json"
    And user makes a REST Call for POST request with url "usergroups/userdetails"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues            | jsonPath       |
      | Becubic Build         | $..['name']    |
      | becubic_build         | $..['account'] |
      | becubic_build@asg.com | $..['email']   |
    And response message contains value "avatar"
    And user add "BEcubIc_BuILd" JsonArray value in payload "idc/MLP-5908_Usernames.json" to "0" index
    And supply payload with file name "idc\MLP-5908_Usernames.json"
    And user makes a REST Call for POST request with url "usergroups/userdetails"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues            | jsonPath       |
      | Becubic Build         | $..['name']    |
      | becubic_build         | $..['account'] |
      | becubic_build@asg.com | $..['email']   |
    And response message contains value "avatar"

  @MLP-5908 @regression @positive @userdetails
  Scenario:MLP-5908 Verification of getting the user details for the account names (Lower Case) from LDAP
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user add "becubic_build" JsonArray value in payload "idc/MLP-5908_Usernames.json" to "0" index
    And supply payload with file name "idc\MLP-5908_Usernames.json"
    And user makes a REST Call for POST request with url "usergroups/userdetails"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues            | jsonPath       |
      | Becubic Build         | $..['name']    |
      | becubic_build         | $..['account'] |
      | becubic_build@asg.com | $..['email']   |
    And response message contains value "avatar"

  @MLP-5908 @regression @positive @userdetails
  Scenario:MLP-5908 Verification of getting the user details for the account names (Upper Case) from LDAP
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user add "BECUBIC_BUILD" JsonArray value in payload "idc/MLP-5908_Usernames.json" to "0" index
    And supply payload with file name "idc\MLP-5908_Usernames.json"
    And user makes a REST Call for POST request with url "usergroups/userdetails"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues            | jsonPath       |
      | Becubic Build         | $..['name']    |
      | becubic_build         | $..['account'] |
      | becubic_build@asg.com | $..['email']   |
    And response message contains value "avatar"


  @MLP-5908 @regression @positive @userdetails
  Scenario:MLP-5908 Verification validating the response for an incorrect account names
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user add "becubic" JsonArray value in payload "idc/MLP-5908_Usernames.json" to "0" index
    And supply payload with file name "idc\MLP-5908_Usernames.json"
    And user makes a REST Call for POST request with url "usergroups/userdetails"
    And Status code 200 must be returned
    And empty response body should be displayed

