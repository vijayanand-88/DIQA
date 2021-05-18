@MLP-1575
Feature: MLP-1575: Recommendation engine based on ratings

  @MLP-1575 @regression @rating @positive
  Scenario:MLP-1575: Verification of recommendation based on rating for Table
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Table" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Table" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Table" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with id and rating as "5" for "Table" with following query param
      | null | null |
    And Status code 201 must be returned
    And user makes a REST Call for POST request with url "/recommendations/update/BigData"
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | Status Code                    |             | 200             |
      | ResponseBody_ReturnSingleValue | users       | 2               |
    Then user makes a REST Call for Get request with url "/recommendations/items/BigData"
    And Status code 200 must be returned
    And response message should contain the recommended "Table" id of similar rated items for "TestSystem"
      | description | schemaName | tableName     | columnName  | criteriaName |
      | SELECT      | BigData    | V_Recommender | recommended | username     |


  @MLP-1575 @regression @rating @positive
  Scenario:MLP-1575: Verification of recommendation based on rating for Column
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Column" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Column" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table "E_rating" in database
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Column" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with id and rating as "5" for "Column" with following query param
      | null | null |
    And Status code 201 must be returned
    And user makes a REST Call for POST request with url "/recommendations/update/BigData"
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | Status Code                    |             | 200             |
      | ResponseBody_ReturnSingleValue | users       | 2               |
    Then user makes a REST Call for Get request with url "/recommendations/items/BigData"
    And Status code 200 must be returned
    And response message should contain the recommended "Column" id of similar rated items for "TestSystem"
      | description | schemaName | tableName     | columnName  | criteriaName |
      | SELECT      | BigData    | V_Recommender | recommended | username     |

  @MLP-1575 @regression @rating @positive
  Scenario:MLP-1575: Verification of recommendation based on rating for File
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "File" with following query param
      | null | null |
    Then Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "File" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table "E_rating" in database
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "File" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with id and rating as "5" for "File" with following query param
      | null | null |
    And Status code 201 must be returned
    And user makes a REST Call for POST request with url "/recommendations/update/BigData"
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | Status Code                    |             | 200             |
      | ResponseBody_ReturnSingleValue | users       | 2               |
    And user makes a REST Call for Get request with url "/recommendations/items/BigData"
    And Status code 200 must be returned
    And response message should contain the recommended "File" id of similar rated items for "TestSystem"
      | description | schemaName | tableName     | columnName  | criteriaName |
      | SELECT      | BigData    | V_Recommender | recommended | username     |


  @MLP-1575 @regression @rating @positive
  Scenario:MLP-1575: Verification of recommendation based on rating for Field
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Field" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Field" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table "E_rating" in database
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Field" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with id and rating as "5" for "Field" with following query param
      | null | null |
    And Status code 201 must be returned
    And user makes a REST Call for POST request with url "/recommendations/update/BigData"
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | Status Code                    |             | 200             |
      | ResponseBody_ReturnSingleValue | users       | 2               |
    And user makes a REST Call for Get request with url "/recommendations/items/BigData"
    Then Status code 200 must be returned
    And response message should contain the recommended "Field" id of similar rated items for "TestSystem"
      | description | schemaName | tableName     | columnName  | criteriaName |
      | SELECT      | BigData    | V_Recommender | recommended | username     |


  @MLP-1575 @regression @rating @positive
  Scenario:MLP-1575: Verification of recommendation based on rating for Directory
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Directory" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Directory" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Directory" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with id and rating as "5" for "Directory" with following query param
      | null | null |
    And Status code 201 must be returned
    Then user makes a REST Call for POST request with url "/recommendations/update/BigData"
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | Status Code                    |             | 200             |
      | ResponseBody_ReturnSingleValue | users       | 2               |
    And user makes a REST Call for Get request with url "/recommendations/items/BigData"
    And Status code 200 must be returned
    And response message should contain the recommended "Directory" id of similar rated items for "TestSystem"
      | description | schemaName | tableName     | columnName  | criteriaName |
      | SELECT      | BigData    | V_Recommender | recommended | username     |

  @MLP-1575 @regression @rating @positive
  Scenario:MLP-1575: Verification of recommendation based on high rating
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "4" for "Table" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "4" for "Table" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and rating as "5" for "Table" with following query param
      | null | null |
    And Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for POST request with url "/ratings/BigData/" with id and rating as "4" for "Table" with following query param
      | null | null |
    And Status code 201 must be returned
    Then user makes a REST Call for POST request with url "/recommendations/update/BigData"
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | Status Code                    |             | 200             |
      | ResponseBody_ReturnSingleValue | users       | 2               |
    And user makes a REST Call for Get request with url "/recommendations/items/BigData"
    And Status code 200 must be returned
    And response message should contain the recommended "Table" id of highly rated items for "TestSystem"
      | description | schemaName | tableName     | columnName  | criteriaName |
      | SELECT      | BigData    | V_Recommender | recommended | username     |







