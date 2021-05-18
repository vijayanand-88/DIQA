@MLP-9610
Feature:MLP-9610: cloudera_S3

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC1#-Set the Credentials and DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaValidCredentials   | ida/cloudEraNavigatorPayloads/Credentials/Valid.json               | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaInValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/Invalid.json             | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource         | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource         |                                                                    | 200           | CNavigatorDataSource |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials     | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json         | 200           |                      |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials     |                                                                    | 200           |                      |          |

  @aws
  Scenario: MLP-9610:SC#1 Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgcnavigatorautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix       | dirPath                                                | recursive |
      | asgcnavigatorautomation | cloudera2       | ida/cloudEraNavigatorPayloads/TestData/cloudera2       | true      |
      | asgcnavigatorautomation | cloudera2/three | ida/cloudEraNavigatorPayloads/TestData/cloudera2/three | true      |
      | asgcnavigatorautomation | folder1         | ida/cloudEraNavigatorPayloads/TestData/folder1         | true      |
      | asgcnavigatorautomation | folder1/one     | ida/cloudEraNavigatorPayloads/TestData/folder1/one     | true      |
      | asgcnavigatorautomation | folder1/two     | ida/cloudEraNavigatorPayloads/TestData/folder1/two     | true      |
      | asgcnavigatorautomation | qatest          | ida/cloudEraNavigatorPayloads/TestData/qatest          | true      |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix       | dirPath                                                |
      | asgcnavigatorautomation | bucketlevel.txt | ida/cloudEraNavigatorPayloads/TestData/bucketlevel.txt |

  @MLP-4610 @positive @regression @cloudera
  Scenario Outline:MLP-9610_SC1#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_9610_S3.json | 204           |                  |          |


  #6690512##6705244##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_9610_Run the plugin for SC1
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3Metadata |      | 200           | IDLE             | $.[?(@.configurationName=='S3Metadata')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3Metadata          |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3Metadata         |      | 200           | IDLE             | $.[?(@.configurationName=='S3Metadata')].status |
    And sync the test execution for "30" seconds

  ##6690512##6705244##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_9610_Verify metadata information at Bucket level is displayed correctly in IDC UI and Database.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC1" and clicks on search
    And sync the test execution for "10" seconds
    And user enters the search text "CN9610SC1" and clicks on search
    And sync the test execution for "30" seconds
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgcnavigatorautomation" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName |
      | Directory size            | 38032         | Statistics |
      | Number of files           | 1             | Statistics |
      | Size of files             | 0             | Statistics |
      | Number of sub-directories | 3             | Statistics |
      | Size of sub-directories   | 38032         | Statistics |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "index.jsp" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | Cloudera QuickStart     |
      | AmazonS3                |
      | asgcnavigatorautomation |
      | cloudera2               |
      | index.jsp               |
    And user clicks on logout button


  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_9610_Verify metadata information at Directory level is displayed correctly in IDC UI and Database.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "cloudera2" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName |
      | Directory size            | 26525         | Statistics |
      | Number of files           | 3             | Statistics |
      | Size of files             | 8714          | Statistics |
      | Number of sub-directories | 1             | Statistics |
      | Size of sub-directories   | 17811         | Statistics |
    And user clicks on logout button


  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_9610_Verify metadata information at File level is displayed correctly in IDC UI and Database.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                         | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND(type:file)AND(parentPath:*asgcnavigatorautomation*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "balance1.jsp" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue   | widgetName  |
      | File size         | 4.50 KB         | Description |
      | Created by        | aws.saas.dev.di | Description |
    And user clicks on logout button

##6693095##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_9610_Run the plugin for SC4
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body | response code | response message | jsonPath                                      |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3ScanON |      | 200           | IDLE             | $.[?(@.configurationName=='S3ScanON')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3ScanON          |      | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3ScanON         |      | 200           | IDLE             | $.[?(@.configurationName=='S3ScanON')].status |
    And sync the test execution for "30" seconds

  ##6693095##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_9610_Verify the CNavigatorCataloger works properly and catalogs S3 Objects when no filters are provided.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC4" and clicks on search
    And sync the test execution for "10" seconds
    And user enters the search text "CN9610SC4" and clicks on search
    And sync the test execution for "20" seconds
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                         | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND(type:file)AND(parentPath:*asgcnavigatorautomation*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

##6691755##6705248##
  @MLP-9610 @webtest @positive @regression @cloudera @MLPQA-18074
  Scenario:SC#5_MLP_9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and toplevel include(Full Name).
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TopInclude |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopInclude')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TopInclude          |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TopInclude         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC5" and clicks on search
    And user performs "facet selection" in "CN9610SC5" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
      | Analysis  |
      | Service   |
      | Cluster   |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                    | fileName  | userTag   |
      | Default     | File | Metadata Type | Cloudera Navigator,CN9610SC5,Amazon S3 | index.jsp | CN9610SC5 |
    And user enters the search text "CN9610SC5" and clicks on search
    And user performs "facet selection" in "CN9610SC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                         | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND(type:file)AND(parentPath:*asgcnavigatorautomation*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN9610SC5" and clicks on search
    And user performs "facet selection" in "CN9610SC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  ##6691758##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#6_MLP_9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and toplevel include(wild card character * Ex: *dirname*).
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body | response code | response message | jsonPath                                                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TopIncludeWildChar |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopIncludeWildChar')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TopIncludeWildChar          |      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TopIncludeWildChar         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopIncludeWildChar')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC6" and clicks on search
    And user performs "facet selection" in "CN9610SC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                         | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND(type:file)AND(parentPath:*asgcnavigatorautomation*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN9610SC6" and clicks on search
    And user performs "facet selection" in "CN9610SC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                                                                        | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation")OR(originalName:"asgcnavigatorautomation1"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

    ##6691777##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#7_MLP-9610_Run the plugin for SC7
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body | response code | response message | jsonPath                                                     |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3BottomIncludeWildChar |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomIncludeWildChar')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3BottomIncludeWildChar          |      | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3BottomIncludeWildChar         |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomIncludeWildChar')].status |
    And sync the test execution for "30" seconds

     ##6691777##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#7_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and bottomlevel include(wild card character * Ex: *dirname*).
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                        | Feature           | jsonPath        |
      | /entities?query=(sourceType:S3)AND(type:file)AND((parentPath:*asgcnavigatorautomation/qatest*)OR(parentPath:*asgcnavigatorautomation/)) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "qatest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                      | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND(parentPath:*asgcnavigatorautomation*)AND(type:DIRECTORY)AND(originalName:qatest)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:9610_SC1 to SC7 :Delete cluster id and Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |


  @MLP-4610 @positive @regression @cloudera
  Scenario Outline:MLP-9610_SC8toSC12-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_9610_S3_1.json | 204           |                  |          |


      ##6691778##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#8_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects, toplevel include(Full Name) and bottom level include(wild card character *).
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message | jsonPath                                                |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TopBottomInclude |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopBottomInclude')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TopBottomInclude          |      | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TopBottomInclude         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopBottomInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC8" and clicks on search
    And user performs "facet selection" in "CN9610SC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                          | Feature           | jsonPath        |
      | /entities?query=(sourceType:S3)AND(type:file)AND((parentPath:*asgcnavigatorautomation/cloudera*)OR(parentPath:*asgcnavigatorautomation/)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN9610SC8" and clicks on search
    And user performs "facet selection" in "CN9610SC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgcnavigatorautomation |
      | three                   |
      | cloudera2               |
    And user clicks on logout button


     ##6691780##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#9_MLP-9610_ Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and toplevel exclude(Full Name).
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TopExclude |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopExclude')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TopExclude          |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TopExclude         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC9" and clicks on search
    And user performs "facet selection" in "CN9610SC9" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | asgcnavigatorautomation [Directory] |
    And user clicks on logout button


     ##6691781##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#10_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and toplevel exclude(wild card character * Ex: *dirname*).
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body | response code | response message | jsonPath                                                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TopExcludeWildChar |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopExcludeWildChar')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TopExcludeWildChar          |      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TopExcludeWildChar         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopExcludeWildChar')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "S3TopExcludeWildChar" and clicks on search
    And user performs "facet selection" in "CN9610SC10" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | asgcnavigatorautomation [Directory] |
    And user clicks on logout button

     ##6691782##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#11_MLP-9610_Run the plugin for SC11
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body | response code | response message | jsonPath                                                     |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3MultipleBottomExclude |      | 200           | IDLE             | $.[?(@.configurationName=='S3MultipleBottomExclude')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3MultipleBottomExclude          |      | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3MultipleBottomExclude         |      | 200           | IDLE             | $.[?(@.configurationName=='S3MultipleBottomExclude')].status |
    And sync the test execution for "30" seconds

       ##6691782##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#11_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and bottomlevel exclude(Multiple directories with Full Name).
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC11" and clicks on search
    And sync the test execution for "10" seconds
    And user enters the search text "CN9610SC11" and clicks on search
    And sync the test execution for "10" seconds
    And user enters the search text "cloudera2 [Directory]" and clicks on search
    And user performs "facet selection" in "CN9610SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                | Feature           | jsonPath        |
      | /entities?query=(sourceType:S3)AND(type:file)AND(parentPath:*asgcnavigatorautomation/cloudera*) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgcnavigatorautomation |
      | three                   |
      | cloudera2               |
    And user clicks on logout button

       ##6691783##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#12_MLP-9610_Run the plugin for SC12
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body | response code | response message | jsonPath                                                     |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3BottomExcludeWildChar |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomExcludeWildChar')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3BottomExcludeWildChar          |      | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3BottomExcludeWildChar         |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomExcludeWildChar')].status |
    And sync the test execution for "30" seconds

        ##6691783##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#12_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and bottomlevel exclude(wild card character * Ex: *dirname*).
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And sync the test execution for "20" seconds
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC12" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                          | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND(type:file)AND(parentPath:*asgcnavigatorautomation*)NOT(parentPath:*asgcnavigatorautomation/folder1*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC12" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgcnavigatorautomation |
      | three                   |
      | cloudera2               |
      | qatest                  |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:9610_SC8 to SC12 :Delete cluster id and Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |

  @MLP-4610 @positive @regression @cloudera
  Scenario Outline:MLP-9610_SC13toSC17#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_9610_S3_2.json | 204           |                  |          |


       ##6691784##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#13_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects, toplevel include(Full Name) and bottom level exclude(wild card character *).
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                           | body | response code | response message | jsonPath                                                       |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TopIncludeBottomExclude |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopIncludeBottomExclude')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TopIncludeBottomExclude          |      | 200           |                  |                                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TopIncludeBottomExclude         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopIncludeBottomExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC13" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                          | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND(type:file)AND(parentPath:*asgcnavigatorautomation*)NOT(parentPath:*asgcnavigatorautomation/folder1*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC13" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgcnavigatorautomation |
      | three                   |
      | cloudera2               |
      | qatest                  |
    And user clicks on logout button


      ##6691787##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#14_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and creation date/modified date is in between from/to dates(From date less than To date)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body | response code | response message | jsonPath                                     |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3Dates |      | 200           | IDLE             | $.[?(@.configurationName=='S3Dates')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3Dates          |      | 200           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3Dates         |      | 200           | IDLE             | $.[?(@.configurationName=='S3Dates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC14" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC14" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgcnavigatorautomation" item from search results
    Then user performs click and verify in new window
      | Table         | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Has_Directory | folder1   | verify widget contains |                  |             |
      | Has_Directory | cloudera2 | verify widget contains |                  |             |
      | Has_Directory | qatest    | verify widget contains |                  |             |
    And user clicks on logout button


     ##6691789##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#15_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and creation date/execution date(From date equal to To date)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3EqualDates |      | 200           | IDLE             | $.[?(@.configurationName=='S3EqualDates')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3EqualDates          |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3EqualDates         |      | 200           | IDLE             | $.[?(@.configurationName=='S3EqualDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC15" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC15" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgcnavigatorautomation" item from search results
    Then user performs click and verify in new window
      | Table         | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Has_Directory | folder1   | verify widget contains |                  |             |
      | Has_Directory | cloudera2 | verify widget contains |                  |             |
      | Has_Directory | qatest    | verify widget contains |                  |             |
    And user clicks on logout button

        ##6693097##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#16_MLP-9610_Verify the CNavigatorCataloger works properly and catalogs items from different source types.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                   |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3MultipleSourceTypes |      | 200           | IDLE             | $.[?(@.configurationName=='S3MultipleSourceTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3MultipleSourceTypes          |      | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3MultipleSourceTypes         |      | 200           | IDLE             | $.[?(@.configurationName=='S3MultipleSourceTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC16" and clicks on search
    And user performs "facet selection" in "CN9610SC16" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 34    |
      | HDFS [Service]                | 6     |
      | AmazonS3 [Service]            | 27    |
    And user enters the search text "CN9610SC16" and clicks on search
    And user performs "facet selection" in "CN9610SC16" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AmazonS3 [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN9610SC16" and clicks on search
    And user performs "facet selection" in "CN9610SC16" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HDFS [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                 | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:file)AND(parentPath:*asgcnavigator*)AND(deleted:false) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

          ##6693099##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#17_MLP-9610_Verify the CNavigatorCataloger collects only analysis item when the SourceType:S3 Objects and Top Level Include Include contains invalid names.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body | response code | response message | jsonPath                                               |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TopLevelInvalid |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopLevelInvalid')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TopLevelInvalid          |      | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TopLevelInvalid         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopLevelInvalid')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC17" and clicks on search
    And user performs "facet selection" in "CN9610SC17" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Cluster  |
      | Service  |
      | Analysis |
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:9610_SC13 to SC17 :Delete cluster id and Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |

  @MLP-4610 @positive @regression @cloudera
  Scenario Outline:MLP-9610_SC18toSC24#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_9610_S3_3.json | 204           |                  |          |


    ##6693099##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#18_MLP-9610_Verify the CNavigatorCataloger collects only analysis item when the SourceType:S3 Objects and Bottom level Include contains invalid names.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body | response code | response message | jsonPath                                                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3BottomLevelInvalid |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomLevelInvalid')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3BottomLevelInvalid          |      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3BottomLevelInvalid         |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomLevelInvalid')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC18" and clicks on search
    And user performs "facet selection" in "CN9610SC18" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Cluster   |
      | Service   |
      | Analysis  |
      | Directory |
      | File      |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC18" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgcnavigatorautomation" item from search results
    Then user performs click and verify in new window
      | Table         | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Has_Directory | folder1   | verify widget contains |                  |             |
      | Has_Directory | cloudera2 | verify widget contains |                  |             |
      | Has_Directory | qatest    | verify widget contains |                  |             |
    And user clicks on logout button

       ##6693101##
  @MLP-9610 @positive @regression @cloudera @webtest
  Scenario:SC#19_MLP-9610_Verify the CNavigatorCataloger collects only analysis item when the SourceType:S3 Objects and the From Date/To Dates are invalid(there are no objects created in the date range)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body | response code | response message | jsonPath                                            |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3InvalidDates |      | 200           | IDLE             | $.[?(@.configurationName=='S3InvalidDates')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3InvalidDates          |      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3InvalidDates         |      | 200           | IDLE             | $.[?(@.configurationName=='S3InvalidDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC19" and clicks on search
    And user performs "facet selection" in "CN9610SC19" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Cluster  |
      | Service  |
      | Analysis |
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
    And user clicks on logout button

     ##6694341##
  @MLP-9610 @positive @regression @cloudera @webtest
  Scenario:SC#20_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and toplevel include(Full Name) and tag name provided.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                       |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TagName |      | 200           | IDLE             | $.[?(@.configurationName=='S3TagName')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TagName          |      | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TagName         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TagName')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TagCloudera" and clicks on search
    And user performs "facet selection" in "CN9610SC20" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TagCloudera" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
      | Analysis  |
    And user clicks on logout button

    ##6549303
#  @sanity @positive @webtest @edibus
#  Scenario:MLP-9610_Verify the Cloudera S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "CN9610SC20" and clicks on search
#    And user performs "facet selection" in "CN9610SC20" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "TagCloudera" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBusClouderaConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                                 | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                 | idc/EdiBusPayloads/datasource/EDIBusDS_Cloudera.json | 204           |                  |                                                     |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/EDIBusClouderaConfig.json         | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusCloudera |                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusCloudera')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusCloudera  |                                                      | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusCloudera |                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusCloudera')].status |
#    And user enters the search text "EDIBusCloudera" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusCloudera%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "CN9610SC20" and clicks on search
#    And user performs "facet selection" in "CN9610SC20" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "TagCloudera" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                               |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Cloudera Navigator |
#      | $..selections.['type_s'][*]                   | File                                                     |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                        | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=TagCloudera&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "CN9610SC20" and clicks on search
#    And user performs "facet selection" in "CN9610SC20" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "TagCloudera" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                               |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Cloudera Navigator |
#      | $..selections.['type_s'][*]                   | Directory                                                |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                        | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=TagCloudera&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user enters the search text "CN9610SC20" and clicks on search
#    And user performs "facet selection" in "CN9610SC20" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "TagCloudera" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                        |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @*CLOUDERA@ NAVIGATOR≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @*CLOUDERA@ NAVIGATOR≫DEFAULT≫DWR_DAT_DIRECTORY≫@* ),AND,( TYPE = DWR_IDC )   |
#      | AP-DATA      | CLOUDERA    | 1.0                | (XNAME * *  ~/ @*CLOUDERA@ NAVIGATOR≫DEFAULT≫DWR_DAT_FILE_SYSTEM≫@* ),AND,( TYPE = DWR_IDC ) |


    ##6705243##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#22_MLP-9610_Run the plugin for SC22
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3TopLevelExcludeInvalid |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopLevelExcludeInvalid')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3TopLevelExcludeInvalid          |      | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3TopLevelExcludeInvalid         |      | 200           | IDLE             | $.[?(@.configurationName=='S3TopLevelExcludeInvalid')].status |
    And sync the test execution for "30" seconds

    ##6705243##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#22_MLP-9610_Verify the CNavigatorCataloger collects only analysis item when the SourceType:S3 Objects and Top Level Exclude contains invalid names.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And sync the test execution for "15" seconds
    And user enters the search text "CN9610SC22" and clicks on search
    And user performs "facet selection" in "CN9610SC22" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
      | Service   |
      | Cluster   |
    And sync the test execution for "20" seconds
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC22" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user clicks on logout button


    ##6705243##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#23_MLP-9610_Run the plugin for SC23
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                             | body | response code | response message | jsonPath                                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3BottomLevelExcludeInvalid |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomLevelExcludeInvalid')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3BottomLevelExcludeInvalid          |      | 200           |                  |                                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3BottomLevelExcludeInvalid         |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomLevelExcludeInvalid')].status |
    And sync the test execution for "30" seconds

     ##6705243##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#23_MLP-9610_Verify the CNavigatorCataloger collects only analysis item when the SourceType:S3 Objects and Bottom Level Exclude contains invalid names.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And sync the test execution for "15" seconds
    And user enters the search text "CN9610SC23" and clicks on search
    And user performs "facet selection" in "CN9610SC23" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
      | Service   |
      | Cluster   |
    And sync the test execution for "20" seconds
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC23" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                         | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND(type:file)AND(parentPath:*asgcnavigatorautomation*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC23" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:S3)AND((parentPath:*asgcnavigatorautomation*)OR(originalName:"asgcnavigatorautomation"))AND((type:DIRECTORY)OR(type:S3BUCKET))) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

       ##6705305##
  @MLP-9610 @webtest @positive @regression @cloudera
  Scenario:SC#24_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and bottom level include(Folder Name as Full Name).
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                 |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/S3BottomIncludeFull |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomIncludeFull')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/S3BottomIncludeFull          |      | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/S3BottomIncludeFull         |      | 200           | IDLE             | $.[?(@.configurationName=='S3BottomIncludeFull')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "asgcnavigatorautomation" and clicks on search
    And user performs "facet selection" in "CN9610SC24" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgcnavigatorautomation |
      | qatest                  |
    And user clicks on logout button

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC21#-Set Internalnode DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                     | body                                                                            | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource_InternalNode.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource |                                                                                 | 200           | CNavigatorDataSource |          |

    ##6705245##
  @MLP-9610 @positive @regression @cloudera @webtest
  Scenario:SC#21_MLP-9610_Verify the CNavigatorCataloger works properly for the filters like: sourcetype as S3 Objects and toplevel include(Full Name) when node condition is given
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message | jsonPath                                             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/CNavigatorCataloger/S3NodeCondition |      | 200           | IDLE             | $.[?(@.configurationName=='S3NodeCondition')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/*/CNavigatorCataloger/S3NodeCondition          |      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/*/CNavigatorCataloger/S3NodeCondition         |      | 200           | IDLE             | $.[?(@.configurationName=='S3NodeCondition')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN9610SC21" and clicks on search
    And user performs "facet selection" in "CN9610SC21" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
      | Analysis  |
      | Service   |
      | Cluster   |
    And user clicks on logout button

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC25-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusValidCredentials     |      | 200           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:9610_SC#26:Delete cluster id and Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |

  @aws
  Scenario:  MLP-9610:SC#27 Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "cloudera2" in bucket "asgcnavigatorautomation"
    Given user "Delete" objects in amazon directory "folder1" in bucket "asgcnavigatorautomation"
    Given user "Delete" objects in amazon directory "qatest" in bucket "asgcnavigatorautomation"
    Given user "Delete Version" objects in amazon directory "/" in bucket "asgcnavigatorautomation"
    Then user "Delete" a bucket "asgcnavigatorautomation" in amazon storage service
