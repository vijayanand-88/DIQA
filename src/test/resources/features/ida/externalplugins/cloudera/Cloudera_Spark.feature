@MLP-4854
Feature:MLP-4854: cloudera_Spark

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
  Scenario Outline:MLP-4854_SC1#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4854_Spark.json | 204           |                  |          |


  ##6148666##
  @MLP-4854 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_4854_Verify Spark metadata and count of spark operation/execution appearing in IDC UI matches with corresponding metadata and count of spark operation/execution in cloudEra
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body | response code | response message | jsonPath                                           |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                            |      | 200           | SparkMetadata    |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SparkMetadata |      | 200           | IDLE             | $.[?(@.configurationName=='SparkMetadata')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SparkMetadata  |      | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SparkMetadata |      | 200           | IDLE             | $.[?(@.configurationName=='SparkMetadata')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4854SC1" and clicks on search
    And user performs "facet selection" in "CN4854SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                | fileName           | userTag   |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CN4854SC1,Spark | Spark Count_726987 | CN4854SC1 |
    And user stores cloud era list values with below parameters
      | Service           | cloudEra Endpoint                                                           | cloudEraJsonPath |
      | CloudEraNavigator | /entities?query=((sourceType:spark)AND(type:operation))&limit=1000&offset=0 | $..originalName  |
    And user reset the REST API Service
    And configure a new REST API for the service "IDC"
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for GET request with url "tags/Default/CN4854SC1/items?subtags=true&limit=0&offset=0" and save the response in file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json"
    Then user compares "tempList" value and value from file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json" using json path "$.[?(@.type=='Operation')].name"
    And user stores cloud era list values with below parameters
      | Service           | cloudEra Endpoint                                                                     | cloudEraJsonPath |
      | CloudEraNavigator | /entities?query=((sourceType:spark)AND(type:operation_execution))&limit=1000&offset=0 | $..originalName  |
    And user reset the REST API Service
    And configure a new REST API for the service "IDC"
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for GET request with url "tags/Default/CN4854SC1/items?subtags=true&limit=0&offset=0" and save the response in file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json"
    Then user compares "tempList" value and value from file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json" using json path "$.[?(@.type=='Execution')].name"
    And user clicks on logout button

##6148657##
  @MLP-4854 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_4854_Verify single Spark service should be visible and it should contain only Spark operation/execution when scanRelations is OFF
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4854SC1" and clicks on search
    And user performs "facet selection" in "CN4854SC1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 355   |
      | SPARK [Service]               | 354   |
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | HDFS [Service] |
      | HIVE [Service] |
    And user enters the search text "application_1532521880492_0055_1324856" and clicks on search
    And user performs "facet selection" in "CN4854SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "application_1532521880492_0055_1324856" item from search results
    And user "widget not present" on "USES" in Item view page
    And user "widget not present" on "LINEAGE HOPS" in Item view page
    Then user performs click and verify in new window
      | Table              | value                                       | Action                 | RetainPrevwindow | indexSwitch |
      | Runtime Executions | application_1532521880492_0055-Exec_1324857 | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4854_SC#1,2:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SparkMetadata% | Analysis  |       |       |
      | MultipleIDDelete | Default | application%                                 | Operation |       |       |
      | MultipleIDDelete | Default | Big%                                         | Operation |       |       |
      | MultipleIDDelete | Default | Read%                                        | Operation |       |       |
      | MultipleIDDelete | Default | S%                                           | Operation |       |       |
      | MultipleIDDelete | Default | H%                                           | Operation |       |       |
      | MultipleIDDelete | Default | C%                                           | Operation |       |       |
      | MultipleIDDelete | Default | P%                                           | Operation |       |       |
      | MultipleIDDelete | Default | A%                                           | Operation |       |       |
      | MultipleIDDelete | Default | s%                                           | Operation |       |       |
      | MultipleIDDelete | Default | o%                                           | Operation |       |       |


##6148623##
  @MLP-4854 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_4854_Verify the dependent services and entities are also collected if Source Type is Spark Operations and Scan relations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/CloudEraCatalog?deleteData=true"
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SparkScanON |      | 200           | IDLE             | $.[?(@.configurationName=='SparkScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SparkScanON  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SparkScanON |      | 200           | IDLE             | $.[?(@.configurationName=='SparkScanON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4854SC3" and clicks on search
    And user performs "facet selection" in "CN4854SC3" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 382   |
      | SPARK [Service]               | 354   |
      | HIVE [Service]                | 20    |
      | HDFS [Service]                | 7     |
    And user enters the search text "application_1532521880492_0055" and clicks on search
    And user performs "facet selection" in "CN4854SC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "application_1532521880492_0055_1324856" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                             | Action                 | RetainPrevwindow | indexSwitch |
      | uses         | salary                                                            | verify widget contains |                  |             |
      | uses         | name                                                              | verify widget contains |                  |             |
      | Lineage Hops | employeeimp.salary => mycsvsampletable123.dispatching_base_number | verify widget contains |                  |             |
      | Lineage Hops | employeeimp.id => mycsvsampletable123.trips                       | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                                                             | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath  |
      | Lineage Hops | employeeimp.salary => mycsvsampletable123.dispatching_base_number | click and verify lineagehops | No               |             | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest3 |
    And user enters the search text "application_1532521880492_0055" and clicks on search
    And user performs "facet selection" in "CN4854SC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "application_1532521880492_0055_1324856" item from search results
    Then user performs click and verify in new window
      | Table        | value                                       | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath  |
      | Lineage Hops | employeeimp.id => mycsvsampletable123.trips | click and verify lineagehops | No               |             | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest4 |
    And user clicks on logout button


  @MLP-4441 @sanity @positive
  Scenario:4854_SC#3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SparkScanON% | Analysis  |       |       |
      | MultipleIDDelete | Default | application%                               | Operation |       |       |
      | MultipleIDDelete | Default | Python%                                    | Operation |       |       |
      | MultipleIDDelete | Default | Big%                                       | Operation |       |       |
      | MultipleIDDelete | Default | S%                                         | Operation |       |       |
      | MultipleIDDelete | Default | H%                                         | Operation |       |       |
      | MultipleIDDelete | Default | C%                                         | Operation |       |       |
      | MultipleIDDelete | Default | P%                                         | Operation |       |       |
      | MultipleIDDelete | Default | A%                                         | Operation |       |       |
      | MultipleIDDelete | Default | s%                                         | Operation |       |       |
      | MultipleIDDelete | Default | o%                                         | Operation |       |       |
      | MultipleIDDelete | Default | R%                                         | Operation |       |       |
      | MultipleIDDelete | Default | ROOT%                                      | Directory |       |       |
      | MultipleIDDelete | Default | d%                                         | Database  |       |       |


  @MLP-4854 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_4854_Verify the top level include name filters check for pig operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SparkInclude |      | 200           | IDLE             | $.[?(@.configurationName=='SparkInclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body | response code | response message | jsonPath                                          |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SparkInclude  |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SparkInclude |      | 200           | IDLE             | $.[?(@.configurationName=='SparkInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4854SC4" and clicks on search
    And user performs "facet selection" in "CN4854SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                | Feature           | jsonPath        |
      | /entities?query=((sourceType:spark)AND(type:operation)AND(originalName:*0055*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN4854SC4" and clicks on search
    And user performs "facet selection" in "CN4854SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                               | Feature           | jsonPath        |
      | /entities?query=((sourceType:spark)AND(type:operation_execution)AND(originalName:*0055-Exec*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4854_SC#4:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SparkInclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | application%                                | Operation |       |       |
      | MultipleIDDelete | Default | ROOT%                                       | Directory |       |       |
      | MultipleIDDelete | Default | d%                                          | Database  |       |       |


  @MLP-4854 @webtest @positive @regression @cloudera
  Scenario:SC#5_MLP_4854_Verify the top level exclude name filters check for pig operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SparkExclude |      | 200           | IDLE             | $.[?(@.configurationName=='SparkExclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body | response code | response message | jsonPath                                          |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SparkExclude  |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SparkExclude |      | 200           | IDLE             | $.[?(@.configurationName=='SparkExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "application_1532521880492_0005_758198" and clicks on search
    And user performs "facet selection" in "CN4854SC5" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Operation |
      | Execution |
    And user enters the search text "*0011*" and clicks on search
    And user performs "facet selection" in "CN4854SC5" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Operation |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4854_SC#5:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SparkExclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | application%                                | Operation |       |       |
      | MultipleIDDelete | Default | Python%                                     | Operation |       |       |
      | MultipleIDDelete | Default | Big%                                        | Operation |       |       |
      | MultipleIDDelete | Default | S%                                          | Operation |       |       |
      | MultipleIDDelete | Default | H%                                          | Operation |       |       |
      | MultipleIDDelete | Default | C%                                          | Operation |       |       |
      | MultipleIDDelete | Default | P%                                          | Operation |       |       |
      | MultipleIDDelete | Default | A%                                          | Operation |       |       |
      | MultipleIDDelete | Default | s%                                          | Operation |       |       |
      | MultipleIDDelete | Default | o%                                          | Operation |       |       |
      | MultipleIDDelete | Default | R%                                          | Operation |       |       |
      | MultipleIDDelete | Default | ROOT%                                       | Directory |       |       |


  @webtest @MLP-4854 @positive @regression @cloudera
  Scenario:SC#6_MLP-4854_Verify the From Date/To Date and tag filters for spark operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SparkDates |      | 200           | IDLE             | $.[?(@.configurationName=='SparkDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SparkDates  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SparkDates |      | 200           | IDLE             | $.[?(@.configurationName=='SparkDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                         | fileName           | userTag   |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CN4854SC6,TagDates,Spark | Spark Count_726987 | CN4854SC6 |
    And user enters the search text "CN4854SC6" and clicks on search
    And user performs "facet selection" in "CN4854SC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                     | Feature           | jsonPath        |
      | /entities?query=((sourceType:spark)AND(type:operation_execution)AND(started:[2018-07-01T01:00:00.000Z TO 2018-07-23T00:00:00.000Z])) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4854_SC#6:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SparkDates% | Analysis  |       |       |
      | MultipleIDDelete | Default | application%                              | Operation |       |       |
      | MultipleIDDelete | Default | Python%                                   | Operation |       |       |
      | MultipleIDDelete | Default | Big%                                      | Operation |       |       |
      | MultipleIDDelete | Default | S%                                        | Operation |       |       |
      | MultipleIDDelete | Default | H%                                        | Operation |       |       |
      | MultipleIDDelete | Default | C%                                        | Operation |       |       |
      | MultipleIDDelete | Default | P%                                        | Operation |       |       |
      | MultipleIDDelete | Default | A%                                        | Operation |       |       |
      | MultipleIDDelete | Default | s%                                        | Operation |       |       |
      | MultipleIDDelete | Default | o%                                        | Operation |       |       |
      | MultipleIDDelete | Default | R%                                        | Operation |       |       |
      | MultipleIDDelete | Default | ROOT%                                     | Directory |       |       |
      | MultipleIDDelete | Default | d%                                        | Database  |       |       |

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:4854_SC7-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:4854_SC#8:Delete cluster id
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |