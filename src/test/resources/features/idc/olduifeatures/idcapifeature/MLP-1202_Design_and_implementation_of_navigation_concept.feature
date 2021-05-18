@MLP-1202
Feature: MLP-1202: This feature is solr based search with facets

  Description:
  To verify API response with Solr Search returns correct values

  @positive
  Scenario:MLP-1202: Verification of fulltext search
    Given A query param with "query" and "customers&advanced=true&limit=500&offset=0" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext"
    Then Status code 200 must be returned
    And compare the count between Json Response and Solr Response
      | queryName | filterQuery | facetField |
      | customers |             |            |
    And compare "result.name" between Json Response and Solr Response with Search Index ID
      | queryName | filterQuery | facetField |
      | customers |             |            |

  @negative
  Scenario:MLP-1202: Verification of error message when areaname is invalid during search as stored query
    Given A query param with "limit" and "0&param=query%3D*&param=tagNames%3DBigData" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "searches/NewTestArea/query/dataTagging"
    Then Status code 404 must be returned
    And response message contains value "Catalog NewTestArea not found"

  @negative
  Scenario:MLP-1202: Verification of error message when queryname is invalid during search as stored query
    Given A query param with "limit" and "0&param=query%3D*&param=tagNames%3DBigData" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "searches/BigData/query/queryTest"
    Then Status code 404 must be returned
    And response message contains value "Stored query queryTest does not exist"

  @negative
  Scenario:MLP-1202: Verification of error when incremental index is provided with vertex id
    Given A query param with "id" and "BigData.Table%3A%3A%3A1&incremental=true&limit=0&maxSeconds=0&hoursUntilNext=48&force=false" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for POST request with url "/searches/fulltext/synchronize/BigData"
    Then Status code 200 must be returned

  @negative
  Scenario:MLP-1202: Verification of error message for invalid areaname in auto suggest
    Given A query param with "input" and "customer&limit=10" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext/autosuggest/NewTestArea"
    Then Status code 404 must be returned
    And response message contains value "Catalog NewTestArea not found"

  @positive
  Scenario:MLP-1202: Verification of fulltext search with advanced query as false
    Given A query param with "query" and "customers&advanced=false&limit=500&offset=0" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext"
    Then Status code 200 must be returned
    And compare the count between Json Response and Solr Response
      | queryName   | filterQuery | facetField |
      | *customers* |             |            |
    And compare "result.name" between Json Response and Solr Response with Search Index ID
      | queryName   | filterQuery | facetField |
      | *customers* |             |            |

  @positive
  Scenario:MLP-1202: Verification of fulltext search with areaname and advanced query as false
    Given A query param with "query" and "city&advanced=false&limit=500&offset=0" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext/BigData"
    Then Status code 200 must be returned
    And compare the count between Json Response and Solr Response
      | queryName | filterQuery       | facetField |
      | *city*    | catalog_s:BigData |            |
    And compare "result.name" between Json Response and Solr Response with Search Index ID
      | queryName | filterQuery       | facetField |
      | *city*    | catalog_s:BigData |            |

  @positive
  Scenario:MLP-1202: Verification of fulltext search with areaname and advanced query as true
    Given A query param with "query" and "city&advanced=true&limit=500&offset=0" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext/BigData"
    Then Status code 200 must be returned
    And compare the count between Json Response and Solr Response
      | queryName | filterQuery       | facetField |
      | city      | catalog_s:BigData |            |
    And compare "result.name" between Json Response and Solr Response with Search Index ID
      | queryName | filterQuery       | facetField |
      | city      | catalog_s:BigData |            |

  @positive
  Scenario:MLP-1202: Verification of search with facets in all catalog
    Given A query param with "query" and "*%3A*&advanced=true&offset=0&limit=500&limitFacets=10" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1202_Search_with_facets.json"
    When user makes a REST Call for POST request with url "/searches/fulltext"
    Then Status code 200 must be returned
    And compare the count between Json Response and Solr Response
      | queryName | filterQuery                       | facetField |
      | *:*       | -catalog_s:sqlg_solr,type_s:Table | type_s     |
    And compare "result.name" and "result.type" between Json Response and Solr Response with type "Table"
      | queryName | filterQuery                       | facetField | sortField | sortOrder |
      | *:*       | -catalog_s:sqlg_solr,type_s:Table | type_s     | id        | Asc       |

  @positive
  Scenario:MLP-1202: Verification of auto suggest
    Given A query param with "input" and "employees&limit=100" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext/autosuggest"
    Then Status code 200 must be returned
    And compare between Json Response and Solr Response matches
      | queryName               | filterQuery | facetField | sortField | sortOrder |
      | name_s_lower:employees* |             | name_s     | name_s    | Asc       |

  @positive
  Scenario:MLP-1202: Verification of auto suggest with areaname
    Given A query param with "input" and "customers&limit=100" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext/autosuggest/BigData"
    Then Status code 200 must be returned
    And compare between Json Response and Solr Response matches
      | queryName               | filterQuery | facetField | sortField | sortOrder |
      | name_s_lower:customers* |             | name_s     | name_s    | Asc       |

  @positive
  Scenario:MLP-1202: Verification of auto suggest with areaname and type
    Given A query param with "input" and "test&limit=100" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext/autosuggest/BigData/File"
    Then Status code 200 must be returned
    And compare between Json Response and Solr Response matches
      | queryName                                              | filterQuery | facetField | sortField | sortOrder |
      | name_s_lower:test* && catalog_s:BigData && type_s:File |             | name_s     | name_s    | Asc       |

  @positive
  Scenario:MLP-1202: Verification of search with facets in particular catalog
    Given A query param with "query" and "*%3A*&advanced=true&limit=500&offset=0&limitFacets=500" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1202_Search_with_facets_in_Catalog.json"
    When user makes a REST Call for POST request with url "/searches/fulltext/BigData"
    Then Status code 200 must be returned
    And compare the count between Json Response and Solr Response
      | queryName | filterQuery                                         | facetField |
      | *:*       | -catalog_s:sqlg_solr,catalog_s:BigData,type_s:Table | type_s     |
    And compare "result.name" and "result.type" between Json Response and Solr Response with type "Table"
      | queryName | filterQuery                                         | facetField | sortField | sortOrder |
      | *:*       | -catalog_s:sqlg_solr,catalog_s:BigData,type_s:Table | type_s     | name_s    | Asc       |

  @positive
  Scenario:MLP-1202: Verification of search as stored query with no facets
    Given A query param with "limit" and "1000&param=query%3D*&param=tagNames%3DBigData" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/BigData/query/dataTagging"
    Then Status code 200 must be returned
    And compare "name" between Json Response and Solr Response with Search Index ID
      | queryName | filterQuery                               | facetField | sortField | sortOrder |
      | *:*       | catalog_s:BigData,asg.tagNames_ss:BigData |            |           |           |

  @positive
  Scenario:MLP-1202: Verification of solr indexer update with id
    Given user performs update in DB for a particular row "10" with value ""
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |
    And user performs update in DB for a particular row "10" with value "TestValue"
      | description | schemaName | tableName | columnName  | criteriaName |
      | UPDATE      | BigData    | V_Table   | description | ID           |
    And value for "description_t" should not be updated in solr
      | queryName | filterQuery                               | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::10" |            |
    When A query param with "catalogName" and "BigData&id=BigData.Table%3A%3A%3A10&limit=0&maxSeconds=0&hoursUntilNext=48&force=false" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "/searches/fulltext/synchronize"
    And Status code 200 must be returned
    And sync the test execution for "10" seconds
    Then value for "description_t" should be updated in solr
      | queryName | filterQuery                               | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::10" |            |

  @positive
  Scenario:MLP-1202: Verification of solr indexer update with incremental update
    Given user performs update in DB for a particular row "46" with value ""
      | description | schemaName | tableName | columnName  | criteriaName |
      | UPDATE      | BigData    | V_Table   | description | ID           |
    And user performs update in DB for a particular row "46" with value "TestValue"
      | description | schemaName | tableName | columnName  | criteriaName |
      | UPDATE      | BigData    | V_Table   | description | ID           |
    And value for "description_t" should not be updated in solr
      | queryName | filterQuery                               | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::46" |            |
    When A query param with "incremental" and "true&limit=0&maxSeconds=0&hoursUntilNext=48&force=false" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "/searches/fulltext/synchronize/BigData"
    And Status code 200 must be returned
    And sync the test execution for "10" seconds
    Then value for "description_t" should be updated in solr
      | queryName | filterQuery                               | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::46" |            |

  @positive
  Scenario:MLP-1202: Verification of solr indexer update with incremental update and limit
    Given user performs update in DB for a particular row "20" with value ""
      | description | schemaName | tableName | columnName  | criteriaName |
      | UPDATE      | BigData    | V_Table   | description | ID           |
    And user performs update in DB for a particular row "21" with value ""
      | description | schemaName | tableName | columnName  | criteriaName |
      | UPDATE      | BigData    | V_Table   | description | ID           |
    And user performs update in DB for a particular row "20" with value "TestValue"
      | description | schemaName | tableName | columnName  | criteriaName |
      | UPDATE      | BigData    | V_Table   | description | ID           |
    And user performs update in DB for a particular row "21" with value "TestValue"
      | description | schemaName | tableName | columnName  | criteriaName |
      | UPDATE      | BigData    | V_Table   | description | ID           |
    When A query param with "incremental" and "true&limit=1&maxSeconds=0&hoursUntilNext=48&force=false" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "/searches/fulltext/synchronize/BigData"
    And Status code 200 must be returned
    And sync the test execution for "10" seconds
    Then value for "description_t" should be updated only for one item in solr
      | queryName | filterQuery                               | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::20" |            |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::21" |            |

  @positive
  Scenario: MLP-1202: Verification of solr indexer update with id for multiple catalog
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "/settings/catalogs/Multiple"
    And supply payload with file name "idc/MLP-1202_CreateCatalog.json"
    And user makes a REST Call for POST request with url "settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2967_lineage.xml"
    And user makes a REST Call for POST request with url "import/Multiple" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    Then user performs update in DB for a particular row "5" with value ""
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |
    And user performs update in DB for a particular row "1" with value ""
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | Multiple   | V_Table   | definition | ID           |
    And configure a new REST API for the service "IDC"
    And A query param with "catalogname" and "BigData&catalogname=Multiple&limit=0&maxSeconds=0&hoursUntilNext=48&force=false" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "/searches/fulltext/synchronize"
    And Status code 200 must be returned
    And user performs update in DB for a particular row "5" with value "TestValue"
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |
    And user performs update in DB for a particular row "1" with value "TestValue"
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | Multiple   | V_Table   | definition | ID           |
    And value for "definition_t" should not be updated in solr
      | queryName | filterQuery                              | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::5" |            |
