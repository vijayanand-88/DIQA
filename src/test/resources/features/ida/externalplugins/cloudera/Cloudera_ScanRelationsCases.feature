@MLP-4755
Feature:MLP-4755: cloudera_ScanRelationsCases

  @MLP-4610 @positive @regression @cloudera
  Scenario Outline: SC1#-Set the Credentials and DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaValidCredentials   | ida/cloudEraNavigatorPayloads/Credentials/Valid.json               | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaInValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/Invalid.json             | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource         | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource         |                                                                    | 200           | CNavigatorDataSource |          |

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:SC1#_MLP_4755_Config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4755_Hive.json | 204           |                  |          |


  ##6060005##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_4755_Verify whether the catalog contains operations and execution if sourceType is "Hive Databases and Tables" and Scan relations is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                         |      | 200           | HiveScanON       |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveScanON |      | 200           | IDLE             | $.[?(@.configurationName=='HiveScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveScanON  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveScanON |      | 200           | IDLE             | $.[?(@.configurationName=='HiveScanON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC1" and clicks on search
    And user performs "facet selection" in "CN4755SC1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 23    |
      | HIVE [Service]                | 14    |
      | IMPALA [Service]              | 8     |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Database  |
      | Table     |
      | Column    |
      | Analysis  |
      | Service   |
      | Cluster   |
    And user clicks on logout button

  ##6062157##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_4755_Verify whether the catalog does not contain operations and execution if sourceType is "Hive Databases and Tables" and Scan relations is OFF.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='HiveScanOFF')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveScanOFF  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='HiveScanOFF')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC2" and clicks on search
    And user performs "facet selection" in "CN4755SC2" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 12    |
      | HIVE [Service]                | 11    |
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | IMPALA [Service] |
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
    And user enters the search text "CN4755SC2" and clicks on search
    And user performs "facet selection" in "CN4755SC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user stores cloud era list values with below parameters
      | Service           | cloudEra Endpoint                                                                          | cloudEraJsonPath |
      | CloudEraNavigator | /entities?query=((sourceType:hive)AND(type:database)AND(originalName:*testscanrelations*)) | $..originalName  |
    And user reset the REST API Service
    And configure a new REST API for the service "IDC"
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for GET request with url "tags/Default/CN4755SC2/items?subtags=true&limit=0&offset=0" and save the response in file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json"
    Then user compares "tempList" value and value from file "rest/payloads/ida/cloudEraNavigatorPayloads/actualList.json" using json path "$.[?(@.type=='Database')].name"
    And user clicks on logout button

  ##6062165##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_4755_Verify whether the catalog contains related operations/execution/Directory/File if sourceType is "Yarn Operations" and Scan relations is ON and lineage appears.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/YarnScanON |      | 200           | IDLE             | $.[?(@.configurationName=='YarnScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/YarnScanON  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/YarnScanON |      | 200           | IDLE             | $.[?(@.configurationName=='YarnScanON')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC3" and clicks on search
    And user performs "facet selection" in "CN4755SC3" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Directory |
      | Analysis  |
      | Service   |
      | Cluster   |
    And user enters the search text "*census*" and clicks on search
    And user performs "facet selection" in "CN4755SC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "YARN [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                 | Feature           | jsonPath        |
      | /entities?query=((sourceType:yarn)AND(type:operation)AND(originalName:*census*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "*census*" and clicks on search
    And user performs "facet selection" in "CN4755SC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "YARN [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "INSERT OVERWRITE DIRECTORY ...default.census(Stage_1657147" item from search results
    Then user performs click and verify in new window
      | Table              | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops       | year=2010 => VIEW/LOCAL        | verify widget contains |                  |             |
      | Lineage Hops       | year=2011 => VIEW/LOCAL        | verify widget contains |                  |             |
      | Lineage Hops       | year=2012 => VIEW/LOCAL        | verify widget contains |                  |             |
      | uses               | insert overwrite directory     | verify widget contains |                  |             |
      | uses               | year=2010                      | verify widget contains |                  |             |
      | uses               | year=2011                      | verify widget contains |                  |             |
      | uses               | year=2012                      | verify widget contains |                  |             |
      | Runtime Executions | job_1532521880492_0131_1657148 | verify widget contains |                  |             |
    And user clicks on logout button

  ##6062212##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_4755_Verify whether the catalog contains operations/execution/database/tables associated with specific filter if sourceType is "Hive Operations" and Scan relations is ON.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body | response code | response message | jsonPath                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveOperation |      | 200           | IDLE             | $.[?(@.configurationName=='HiveOperation')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveOperation  |      | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveOperation |      | 200           | IDLE             | $.[?(@.configurationName=='HiveOperation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC4" and clicks on search
    And user performs "facet selection" in "CN4755SC4" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Analysis  |
      | Service   |
      | Cluster   |
      | Database  |
      | Table     |
      | Column    |
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                              | Feature           | jsonPath        |
      | /entities?query=((sourceType:HIVE)AND(type:operation)AND(originalName:*testlineage1.tblres*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CN4755SC4" and clicks on search
    And user performs "facet selection" in "CN4755SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                        | Feature           | jsonPath        |
      | /entities?query=((sourceType:HIVE)AND(type:operation_execution)AND(originalName:*testlineage1.tblres*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  ##6062223##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#5_MLP_4755_Verify whether the catalog contains related operations and execution if sourceType is "HDFS Directories and Files" and Scan relations is ON.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                        | body | response code | response message | jsonPath                                    |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSON |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body | response code | response message | jsonPath                                    |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSON  |      | 200           |                  |                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSON |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSON')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC5" and clicks on search
    And user performs "facet selection" in "CN4755SC5" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Directory |
      | File      |
      | Analysis  |
      | Service   |
      | Cluster   |
      | Database  |
      | Table     |
      | Column    |
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 223   |
      | HDFS [Service]                | 93    |
      | HIVE [Service]                | 63    |
      | IMPALA [Service]              | 55    |
      | YARN [Service]                | 11    |
    And user enters the search text "INSERT OVERWRITE DIRECTORY ...default.census(Stage__1657147" and clicks on search
    And user performs "item click" on "INSERT OVERWRITE DIRECTORY ...default.census(Stage_1657147" item from search results
    Then user performs click and verify in new window
      | Table              | value                          | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops       | year=2010 => VIEW/LOCAL        | verify widget contains |                  |             |
      | Lineage Hops       | year=2011 => VIEW/LOCAL        | verify widget contains |                  |             |
      | Lineage Hops       | year=2012 => VIEW/LOCAL        | verify widget contains |                  |             |
      | uses               | insert overwrite directory     | verify widget contains |                  |             |
      | uses               | year=2010                      | verify widget contains |                  |             |
      | uses               | year=2011                      | verify widget contains |                  |             |
      | uses               | year=2012                      | verify widget contains |                  |             |
      | Runtime Executions | job_1532521880492_0131_1657148 | verify widget contains |                  |             |
    And user clicks on logout button

##6062236##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#6_MLP_4755_Verify whether the catalog does not contain related operations and execution if sourceType is "HDFS Directories and Files" and Scan relations is OFF.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body | response code | response message | jsonPath                                     |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSOFF |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSOFF')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body | response code | response message | jsonPath                                     |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSOFF  |      | 200           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSOFF |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSOFF')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC6" and clicks on search
    And user performs "facet selection" in "CN4755SC6" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
      | Analysis  |
      | Service   |
      | Cluster   |
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 94    |
      | HDFS [Service]                | 93    |
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | HIVE [Service]   |
      | IMPALA [Service] |
      | YARN [Service]   |
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
    And user clicks on logout button


  ##6132311##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#7_MLP_4755_Verify the lineage appears properly when the sourceType is “Yarn Operations” which involves data flow from one HDFS directory to another HDFS directory..
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                        | body | response code | response message | jsonPath                                    |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/YARNON |      | 200           | IDLE             | $.[?(@.configurationName=='YARNON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body | response code | response message | jsonPath                                    |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/YARNON  |      | 200           |                  |                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/YARNON |      | 200           | IDLE             | $.[?(@.configurationName=='YARNON')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC8" and clicks on search
    And user performs "facet selection" in "CN4755SC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "wordcount_4698084" item from search results
    Then user performs click and verify in new window
      | Table        | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | input => output10 | verify widget contains |                  |             |
      | uses         | input             | verify widget contains |                  |             |
      | uses         | output10          | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value             | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath  |
      | Lineage Hops | input => output10 | click and verify lineagehops | Yes              |             | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest6 |
    And user clicks on logout button

##6133420##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#8_MLP_4755_Verify lineage appears properly from HDFS to another HDFS if sourceType is “HDFS Directories and Files” and scan relation is ON
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HDFSOutput |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSOutput')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HDFSOutput  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HDFSOutput |      | 200           | IDLE             | $.[?(@.configurationName=='HDFSOutput')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC9" and clicks on search
    And user performs "facet selection" in "CN4755SC9" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "YARN [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "wordcount_191636" item from search results
    Then user performs click and verify in new window
      | Table        | value           | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | input => output | verify widget contains |                  |             |
      | uses         | input           | verify widget contains |                  |             |
      | uses         | output          | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value           | Action                       | RetainPrevwindow | indexSwitch | filePath                                                      | jsonPath  |
      | Lineage Hops | input => output | click and verify lineagehops | Yes              |             | ida/cloudEraNavigatorPayloads/DataSource/lineageMetadata.json | $.QATest7 |
    And user clicks on logout button

##6062201##
  @MLP-4755 @webtest @positive @regression @cloudera
  Scenario:SC#9_MLP_4755_Verify whether the catalog contains operations and execution of all the tables if sourceType is "Hive Databases and Tables" and Scan relations is ON.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveLineage |      | 200           | IDLE             | $.[?(@.configurationName=='HiveLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveLineage          |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveLineage         |      | 200           | IDLE             | $.[?(@.configurationName=='HiveLineage')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4755SC10" and clicks on search
    And user performs "facet selection" in "CN4755SC10" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 211   |
      | HIVE [Service]                | 116   |
      | YARN [Service]                | 42    |
      | IMPALA [Service]              | 41    |
      | HDFS [Service]                | 11    |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Directory |
      | Analysis  |
      | Service   |
      | Cluster   |
      | Database  |
      | Table     |
      | Column    |
      | Partition |
    And user enters the search text "*testlineage*" and clicks on search
    And user performs "facet selection" in "CN4755SC10" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Directory |
      | Analysis  |
      | Database  |
      | Table     |
      | Column    |
      | Partition |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4755_SC#10:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type      | query | param |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | insert%                        | Operation |       |       |
      | MultipleIDDelete | Default | create%                        | Operation |       |       |
      | MultipleIDDelete | Default | select%                        | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%                        | Operation |       |       |
      | MultipleIDDelete | Default | CREATE%                        | Operation |       |       |
      | MultipleIDDelete | Default | SELECT%                        | Operation |       |       |
      | MultipleIDDelete | Default | FROM%                          | Operation |       |       |
      | MultipleIDDelete | Default | Pig%                           | Operation |       |       |
      | MultipleIDDelete | Default | word%                          | Operation |       |       |
      | MultipleIDDelete | Default | ROOT                           | Directory |       |       |
      | MultipleIDDelete | Default | test%                          | Database  |       |       |
      | MultipleIDDelete | Default | default                        | Database  |       |       |


  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:4755_SC11-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:4755_SC#12:Delete cluster id and Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |