@MLP-5386
Feature:MLP-5386: cloudera_Sqoop

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
  Scenario Outline:MLP-5386_SC1#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_5386_Sqoop.json | 204           |                  |          |


  ##6148670##
  @MLP-5386 @webtest @positive @regression @cloudera @MLPQA-18070
  Scenario:SC#1_MLP_5386_Verify the cloudEraNavigator metadata attributes matches with IDC UI metadata attributes for Sqoop operations
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body | response code | response message | jsonPath                                           |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                            |      | 200           | SqoopMetadata    |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SqoopMetadata |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopMetadata')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SqoopMetadata  |      | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SqoopMetadata |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopMetadata')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5386SC1" and clicks on search
    And user performs "facet selection" in "CN5386SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                | fileName                 | userTag   |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CN5386SC1,Sqoop | employee_details_7899544 | CN5386SC1 |
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                        | Feature           | jsonPath        |
      | /entities?query=((sourceType:sqoop)AND(type:operation)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button


  ##6148672##
  @MLP-5386 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_5386_Verify the cloudEraNavigator metadata attributes matches with IDC UI metadata attributes for Sqoop operation executions
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5386SC1" and clicks on search
    And user performs "facet selection" in "CN5386SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                          | Feature           | jsonPath        |
      | /entities?query=((sourceType:sqoop)AND(type:operation_execution)NOT(originalName:job_1534151452716_0045)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  ##6148683##
  @MLP-5386 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_5386_Verify the dependent operations are not collected if sourceType is Sqoop operation and scanRelations is OFF
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5386SC1" and clicks on search
    And user performs "facet selection" in "CN5386SC1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 21    |
      | SQOOP [Service]               | 20    |
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | YARN [Service] |
    And user enters the search text "sqoop_to_hive_2518576" and clicks on search
    And user performs "facet selection" in "CN5386SC1" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "sqoop_to_hive_2518576" item from search results
    And user "widget not present" on "USES" in Item view page
    And user "widget not present" on "LINEAGE HOPS" in Item view page
    Then user performs click and verify in new window
      | Table              | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | Runtime Executions | job_1534151452716_0018_2518583 | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5386_SC#1,2,3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SqoopMetadata% | Analysis  |       |       |
      | MultipleIDDelete | Default | s%                                           | Operation |       |       |
      | MultipleIDDelete | Default | e%                                           | Operation |       |       |
      | MultipleIDDelete | Default | Movies%                                      | Operation |       |       |


 ##6148674##6155831##6155832##6148675##
  @MLP-5386 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_5386Verify the relationship appearing in IDC UI for SQOOP operations(RDBMS to HDFS, RDBMS to Hive and HDFS to RDBMS)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SqoopScanON |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SqoopScanON  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SqoopScanON |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopScanON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5386SC4" and clicks on search
    And user performs "facet selection" in "CN5386SC4" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 41    |
      | SQOOP [Service]               | 20    |
      | YARN [Service]                | 20    |
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Operation |
      | Execution |
      | Service   |
      | Analysis  |
      | Cluster   |
    And user enters the search text "sqoop_to_hdfs_2518566" and clicks on search
    And user performs "facet selection" in "CN5386SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqoop_to_hdfs_2518566" item from search results
    Then user performs click and verify in new window
      | Table              | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | uses               | sqoop_to_hdfs.jar_2518564      | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => VIEW/LOCAL            | verify widget contains |                  |             |
      | Runtime Executions | job_1534151452716_0017_2518573 | verify widget contains |                  |             |
    And user enters the search text "sqoop_to_hive_2518576" and clicks on search
    And user performs "facet selection" in "CN5386SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqoop_to_hive_2518576" item from search results
    Then user performs click and verify in new window
      | Table              | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | uses               | sqoop_to_hive.jar_2518574      | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => VIEW/LOCAL            | verify widget contains |                  |             |
      | Runtime Executions | job_1534151452716_0018_2518583 | verify widget contains |                  |             |
    And user enters the search text "Movies_data_from_hdfs_4431800" and clicks on search
    And user performs "facet selection" in "CN5386SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Movies_data_from_hdfs_4431800" item from search results
    Then user performs click and verify in new window
      | Table              | value                             | Action                 | RetainPrevwindow | indexSwitch |
      | uses               | Movies_data_from_hdfs.jar_4431798 | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => VIEW/LOCAL               | verify widget contains |                  |             |
      | Runtime Executions | job_1538662185068_0008_4431806    | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5386_SC#4:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SqoopScanON% | Analysis  |       |       |
      | MultipleIDDelete | Default | s%                                         | Operation |       |       |
      | MultipleIDDelete | Default | e%                                         | Operation |       |       |
      | MultipleIDDelete | Default | Movies%                                    | Operation |       |       |


##6148695##6152090##
  @MLP-5386 @webtest @positive @regression @cloudera
  Scenario:SC#5_MLP_5386_Verify the top level include name filters check for Sqoop operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SqoopInclude |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopInclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body | response code | response message | jsonPath                                          |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SqoopInclude  |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SqoopInclude |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sqoop_to_hdfs_2518566" and clicks on search
    And user performs "facet selection" in "CN5386SC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqoop_to_hdfs_2518566" item from search results
    Then user performs click and verify in new window
      | Table              | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | uses               | sqoop_to_hdfs.jar_2518564      | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => VIEW/LOCAL            | verify widget contains |                  |             |
      | Runtime Executions | job_1534151452716_0017_2518573 | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5386_SC#5:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SqoopInclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | s%                                          | Operation |       |       |
      | MultipleIDDelete | Default | Movies%                                     | Operation |       |       |


  ##6148745##6152094##6152101##
  @MLP-5386 @webtest @positive @regression @cloudera
  Scenario:SC#6_MLP_5386_Verify the top level exclude name filters check for Sqoop operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SqoopExclude |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopExclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body | response code | response message | jsonPath                                          |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SqoopExclude  |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SqoopExclude |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "stunts" and clicks on search
    And user performs "facet selection" in "CN5386SC6" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Operation |
    And user enters the search text "sqoop_to_hive_2518576" and clicks on search
    And user performs "facet selection" in "CN5386SC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqoop_to_hive_2518576" item from search results
    Then user performs click and verify in new window
      | Table              | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | uses               | sqoop_to_hive.jar_2518574      | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => VIEW/LOCAL            | verify widget contains |                  |             |
      | Runtime Executions | job_1534151452716_0018_2518583 | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5386_SC#6:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SqoopExclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | s%                                          | Operation |       |       |
      | MultipleIDDelete | Default | e%                                          | Operation |       |       |
      | MultipleIDDelete | Default | Movies%                                     | Operation |       |       |


  ##6148809##
  @webtest @MLP-5386 @positive @regression @cloudera @MLPQA-18070
  Scenario:SC#7_MLP-5386_Verify the From Date/To Date and tag filters for sqoop operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SqoopDates |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/SqoopDates  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/SqoopDates |      | 200           | IDLE             | $.[?(@.configurationName=='SqoopDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                         | fileName                 | userTag   |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CN5386SC7,TagDates,Sqoop | employee_details_7899544 | CN5386SC7 |
    And user enters the search text "CN5386SC7" and clicks on search
    And user performs "facet selection" in "CN5386SC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "SQOOP [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                     | Feature           | jsonPath        |
      | /entities?query=((sourceType:sqoop)AND(type:operation_execution)AND(started:[2018-08-01T01:00:00.000Z TO 2018-08-22T00:00:00.000Z])) | CloudEraNavigator | $..originalName |
    And user enters the search text "sqoop_to" and clicks on search
    And user performs "facet selection" in "CN5386SC7" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 9     |
      | SQOOP [Service]               | 5     |
      | YARN [Service]                | 5     |
    And user enters the search text "sqoop_to_hdfs_2518566" and clicks on search
    And user performs "facet selection" in "TagDates" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CN5386SC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqoop_to_hdfs_2518566" item from search results
    Then user performs click and verify in new window
      | Table              | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | uses               | sqoop_to_hdfs.jar_2518564      | verify widget contains |                  |             |
      | Lineage Hops       | INPUT => VIEW/LOCAL            | verify widget contains |                  |             |
      | Runtime Executions | job_1534151452716_0017_2518573 | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5386_SC#7:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/SqoopDates% | Analysis  |       |       |
      | MultipleIDDelete | Default | s%                                        | Operation |       |       |
      | MultipleIDDelete | Default | e%                                        | Operation |       |       |
      | MultipleIDDelete | Default | Movies%                                   | Operation |       |       |


  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:5386_SC8-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |


  @MLP-4441 @sanity @positive
  Scenario:5386_SC#9:Delete cluster id
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |