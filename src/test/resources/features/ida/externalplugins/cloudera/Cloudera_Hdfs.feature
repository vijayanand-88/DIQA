@MLP-4441
Feature:MLP-4441: cloudera_Hdfs

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC1#-Set the Credentials and DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaValidCredentials   | ida/cloudEraNavigatorPayloads/Credentials/Valid.json               | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaInValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/Invalid.json             | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource         | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource         |                                                                    | 200           | CNavigatorDataSource |          |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC1#_create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/cloudEraNavigatorPayloads/BussinessApplication.json | 200           |                  |          |


  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC1#-Config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                  | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4441_HDFS.json | 204           |                     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorCataloger |                                                       | 200           | HDFSToplevelInclude |          |

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC1#-start the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSToplevelInclude  |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSToplevelInclude |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSToplevelInclude')].status |

  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-18066
  Scenario:SC1#_Verify Bussiness tag appears correctly in cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC1" and clicks on search
    And user performs "facet selection" in "CNavigator_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Cloudera Navigator,CNavigator_BA,CNHdfSSC1" should get displayed for the column "cataloger/AmazonS3Cataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                                     | fileName            | userTag   |
      | Default     | Cluster   | Metadata Type | Cloudera Navigator,CNavigator_BA,CNHdfSSC1              | Cloudera QuickStart | CNHdfSSC1 |
      | Default     | Service   | Metadata Type | Cloudera Navigator,CNavigator_BA,CNHdfSSC1,Hadoop Files | HDFS                | CNHdfSSC1 |
      | Default     | Directory | Metadata Type | Cloudera Navigator,CNavigator_BA,CNHdfSSC1,Hadoop Files | ROOT                | CNHdfSSC1 |
      | Default     | File      | Metadata Type | Cloudera Navigator,CNavigator_BA,CNHdfSSC1,Hadoop Files | f1_testfile2        | CNHdfSSC1 |


  @MLP-4441 @positive @regression @cloudera @webtest
  Scenario:SC1#Verify whether the data got displayed in UI after applying filters like: sourcetype and  top level include in HDFS
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC1" and clicks on search
    And user performs "facet selection" in "CNHdfSSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:directory)AND((originalName:*filtertest*)OR(parentPath:*filtertest*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNHdfSSC1" and clicks on search
    And user performs "facet selection" in "CNHdfSSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                              | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:file)AND(parentPath:*filtertest*)AND(deleted:false) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC1# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | Default | ROOT                                                  |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id1 |
      | APPDBPOSTGRES | Default | user                                                  |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id2 |
      | APPDBPOSTGRES | Default | cloudera                                              |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id3 |
      | APPDBPOSTGRES | Default | TestFolder1                                           |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id4 |
      | APPDBPOSTGRES | Default | TestFolder2                                           |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id5 |
      | APPDBPOSTGRES | Default | filtertest                                            |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id6 |
      | APPDBPOSTGRES | Default | IncrementalDir                                        |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id7 |
      | APPDBPOSTGRES | Default | IncFolder1                                            |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id8 |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HDFSToplevelInclude%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC1# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson            | inputFile                             |
      | items/Default/Default.Directory:::dynamic    | 204          | $..has_Directory.id1 | response/Cloudera/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id   | response/Cloudera/actual/itemIds.json |


