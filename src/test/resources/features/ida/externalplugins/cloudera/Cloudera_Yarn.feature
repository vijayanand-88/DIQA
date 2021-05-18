@MLP-4851
Feature:MLP-4851: cloudera_Yarn

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
  Scenario Outline:MLP-4851_SC1#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4851_Yarn.json | 204           |                  |          |


  ##6118333##
  @MLP-4851 @webtest @positive @regression @cloudera @MLPQA-18068
  Scenario:SC#1_MLP_4851_Verify the cloudEraNavigator metadata attributes matches with IDC UI metadata attributes for Yarn operations
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                          |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                           |      | 200           | YarnMetadata     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/YarnMetadata |      | 200           | IDLE             | $.[?(@.configurationName=='YarnMetadata')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body | response code | response message | jsonPath                                          |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/YarnMetadata  |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/YarnMetadata |      | 200           | IDLE             | $.[?(@.configurationName=='YarnMetadata')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4851SC1" and clicks on search
    And user performs "facet selection" in "CN4851SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                               | fileName                       | userTag   |
      | Default     | Execution | Metadata Type | Cloudera Navigator,CN4851SC1,Yarn | job_1543825282419_0004_8094873 | CN4851SC1 |
    And user stores cloud era list values with below parameters
      | Service           | cloudEra Endpoint                                                          | cloudEraJsonPath |
      | CloudEraNavigator | /entities?query=((sourceType:yarn)AND(type:operation))&limit=1000&offset=0 | $..originalName  |
    And user reset the REST API Service
    And configure a new REST API for the service "IDC"
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for GET request with url "tags/Default/CN4851SC1/items?subtags=true&limit=0&offset=0" and save the response in file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json"
    Then user compares "tempList" value and value from file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json" using json path "$.[?(@.type=='Operation')].name"
    And user clicks on logout button

##6118347##
  @MLP-4851 @positive @regression @cloudera
  Scenario:SC#2_MLP_4851_Verify the cloudEraNavigator metadata attributes matches with IDC UI metadata attributes for Yarn operation executions
    And user stores cloud era list values with below parameters
      | Service           | cloudEra Endpoint                                                                    | cloudEraJsonPath |
      | CloudEraNavigator | /entities?query=((sourceType:yarn)AND(type:operation_execution))&limit=1000&offset=0 | $..originalName  |
    And user reset the REST API Service
    And configure a new REST API for the service "IDC"
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for GET request with url "tags/Default/CN4851SC1/items?subtags=true&limit=0&offset=0" and save the response in file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json"
    Then user compares "tempList" value and value from file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json" using json path "$.[?(@.type=='Execution')].name"


##6118440##
  @MLP-4851 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_4851_Verify the dependent operations are not collected if sourceType is Yarn operation and scanRelations is OFF
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4851SC1" and clicks on search
    And user performs "facet selection" in "CN4851SC1" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Analysis  |
      | Cluster   |
      | Service   |
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 468   |
      | YARN [Service]                | 467   |
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | HIVE [Service]  |
      | HDFS [Service]  |
      | SQOOP [Service] |
      | PIG [Service]   |
    And user enters the search text "wordcount_191636" and clicks on search
    And user performs "facet selection" in "CN4851SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "wordcount_191636" item from search results
    Then user performs click and verify in new window
      | Table              | value                         | Action                 | RetainPrevwindow | indexSwitch |
      | Runtime Executions | job_1530878259893_0005_191637 | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4851_SC#1,2,3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name       | type      | query | param |
      | MultipleIDDelete | Default | select%    | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%    | Operation |       |       |
      | MultipleIDDelete | Default | create%    | Operation |       |       |
      | MultipleIDDelete | Default | CREATE%    | Operation |       |       |
      | MultipleIDDelete | Default | FROM%      | Operation |       |       |
      | MultipleIDDelete | Default | sqoop%     | Operation |       |       |
      | MultipleIDDelete | Default | insert%    | Operation |       |       |
      | MultipleIDDelete | Default | Pig%       | Operation |       |       |
      | MultipleIDDelete | Default | wordcount% | Operation |       |       |
      | MultipleIDDelete | Default | Movies%    | Operation |       |       |
      | MultipleIDDelete | Default | stunts%    | Operation |       |       |
      | MultipleIDDelete | Default | employee%  | Operation |       |       |
      | MultipleIDDelete | Default | Hdfs%      | Operation |       |       |
      | MultipleIDDelete | Default | job%       | Execution |       |       |

  @MLP-4441 @sanity @positive
  Scenario:4851_SC#1,2,3:Delete Analysis id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/YarnMetadata% | Analysis |       |       |

  ##6118371##6118584##6118412##
  @MLP-4851 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_4851_Verify the dependent hdfs and yarn operations also should be collected if sourceType is Yarn operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/CloudEraCatalog?deleteData=true"
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/YarnScanON |      | 200           | IDLE             | $.[?(@.configurationName=='YarnScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/YarnScanON  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/YarnScanON |      | 200           | IDLE             | $.[?(@.configurationName=='YarnScanON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4851SC4" and clicks on search
    And user performs "facet selection" in "CN4851SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    Then user verify "verify presence" with following values under "Items List" section in item search results page
      | YARN  |
      | HDFS  |
      | PIG   |
      | SQOOP |
      | HIVE  |
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 5     |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4851_SC#4:Delete Analysis id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/YarnScanON% | Analysis |       |       |


  ##6118584##
  @MLP-4851 @webtest @positive @regression @cloudera
  Scenario:SC#5_MLP_4851_Verify the top level include name filters check for YARN operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/YarnInclude |      | 200           | IDLE             | $.[?(@.configurationName=='YarnInclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/YarnInclude  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/YarnInclude |      | 200           | IDLE             | $.[?(@.configurationName=='YarnInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "*wordcount*" and clicks on search
    And user performs "facet selection" in "CN4851SC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user stores cloud era list values with below parameters
      | Service           | cloudEra Endpoint                                                                   | cloudEraJsonPath |
      | CloudEraNavigator | /entities?query=((sourceType:yarn)AND(type:operation)AND(originalName:*wordcount*)) | $..originalName  |
    And user reset the REST API Service
    And configure a new REST API for the service "IDC"
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for GET request with url "tags/Default/CN4851SC5/items?subtags=true&limit=0&offset=0" and save the response in file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json"
    Then user compares "tempList" value and value from file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json" using json path "$.[?(@.type=='Operation')].name"
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4851_SC#5:Delete Analysis id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/YarnInclude% | Analysis |       |       |


  ##6118586##
  @MLP-4851 @webtest @positive @regression @cloudera
  Scenario:SC#6_MLP_4851_Verify the top level exclude name filters check for YARN operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/YarnExclude |      | 200           | IDLE             | $.[?(@.configurationName=='YarnExclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/YarnExclude  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/YarnExclude |      | 200           | IDLE             | $.[?(@.configurationName=='YarnExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4851SC6" and clicks on search
    And user performs "facet selection" in "CN4851SC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    Then user verify "verify presence" with following values under "Items List" section in item search results page
      | YARN  |
      | HDFS  |
      | PIG   |
      | SQOOP |
      | HIVE  |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4851_SC#6:Delete Analysis id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/YarnExclude% | Analysis |       |       |
      | SingleItemDelete | Default | Cloudera QuickStart                        | Cluster  |       |       |


##6118603##
  @webtest @MLP-4851 @positive @regression @cloudera @MLPQA-18068
  Scenario:SC#7_MLP-4851_Verify the time intervals filters check for YARN operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                       |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/YarnDates |      | 200           | IDLE             | $.[?(@.configurationName=='YarnDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                       |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/YarnDates  |      | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/YarnDates |      | 200           | IDLE             | $.[?(@.configurationName=='YarnDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                        | fileName                       | userTag   |
      | Default     | Execution | Metadata Type | Cloudera Navigator,CN4851SC7,TagDates,Yarn | job_1543825282419_0004_8094873 | CN4851SC7 |
    And user enters the search text "CN4851SC7" and clicks on search
    And user performs "facet selection" in "CN4851SC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                    | Feature           | jsonPath        |
      | /entities?query=((sourceType:yarn)AND(type:operation_execution)AND(started:[2018-12-01T01:00:00.000Z TO 2019-08-08T00:00:00.000Z])) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:4851_SC8-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:4851_SC#9:Delete cluster id and Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |