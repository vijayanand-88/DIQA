@MLP-5875
Feature: MLP-5875: This feature is to verify the User names by Ldap - provide account name and case in sensitive names

  @MLP-5875 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-5875: Verification of account parameter while getting users for usergroups
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-5875_AccountParameters.json"
    When user makes a REST Call for POST request with url "usergroups/users"
    Then Status code 200 must be returned
    And response message contains value "name"
    And response message contains value "account"


  @MLP-5875 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-5875: Verification of uppercase account name during login
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-5875_BecubicRoleMapping.json"
    When user makes a REST Call for PUT request with url "rolemappings"
    Then Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json                           |
      | Accept        | application/json                           |
      | Authorization | Basic QkVDVUJJQ19CVUlMRDpsYWd1bmEtMjAxMg== |
    When user makes a REST Call for Get request with url "users"
    Then Status code 200 must be returned
    And response message contains value "becubic_build"

  @MLP-5875 @sanity @regression @rolevisibilitymanagement @positive
  Scenario:MLP-5875: Verification of lowercase account name during login
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-5875_BecubicRoleMapping.json"
    When user makes a REST Call for PUT request with url "rolemappings"
    Then Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json                           |
      | Accept        | application/json                           |
      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
    When user makes a REST Call for Get request with url "users"
    Then Status code 200 must be returned
    And response message contains value "becubic_build"

#  @MLP-5875 @sanity @regression @rolevisibilitymanagement @positive
#  Scenario Outline: MLP-5875: Verification of system attributes
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#    And supply payload with file name "idc/MLP-3297_DataSets_with_data_Elements.json"
#    When user makes a REST Call for POST request with url "datasets"
#    Then Status code 200 must be returned
#    And user get the column "DataSet with DataElements" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And configure a new REST API for the service "IDC"
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "BecubicUser" user
#    And user compares the value from response using json path "$.createdBy"
#      | jsonValues    |
#      | becubic_build |
#    And user compares the value from response using json path "$.modifiedBy"
#      | jsonValues    |
#      | becubic_build |
#
#    Examples:
#      | contentType      | acceptType       | type   | url                                | endpoint | body |
#      | application/json | application/json | Get    | datasets/DataSets.DataSet%3A%3A%3A |          |      |
#
#  @MLP-5875 @sanity @regression @rolevisibilitymanagement @positive
#  Scenario Outline: Verification of proper user name in asg.acl
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#    And user get the column "DataSet with DataElements" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And configure a new REST API for the service "IDC"
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "BecubicUser" user
#    When Status code 204 must be returned
#
#    Examples:
#      | contentType      | acceptType       | type | url                                | endpoint                       | body                             |
#      | application/json | application/json | Put  | accesses/DataSets/DataSets.DataSet%3A%3A%3A | ?recursive=false&operation=SET | idc/MLP-5875_ACLAccessValue.json |
#
#
#  @MLP-5875 @sanity @regression @rolevisibilitymanagement @positive
#  Scenario Outline: Verification getting value of asg.acl for an item
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#    And user get the column "DataSet with DataElements" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And configure a new REST API for the service "IDC"
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "BecubicUser" user
#    When Status code 200 must be returned
#    Then user compares the value from response using json path "$..['asg.acl']"
#      | jsonValues                                              |
#      | {\"users\":[\"becubic_build\"],\"groups\":[\"System\"]} |
#
#    Examples:
#      | contentType      | acceptType       | type | url                                         | endpoint                     | body |
#      | application/json | application/json | Get  | accesses/DataSets/DataSets.DataSet%3A%3A%3A | ?what=asg.acl&recursive=false |      |
#
#  @MLP-5875 @sanity @regression @rolevisibilitymanagement @positive
#  Scenario Outline: Verification deleting the created dataset
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#      | Authorization | Basic YmVjdWJpY19idWlsZDpsYWd1bmEtMjAxMg== |
#    And user get the column "DataSet with DataElements" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And configure a new REST API for the service "IDC"
#    And  user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "BecubicUser" user
#    When Status code 200 must be returned
#
#    Examples:
#      | contentType      | acceptType       | type   | url                                | endpoint | body |
#      | application/json | application/json | Delete | datasets/DataSets.DataSet%3A%3A%3A |          |      |
#

  @webtest  @login @regression @positive
  Scenario Outline:Verification of logging into IDC irrespective of case sensitivity
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-5875_BecubicRoleMapping.json"
    When user makes a REST Call for PUT request with url "rolemappings"
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    When  User type username as "<username>" and Password as "<password>" from property file
    Then login must be successful for all users
    And user clicks on logout button

    Examples:
      | username           | password           |
      | BITBUCKET_USERNAME | BITBUCKET_PASSWORD |
      | bitbucket_username | BITBUCKET_PASSWORD |