##6059924##6059946##6059911##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18066
  Scenario:SC#2_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel include and  bottom level include in HDFS having subdirectories
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                        | body | response code | response message | jsonPath                                                                    |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HdfsTopLevelBottomLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsTopLevelBottomLevelIncludeWithTags')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                | body | response code | response message | jsonPath                                                                    |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HdfsTopLevelBottomLevelIncludeWithTags  |      | 200           |                  |                                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HdfsTopLevelBottomLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsTopLevelBottomLevelIncludeWithTags')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC2" and clicks on search
    And user performs "facet selection" in "CNHdfSSC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                                 | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:directory)AND((originalName:*TestFolder1*)OR(originalName:*TestFolder2*)OR(originalName:*filtertest*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNHdfSSC2" and clicks on search
    And user performs "facet selection" in "CNHdfSSC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                               | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:file)AND((originalName:*f1_testfile1*)OR(originalName:*f2_testfile2*))AND(parentPath:*filtertest*)AND(deleted:false) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                       | fileName     | userTag   |
      | Default     | Directory | Metadata Type | Cloudera Navigator,CNHdfSSC2,Hadoop Files | ROOT         | CNHdfSSC2 |
      | Default     | File      | Metadata Type | Cloudera Navigator,CNHdfSSC2,Hadoop Files | f1_testfile1 | CNHdfSSC2 |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC2# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                                     | type | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | Default | ROOT                                                                     |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id1 |
      | APPDBPOSTGRES | Default | user                                                                     |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id2 |
      | APPDBPOSTGRES | Default | cloudera                                                                 |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id3 |
      | APPDBPOSTGRES | Default | TestFolder1                                                              |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id4 |
      | APPDBPOSTGRES | Default | TestFolder2                                                              |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id5 |
      | APPDBPOSTGRES | Default | filtertest                                                               |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id6 |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HdfsTopLevelBottomLevelIncludeWithTags%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC2# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson            | inputFile                             |
      | items/Default/Default.Directory:::dynamic    | 204          | $..has_Directory.id1 | response/Cloudera/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id   | response/Cloudera/actual/itemIds.json |

##6059910##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18066
  Scenario:SC#3_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel include and  bottom level exclude in Hdfs
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                       | body | response code | response message | jsonPath                                                                   |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HdfsTopLevelIncludeBottomLevelExclude |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsTopLevelIncludeBottomLevelExclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body | response code | response message | jsonPath                                                                   |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HdfsTopLevelIncludeBottomLevelExclude  |      | 200           |                  |                                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HdfsTopLevelIncludeBottomLevelExclude |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsTopLevelIncludeBottomLevelExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC3" and clicks on search
    And user performs "facet selection" in "CNHdfSSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                                      | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:file)AND(parentPath:*filtertest*)NOT(originalName:f3_filter*)NOT(originalName:f4_filter*)AND(deleted:false) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNHdfSSC3" and clicks on search
    And user performs "facet selection" in "CNHdfSSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user finds search result does not contain "f3_filter" item name link
    And user finds search result does not contain "f4_filter" item name link
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                       | fileName     | userTag   |
      | Default     | File | Metadata Type | Cloudera Navigator,CNHdfSSC3,Hadoop Files | f1_testfile1 | CNHdfSSC3 |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC3# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                                    | type | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | Default | ROOT                                                                    |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id1 |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HdfsTopLevelIncludeBottomLevelExclude%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC3# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson            | inputFile                             |
      | items/Default/Default.Directory:::dynamic    | 204          | $..has_Directory.id1 | response/Cloudera/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id   | response/Cloudera/actual/itemIds.json |


##6059963##
  @webtest @MLP-4441 @positive @regression @cloudera
  Scenario:SC#4_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel include and  bottom level exclude in HDFS having subdirectories
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                   | body | response code | response message | jsonPath                                                               |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HdfsTopIncludeBottomExcludeSubDir |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsTopIncludeBottomExcludeSubDir')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                           | body | response code | response message | jsonPath                                                               |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HdfsTopIncludeBottomExcludeSubDir  |      | 200           |                  |                                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HdfsTopIncludeBottomExcludeSubDir |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsTopIncludeBottomExcludeSubDir')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC4" and clicks on search
    And user performs "facet selection" in "CNHdfSSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TestFolder1  |
      | TestFolder2  |
      | filtertest   |
      | f1_testfile2 |
      | f2_testfile1 |
    And user enters the search text "CNHdfSSC4" and clicks on search
    And user performs "facet selection" in "CNHdfSSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user finds "f1_testfile1" item name link not found
    And user finds "f2_testfile2" item name link not found
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                       | fileName     | userTag   |
      | Default     | File | Metadata Type | Cloudera Navigator,CNHdfSSC4,Hadoop Files | f1_testfile2 | CNHdfSSC4 |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC4# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                                | type | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | Default | ROOT                                                                |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id1 |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HdfsTopIncludeBottomExcludeSubDir%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC4# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson            | inputFile                             |
      | items/Default/Default.Directory:::dynamic    | 204          | $..has_Directory.id1 | response/Cloudera/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id   | response/Cloudera/actual/itemIds.json |


