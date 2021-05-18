@MLP-1110
Feature: MLP-1110: As an user I can rate a data element

  Description:
  As a user with different login I can rate a data element that can be seen in Postgres DB.

  @MLP-1110 @sanity @regression @rating @positive
  Scenario:MLP-1110: Verification of adding a rate from API for Table
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings from DB with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    Then Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And Dynamic rating must be matched with the table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName          |
      | SELECT      | BigData    | E_rating  | *          | asg.modifiedBy,rating |


  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification of adding a rate from API for column
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Column" with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Column"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Column  | ID         | *            |
    Then Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And Dynamic rating must be matched with the table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName          |
      | SELECT      | BigData    | E_rating  | *          | asg.modifiedBy,rating |

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification of adding a rate from API for File
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "File" with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "File"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_File    | ID         | *            |
    Then Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And Dynamic rating must be matched with the table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName          |
      | SELECT      | BigData    | E_rating  | *          | asg.modifiedBy,rating |

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification of adding a rate from API for Field
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Field" with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Field"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Field   | ID         | *            |
    Then Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And Dynamic rating must be matched with the table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName          |
      | SELECT      | BigData    | E_rating  | *          | asg.modifiedBy,rating |

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification of adding a rate from API for Database
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Database" with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Database"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | BigData    | V_Database | ID         | *            |
    Then Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And Dynamic rating must be matched with the table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName          |
      | SELECT      | BigData    | E_rating  | *          | asg.modifiedBy,rating |

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification of adding a rate from API for Directory
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Directory" with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Directory"
      | description | schemaName | tableName   | columnName | criteriaName |
      | SELECT      | BigData    | V_Directory | ID         | *            |
    Then Status code 201 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And Dynamic rating must be matched with the table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName          |
      | SELECT      | BigData    | E_rating  | *          | asg.modifiedBy,rating |

  @MLP-1110 @rating @negative
  Scenario:MLP-1110: Verify wrong item id returns 404 message when call POST Request.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for POST request with url "/ratings/BigData/BigData.Table%3A%3A%3A632434/5"
    Then Status code 404 must be returned
    And response message contains value "itemId not foundBigData.Table:::632434"

  @MLP-1110 @rating @negative
  Scenario:MLP-1110: Verify wrong item id returns 404 message when call GET request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/ratings/BigData/BigData.Table%3A%3A%3A4564"
    Then Status code 404 must be returned
    And response message contains value "itemId not foundBigData.Table:::4564"

  @MLP-1110 @rating @negative
  Scenario:MLP-1110: Verify wrong item id returns 404 message when call DELETE request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/ratings/BigData/BigData.Table%3A%3A%3A4564"
    Then Status code 404 must be returned
    And response message contains value "itemId not foundBigData.Table:::4564"

  @MLP-1110 @rating @negative
  Scenario:MLP-1110: Verify wrong catalog Name returns 404 message when call GET request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/ratings/BigDataTest/BigData.Table%3A%3A%3A4564"
    Then Status code 404 must be returned
    And response message contains value "Catalog BigDataTest not found"

  @MLP-1110 @rating @negative
  Scenario:MLP-1110: Verify wrong catalog Name returns 404 message when call POST request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for POST request with url "/ratings/BigDataTest/BigData.Table%3A%3A%3A4/4"
    Then Status code 404 must be returned
    And response message contains value "Catalog BigDataTest not found"

  @MLP-1110 @rating @negative
  Scenario:MLP-1110: Verify wrong catalog Name returns 404 message when call Delete request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/ratings/BigDataTest/BigData.Table%3A%3A%3A4?user=TestService"
    Then Status code 404 must be returned
    And response message contains value "Catalog BigDataTest not found"

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification of updating a rating from API
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings from DB with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    And Status code 201 must be returned
    Then user makes a REST Call for POST request with url "/ratings/BigData/" with id and dynamic Rating from DB with following query param
      | null | null |
    And Status code 200 must be returned
    And Response id return in json format must match with table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | E_rating  | ID         | ID           |
    And Dynamic rating must be matched with the table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName          |
      | SELECT      | BigData    | E_rating  | *          | asg.modifiedBy,rating |

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification of deleting a rating from API
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    And Status code 201 must be returned
    Then user makes a REST Call for DELETE request with url "/ratings/BigData/" and id for "TestService" user
    And Status code 204 must be returned
    And deleted id must not be present in table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName                    |
      | SELECT      | BigData    | E_rating  | *          | BigData.Table__I,asg.modifiedBy |

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verfication of deleting rating of other users by TestInfo
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    And Status code 201 must be returned
    Then user makes a REST Call for DELETE request with url "/ratings/BigData/" and id for "TestInfo" user
    And Status code 404 must be returned
    And response message contains value "rating by user TestInfo for itemId not found"

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification of delete rating with wrong user
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings from DB with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    And Status code 201 must be returned
    Then user makes a REST Call for DELETE request with url "/ratings/BigData/" and id for "TestSystem" user
    And Status code 404 must be returned
    And response message contains value "rating by user TestSystem for itemId not found"

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification to get all ratings for a specified item and average rating
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    And Status code 201 must be returned
    And configure a new REST API for the service "IDC"
    Then To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And  user makes a REST Call for POST request with url "/ratings/BigData/" with id and dynamic Rating from DB with following query param
      | null | null |
    And Status code 201 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/ratings/BigData/" for the specific id
    And all rating should be displayed for specified item
    And compare the average rating displayed for the item
    And response returns with the following items
      | description                    | searchItems       | expectedResults        |
      | Status Code                    |                   | 200                    |
      | ResponseBody_ReturnSingleValue | ratingCount       | 2                      |
      | ResponseBody_ValidateList      | ratings[0,1].user | TestSystem,TestService |

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110:Verification of deleting a rating reflects the average rating
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    And Status code 201 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And  user makes a REST Call for POST request with url "/ratings/BigData/" with id and dynamic Rating from DB with following query param
      | null | null |
    And Status code 201 must be returned
    And get average Rating of the specified item
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    Then user makes a REST Call for DELETE request with url "/ratings/BigData/" and id for "TestService" user
    And Status code 204 must be returned
    And deleted id must not be present in table in database for "TestService"
      | description | schemaName | tableName | columnName | criteriaName                    |
      | SELECT      | BigData    | E_rating  | *          | BigData.Table__I,asg.modifiedBy |
    And user makes a REST Call for Get request with url "/ratings/BigData/" for the specific id
    And Status code 200 must be returned
    And average rating should be changed after deletion

  @MLP-1110 @regression @rating @positive
  Scenario:MLP-1110: Verification to get items rated by specified user
    Given Delete all records in the table "E_rating"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings from DB with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    And Status code 201 must be returned
#    And user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings from DB with following query param
#      | null | null |
    When user makes a REST Call for POST request with url "/ratings/BigData/" with dynamic id and Ratings for "Table"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | *            |
    And Status code 201 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    Then user makes a REST Call for Get request with url "/users/ratings/BigData?userName=TestService&limit=10&order=date&reverse=true" for the specific user
    And Status code 200 must be returned
    And rating must be matched with table in database for "TestService" user
      | description | schemaName | tableName | columnName | criteriaName   |
      | SELECT      | BigData    | E_rating  | rating     | asg.modifiedBy |
    And table id must be matched with table in database for "TestService" user
      | description | schemaName | tableName | columnName       | criteriaName   |
      | SELECT      | BigData    | E_rating  | BigData.Table__I | asg.modifiedBy |