#    And value for "definition_t" should not be updated in solr
#      | queryName | filterQuery                                | facetField |
#      | *:*       | catalog_s:Multiple,id:"Multiple.Table:::1" |            |
    And configure a new REST API for the service "IDC"
    And A query param with "catalogname" and "BigData&catalogname=Multiple&id=BigData.Table%3A%3A%3A5&id=Multiple.Table%3A%3A%3A1&limit=0&maxSeconds=0&hoursUntilNext=48&force=false" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "/searches/fulltext/synchronize"
    And Status code 200 must be returned
    And sync the test execution for "10" seconds
    And value for "definition_t" should be updated for both item in solr
      | queryName | filterQuery                                | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::5"   |            |
      | *:*       | catalog_s:Multiple,id:"Multiple.Table:::1" |            |

  @positive
  Scenario: MLP-1202: Verification of solr indexer update with incremental update for multiple catalog
    Given user performs update in DB for a particular row "6" with value ""
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |
    And user performs update in DB for a particular row "1" with value ""
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | Multiple   | V_Table   | definition | ID           |
    And A query param with "catalogname" and "BigData&catalogname=Multiple&limit=0&maxSeconds=0&hoursUntilNext=48" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "/searches/fulltext/synchronize"
    And Status code 200 must be returned
    And user performs update in DB for a particular row "6" with value "TestValue"
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |
    And user performs update in DB for a particular row "1" with value "TestValue"
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | Multiple   | V_Table   | definition | ID           |
    And value for "definition_t" should not be updated in solr
      | queryName | filterQuery                              | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::6" |            |
    And value for "definition_t" should not be updated in solr
      | queryName | filterQuery                                | facetField |
      | *:*       | catalog_s:Multiple,id:"Multiple.Table:::1" |            |
    And configure a new REST API for the service "IDC"
    And A query param with "catalogname" and "BigData&catalogname=Multiple&incremental=true&limit=0&maxSeconds=0&hoursUntilNext=48" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "searches/fulltext/synchronize"
    And Status code 200 must be returned
    And sync the test execution for "10" seconds
    And value for "definition_t" should be updated for both item in solr
      | queryName | filterQuery                                | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::6"   |            |
      | *:*       | catalog_s:Multiple,id:"Multiple.Table:::1" |            |

  @positive
  Scenario: MLP-1202: Verification of solr indexer update with incremental update and limit for multiple catalog
    Given user performs update in DB for a particular row "1" with value "TestValue"
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |
    And user performs update in DB for a particular row "2" with value "TestValue"
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |
    And user performs update in DB for a particular row "1" with value "TestValue"
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | Multiple   | V_Column  | definition | ID           |
    And user performs update in DB for a particular row "2" with value "TestValue"
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | Multiple   | V_Column  | definition | ID           |
    When A query param with "catalogname" and "BigData&catalogname=Multiple&incremental=true&limit=1&maxSeconds=0&hoursUntilNext=48" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "/searches/fulltext/synchronize"
    And Status code 200 must be returned
    And sync the test execution for "10" seconds
    Then value for "definition_t" should be updated for both items in solr
      | queryName | filterQuery                                 | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::1"    |            |
      | *:*       | catalog_s:Multiple,id:"Multiple.Column:::1" |            |
    And value for "definition_t" should not be updated for both items in solr
      | queryName | filterQuery                                 | facetField |
      | *:*       | catalog_s:BigData,id:"BigData.Table:::2"    |            |
      | *:*       | catalog_s:Multiple,id:"Multiple.Column:::2" |            |
    And user performs update in DB for a particular row "1" with value ""
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |
    And user performs update in DB for a particular row "2" with value ""
      | description | schemaName | tableName | columnName | criteriaName |
      | UPDATE      | BigData    | V_Table   | definition | ID           |

  @positive
  Scenario: MLP-1202: Verification of solr indexer update for multiple catalog with hours
    Given A query param with "catalogname" and "Multiple&limit=0&maxSeconds=0&hoursUntilNext=0&force=false" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for POST request with url "/searches/fulltext/synchronize"
    And Status code 200 must be returned
    And sync the test execution for "10" seconds
    Then register for "Multiple" catalog should not be displayed
      | description | schemaName | tableName        | columnName | criteriaName |
      | SELECT      | sqlg_solr  | V_DbOperationReg | schema     |              |
    And user makes a REST Call for DELETE request with url "/settings/catalogs/Multiple"
    And Status code 204 must be returned

  @positive
  Scenario: MLP-1202 Verification to get field names of specific area
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "settings/searches/fields/BigData?namesOnly=true"
    Then Status code 200 must be returned

  @positive
  Scenario: MLP-1202 Verification of solr indexer with incremental update as false
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for POST request with url "searches/fulltext/synchronize/BigData?incremental=false&limit=0&maxSeconds=0&hoursUntilNext=48"
    Then Status code 200 must be returned