##6059908##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18066
  Scenario:SC#5_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and bottom level include in Hdfs
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body | response code | response message | jsonPath                                                    |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSBottomlevelInclude |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSBottomlevelInclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body | response code | response message | jsonPath                                                    |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSBottomlevelInclude  |      | 200           |                  |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSBottomlevelInclude |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSBottomlevelInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC5" and clicks on search
    And user performs "facet selection" in "CNHdfSSC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                | Feature           | jsonPath        |
      | /entities?query=((sourceType:hdfs)AND(type:file)AND(originalName:f3_filter*)AND(deleted:false)) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                       | fileName  | userTag   |
      | Default     | File | Metadata Type | Cloudera Navigator,CNHdfSSC5,Hadoop Files | f3_filter | CNHdfSSC5 |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC5# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                     | type | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | Default | ROOT                                                     |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id1 |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HDFSBottomlevelInclude%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC5# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson            | inputFile                             |
      | items/Default/Default.Directory:::dynamic    | 204          | $..has_Directory.id1 | response/Cloudera/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id   | response/Cloudera/actual/itemIds.json |


##6059969##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18066
  Scenario:SC#6_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and time intervals in Hdfs
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body | response code | response message | jsonPath                                               |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSWithDiffDates |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSWithDiffDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                               |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSWithDiffDates  |      | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSWithDiffDates |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSWithDiffDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC6" and clicks on search
    And user performs "facet selection" in "CNHdfSSC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                           | Feature           | jsonPath        |
      | /entities?query=((sourceType:hdfs)AND(type:file)AND(parentPath:*Temp*)AND(created:[2018-08-01T00:00:00.000Z TO 2018-08-02T23:00:00.000Z])) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                       | fileName | userTag   |
      | Default     | File | Metadata Type | Cloudera Navigator,CNHdfSSC6,Hadoop Files | 000000_0 | CNHdfSSC6 |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC6# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                | type | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | Default | ROOT                                                |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id1 |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HDFSWithDiffDates%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC6# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson            | inputFile                             |
      | items/Default/Default.Directory:::dynamic    | 204          | $..has_Directory.id1 | response/Cloudera/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id   | response/Cloudera/actual/itemIds.json |


##6059973##
  @webtest @MLP-4441 @positive @regression @cloudera
  Scenario:SC#7_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and same time intervals in Hdfs
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body | response code | response message | jsonPath                                               |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSWithSameDates |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSWithSameDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                               |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSWithSameDates  |      | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSWithSameDates |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSWithSameDates')].status |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC7" and clicks on search
    And user performs "facet selection" in "CNHdfSSC7" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Service  |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CNavigatorCataloger/HDFSWithSameDates%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Cloudera QuickStart |
      | HDFS                |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/CNavigatorCataloger/HDFSWithSameDates%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:CNavigatorCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:0514315f9f50, Plugin Configuration name:HDFSWithSameDates                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0071 | CNavigatorCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: ---  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: name: "HDFSWithSameDates"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: pluginVersion: "LATEST"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: label:  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: : ""  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: catalogName: "Default"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: eventClass: null  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: eventCondition: null  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: maxWorkSize: 100  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: tags:  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: - "CNHdfSSC7"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: pluginType: "cataloger"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: dataSource: "CNavigatorDataSource"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: credential: "ClouderaValidCredentials"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: businessApplicationName: null  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: dryRun: false  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: filter:  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: filters:  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: - class: "com.asg.dis.common.analysis.dom.Filter"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: label:  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: : "filter1"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: tags: []  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: fromLastRun: false  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: dateTimeFilters:  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: toDate: "2018-06-01T11:00"  2020-05-07 15:23:40.236 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: fromDate: "2018-06-01T01:00"  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: sourceTypes:  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: - "HDFS"  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: excludeNameWrapper:  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: excludeNamePattern: []  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: excludeTopNamePattern: []  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: includeNameWrapper:  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: includeNamePattern: []  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: includeTopNamePattern: []  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: deltaTime: null  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: extraFilters: {}  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: maxHits: null  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: trackRelations: false  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: pluginName: "CNavigatorCataloger"  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: skipSelects: false  2020-05-07 15:23:40.237 INFO  - ANALYSIS-0073: Plugin CNavigatorCataloger Configuration: type: "Cataloger" | ANALYSIS-0073 | CNavigatorCataloger |                |
      | INFO | Plugin CNavigatorCataloger Start Time:2020-05-07 15:23:40.235, End Time:2020-05-07 15:23:40.698, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0072 | CNavigatorCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0020 |                     |                |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC7# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                | type | targetFile                            | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HDFSWithSameDates%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC7# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                             |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/Cloudera/actual/itemIds.json |


##6059904##
  @MLP-4441 @webtest @positive @regression @cloudera @MLPQA-18066
  Scenario:SC#8_MLP_4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel include and  bottom level include in HDFS
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                | body                                                  | response code | response message               | jsonPath                                                            |
      | application/json |       |       | Put          | settings/analyzers/CNavigatorCataloger                                                             | ida/cloudEraNavigatorPayloads/CloudEra_4441_HDFS.json | 204           |                                |                                                                     |
      |                  |       |       | Get          | settings/analyzers/CNavigatorCataloger                                                             |                                                       | 200           | HdfsTopLevelBottomLevelInclude |                                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HdfsTopLevelBottomLevelInclude |                                                       | 200           | IDLE                           | $.[?(@.configurationName=='HdfsTopLevelBottomLevelInclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body | response code | response message | jsonPath                                                            |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HdfsTopLevelBottomLevelInclude  |      | 200           |                  |                                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HdfsTopLevelBottomLevelInclude |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsTopLevelBottomLevelInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC9" and clicks on search
    And user performs "facet selection" in "CNHdfSSC9" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                            | Feature           | jsonPath        |
      | /entities?query=((sourceType:hdfs)AND(type:file)AND(parentPath:*filtertest*)AND(originalName:f1_filter*)AND(deleted:false)) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                       | fileName   | userTag   |
      | Default     | File      | Metadata Type | Cloudera Navigator,CNHdfSSC9,Hadoop Files | f1_filter  | CNHdfSSC9 |
      | Default     | Directory | Metadata Type | Cloudera Navigator,CNHdfSSC9,Hadoop Files | filtertest | CNHdfSSC9 |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC8# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | Default | ROOT                                                             |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id1 |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HdfsTopLevelBottomLevelInclude%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC8# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson            | inputFile                             |
      | items/Default/Default.Directory:::dynamic    | 204          | $..has_Directory.id1 | response/Cloudera/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id   | response/Cloudera/actual/itemIds.json |


    ##6059939##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18066
  Scenario:SC#9_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel multiple include in HDFS having subdirectories
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body | response code | response message | jsonPath                                                    |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HdfsMultipleIncludeSub |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsMultipleIncludeSub')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body | response code | response message | jsonPath                                                    |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HdfsMultipleIncludeSub  |      | 200           |                  |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HdfsMultipleIncludeSub |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsMultipleIncludeSub')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNHdfSSC10" and clicks on search
    And user performs "facet selection" in "CNHdfSSC10" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                             | Feature           | jsonPath        |
      | /entities?query=((sourceType:hdfs)AND(type:file)AND((parentPath:*TestFolder1*)OR(parentPath:*TestFolder2*))) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                        | fileName    | userTag    |
      | Default     | Directory | Metadata Type | Cloudera Navigator,CNHdfSSC10,Hadoop Files | TestFolder1 | CNHdfSSC10 |
      | Default     | Directory | Metadata Type | Cloudera Navigator,CNHdfSSC10,Hadoop Files | TestFolder2 | CNHdfSSC10 |
    And user clicks on logout button

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC9# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                     | type | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | Default | ROOT                                                     |      | response/Cloudera/actual/itemIds.json | $..has_Directory.id1 |
      | APPDBPOSTGRES | Default | cataloger/CNavigatorCataloger/HdfsMultipleIncludeSub%DYN |      | response/Cloudera/actual/itemIds.json | $..has_Analysis.id   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC9# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson            | inputFile                             |
      | items/Default/Default.Directory:::dynamic    | 204          | $..has_Directory.id1 | response/Cloudera/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id   | response/Cloudera/actual/itemIds.json |

  @MLP-4441 @sanity @positive
  Scenario:SC10#_clouderaHdfs_Delete cluster id & All_Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |

  ############################ Hdfs scenarios from MLP-4610 ##########

  ##6014608##
  @webtest @MLP-4610 @positive @regression @cloudera
  Scenario:SC#1_MLP-4610_Verify cNavigator catalog does not collect any information when not existing HDFS Directory is mentioned in catalog config
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/InvalidHDFSConfiguration |      | 200           | IDLE             | $.[?(@.configurationName=='InvalidHDFSConfiguration')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/InvalidHDFSConfiguration  |      | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/InvalidHDFSConfiguration |      | 200           | IDLE             | $.[?(@.configurationName=='InvalidHDFSConfiguration')].status |
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC7" and clicks on search
    And user performs "facet selection" in "CN4610SC7" attribute under "Tags" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | InvalidDirectory |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#1:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/InvalidHDFSConfiguration% | Analysis |       |       |

##5995447##
  @webtest @MLP-4610 @positive @regression @cloudera
  Scenario:SC#2_MLP-4610_Scenario:Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator for HDFS Directory entity.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSConfig |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSConfig')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSConfig  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSConfig |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSConfig')].status |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC8" and clicks on search
    And user performs "facet selection" in "CN4610SC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:directory)AND((originalName:*filtertest*)OR(parentPath:*filtertest*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN4610SC8" and clicks on search
    And user performs "facet selection" in "CN4610SC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "filtertest" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName |
      | Directory size            | 145           | Statistics |
      | Number of files           | 6             | Statistics |
      | Size of files             | 145           | Statistics |
      | Number of sub-directories | 4             | Statistics |
      | Size of sub-directories   | 0             | Statistics |
    And user clicks on logout button

##5995629##
  @webtest @MLP-4610 @positive @regression @cloudera
  Scenario:SC#3_MLP-4610_Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator for HDFS File entity.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC8" and clicks on search
    And user performs "facet selection" in "CN4610SC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                              | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:file)AND(parentPath:*filtertest*)AND(deleted:false) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN4610SC8" and clicks on search
    And user performs "facet selection" in "CN4610SC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "filtertest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "f2_filter" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | blockSize         | 128.00 MB     | Description |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#2,3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HDFSConfig% | Analysis  |       |       |
      | SingleItemDelete | Default | ROOT                                      | Directory |       |       |


##6013548##
  @webtest @MLP-4610 @positive @regression @cloudera
  Scenario:SC#4_MLP-4610_Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator for HDFS Subdirectory and file under it.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/DirectoryandSubDirectory |      | 200           | IDLE             | $.[?(@.configurationName=='DirectoryandSubDirectory')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/DirectoryandSubDirectory  |      | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/DirectoryandSubDirectory |      | 200           | IDLE             | $.[?(@.configurationName=='DirectoryandSubDirectory')].status |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC10" and clicks on search
    And user performs "facet selection" in "CN4610SC10" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testsubdirectory [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                            | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:directory)AND((originalName:*testsubdirectory*)OR(parentPath:*testsubdirectory*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN4610SC10" and clicks on search
    And user performs "facet selection" in "CN4610SC10" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testsubdirectory [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testsub3" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName |
      | Size of files             | 31            | Statistics |
      | Directory size            | 31            | Statistics |
      | Number of files           | 1             | Statistics |
      | Number of sub-directories | 0             | Statistics |
      | Size of sub-directories   | 0             | Statistics |
    And user enters the search text "CN4610SC10" and clicks on search
    And user performs "facet selection" in "CN4610SC10" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                    | Feature           | jsonPath        |
      | /entities?query=(sourceType:hdfs)AND(type:file)AND(parentPath:*testsubdirectory*)AND(deleted:false) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#4:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/DirectoryandSubDirectory% | Analysis  |       |       |
      | SingleItemDelete | Default | ROOT                                                    | Directory |       |       |

  @MLP-4441 @sanity @positive
  Scenario:SC5#_MLP-4610_Delete cluster id & All_Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |

################################## MLP- 5919 Hdfs cases ####################################

   ##6166307##
  @MLP-5919 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_5919_Verify whether the catalog contains related entities if sourceType is "HDFS Directories and Files" and Scan relations is ON.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                         |      | 200           | HDFSScanON       |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSScanON |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSScanON  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSScanON |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSScanON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5919SC1" and clicks on search
    And user performs "facet selection" in "CN5919SC1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 223   |
      | HIVE [Service]                | 63    |
      | IMPALA [Service]              | 55    |
      | YARN [Service]                | 11    |
      | HDFS [Service]                | 93    |
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Operation |
      | Execution |
      | Directory |
      | File      |
      | Column    |
      | Table     |
      | Service   |
      | Analysis  |
      | Cluster   |
      | Database  |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5919_SC#1:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HDFSScanON% | Analysis  |       |       |
      | MultipleIDDelete | Default | ROOT%                                     | Directory |       |       |
      | MultipleIDDelete | Default | default%                                  | Database  |       |       |
      | MultipleIDDelete | Default | select%                                   | Operation |       |       |
      | MultipleIDDelete | Default | SELECT%                                   | Operation |       |       |
      | MultipleIDDelete | Default | create%                                   | Operation |       |       |
      | MultipleIDDelete | Default | insert%                                   | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%                                   | Operation |       |       |
      | MultipleIDDelete | Default | FROM%                                     | Operation |       |       |


  ##6166310##
  @MLP-5919 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_5919_Verify whether the catalog contains related entities if sourceType is "HDFS Directories and Files" and Scan relations is OFF.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSScanOFF')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSScanOFF  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSScanOFF')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5919SC2" and clicks on search
    And user performs "facet selection" in "CN5919SC2" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 94    |
      | HDFS [Service]                | 93    |
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Directory |
      | File      |
      | Service   |
      | Analysis  |
      | Cluster   |
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | HIVE [Service]   |
      | IMPALA [Service] |
      | YARN [Service]   |
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Operation |
      | Execution |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5919_SC#2:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HDFSScanOFF% | Analysis  |       |       |
      | MultipleIDDelete | Default | ROOT%                                      | Directory |       |       |

############################### MLP-5414 cases ##############################

   ##6083539##6088118#6084444#
  @MLP-5414 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_5414_Verify hierarchical directory structure in IDC UI for HDFS appears as same as directory structure in HDFS
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body | response code | response message | jsonPath                                            |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                             |      | 200           | HDFSConfig5414   |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSConfig5414 |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSConfig5414')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                        | body | response code | response message | jsonPath                                            |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSConfig5414  |      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSConfig5414 |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSConfig5414')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "filtertest" and clicks on search
    And user performs "facet selection" in "CN5414SC1" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Directory |
      | File      |
      | Analysis  |
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "filtertest" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | Cloudera QuickStart |
      | HDFS                |
      | ROOT                |
      | user                |
      | cloudera            |
      | filtertest          |
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName |
      | Directory size            | 145           | Statistics |
      | Number of files           | 6             | Statistics |
      | Size of files             | 145           | Statistics |
      | Number of sub-directories | 4             | Statistics |
    And user clicks on logout button

     ##6084443##
  @MLP-5414 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_5414_Verify first level directory and files should be mapped directly to project and remaining sub folder and files should be mapped to their respective parent(for HDFS)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5414SC1" and clicks on search
    And user performs "facet selection" in "CN5414SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ROOT" item from search results
    And user "widget presence" on "has_Directory" in Item view page
    Then user "verify presence" of following "hierarchy" in Item View Page
      | Cloudera QuickStart |
      | HDFS                |
      | ROOT                |
    And user enters the search text "CN5414SC1" and clicks on search
    And user performs "facet selection" in "CN5414SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "user" item from search results
    And user "widget presence" on "has_Directory" in Item view page
    Then user "verify presence" of following "hierarchy" in Item View Page
      | Cloudera QuickStart |
      | HDFS                |
      | ROOT                |
      | user                |
    And user enters the search text "CN5414SC1" and clicks on search
    And user performs "facet selection" in "CN5414SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CNavigatorCataloger/HDFSConfig%"
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Number of errors  | 0             | Description |
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/CNavigatorCataloger/HDFSConfig%" should display below info/error/warning
      | type | logValue                                                                                                                                 | logCode       | pluginName | removableText |
      | INFO | Plugin CNavigatorCataloger Start Time:2020-05-20 07:22:48.260, End Time:2020-05-20 07:22:50.431, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 |            |               |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5414_SC#3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HDFSConfig5414% | Analysis  |       |       |
      | MultipleIDDelete | Default | ROOT%                                         | Directory |       |       |


  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:ClouderaHdfs_Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |


  @MLP-4441 @sanity @positive
  Scenario:ClouderaHdfs_Delete cluster id & All_Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |


