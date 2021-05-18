@shakeout
Feature: Feature to validate all rest api end points

  @shakeout @positive
  Scenario:MLP-1667: To verify catalog is created with supplied payload
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/CLOUDBEE%20CATALOG?deleteData=true"
    And supply payload with file name "idc/cloudBeePayloads/createCloudBeeCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "CLOUDBEE CATALOG" exists in database


  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in Analysis service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type   | url                                                              | body                                         | response code | response message |
      | application/json | raw   | false | Get    | extensions/analyzers/status/LocalNode/linker/SimilarityLinker/*  |                                              | 200           |                  |
      | application/json |       |       | Post   | extensions/analyzers/status/LocalNode/linker/SimilarityLinker/*  |                                              | 204           |                  |
      | application/json |       |       | Delete | extensions/analyzers/status/LocalNode/linker/SimilarityLinker/*  |                                              | 204           |                  |
      | application/json |       |       | Put    | extensions/analyzers/status/LocalNode/linker/SimilarityLinker/*  | idc/cloudBeePayloads/analysisCloudBee.txt    | 204           |                  |
      | application/json |       |       | Post   | extensions/analyzers/stop/LocalNode/linker/SimilarityLinker/*    |                                              | 204           |                  |
      | application/json |       |       | Get    | extensions/analyzers/status/Cluster%20Demo                       |                                              | 200           |                  |
      | application/json |       |       | Put    | extensions/analyzers/status/Cluster%20Demo                       | idc/cloudBeePayloads/analysisNodeUp.txt      | 204           |                  |
      | application/json |       |       | Get    | extensions/analyzers/callback/LocalNode                          |                                              | 200           |                  |
      | application/json |       |       | Delete | extensions/analyzers/callback/LocalNode                          |                                              | 204           |                  |
      | application/json |       |       | Put    | extensions/analyzers/callback/LocalNode                          | idc/cloudBeePayloads/analyisCallBack.json    | 204           |                  |
      | application/json |       |       | Post   | extensions/analyzers/start/LocalNode/linker/SimilarityLinker/*   |                                              | 200           |                  |
      | application/json |       |       | Get    | settings/analyzers/LocalNode                                     |                                              | 200           |                  |
      | application/json |       |       | Delete | settings/analyzers/LocalNode                                     |                                              | 204           |                  |
      | application/json |       |       | Put    | settings/analyzers/LocalNode                                     | idc/cloudBeePayloads/analysisNodeConfig.json | 204           |                  |
      | application/json |       |       | Get    | settings/analyzers                                               |                                              | 200           |                  |
      | application/json |       |       | Get    | settings/analyzers/recent/1                                      |                                              | 200           |                  |
      | application/json |       |       | Get    | extensions/analyzers/history/LocalNode/linker/SimilarityLinker/* |                                              | 200           |                  |
      | text/plain       |       |       | Get    | extensions/analyzers/log/LocalNode                               |                                              | 200           |                  |

  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in Configuration service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query      | Param | type   | url                                                           | body                                           | response code | response message |
      | application/json |            |       | Get    | settings/analysis                                             |                                                | 204           |                  |
      | application/json | raw        | false | Post   | settings/analysis                                             |                                                | 204           |                  |
      | application/json |            |       | Get    | settings/user?path=com%2Fasg%2Fdis%2Fplatform%2Fsecurity.json |                                                | 200           |                  |
      | application/json |            |       | Put    | settings/user?path=com%2Fasg%2Fdis%2Fplatform%2Fsecurity.json | idc/cloudBeePayloads/configForCurrentUser.json | 204           |                  |
      | application/json |            |       | Delete | settings/user?path=com%2Fasg%2Fdis%2Fplatform%2Fsecurity.json |                                                | 204           |                  |
      | application/json |            |       | Put    | settings/user?path=com%2Fasg%2Fdis%2Fplatform%2Fsecurity.json | idc/cloudBeePayloads/configForCurrentUser.json | 204           |                  |
      | application/json |            |       | Get    | settings/catalogs                                             |                                                | 200           |                  |
      | application/json |            |       | Post   | settings/catalogs                                             | idc/cloudBeePayloads/configCreateCatalog.json  | 204           |                  |
      | application/json |            |       | Get    | settings/catalogs/TESTCLOUDBEE CATALOG                        |                                                | 200           |                  |
      | application/json | deleteData | true  | Delete | settings/catalogs/TESTCLOUDBEE%20CATALOG                      |                                                | 204           |                  |
      | application/json |            |       | Get    | settings/catalogs/images/BigData                              |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/catalogs/images                                      |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/catalogs/recent/1                                    |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/catalogs/BigData/types                               |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/catalogs/schemas                                     |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/catalogs/{catalogname}/types/creatable               |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/components/dataSample                                |                                                | 200           |                  |
      | application/json |            |       | Delete | settings/components/dataSample                                |                                                | 204           |                  |
      | application/json |            |       | Put    | settings/components/dataSample                                | idc/cloudBeePayloads/configComponent.json      | 204           |                  |
      | application/json |            |       | Get    | settings/components                                           |                                                | 200           |                  |
      | application/json |            |       | Put    | settings/diagram/test_h                                       | idc/cloudBeePayloads/configDiagram.json        | 204           |                  |
      | application/json |            |       | Get    | settings/diagram                                              |                                                | 200           |                  |
      | application/json |            |       | Delete | settings/diagram/test_h                                       |                                                | 204           |                  |
      | application/json |            |       | Get    | settings/license                                              |                                                | 200           |                  |
      | application/json |            |       | Put    | settings/license                                              | idc/cloudBeePayloads/configLicenseKeyNull.json | 204           |                  |
      | application/json |            |       | Post   | settings/queries/CLOUDBEE CATALOG                             | idc/cloudBeePayloads/configQueriesPost.json    | 200           |                  |
      | application/json |            |       | Get    | settings/queries/types                                        |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/queries/queryDiagramIn                               |                                                | 200           |                  |
      | application/json |            |       | Delete | settings/queries/queryDiagramIn                               |                                                | 204           |                  |
      | application/json |            |       | Put    | settings/queries/queryDiagramIn                               | idc/cloudBeePayloads/configQueriesPut.json     | 204           |                  |
      | application/json |            |       | Get    | settings/queries                                              |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/schemas/list                                         |                                                | 200           |                  |
#      | application/json |           |       | Get    | settings/schemas                                          |                                                | 200           |                  |
      | application/json | namesOnly  | false | Get    | settings/searches/fields/CLOUDBEE CATALOG                     |                                                | 200           |                  |
      | application/json | namesOnly  | false | Get    | settings/searches/fields                                      |                                                | 200           |                  |
      | application/json | raw        | false | Get    | settings/searches                                             |                                                | 200           |                  |
      | application/json | namesOnly  | false | Get    | settings/searches/fields/CLOUDBEE CATALOG/asg.dataSets_ss     |                                                | 200           |                  |
      | application/json |            |       | Put    | settings/searches                                             | idc/cloudBeePayloads/configPutSearches.json    | 204           |                  |
      | application/json |            |       | Get    | settings/socialnotifiers                                      |                                                | 200           |                  |
      | application/json |            |       | Post   | settings/tagtemplates                                         | idc/cloudBeePayloads/configTagTempPost.json    | 204           |                  |
      | application/json |            |       | Delete | settings/tagtemplates/TestTagTemplate1                        |                                                | 204           |                  |
      | application/json |            |       | Get    | settings/tagtemplates                                         |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/theme/lineage                                        |                                                | 200           |                  |
      | application/json |            |       | Put    | settings/theme/Test                                           | idc/cloudBeePayloads/configThemePut.json       | 204           |                  |
      | application/json |            |       | Delete | settings/theme/Test                                           |                                                | 204           |                  |
      | application/json |            |       | Get    | settings/theme                                                |                                                | 200           |                  |
      | application/json |            |       | Get    | settings/notifications                                        |                                                | 200           |                  |
      | application/json |            |       | Get    | statistics/uris                                               |                                                | 200           |                  |
      | application/json |            |       | Get    | statistics/requests                                           |                                                | 200           |                  |
      | application/json |            |       | Get    | statistics/responses                                          |                                                | 200           |                  |


  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in dataSet service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type   | url               | body                                  | response code | response message |
      | application/json | raw   | false | Get    | settings/datasets |                                       | 200           |                  |
      | application/json |       |       | Delete | settings/datasets |                                       | 204           |                  |
      | application/json |       |       | Put    | settings/datasets | idc/cloudBeePayloads/dataSetsPut.json | 204           |                  |
      | application/json |       |       | Get    | settings/datasets |                                       | 200           |                  |

  @shakeout @positive
  Scenario: Verification of creating a DataSets with no dataElements
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/cloudBeePayloads/dataSetCreateNoElements.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataSet with empty DataElements", Description "DataSet with empty DataElements" and status as "PUBLIC"
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned


  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in dashboard service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type   | url                                             | body                                              | response code | response message |
      | application/json | raw   | false | Get    | dashboards/widgets                              |                                                   | 200           |                  |
      | application/json |       |       | Get    | dashboards/QuickStart                           |                                                   | 200           |                  |
      | application/json |       |       | Post   | dashboards/                                     | idc/cloudBeePayloads/dashBoardPost.json           | 204           |                  |
      | application/json |       |       | Post   | dashboards/IDCTest/widgets                      | idc/cloudBeePayloads/dashBoardAnalysisUpdate.json | 200           |                  |
      | application/json |       |       | Delete | dashboards/IDCTest/open-tasks-widget/open-tasks |                                                   | 204           |                  |
      | application/json |       |       | Delete | dashboards/IDCTest                              |                                                   | 204           |                  |
      | application/json |       |       | Get    | dashboards/datasets                             |                                                   | 200           |                  |
      | application/json |       |       | Get    | dashboards                                      |                                                   | 200           |                  |
      | application/json |       |       | Get    | dashboards/open-tasks/image                     |                                                   | 204           |                  |
      | application/json |       |       | Get    | dashboards/queryDiagramIn/charts                |                                                   | 200           |                  |
      | application/json |       |       | Get    | dashboards/queryDiagramIn/widgets               |                                                   | 200           |                  |
      | application/json |       |       | Get    | navmenu                                         |                                                   | 200           |                  |
      | application/json |       |       | Post   | quicklinks/                                     | idc/cloudBeePayloads/dashBoardQuickLinkPost.json  | 200           |                  |
      | application/json |       |       | Put    | quicklinks/1                                    | idc/cloudBeePayloads/dashBoardQuickLinkPut.json   | 204           |                  |
      | application/json |       |       | Get    | quicklinks/1                                    |                                                   | 200           |                  |
      | application/json |       |       | Delete | quicklinks/1                                    |                                                   | 204           |                  |

  @shakeout @positive
  Scenario: Verification of importing items into catalog
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/cloudBeePayloads/CatalogData.xml"
    When user makes a REST Call for POST request with url "import/CLOUDBEE%20CATALOG?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
    Then Status code 200 must be returned

  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in Item service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query       | Param | type   | url                                                                                    | body                                                    | response code | response message |
      | application/json | allowUpdate | false | Post   | items/CLOUDBEE%20CATALOG/root                                                          | idc/cloudBeePayloads/itemCreationPost.json              | 200           |                  |
      | application/json | raw         | false | Get    | items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Database:::1                               |                                                         | 200           |                  |
      | application/json |             |       | Get    | items/CLOUDBEE%20CATALOG/relations?limit=10                                            |                                                         | 200           |                  |
      | application/json |             |       | Delete | items/CLOUDBEE CATALOG/CLOUDBEE%20CATALOG.Database:::1                                 |                                                         | 204           |                  |
      | application/json |             |       | Post   | items/CLOUDBEE%20CATALOG/env?dir=%3C-%3E&limit=0                                       | idc/cloudBeePayloads/ItemId.json                        | 200           |                  |
      | application/json |             |       | Get    | items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1/env?dir=%3C-%3E&limit=0    |                                                         | 200           |                  |
      | application/json |             |       | Get    | items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1/siblings                   |                                                         | 200           |                  |
      | application/json |             |       | Put    | items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Column%3A%3A%3A1                           | idc/cloudBeePayloads/ItemUpdate.json                    | 204           |                  |
      | application/json | allowUpdate | false | Post   | items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1                            | idc/cloudBeePayloads/itemCreationwithScopeIdPost.json   | 200           |                  |
      | application/json | allowUpdate | false | Post   | items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1/definitions                | idc/cloudBeePayloads/itemCreationwithScopeAttrPost.json | 200           |                  |
      | application/json |             |       | Post   | items/CLOUDBEE%20CATALOG/delete                                                        | idc/cloudBeePayloads/DeleteMultipleItems.json           | 204           |                  |

  @shakeout @positive
  Scenario: Verification of hard deletion of items
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get the column "Col5" id from the following query
      | description | schemaName       | tableName | columnName | criteriaName |
      | SELECT      | CLOUDBEE CATALOG | V_Column  | ID         | name         |
    And user makes a REST Call for DELETE request with url "items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Column" with softdelete as "true"
    And Status code 204 must be returned
    And user makes a REST Call for GET request with url "items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Column" for the stored id
    When user makes a REST Call for POST request with url "items/CLOUDBEE%20CATALOG/harddelete?timestamp=" with timestamp
    And Status code 200 must be returned

  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in Searches service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type   | url                                                                                                           | body                                     | response code | response message |
      | application/json |       |       | Get    | searches/CLOUDBEE%20CATALOG/list/Column?limit=0                                                               |                                          | 200           |                  |
      | application/json |       |       | Get    | searches/CLOUDBEE%20CATALOG/query/queryDiagramIn/CLOUDBEE%20CATALOG.Column%3A%3A%3A1?limit=0                  |                                          | 200           |                  |
      | application/json |       |       | Get    | searches/CLOUDBEE%20CATALOG/query/TopTags?limit=0                                                             |                                          | 200           |                  |
      | application/json |       |       | Post   | searches/CLOUDBEE%20CATALOG/query/queryDiagramIn?limit=0                                                      | idc/cloudBeePayloads/SearchesItemId.json | 200           |                  |
      | application/json |       |       | Get    | searches/CLOUDBEE%20CATALOG?query=g.V().hasLabel(%27%24%7Bschema%7D.Database%27)%20&limit=0                   |                                          | 200           |                  |
      | application/json |       |       | Post   | searches/CLOUDBEE%20CATALOG?query=g.V().hasLabel(%27%24%7Bschema%7D.Table%27)%20&limit=0                      | idc/cloudBeePayloads/SearchesItemId.json | 200           |                  |
      | application/json |       |       | Post   | searches/CLOUDBEE%20CATALOG/query/TopTags/parameters?limit=0                                                  |                                          | 200           |                  |
      | application/json |       |       | Post   | searches/CLOUDBEE%20CATALOG/parameters?query=g.V().hasLabel(%27%24%7Bschema%7D.Database%27)%20&limit=0        |                                          | 200           |                  |
      | text/json        |       |       | Post   | searches                                                                                                      | idc/cloudBeePayloads/GremlinQuery.txt    | 200           |                  |
      | application/json |       |       | Get    | searches/fulltext?query=type%20%3D%20Table&advanced=false&limit=10&offset=0                                   |                                          | 200           |                  |
      | application/json |       |       | Post   | searches/fulltext?query=type%20%3D%20Table&advanced=false&limit=10&offset=0&limitFacets=10                    |                                          | 200           |                  |
      | application/json |       |       | Get    | searches/fulltext/CLOUDBEE%20CATALOG?query=type%20%3D%20Table&advanced=false&limit=10&offset=0                |                                          | 200           |                  |
      | application/json |       |       | Post   | searches/fulltext/CLOUDBEE%20CATALOG?query=type%20%3D%20Table&advanced=false&limit=10&offset=0&limitFacets=10 |                                          | 200           |                  |
      | application/json |       |       | Get    | searches/fulltext/autosuggest/CLOUDBEE%20CATALOG/Column?input=customer&limit=10                               |                                          | 200           |                  |
      | application/json |       |       | Get    | searches/fulltext/autosuggest/CLOUDBEE%20CATALOG?input=customer&limit=10                                      |                                          | 200           |                  |
      | application/json |       |       | Get    | searches/fulltext/autosuggest?input=customer&limit=10                                                         |                                          | 200           |                  |
      | application/json |       |       | Post   | searches/fulltext/synchronize/CLOUDBEE%20CATALOG?limit=0&maxSeconds=0&hoursUntilNext=48                       |                                          | 200           |                  |
      | application/json |       |       | Delete | searches/fulltext/synchronize/CLOUDBEE%20CATALOG                                                              |                                          | 200           |                  |
      | application/json |       |       | Delete | searches/fulltext/synchronize?catalogname=CLOUDBEE%20CATALOG&doReset=false                                    |                                          | 200           |                  |
      | application/json |       |       | Post   | searches/fulltext/synchronize?catalogname=CLOUDBEE%20CATALOG&limit=0&maxSeconds=0&hoursUntilNext=48           |                                          | 200           |                  |


  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in Collaboration service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type   | url                                                                                               | body                                      | response code | response message |
      | application/json |       |       | Post   | comments/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1                                    | idc/cloudBeePayloads/analysisCloudBee.txt | 200           |                  |
      | application/json |       |       | Get    | comments/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1                                    |                                           | 200           |                  |
      | application/json |       |       | Put    | comments/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Comment%3A%3A%3A1                                  | idc/cloudBeePayloads/CommentsUpdated.txt  | 204           |                  |
      | application/json |       |       | Get    | comments/preview/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1                            |                                           | 200           |                  |
      | application/json |       |       | Delete | comments/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Comment%3A%3A%3A1                                  |                                           | 204           |                  |
      | application/json |       |       | Post   | ratings/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1/5                                   |                                           | 201           |                  |
      | application/json |       |       | Get    | ratings/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1?limit=10&order=date&reverse=true    |                                           | 200           |                  |
      | application/json |       |       | Post   | recommendations/update/CLOUDBEE%20CATALOG                                                         |                                           | 200           |                  |
#      | application/json |       |       | Get    | recommendations/items/CLOUDBEE%20CATALOG                                                          |                                           | 200           |                  |
#      | application/json |       |       | Get    | recommendations/items/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1                       |                                           | 200           |                  |
      | application/json |       |       | Delete | ratings/CLOUDBEE%20CATALOG/CLOUDBEE%20CATALOG.Table%3A%3A%3A1                                     |                                           | 204           |                  |
      | application/json |       |       | Delete | recommendations/update/CLOUDBEE%20CATALOG                                                         |                                           | 204           |                  |

  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in Security service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type   | url                                                                               | body                                            | response code | response message |
      | application/json |       |       | Put    | accesses/BigData/BigData.Table%3A%3A%3A1?recursive=false&operation=SET            | idc/cloudBeePayloads/SystemAccess.json          | 204           |                  |
      | application/json |       |       | Get    | accesses/BigData/BigData.Table%3A%3A%3A1?recursive=false                          |                                                 | 200           |                  |
      | application/json |       |       | Delete | accesses/BigData/BigData.Table%3A%3A%3A1?recursive=false                          |                                                 | 204           |                  |
      | application/json |       |       | Post   | accesses/BigData?recursive=false&operation=SET&acluser=TestSystem&aclgroup=System | idc/cloudBeePayloads/MultipleItemsAccess.json   | 204           |                  |
      | application/json |       |       | Delete | accesses/BigData/BigData.Table%3A%3A%3A4?recursive=false                          |                                                 | 204           |                  |
      | application/json |       |       | Delete | accesses/BigData/BigData.Table%3A%3A%3A5?recursive=false                          |                                                 | 204           |                  |
      | application/json |       |       | Get    | users/roles                                                                       |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/usergroups                                                                  |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/permissions/tenant                                                          |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/permissions/catalog/CLOUDBEE%20CATALOG                                      |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/roles/tenant                                                                |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/roles/catalog/CLOUDBEE%20CATALOG                                            |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/ratings/CLOUDBEE%20CATALOG?limit=10&order=date&reverse=true                 |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/profile                                                                     |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/catalogs                                                                    |                                                 | 200           |                  |
      | application/json |       |       | Get    | users                                                                             |                                                 | 200           |                  |
      | application/json |       |       | Get    | users/permissions                                                                 |                                                 | 200           |                  |
      | application/json |       |       | Get    | encrypt?connectionName=ADMIN&connectionPassword=ADMIN                             |                                                 | 200           |                  |
      | application/json |       |       | Get    | permissions                                                                       |                                                 | 200           |                  |
      | application/json |       |       | Post   | roles                                                                             | idc/cloudBeePayloads/RoleCreation.json          | 204           |                  |
      | application/json |       |       | Post   | rolemappings                                                                      | idc/cloudBeePayloads/PostRolemapping.json       | 204           |                  |
      | application/json |       |       | Put    | rolemappings                                                                      | idc/cloudBeePayloads/PutRolemapping.json        | 204           |                  |
      | application/json |       |       | Get    | rolemappings                                                                      |                                                 | 200           |                  |
      | application/json |       |       | Delete | rolemappings?rolename=NewTestRole&usergroup=System                                |                                                 | 204           |                  |
      | application/json |       |       | Post   | rolemappings/tenant                                                               | idc/cloudBeePayloads/PostRolemapping.json       | 204           |                  |
      | application/json |       |       | Get    | rolemappings/tenant                                                               |                                                 | 200           |                  |
      | application/json |       |       | Put    | rolemappings/tenant                                                               | idc/cloudBeePayloads/PutRolemapping.json        | 204           |                  |
      | application/json |       |       | Delete | rolemappings/tenant?rolename=NewTestRole&usergroup=System                         |                                                 | 204           |                  |
      | application/json |       |       | Post   | rolemappings/catalog/CLOUDBEE%20CATALOG                                           | idc/cloudBeePayloads/PutRolemapping.json        | 204           |                  |
      | application/json |       |       | Put    | rolemappings/catalog/CLOUDBEE%20CATALOG                                           | idc/cloudBeePayloads/PutRolemapping.json        | 204           |                  |
      | application/json |       |       | Get    | rolemappings/catalog/CLOUDBEE%20CATALOG                                           |                                                 | 200           |                  |
      | application/json |       |       | Delete | rolemappings/catalog/CLOUDBEE%20CATALOG?rolename=NewTestRole                      |                                                 | 204           |                  |
      | application/json |       |       | Get    | roles/SYSTEM_ADMIN                                                                |                                                 | 200           |                  |
      | application/json |       |       | Get    | roles                                                                             |                                                 | 200           |                  |
      | application/json |       |       | Put    | roles/NewTestRole                                                                 | idc/cloudBeePayloads/RoleUpdate.json            | 204           |                  |
      | application/json |       |       | Get    | roles/tenant                                                                      |                                                 | 200           |                  |
      | application/json |       |       | Post   | roles/tenant                                                                      | idc/cloudBeePayloads/TenantRoleCreation.json    | 204           |                  |
      | application/json |       |       | Get    | roles/catalog/CLOUDBEE%20CATALOG                                                  |                                                 | 200           |                  |
      | application/json |       |       | Get    | roles/tenant/SYSTEM_ADMIN                                                         |                                                 | 200           |                  |
      | application/json |       |       | Put    | roles/tenant/TestRole                                                             | idc/cloudBeePayloads/TenantRoleUpdate.json      | 204           |                  |
      | application/json |       |       | Delete | roles/tenant/TestRole                                                             |                                                 | 204           |                  |
      | application/json |       |       | Delete | roles/NewTestRole                                                                 |                                                 | 204           |                  |
      | application/json |       |       | Get    | usergroups                                                                        |                                                 | 200           |                  |
      | application/json |       |       | Post   | usergroups/users                                                                  | idc/cloudBeePayloads/UsergroupsUsers.json       | 200           |                  |
      | application/json |       |       | Post   | usergroups/userdetails                                                            | idc/cloudBeePayloads/UsergroupsUserdetails.json | 200           |                  |
      | application/json |       |       | Get    | usergroups/users                                                                  |                                                 | 200           |                  |
      | application/json |       |       | Get    | usergroups/DI%20QA%20Team                                                         |                                                 | 200           |                  |
      | application/json |       |       | Get    | usergroups/users/TestSystem                                                       |                                                 | 200           |                  |


  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in Workflows service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type   | url                                                                                                                 | body                                     | response code | response message |
      | application/json |       |       | Get    | events/types                                                                                                        |                                          | 200           |                  |
      | application/json |       |       | Get    | workflows/instances/urn%3Ajsonschema%3Acom%3Aasg%3Adis%3Acommon%3Adata%3Aevents%3AItemCommentDeletedEvent/variables |                                          | 200           |                  |
      | xml/json         |       |       | Put    | workflows/deployments/test                                                                                          | idc/cloudBeePayloads/wait-for-event.bpmn | 200           |                  |
      | xml/xml          |       |       | Get    | workflows/definitions/wait-for-event                                                                                |                                          | 200           |                  |
      | application/json |       |       | Post   | workflows/definitions/wait-for-event/start                                                                          | idc/cloudBeePayloads/empty.json          | 200           |                  |
      | application/json |       |       | Get    | workflows/definitions/wait-for-event/instances                                                                      |                                          | 200           |                  |
      | application/json |       |       | Get    | workflows/instances/urn%3Ajsonschema%3Acom%3Aasg%3Adis%3Acommon%3Aconfig%3Aevents%3AAnalyzerDeleteEvent             |                                          | 204           |                  |
      | application/json |       |       | Get    | workflows/tasks/user                                                                                                |                                          | 200           |                  |
      | application/json |       |       | Get    | workflows/definitions                                                                                               |                                          | 200           |                  |
      | application/json |       |       | Delete | workflows/deployments/test                                                                                          |                                          | 204           |                  |


  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in Workflows service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type | url                      | body                                          | response code | response message |
      | application/json |       |       | Post | settings/catalogs        | idc/cloudBeePayloads/uploadCreateCatalog.json | 204           |                  |
      | application/json |       |       | Get  | settings/catalogs/UPLOAD |                                               | 200           |                  |

  @shakeout @positive
  Scenario: Verification of uploading xlsx file with allow update as true
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/SampleAutomationData.xlsx" to request
    When user makes a REST Call for POST request with url "/uploads/UPLOAD" with the following query param
      | databaseName | northwind                 |
      | tableName    | inventory_fact_Automation |
      | clusterName  | Cluster Test              |
      | allowUpdate  | true                      |
    Then Status code 200 must be returned
    And excel "SampleAutomationData.xlsx" should be uploaded to uploadData table
      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | UPLOAD     | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |


  @shakeout @positive
  Scenario: Verification of downloading xlsx file
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/UPLOAD/content" with the following query param
      | databaseName | northwind                 |
      | tableName    | inventory_fact_Automation |
      | clusterName  | Cluster Test              |
    Then Status code 200 must be returned
    And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "inventory_file.xlsx"
    And both "UPLOAD_FILE_PATH" directory file "SampleAutomationData.xlsx" and "DOWNLOAD_FILE_PATH" directory file "inventory_file.xlsx" should match

  @shakeout @positive
  Scenario: Verification of GET request of Upload file data
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "uploads/UPLOAD/uploaddata" with the following query param
      | databaseName | northwind                 |
      | tableName    | inventory_fact_Automation |
      | clusterName  | Cluster Test              |
    Then Status code 200 must be returned
    And Database "northwind" and tableName "inventory_fact_Automation" and cluster "Cluster Test" and file "SampleAutomationData.xlsx"should be matching


  @shakeout @positive
  Scenario: Verification of DELETE request for uploaded file
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for DELETE request with url "uploads/UPLOAD" with the following query param
      | databaseName | northwind                 |
      | tableName    | inventory_fact_Automation |
      | clusterName  | Cluster Test              |
    Then Status code 200 must be returned
    And file "SampleAutomationData.xlsx" should be removed from "northwind" database and "inventory_fact_Automation" table
      | description | schemaName | tableName    | columnName | criteriaName           |
      | SELECT      | UPLOAD     | V_UploadData | status     | databaseName,tableName |

  @shakeout @positive
  Scenario Outline: Login Scenario - To verify status code of all end point in tag service
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query       | Param | type   | url                                                             | body                                         | response code | response message |
      | application/json |             |       | Post   | settings/catalogs                                               | idc/cloudBeePayloads/tagCatalog.json         | 204           |                  |
      | application/json | allowUpdate | false | Post   | items/TAGCATALOG/root                                           | idc/cloudBeePayloads/tagItemCreation.json    | 200           |                  |
      | application/json | raw         | false | Get    | items/TAGCATALOG/TAGCATALOG.TestItemForTag:::1                  |                                              | 200           |                  |
      | application/json |             |       | Post   | tags/TAGCATALOG/tags                                            | idc/cloudBeePayloads/tagCreate.json          | 200           |                  |
      | application/json |             |       | Put    | tags/TAGCATALOG/tags/Trustworthy                                | idc/cloudBeePayloads/tagUpdate.json          | 200           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/tags/Trustworthy                                |                                              | 200           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/structures                                      |                                              | 200           |                  |
      | application/json | keepOld     | false | Post   | tags/TAGCATALOG/structures                                      | idc/cloudBeePayloads/tagStructureUpdate.json | 204           |                  |
      | application/json |             |       | Post   | tags/TAGCATALOG/assignments                                     | idc/cloudBeePayloads/assignTagToItem.json    | 204           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/Trustworthy/items?subtags=true&limit=1&offset=0 |                                              | 200           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/items?subtags=true&limit=1&offset=0             |                                              | 200           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/Untrusted/subtags                               |                                              | 200           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/list                                            |                                              | 200           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/list/TAGCATALOG.TestItemForTag%3A%3A%3A1        |                                              | 200           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/assignments                                     |                                              | 200           |                  |
      | application/json |             |       | Get    | tags/TAGCATALOG/tags/ids/TAGCATALOG.Tag%3A%3A%3A3               |                                              | 200           |                  |
      | application/json |             |       | Delete | tags/TAGCATALOG/tags/TrustworthyUpdated                         |                                              | 204           |                  |
      | application/json |             |       | Delete | /settings/catalogs/TAGCATALOG                                   |                                              | 204           |                  |


  @shakeout @positive
  Scenario:MLP-1667: To verify created upload catalog is deleted
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/settings/catalogs/UPLOAD"
    Then Status code 204 must be returned

  @shakeout @positive
  Scenario:MLP-1667: To verify created catalog is deleted
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CLOUDBEE%20CATALOG"
    Then Status code 204 must be returned