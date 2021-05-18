@MLP-4850
Feature:MLP-4850: cloudera_MapReduce

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC1#-Set the Credentials and DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaValidCredentials   | ida/cloudEraNavigatorPayloads/Credentials/Valid.json               | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaInValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/Invalid.json             | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource         | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource         |                                                                    | 200           | CNavigatorDataSource |          |

  @MLP-4610 @positive @regression @cloudera
  Scenario Outline:MLP-4850_SC1#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4850_MapReduce.json | 204           |                  |          |


  ##6239218##
  @MLP-4850 @webtest @positive @regression @cloudera @MLPQA-18071
  Scenario:SC#1_MLP_4850_Verify the dependent services and entities are also collected if Source Type is Map Reduce Operations and Scan relations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                             |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                              |      | 200           | MapReduceScanON  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/MapReduceScanON |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/MapReduceScanON  |      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/MapReduceScanON |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceScanON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4850SC1" and clicks on search
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                    | fileName          | userTag   |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CN4850SC1,MapReduce | wordcount_5431085 | CN4850SC1 |
    And user enters the search text "CN4850SC1" and clicks on search
    And user performs "facet selection" in "CN4850SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    When user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table | value    | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | input    | verify widget contains |                  |             |
      | uses  | output13 | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value             | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath  |
      | Lineage Hops | input => output13 | click and verify lineagehops | Yes              |             | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest1 |
    And user clicks on logout button


  @MLP-4441 @sanity @positive
  Scenario:4850_SC#1:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type      | query | param |
      | MultipleIDDelete | Default | wordcount%                                     | Operation |       |       |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/MapReduceScanON% | Analysis  |       |       |
      | MultipleIDDelete | Default | job%                                           | Execution |       |       |
      | MultipleIDDelete | Default | ROOT%                                          | Directory |       |       |


##6239295##
  @MLP-4850 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_4850_Verify only MapReduce service should be visible and it should contain only MapReduce operation/execution when scanRelations is OF
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message | jsonPath                                              |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/MapReduceScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceScanOFF')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/MapReduceScanOFF  |      | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/MapReduceScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceScanOFF')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4850SC2" and clicks on search
    And user performs "facet selection" in "CN4850SC2" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 6     |
      | MAPREDUCE [Service]           | 5     |
      | wordcount_5431085 [Operation] | 4     |
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    When user clicks on first item on the item list page
    And user "widget not present" on "USES" in Item view page
    And user "widget not present" on "LINEAGE HOPS" in Item view page
    Then user performs click and verify in new window
      | Table              | value                         | Action                 | RetainPrevwindow | indexSwitch |
      | Runtime Executions | job_201810202026_0001_5431086 | verify widget contains |                  |             |
      | Runtime Executions | job_201810202026_0002_5431087 | verify widget contains |                  |             |
      | Runtime Executions | job_201810202026_0003_5435211 | verify widget contains |                  |             |
    And user clicks on logout button

##6239382##
  @webtest @MLP-4850 @positive @regression @cloudera
  Scenario:SC#3_MLP_4850_Verify MapReduce metadata and count of MapReduce operation/execution appearing in IDC UI matches with corresponding metadata and count of MapReduce operation/execution in cloudEraNavigator
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4850SC2" and clicks on search
    And user performs "facet selection" in "CN4850SC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                       | Feature           | jsonPath        |
      | /entities?query=((sourceType:mapreduce)AND(type:operation)and(originalName:wordcount)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN4850SC2" and clicks on search
    And user performs "facet selection" in "CN4850SC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                      | Feature           | jsonPath        |
      | /entities?query=((sourceType:mapreduce)AND(type:operation_execution)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4850_SC#2,3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type      | query | param |
      | MultipleIDDelete | Default | wordcount%                                      | Operation |       |       |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/MapReduceScanOFF% | Analysis  |       |       |
      | MultipleIDDelete | Default | job%                                            | Execution |       |       |

##6239422##
  @webtest @MLP-4850 @positive @regression @cloudera
  Scenario:SC#4_MLP_4850_Verify the top level include name filters check for MapReduce operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body | response code | response message | jsonPath                                               |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/MapReduceONFilter |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceONFilter')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                               |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/MapReduceONFilter  |      | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/MapReduceONFilter |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceONFilter')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "*word*" and clicks on search
    And user performs "facet selection" in "CN4850SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                    | Feature           | jsonPath        |
      | /entities?query=((sourceType:mapreduce)AND(type:operation)AND(originalName:*word*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "*word*" and clicks on search
    And user performs "facet selection" in "CN4850SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:mapreduce)AND(type:operation_execution)AND(originalName:*job*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4850_SC#4:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type      | query | param |
      | MultipleIDDelete | Default | wordcount%                                       | Operation |       |       |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/MapReduceONFilter% | Analysis  |       |       |
      | MultipleIDDelete | Default | job%                                             | Execution |       |       |


##6239460##
  @webtest @MLP-4850 @positive @regression @cloudera
  Scenario:SC#5_MLP_4850_Verify the top level exclude name filters check for MapReduce operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message | jsonPath                                                |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/MapReduceONExclude |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceONExclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                                |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/MapReduceONExclude  |      | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/MapReduceONExclude |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceONExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4850SC5" and clicks on search
    And user performs "facet selection" in "CN4850SC5" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Operation |
      | Execution |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4850_SC#5:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/MapReduceONExclude% | Analysis |       |       |


##6239482##
  @webtest @MLP-4850 @positive @regression @cloudera
  Scenario:SC#6_MLP_4850_Verify the From Date/To Date and tag filters for MapReduce operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body | response code | response message | jsonPath                                            |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/MapReduceDates |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                        | body | response code | response message | jsonPath                                            |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/MapReduceDates  |      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/MapReduceDates |      | 200           | IDLE             | $.[?(@.configurationName=='MapReduceDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TagDates" and clicks on search
    And user performs "facet selection" in "CN4850SC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                         | Feature           | jsonPath        |
      | /entities?query=((sourceType:mapreduce)AND(type:operation_execution)AND(started:[2018-07-01T01:00:00.000Z TO 2019-08-08T00:00:00.000Z])) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4850_SC#6:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/MapReduceDates% | Analysis  |       |       |
      | MultipleIDDelete | Default | wordcount%                                    | Operation |       |       |
      | MultipleIDDelete | Default | ROOT                                          | Directory |       |       |


  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC7-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:4850_SC#8:Delete cluster id
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |