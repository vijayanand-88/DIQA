@MLP-4853
Feature:MLP-4853: cloudera_Pig

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
  Scenario Outline:MLP-4853_SC1#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                 | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4853_Pig.json | 204           |                  |          |


  ##6170055##
  @MLP-4853 @webtest @positive @regression @cloudera @MLPQA-18069
  Scenario:SC#1_MLP_4853_Verify Pig metadata and count of pig operation/execution appearing in IDC UI matches with corresponding metadata and count of pig operation/execution in cloudEraNavigator
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                          |      | 200           | PigMetadata      |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/PigMetadata |      | 200           | IDLE             | $.[?(@.configurationName=='PigMetadata')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/PigMetadata  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/PigMetadata |      | 200           | IDLE             | $.[?(@.configurationName=='PigMetadata')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4853SC1" and clicks on search
    And user performs "facet selection" in "CN4853SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                              | fileName                      | userTag   |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CN4853SC1,Pig | PigLatin:pig-e1d4.pig_4698071 | CN4853SC1 |
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                      | Feature           | jsonPath        |
      | /entities?query=((sourceType:pig)AND(type:operation)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN4853SC1" and clicks on search
    And user performs "facet selection" in "CN4853SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                | Feature           | jsonPath        |
      | /entities?query=((sourceType:pig)AND(type:operation_execution)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4853_SC#1:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/PigMetadata% | Analysis  |       |       |
      | MultipleIDDelete | Default | Pig%                                       | Operation |       |       |
      | MultipleIDDelete | Default | Pig%                                       | Execution |       |       |

##6170053##
  @MLP-4853 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_4853_Verify single pig service should be visible and it should contain only pig operation/execution when scanRelations is OFF
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/PigScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='PigScanOFF')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/PigScanOFF  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/PigScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='PigScanOFF')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4853SC2" and clicks on search
    And user performs "facet selection" in "CN4853SC2" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 15    |
      | PIG [Service]                 | 14    |
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | HDFS [Service] |
    And user enters the search text "PigLatin:DefaultJobName_2520839" and clicks on search
    And user performs "item click" on "PigLatin:DefaultJobName_2520839" item from search results
    And user "widget not present" on "USES" in Item view page
    And user "widget not present" on "LINEAGE HOPS" in Item view page
    Then user performs click and verify in new window
      | Table              | value                           | Action                 | RetainPrevwindow | indexSwitch |
      | Runtime Executions | PigLatin:DefaultJobName_2520838 | verify widget contains |                  |             |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4853_SC#2:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/PigScanOFF% | Analysis  |       |       |
      | MultipleIDDelete | Default | Pig%                                      | Operation |       |       |
      | MultipleIDDelete | Default | Pig%                                      | Execution |       |       |


##6170052##
  @MLP-4853 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_4853_Verify the dependent services and entities are also collected if Source Type is Pig Operations and Scan relations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                       |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/PigScanON |      | 200           | IDLE             | $.[?(@.configurationName=='PigScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                   | body | response code | response message | jsonPath                                       |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/PigScanON  |      | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/PigScanON |      | 200           | IDLE             | $.[?(@.configurationName=='PigScanON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4853SC3" and clicks on search
    And user performs "facet selection" in "CN4853SC3" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 31    |
      | HDFS [Service]                | 16    |
      | PIG [Service]                 | 14    |
    And user enters the search text "PigLatin:DefaultJobName_2520839" and clicks on search
    And user performs "item click" on "PigLatin:DefaultJobName_2520839" item from search results
    Then user performs click and verify in new window
      | Table              | value                                       | Action                 | RetainPrevwindow | indexSwitch |
      | Runtime Executions | PigLatin:DefaultJobName_2520838             | verify widget contains |                  |             |
      | uses               | sqoop_to_hdfs                               | verify widget contains |                  |             |
      | uses               | sqoop_to_hdfs_pig_filtered                  | verify widget contains |                  |             |
      | Lineage Hops       | sqoop_to_hdfs => sqoop_to_hdfs_pig_filtered | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                                       | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath  |
      | Lineage Hops | sqoop_to_hdfs => sqoop_to_hdfs_pig_filtered | click and verify lineagehops | Yes              |             | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest2 |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4853_SC#3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/PigScanON% | Analysis  |       |       |
      | MultipleIDDelete | Default | Pig%                                     | Operation |       |       |
      | MultipleIDDelete | Default | Pig%                                     | Execution |       |       |
      | MultipleIDDelete | Default | ROOT%                                    | Directory |       |       |


##6170093##
  @MLP-4853 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_4853_Verify the top level include name filters check for pig operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/PigInclude |      | 200           | IDLE             | $.[?(@.configurationName=='PigInclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/PigInclude  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/PigInclude |      | 200           | IDLE             | $.[?(@.configurationName=='PigInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4853SC4" and clicks on search
    And user performs "facet selection" in "CN4853SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:pig)AND(type:operation)AND(originalName:*pig*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN4853SC4" and clicks on search
    And user performs "facet selection" in "CN4853SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                       | Feature           | jsonPath        |
      | /entities?query=((sourceType:pig)AND(type:operation_execution)AND(originalName:*pig*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4853_SC#4:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/PigInclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | Pig%                                      | Operation |       |       |
      | MultipleIDDelete | Default | Pig%                                      | Execution |       |       |
      | MultipleIDDelete | Default | ROOT%                                     | Directory |       |       |


##6170125##
  @MLP-4853 @webtest @positive @regression @cloudera
  Scenario:SC#5_MLP_4853_Verify the top level exclude name filters check for pig operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/PigExclude |      | 200           | IDLE             | $.[?(@.configurationName=='PigExclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/PigExclude  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/PigExclude |      | 200           | IDLE             | $.[?(@.configurationName=='PigExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4853SC5" and clicks on search
    And user performs "facet selection" in "CN4853SC5" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Directory |
      | Execution |
      | Operation |
      | Service   |
      | Analysis  |
      | Cluster   |
      | File      |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4853_SC#5:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/PigExclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | Pig%                                      | Operation |       |       |
      | MultipleIDDelete | Default | Pig%                                      | Execution |       |       |
      | MultipleIDDelete | Default | ROOT%                                     | Directory |       |       |

##6170128##
  @webtest @MLP-4853 @positive @regression @cloudera @MLPQA-18069
  Scenario:SC#6_MLP-4853_Verify the From Date/To Date and tag filters for pig operation and scanRelations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body | response code | response message | jsonPath                                      |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/PigDates |      | 200           | IDLE             | $.[?(@.configurationName=='PigDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body | response code | response message | jsonPath                                      |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/PigDates  |      | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/PigDates |      | 200           | IDLE             | $.[?(@.configurationName=='PigDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                       | fileName                      | userTag   |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CN4853SC6,TagDates,Pig | PigLatin:pig-e1d4.pig_4698071 | CN4853SC6 |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4853_SC#6:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/PigDates% | Analysis  |       |       |
      | MultipleIDDelete | Default | Pig%                                    | Operation |       |       |
      | MultipleIDDelete | Default | Pig%                                    | Execution |       |       |
      | MultipleIDDelete | Default | ROOT%                                   | Directory |       |       |


  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:4853_SC7-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:4853_SC#8:Delete cluster id
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |