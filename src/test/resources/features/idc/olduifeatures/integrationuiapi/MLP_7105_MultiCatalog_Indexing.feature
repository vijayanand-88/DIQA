@MLP-7105
Feature: MLP-7105: This feature is verify multi catalog indexing

  @MLP-7105 @webtest @positive @regression @solrindexer
  Scenario:MLP-7105: Verification of multi catalog indexing
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "/settings/catalogs/MultiCatalogOne"
    And user makes a REST Call for DELETE request with url "/settings/catalogs/MultiCatalogTwo"
    And supply payload with file name "idc/MLP-7105_MultiCatalog.json"
    And user makes a REST Call for POST request with url "/settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP-7105_Sample.xml"
    Then user makes a REST Call for POST request with url "import/MultiCatalogOne" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false |
    And Status code 200 must be returned
    And supply payload with file name "idc/MLP-7105_SampleOne.xml"
    Then user makes a REST Call for POST request with url "import/MultiCatalogTwo" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false |
    And Status code 200 must be returned
    And user performs update in DB for a particular row "ColOne" with value "ColOneUpdated" without suffix
      | description | schemaName      | tableName | columnName | criteriaName |
      | UPDATE      | MultiCatalogOne | V_Column  | name       | name         |
    And user performs update in DB for a particular row "ColThree" with value "ColThreeUpdated" without suffix
      | description | schemaName      | tableName | columnName | criteriaName |
      | UPDATE      | MultiCatalogTwo | V_Column  | name       | name         |
    And user verifies the solr count for the following query should be "0"
      | queryName                 | filterQuery          |
      | catalog_s:MultiCatalogOne | name_s:ColOneUpdated |
    And user verifies the solr count for the following query should be "0"
      | queryName                 | filterQuery            |
      | catalog_s:MultiCatalogTwo | name_s:ColThreeUpdated |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "searches/fulltext/synchronize?catalogname=MultiCatalogOne&catalogname=MultiCatalogTwo&limit=0&maxSeconds=0&hoursUntilNext=48"
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    Then user selects "MultiCatalogOne" catalog from catalog list
    And user enters the search text "ColOneUpdated" and clicks on search
    And user verifies "1" items found
    And user verifies the solr count for the following query should be "1"
      | queryName                 | filterQuery          |
      | catalog_s:MultiCatalogOne | name_s:ColOneUpdated |
    And user verifies the solr count for the following query should be "1"
      | queryName                 | filterQuery            |
      | catalog_s:MultiCatalogTwo | name_s:ColThreeUpdated |


  @MLP-7105 @webtest  @positive @regression @solrindexer
  Scenario:MLP-7105: Verification of multi catalog indexing with id
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user performs update in DB for a particular row "ColTwo" with value "ColTwoUpdated" without suffix
      | description | schemaName      | tableName | columnName | criteriaName |
      | UPDATE      | MultiCatalogOne | V_Column  | name       | name         |
    And user performs update in DB for a particular row "ColFour" with value "ColFourUpdated" without suffix
      | description | schemaName      | tableName | columnName | criteriaName |
      | UPDATE      | MultiCatalogTwo | V_Column  | name       | name         |
    And user verifies the solr count for the following query should be "0"
      | queryName                 | filterQuery          |
      | catalog_s:MultiCatalogOne | name_s:ColTwoUpdated |
    And user verifies the solr count for the following query should be "0"
      | queryName                 | filterQuery           |
      | catalog_s:MultiCatalogTwo | name_s:ColFourUpdated |
    And user makes a REST Call for POST request with url "searches/fulltext/synchronize?catalogname=MultiCatalogOne&catalogname=MultiCatalogTwo&id=MultiCatalogOne.Column%3A%3A%3A2&id=MultiCatalogTwo.Column%3A%3A%3A2&limit=0&maxSeconds=0&hoursUntilNext=48"
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    Then user selects "MultiCatalogOne" catalog from catalog list
    And user enters the search text "ColTwoUpdated" and clicks on search
    And user verifies "1" items found
    And user verifies the solr count for the following query should be "1"
      | queryName                 | filterQuery          |
      | catalog_s:MultiCatalogOne | name_s:ColTwoUpdated |
    And user verifies the solr count for the following query should be "1"
      | queryName                 | filterQuery           |
      | catalog_s:MultiCatalogTwo | name_s:ColFourUpdated |

  @MLP-7105 @webtest  @positive @regression @solrindexer
  Scenario Outline: Login Scenario - Verification of indexing with id
    Given user get the column "ColNew" id from the following query
      | description | schemaName      | tableName | columnName | criteriaName |
      | SELECT      | MultiCatalogOne | V_Column  | ID         | name         |
    And user performs update in DB for a particular row "ColNew" with value "ColNewUpdated" without suffix
      | description | schemaName      | tableName | columnName | criteriaName |
      | UPDATE      | MultiCatalogOne | V_Column  | name       | name         |
    And user verifies the solr count for the following query should be "0"
      | queryName                 | filterQuery          |
      | catalog_s:MultiCatalogOne | name_s:ColNewUpdated |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
    Then Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    Then user selects "MultiCatalogOne" catalog from catalog list
    And user enters the search text "ColNewUpdated" and clicks on search
    And user verifies "1" items found
    And user verifies the solr count for the following query should be "1"
      | queryName                 | filterQuery          |
      | catalog_s:MultiCatalogOne | name_s:ColNewUpdated |
    And user makes a REST Call for DELETE request with url "/settings/catalogs/MultiCatalogOne"
    And user makes a REST Call for DELETE request with url "/settings/catalogs/MultiCatalogTwo"

    Examples:
      | contentType      | acceptType       | type | url                                                                                          | endpoint                                | body |
      | application/json | application/json | Post | searches/fulltext/synchronize?catalogname=MultiCatalogOne&id=MultiCatalogOne.Column%3A%3A%3A | &limit=0&maxSeconds=0&hoursUntilNext=48 |      |
