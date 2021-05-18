@Examples
Feature: This is examples feature file to play around Rest Assured

  Description:
  This feature file is basically help guys to get comfortable on Rest Assured. Mostly, it will cover examples.

#  Scenario:MLP-606: To get the status code for given rest api to verify hardcoded headers and query param
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "configuration/socialnotifiers"
#    Then Status code 200 must be returned
#
#  Scenario:MLP-606: To get the status line code for given rest api to verify hardcoded headers and query param
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "configuration/socialnotifiers"
#    Then Status line "HTTP/1.1 200 OK" must be returned
#
#  Scenario:MLP-606: To use Multi header and authorization for rest endpoint
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    When user makes a REST Call for Get request with url "configuration/socialnotifiers"
#    Then Status code 200 must be returned
#
#  Scenario: To use query param and multi header dynamically with no url encyrption
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    When user makes a REST Call for Get request with url "configuration/ingestion/cataloger/Cluster Test" with the following query param
#      | raw | false |
#    Then Status code 200 must be returned
#
#  Scenario: How to use payloads or test data to run put request
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "idc/MLP-938_postreq.json"
#    When user makes a REST Call for PUT request with url "configuration/ingestion/cataloger/Cluster Test" with the following query param
#      | raw | false |
#    Then Status code 204 must be returned
#
#  Scenario: To get status code, statusline, content type and validate tags in one
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    When user makes a REST Call for Get request with url "configuration/ingestion/cataloger/Cluster Test" with the following query param
#      | raw | false |
#    Then response returns with the following items
#      | description                    | searchItems            | expectedResults         |
#      | Status Code                    |                        | 200                     |
#      | Status Line                    |                        | HTTP/1.1 200 OK         |
#      | Content Type                   |                        | application/json        |
#      | ResponseBody_ReturnSingleValue | catalogers[0].label.en | Hive Cataloger          |
#      | ResponseBody_ValidateList      | catalogers[0,1,2].name | Hive,Hdfs,Data Analyzer |
#
#  @MLP-1110 @regression @rating
#  Scenario:MLP-1110: Verification of adding a rate from API for column
#    Given Delete all records in the table "E_rating"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    When user makes a REST Call for POST request with url "collaboration/ratings/BigData/" with dynamic id and Ratings for "Column" with following query param
#      | null | null |
#    Then Status code 201 must be returned
#    And Response id return in json format must match with table in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | E_rating  | ID         | ID           |
#    #And Response id return in json format must match with table "E_rating" in database
#    And Dynamic rating must be matched with the table "E_rating" in database for "TestService" user
#
#  @SqlQueryBuilder
#  Scenario: To generate Dynamic query you can implement in any scenarios
#    Given To generate dynamic query with the following param
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | E_rating  | *          | ID, NAME     |
#
#  @SqlQueryBuilder
#  Scenario: To generate dynamic query with multiple return columns and criteria
#    Given To generate dynamic query with the following param
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | BigData    | E_rating  | ID,NAME    | ID,NAME      |
#
#  @dynamicresponseValidation
#  Scenario: To validate response validation using responseValidationIsItem
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "collaboration/user/ratings/BigData?userName=TestService&limit=10&order=date&reverse=true"
#    Then Status code 200 must be returned
#    Then validate response with the node "id"
#
#  @validatecurlforstopservicecomponet
#  Scenario: This scenario to validate curl request to stop catalogHive server
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "ida/StopServiceComponent.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/CATALOGER/components/CATALOG_HIVE"
#    Then Status code 202 must be returned
#
#  @validatecurlforstartservicecomponet
#  Scenario: This scenario to validate curl request to start catalogHive server
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "ida/StartServiceComponent.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/CATALOGER/components/CATALOG_HIVE"
#    Then Status code 202 must be returned
#
#  @Tovalidateexcelupload
#  Scenario: This example is validation of file upload in your request endpoint
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "datasetupload/inventory_fact_1998_sample.xlsx" to request
#    When user makes a REST Call for POST request with url "upload/BigData" with the following query param
#      | databaseName | northwind |
#      | tableName    | test      |
#      | allowUpdate  | false     |
#    Then Status code 200 must be returned
#  Scenario: Create a workflow of requests to update the ingestion config
#    Given I send series of requests for an operation
#      |requestConfig|responseConfig|responseRequiredOnNextCall|valueToUpdate|
#      |getIngestionConfiguration.json|validateGetIngestionConfiguration.json|Yes|deleteFilterPattern.json|
#      |putIngestionConfiguration.json|validatePutIngestionConfiguration.json|No|Nil|
#      |getIngestionConfiguration.json|validateGetIngestionConfiguration.json|Yes|addFilterPatternTC1111.json|
#      |putIngestionConfiguration.json|validatePutIngestionConfiguration.json|No|Nil|
#      |getIngestionConfiguration.json|validateGetIngestionConfiguration.json|No|Nil|