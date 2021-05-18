@MLP-17683
Feature:DataSource Implementation for AWS S3 Parquet Cataloger

  @aws @precondition
  Scenario: Update AWS secret key and access from config file
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                            | accessKeyPath | secretKeyPath |
      | ida/s3ParquetPayloads/Credentials/awsParquetS3ValidCredentials.json | $..accessKey  | $..secretKey  |

  #6938867
  @cr-data @sanity @positive
  Scenario Outline: Configure the Credentials for Parquet S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | body                                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidParquetCredentials     | ida/s3ParquetPayloads/Credentials/awsParquetS3ValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectParquetCredentials | ida/s3ParquetPayloads/Credentials/awsParquetS3InValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyParquetCredentials     | ida/s3ParquetPayloads/Credentials/awsParquetS3EmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidParquetCredentials     |                                                                       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectParquetCredentials |                                                                       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyParquetCredentials     |                                                                       | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials      | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json            | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials      |                                                                       | 200           |                  |          |


  @sanity @positive @regression
  Scenario Outline: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3ParquetPayloads/ParquetS3BusinessApplication.json | 200           |                  |          |


  @MLP-17683 @webtest
  Scenario: SC#1-Verify whether the background of the panel is displayed in green when test connection is successful for ParquetS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | ParquetS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute               |
      | Name      | ParquetS3DataSourceTest |
      | Label     | ParquetS3DataSourceTest |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | ValidParquetCredentials           |
      | Deployment | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  @MLP-17683 @webtest
  Scenario: SC#2-Verify whether the background of the panel is displayed in red when test connection is not successful for ParquetS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | ParquetS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                |
      | Name      | ParquetS3DataSourceTest2 |
      | Label     | ParquetS3DataSourceTest2 |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | IncorrectParquetCredentials       |
      | Deployment | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    #And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute               |
      | Credential | EmptyParquetCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    #And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"

  @cr-data @sanity @positive
  Scenario: SC#3-Configure the Parquet S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                    | body                                                                       | response code | response message               | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/ParquetS3DataSource | ida/s3ParquetPayloads/DataSource/AmazonParquetS3ValidDataSourceConfig.json | 204           |                                |          |
      |                  |       |       | Get  | settings/analyzers/ParquetS3DataSource |                                                                            | 200           | AmazonParquetS3ValidDataSource |          |

  @aws
  Scenario: SC#3-Create a bucket and folder with parquet files in S3 Amazon storage
    Given user "Create" a bucket "asgqaparquetautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix       | dirPath                         | recursive |
      | asgqaparquetautomation | ParquetTestData | ida/s3ParquetPayloads/TestData/ | true      |

  #6936987
  @cr-data @sanity @positive
  Scenario: SC#3-Configure & run the ParquetS3Cataloger for SC3
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                           | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc1ParquetS3ConfigBucketInclude.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  |                                                                                | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |


  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: MLP-17683:SC3#Verify Bucket level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgqaparquetautomation" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue           | widgetName  |
      | Created by                | aws.saas.dev.di         | Description |
      | Directory size            | 0                       | Statistics  |
      | Number of files           | 0                       | Statistics  |
      | Size of files             | 0                       | Statistics  |
      | Location                  | asgqaparquetautomation/ | Description |
      | Number of sub-directories | 1                       | Statistics  |
      | Size of sub-directories   | 0                       | Statistics  |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | asgqaparquetautomation                        |
#      | attributeName  | Technical Data                                |
#      | actualFilePath | ida/s3ParquetPayloads/actualBuckTechData.json |
#    Then file content in "ida/s3ParquetPayloads/expectedBuckTechData.json" should be same as the content in "ida/s3ParquetPayloads/actualBuckTechData.json"
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute | widgetName |
#      | ID                | Metadata   |
#      | Created           | Metadata   |
#    Then user "verify metadata properties" section has following values
#      | ID      |
#      | Created |


  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: MLP-17683:SC4#Verify Directory level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ParquetTestData" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                           | widgetName  |
      | Directory size            | 0                                       | Statistics  |
      | Number of files           | 0                                       | Statistics  |
      | Size of files             | 0                                       | Statistics  |
      | Location                  | asgqaparquetautomation/ParquetTestData/ | Description |
      | Number of sub-directories | 3                                       | Statistics  |
      | Size of sub-directories   | 134263                                  | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Modified          | Lifecycle  |
#    Then user "verify metadata properties" section has following values
#      | ID       |
#      | Modified |


  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: MLP-17683:SC5#Verify sub directory level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TestParquet" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                                       | widgetName  |
      | Directory size            | 125919                                              | Statistics  |
      | Number of files           | 10                                                  | Statistics  |
      | Size of files             | 125919                                              | Statistics  |
      | Location                  | asgqaparquetautomation/ParquetTestData/TestParquet/ | Description |
      | Number of sub-directories | 1                                                   | Statistics  |
      | Size of sub-directories   | 1445                                                | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | Modified          | Description |
#    Then user "verify metadata properties" section has following values
#      | ID       |
#      | Modified |


  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: MLP-17683:SC6#Verify File level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "source.parquet [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "source.parquet" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                     | widgetName  |
      | File size         | 615.00 Bytes                                                      | Description |
      | Location          | asgqaparquetautomation/ParquetTestData/TestParquet/source.parquet | Description |


  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: MLP-17683:SC7#Verify Field level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "source.parquet [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "name" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | STRING        | Description |


  Scenario Outline: SC#1-7-user retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                | type | targetFile                             | jsonpath            |
      | APPDBPOSTGRES | Default | amazonaws.com                                       |      | response/parquetS3/actual/itemIds.json | $..Cluster.id       |
      | APPDBPOSTGRES | Default | AmazonS3                                            |      | response/parquetS3/actual/itemIds.json | $..has_Service.id   |
      | APPDBPOSTGRES | Default | asgqaparquetautomation                              |      | response/parquetS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger%DYN |      | response/parquetS3/actual/itemIds.json | $..has_Analysis.id  |

#  Scenario Outline: SC#10-user retrieves the metadata of each data type for a catalog
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
#    Examples:
#      | url                                                 | responseCode | inputJson           | inputFile                              | outPutFile                                      | outPutJson |
#      | components/Default/item/Default.Cluster:::dynamic   | 200          | $..Cluster.id       | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/clusterMetadata.json  |            |
#      | components/Default/item/Default.Service:::dynamic   | 200          | $..has_Service.id   | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/serviceMetadata.json  |            |
#      | components/Default/item/Default.Directory:::dynamic | 200          | $..has_Directory.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/dirMetadata.json      |            |
#      | components/Default/item/Default.Analysis:::dynamic  | 200          | $..has_Analysis.id  | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/analysisMetadata.json |            |

  Scenario Outline: SC#8-user retrieves the metadata of each item for a catalog
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                               | response code | response message | filePath                                      | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | searches/fulltext/Default?query=testtagSC1Parquet&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0 |                                                    | 200           |                  | response/parquetS3/actual/catalogItems.json   |          |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/parquetS3/body/getFacetsCountRequest.json | 200           |                  | response/parquetS3/actual/facetWiseCount.json |          |

  Scenario Outline: SC#8-Validate the catalogued count and facets counts in IDC platform
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                             | actualValues                                  | valueType      | expectedJsonPath                      | actualJsonPath               |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/catalogItems.json   | stringCompare  | $..totalCount                         | $..count                     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/facetWiseCount.json | intListCompare | $..MetaData.facetCounts.type_s..count | $.facetCounts..type_s..count |

#  #6936984
#  Scenario Outline: SC#13-Validate the service and bucket level metadata results in IDC platform
#    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
#    Examples:
#      | expectedValues                                             | actualValues                               | valueType         | expectedJsonPath                                | actualJsonPath                                                                             |
##      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/serviceMetadata.json | stringListCompare | $..serviceMetaData..has_Directory..name         | $.data.[0]..[?(@.caption=='definitions')].data..name                                       |
##      | response/amazonS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/serviceMetadata.json | stringListCompare | $..serviceMetaData..taglist..techTag            | $..[?(@.caption=='tag')].data..name                                                        |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/dirMetadata.json | intCompare        | $..directoryMetaData..directorySize             | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Directory size')]..value      |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/dirMetadata.json | intCompare        | $..directoryMetaData..sizeOfFiles               | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Size of files')]..value       |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/dirMetadata.json | stringCompare     | $..directoryMetaData..location                  | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Location')]..value            |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/dirMetadata.json | stringCompare     | $..directoryMetaData..sizeOfSubDir              | $..[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Size of sub-directories')]..value |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/dirMetadata.json | stringListCompare | $..directoryMetaData.table..has_Directory..name | $..[0].[?(@.caption=='definitions')].data..name                                            |
#
#  Scenario Outline: SC#14-user retrieves the item ids of SubDirectory items and copy them to a json file
#    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | catalog | name        | type | targetFile                             | jsonpath            |
#      | APPDBPOSTGRES | Default | TestParquet |      | response/parquetS3/actual/itemIds.json | $..has_Directory.id |
#
#  Scenario Outline: SC#15-user retrieves the metadata of SubDirectory type for a catalog
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
#    Examples:
#      | url                                                 | responseCode | inputJson           | inputFile                              | outPutFile                                    | outPutJson |
#      | components/Default/item/Default.Directory:::dynamic | 200          | $..has_Directory.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/subDirMetadata.json |            |
#
#  #6936985
#  Scenario Outline: SC#16-Validate the SubDirectory level metadata results in IDC platform
#    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
#    Examples:
#      | expectedValues                                             | actualValues                                  | valueType         | expectedJsonPath                               | actualJsonPath                                                                               |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/subDirMetadata.json | intCompare        | $..subDirectoryMetaData..directorySize         | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Directory size')]..value        |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/subDirMetadata.json | intCompare        | $..subDirectoryMetaData..sizeOfFiles           | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Size of files')]..value         |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/subDirMetadata.json | intCompare        | $..subDirectoryMetaData..numberOfFiles         | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Number of files')]..value       |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/subDirMetadata.json | stringCompare     | $..subDirectoryMetaData..location              | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Location')]..value              |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/subDirMetadata.json | stringCompare     | $..subDirectoryMetaData..numberOfSubDir        | $..[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Number of sub-directories')]..value |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/subDirMetadata.json | stringCompare     | $..subDirectoryMetaData..sizeOfSubDir          | $..[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Size of sub-directories')]..value   |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/subDirMetadata.json | stringListCompare | $..subDirectoryMetaData.table..has_Files..name | $..[0].[?(@.caption=='definitions')].data..name                                              |
#
#  Scenario Outline: SC#17-user retrieves the item ids of File items and copy them to a json file
#    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | catalog | name           | type | targetFile                             | jsonpath       |
#      | APPDBPOSTGRES | Default | nation.parquet |      | response/parquetS3/actual/itemIds.json | $..has_File.id |
#
#  Scenario Outline: SC#18-user retrieves the metadata of File type for a catalog
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
#    Examples:
#      | url                                            | responseCode | inputJson      | inputFile                              | outPutFile                                  | outPutJson |
#      | components/Default/item/Default.File:::dynamic | 200          | $..has_File.id | response/parquetS3/actual/itemIds.json | response/parquetS3/actual/fileMetadata.json |            |
##
#  #6936986
#  Scenario Outline: SC#19-Validate the File level metadata results in IDC platform
#    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
#    Examples:
#      | expectedValues                                             | actualValues                                | valueType         | expectedJsonPath                        | actualJsonPath                                                                                        |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fileMetadata.json | stringCompare     | $..fileMetaData..Location               | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Location')]..value                       |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fileMetadata.json | intCompare        | $..fileMetaData..fileContentLength      | $..[0].[?(@.caption=='Metadata')]..attributes.[?(@.caption=='Technical Data')]..value..Content-Length |
#      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fileMetadata.json | stringListCompare | $..fileMetaData.table..has_Fields..name | $..[0].[?(@.caption=='definitions')].data..name                                                       |

  Scenario Outline: SC#9-user retrieves the item ids of Field items of file: HiveParquet.parquet and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name | type | targetFile                                  | jsonpath     |
      | APPDBPOSTGRES | Default | a1   |      | response/parquetS3/actual/fieldItemIds.json | $..Field1.id |
      | APPDBPOSTGRES | Default | b1   |      | response/parquetS3/actual/fieldItemIds.json | $..Field2.id |
      | APPDBPOSTGRES | Default | c1   |      | response/parquetS3/actual/fieldItemIds.json | $..Field3.id |
      | APPDBPOSTGRES | Default | d1   |      | response/parquetS3/actual/fieldItemIds.json | $..Field4.id |
      | APPDBPOSTGRES | Default | e1   |      | response/parquetS3/actual/fieldItemIds.json | $..Field5.id |

  Scenario Outline: SC#9-user retrieves the metadata of Field type for a file: HiveParquet.parquet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson   | inputFile                                   | outPutFile                                   | outPutJson                                              | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field1.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field1.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field2.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field2.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field3.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field3.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field4.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field4.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field5.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field5.fieldActualDataType | $..[?(@.caption=='Data type')]..value |

  #6938862
  Scenario Outline: SC#9-Validate the Field level metadata results for a file: HiveParquet.parquet in IDC platform
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                             | actualValues                                 | valueType     | expectedJsonPath                            | actualJsonPath                                          |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field1.fieldName     | $..fieldActualMetaData.file1.field1.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field1.fieldDataType | $..fieldActualMetaData.file1.field1.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field2.fieldName     | $..fieldActualMetaData.file1.field2.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field2.fieldDataType | $..fieldActualMetaData.file1.field2.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field3.fieldName     | $..fieldActualMetaData.file1.field3.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field3.fieldDataType | $..fieldActualMetaData.file1.field3.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field4.fieldName     | $..fieldActualMetaData.file1.field4.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field4.fieldDataType | $..fieldActualMetaData.file1.field4.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field5.fieldName     | $..fieldActualMetaData.file1.field5.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field5.fieldDataType | $..fieldActualMetaData.file1.field5.fieldActualDataType |

  Scenario Outline: SC#10-user retrieves the item ids of Field items of files: Simple Data Types - userDiffDataTypes.parquet, Complex Data Types - testcomplex.parquet and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name        | type | targetFile                                  | jsonpath      |
      | APPDBPOSTGRES | Default | username    |      | response/parquetS3/actual/fieldItemIds.json | $..Field1.id  |
      | APPDBPOSTGRES | Default | age         |      | response/parquetS3/actual/fieldItemIds.json | $..Field2.id  |
      | APPDBPOSTGRES | Default | InCity      |      | response/parquetS3/actual/fieldItemIds.json | $..Field3.id  |
      | APPDBPOSTGRES | Default | doubleType  |      | response/parquetS3/actual/fieldItemIds.json | $..Field4.id  |
      | APPDBPOSTGRES | Default | floatType   |      | response/parquetS3/actual/fieldItemIds.json | $..Field5.id  |
      | APPDBPOSTGRES | Default | longType    |      | response/parquetS3/actual/fieldItemIds.json | $..Field6.id  |
      | APPDBPOSTGRES | Default | bytesType   |      | response/parquetS3/actual/fieldItemIds.json | $..Field7.id  |
      | APPDBPOSTGRES | Default | phone       |      | response/parquetS3/actual/fieldItemIds.json | $..Field8.id  |
      | APPDBPOSTGRES | Default | object      |      | response/parquetS3/actual/fieldItemIds.json | $..Field9.id  |
      | APPDBPOSTGRES | Default | StringArray |      | response/parquetS3/actual/fieldItemIds.json | $..Field10.id |
      | APPDBPOSTGRES | Default | String      |      | response/parquetS3/actual/fieldItemIds.json | $..Field11.id |
      | APPDBPOSTGRES | Default | Double      |      | response/parquetS3/actual/fieldItemIds.json | $..Field12.id |
      | APPDBPOSTGRES | Default | ObjectArray |      | response/parquetS3/actual/fieldItemIds.json | $..Field13.id |
      | APPDBPOSTGRES | Default | magic       |      | response/parquetS3/actual/fieldItemIds.json | $..Field14.id |
      | APPDBPOSTGRES | Default | StringMap   |      | response/parquetS3/actual/fieldItemIds.json | $..Field15.id |
      | APPDBPOSTGRES | Default | IntMap      |      | response/parquetS3/actual/fieldItemIds.json | $..Field16.id |
      | APPDBPOSTGRES | Default | Int         |      | response/parquetS3/actual/fieldItemIds.json | $..Field17.id |
      | APPDBPOSTGRES | Default | object3     |      | response/parquetS3/actual/fieldItemIds.json | $..Field18.id |

  Scenario Outline: SC#10-user retrieves the metadata of Field type for files: Simple Data Types - userDiffDataTypes.parquet, Complex Data Types - testcomplex.parquet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson    | inputFile                                   | outPutFile                                   | outPutJson                                               | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field1.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field1.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field2.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field2.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field3.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field3.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field4.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field4.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field5.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field5.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field6.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field6.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field7.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field7.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field8.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field8.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field9.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field9.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field10.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field10.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field11.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field11.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field12.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field12.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field13.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field13.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field14.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field14.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field15.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field15.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field16.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field16.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field16.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field16.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field17.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field17.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field17.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field17.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field18.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field18.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field18.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file2.field18.fieldActualDataType | $..[?(@.caption=='Data type')]..value |

  #6938863
  Scenario Outline: SC#10-Validate the Field level metadata results for files: Simple Data Types - userDiffDataTypes.parquet, Complex Data Types - testcomplex.parquet
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                             | actualValues                                 | valueType     | expectedJsonPath                             | actualJsonPath                                           |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field1.fieldName      | $..fieldActualMetaData.file2.field1.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field1.fieldDataType  | $..fieldActualMetaData.file2.field1.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field2.fieldName      | $..fieldActualMetaData.file2.field2.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field2.fieldDataType  | $..fieldActualMetaData.file2.field2.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field3.fieldName      | $..fieldActualMetaData.file2.field3.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field3.fieldDataType  | $..fieldActualMetaData.file2.field3.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field4.fieldName      | $..fieldActualMetaData.file2.field4.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field4.fieldDataType  | $..fieldActualMetaData.file2.field4.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field5.fieldName      | $..fieldActualMetaData.file2.field5.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field5.fieldDataType  | $..fieldActualMetaData.file2.field5.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field6.fieldName      | $..fieldActualMetaData.file2.field6.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field6.fieldDataType  | $..fieldActualMetaData.file2.field6.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field7.fieldName      | $..fieldActualMetaData.file2.field7.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field7.fieldDataType  | $..fieldActualMetaData.file2.field7.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field8.fieldName      | $..fieldActualMetaData.file2.field8.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field8.fieldDataType  | $..fieldActualMetaData.file2.field8.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field9.fieldName      | $..fieldActualMetaData.file2.field9.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field9.fieldDataType  | $..fieldActualMetaData.file2.field9.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field10.fieldName     | $..fieldActualMetaData.file2.field10.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field10.fieldDataType | $..fieldActualMetaData.file2.field10.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field11.fieldName     | $..fieldActualMetaData.file2.field11.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field11.fieldDataType | $..fieldActualMetaData.file2.field11.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field12.fieldName     | $..fieldActualMetaData.file2.field12.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field12.fieldDataType | $..fieldActualMetaData.file2.field12.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field13.fieldName     | $..fieldActualMetaData.file2.field13.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field13.fieldDataType | $..fieldActualMetaData.file2.field13.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field14.fieldName     | $..fieldActualMetaData.file2.field14.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field14.fieldDataType | $..fieldActualMetaData.file2.field14.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field15.fieldName     | $..fieldActualMetaData.file2.field15.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field15.fieldDataType | $..fieldActualMetaData.file2.field15.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field16.fieldName     | $..fieldActualMetaData.file2.field16.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field16.fieldDataType | $..fieldActualMetaData.file2.field16.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field17.fieldName     | $..fieldActualMetaData.file2.field17.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field17.fieldDataType | $..fieldActualMetaData.file2.field17.fieldActualDataType |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field18.fieldName     | $..fieldActualMetaData.file2.field18.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file2.field18.fieldDataType | $..fieldActualMetaData.file2.field18.fieldActualDataType |

  Scenario Outline: SC#11-user retrieves the item ids of Field items of files: Spark.parquet and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name | type | targetFile                                  | jsonpath      |
      | APPDBPOSTGRES | Default | _c0  |      | response/parquetS3/actual/fieldItemIds.json | $..Field1.id  |
      | APPDBPOSTGRES | Default | _c1  |      | response/parquetS3/actual/fieldItemIds.json | $..Field2.id  |
      | APPDBPOSTGRES | Default | _c2  |      | response/parquetS3/actual/fieldItemIds.json | $..Field3.id  |
      | APPDBPOSTGRES | Default | _c3  |      | response/parquetS3/actual/fieldItemIds.json | $..Field4.id  |
      | APPDBPOSTGRES | Default | _c4  |      | response/parquetS3/actual/fieldItemIds.json | $..Field5.id  |
      | APPDBPOSTGRES | Default | _c5  |      | response/parquetS3/actual/fieldItemIds.json | $..Field6.id  |
      | APPDBPOSTGRES | Default | _c6  |      | response/parquetS3/actual/fieldItemIds.json | $..Field7.id  |
      | APPDBPOSTGRES | Default | _c7  |      | response/parquetS3/actual/fieldItemIds.json | $..Field8.id  |
      | APPDBPOSTGRES | Default | _c8  |      | response/parquetS3/actual/fieldItemIds.json | $..Field9.id  |
      | APPDBPOSTGRES | Default | _c9  |      | response/parquetS3/actual/fieldItemIds.json | $..Field10.id |

  Scenario Outline: SC#11-user retrieves the metadata of Field type for file: Spark.parquet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson    | inputFile                                   | outPutFile                                   | outPutJson                                               | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field1.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field1.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field2.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field2.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field3.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field3.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field4.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field4.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field5.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field5.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field6.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field6.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field7.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field7.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field8.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field8.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field9.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field9.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field10.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/parquetS3/actual/fieldItemIds.json | response/parquetS3/actual/fieldMetadata.json | $..fieldActualMetaData.file3.field10.fieldActualDataType | $..[?(@.caption=='Data type')]..value |

  #6938864
  Scenario Outline: SC#11-Validate the Field level metadata results for files: Spark.parquet
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                             | actualValues                                 | valueType     | expectedJsonPath                             | actualJsonPath                                           |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field1.fieldName      | $..fieldActualMetaData.file3.field1.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field1.fieldDataType  | $..fieldActualMetaData.file3.field1.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field2.fieldName      | $..fieldActualMetaData.file3.field2.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field2.fieldDataType  | $..fieldActualMetaData.file3.field2.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field3.fieldName      | $..fieldActualMetaData.file3.field3.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field3.fieldDataType  | $..fieldActualMetaData.file3.field3.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field4.fieldName      | $..fieldActualMetaData.file3.field4.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field4.fieldDataType  | $..fieldActualMetaData.file3.field4.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field5.fieldName      | $..fieldActualMetaData.file3.field5.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field5.fieldDataType  | $..fieldActualMetaData.file3.field5.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field6.fieldName      | $..fieldActualMetaData.file3.field6.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field6.fieldDataType  | $..fieldActualMetaData.file3.field6.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field7.fieldName      | $..fieldActualMetaData.file3.field7.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field7.fieldDataType  | $..fieldActualMetaData.file3.field7.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field8.fieldName      | $..fieldActualMetaData.file3.field8.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field8.fieldDataType  | $..fieldActualMetaData.file3.field8.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field9.fieldName      | $..fieldActualMetaData.file3.field9.fieldActualName      |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field9.fieldDataType  | $..fieldActualMetaData.file3.field9.fieldActualDataType  |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field10.fieldName     | $..fieldActualMetaData.file3.field10.fieldActualName     |
      | response/parquetS3/expected/parquetS3ExpectedJsonData.json | response/parquetS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file3.field10.fieldDataType | $..fieldActualMetaData.file3.field10.fieldActualDataType |


  @MLP-17683 @sanity @positive @webtest
  Scenario: SC#12-Verify the facet counts are exact once the Parquet S3 items are cataloged.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Service   | 1     |
      | Cluster   | 1     |
      | Analysis  | 1     |
      | Directory | 6     |
      | File      | 14    |
      | Field     | 88    |
    #And user clicks on logout button

  #6936971
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-18061 @MLPQA-18064
  Scenario: SC#13-Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname with Include
    Given user gets amazon bucket "asgqaparquetautomation" file count in "ParquetTestData/TestParquet" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "TestParquet [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then results panel "Search Results" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ParquetTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | asgqaparquetautomation |
      | ParquetTestData |
      | TestParquet     |
      | NonParquet      |
      | version         |
      | Incremental     |
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
      | incremental.parquet       |
      | simple.parquet            |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                 | fileName       | userTag           |
      | Default     | File | Metadata Type | testtagSC1Parquet,Parquet,Amazon S3 | nation.parquet | testtagSC1Parquet |
    And sync the test execution for "20" seconds
    #And user clicks on logout button

#    ##6549303
#  @sanity @positive @webtest @edibus
#  Scenario:MLP-9043_Verify the Parquet S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "testtagSC1Parquet" and clicks on search
#    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Parquet" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#      | Field     |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBusParquetConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                | body                                                  | response code | response message | jsonPath                                           |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                | idc/EdiBusPayloads/datasource/EDIBusDS_Parquets3.json | 204           |                  |                                                    |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/EDIBusParquetConfig.json           | 204           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusParquet |                                                       | 200           | IDLE             | $.[?(@.configurationName=='EDIBusParquet')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusParquet  |                                                       | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusParquet |                                                       | 200           | IDLE             | $.[?(@.configurationName=='EDIBusParquet')].status |
#    And user enters the search text "EDIBusParquet" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusParquet%"
#    Then the following metadata values should be displayed
#      | metaDataItem     | metaDataItemValue | widgetName  |
#      | Number of errors | 0                 | Description |
#    And user enters the search text "testtagSC1Parquet" and clicks on search
#    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Parquet |
#      | $..selections.['type_s'][*]                   | File                                          |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                              | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=testtagSC1Parquet&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "testtagSC1Parquet" and clicks on search
#    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Parquet |
#      | $..selections.['type_s'][*]                   | Directory                                     |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                              | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=testtagSC1Parquet&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user enters the search text "testtagSC1Parquet" and clicks on search
#    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM) |
#    And user enters the search text "testtagSC1Parquet" and clicks on search
#    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FIELD ) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                            |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @*Parquet≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @*Parquet≫DEFAULT≫DWR_DAT_DIRECTORY≫@* ),AND,( TYPE = DWR_IDC )   |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @*Parquet≫DEFAULT≫DWR_DAT_FILE_SYSTEM≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @*Parquet≫DEFAULT≫DWR_DAT_FIELD≫@* ),AND,( TYPE = DWR_IDC )       |


  @sanity @positive @MLP-17683 @webtest @IDA-10.3 @MLPQA-18061 @MLPQA-18064
  Scenario: SC#14-Verify the technology tags got assigned to all S3 Parquet catalogued items like Cluster,Service,Database...etc
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                 | fileName               | userTag           |
      | Default     | Directory | Metadata Type | testtagSC1Parquet,Parquet,Amazon S3 | asgqaparquetautomation | testtagSC1Parquet |
      | Default     | Cluster   | Metadata Type | testtagSC1Parquet,Parquet,Amazon S3 | amazonaws.com          | testtagSC1Parquet |
      | Default     | Field     | Metadata Type | testtagSC1Parquet,Parquet,Amazon S3 | gender                 | testtagSC1Parquet |
      | Default     | File      | Metadata Type | testtagSC1Parquet,Parquet,Amazon S3 | simple.parquet         | testtagSC1Parquet |
      | Default     | Service   | Metadata Type | testtagSC1Parquet,Parquet,Amazon S3 | AmazonS3               | testtagSC1Parquet |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag        | fileName               | userTag           |
      | Default     | Cluster   | Metadata Type | Data Files | amazonaws.com          | testtagSC1Parquet |
      | Default     | Directory | Metadata Type | Data Files | asgqaparquetautomation | testtagSC1Parquet |
      | Default     | Field     | Metadata Type | Data Files | GENDER                 | testtagSC1Parquet |
      | Default     | File      | Metadata Type | Data Files | simple.parquet         | testtagSC1Parquet |
      | Default     | Service   | Metadata Type | Data Files | AmazonS3               | testtagSC1Parquet |
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/ParquetS3Cataloger/ParquetS3Cataloger%"
    Then user "verify presence" of following "Tag List" in Item View Page
      | testtagSC1Parquet |
      | Parquet           |
    #And user clicks on logout button

  #6936988 This functionality is removed in DD.Once the alternate automation fixes are merged this can be altered.
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: SC#15-Verify breadcrumb hierarchy appears correctly in S3Cataloger cataloged items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC1Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC1Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "simple.parquet" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com          |
      | AmazonS3               |
      | asgqaparquetautomation |
      | ParquetTestData        |
      | TestParquet            |
      | simple.parquet         |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#15:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  Scenario: SC#16-Configure & run the ParquetS3Cataloger for SC2
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                         | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc2ParquetS3ConfigFileInclude.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                              | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                              | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                             | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                              | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |


  #6938868
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3 @MLPQA-18061 @MLPQA-18064
  Scenario: SC#16- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include)/Directory/File(include)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC2Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC2Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaparquetautomation |
      | ParquetTestData        |
      | TestParquet            |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | NonParquet  |
      | Incremental |
    And user enters the search text "testtagSC2Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC2Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | simple.parquet |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
      | incremental.parquet       |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                 | fileName       | userTag           |
      | Default     | File | Metadata Type | testtagSC2Parquet,Parquet,Amazon S3 | simple.parquet | testtagSC2Parquet |
    #And user clicks on logout button


  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#17- Verify ParquetS3Cataloger collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC2Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC2Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/ParquetS3Cataloger/ParquetS3Cataloger%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | amazonaws.com |
      | AmazonS3      |
    Then Analysis log "cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:ParquetS3Cataloger, Plugin Type:cataloger, Plugin Version:LATEST, Node Name:LocalNode, Host Name:c73092d5f4be, Plugin Configuration name:ParquetS3Cataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0071 | ParquetS3Cataloger | Plugin Version |
      | INFO | Plugin ParquetS3Cataloger Configuration: ---  2021-02-07 18:10:59.353 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: name: "ParquetS3Cataloger"  2021-02-07 18:10:59.353 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: pluginVersion: "LATEST"  2021-02-07 18:10:59.353 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: label:  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: : ""  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: auditFields:  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: createdBy: "TestSystem"  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: createdAt: "2021-02-07T18:09:55.741689"  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: modifiedBy: "TestSystem"  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: modifiedAt: "2021-02-07T18:09:55.741689"  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: catalogName: "Default"  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: eventClass: null  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: eventCondition: null  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: nodeCondition: null  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: maxWorkSize: 1000  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: tags:  2021-02-07 18:10:59.354 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: - "testtagSC2Parquet"  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: pluginType: "cataloger"  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: dataSource: "AmazonParquetS3ValidDataSource"  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: credential: "ValidParquetCredentials"  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: businessApplicationName: null  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: schedule: null  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: filter: null  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: dryRun: false  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: versionMode: false  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: maxObjectsAmount: 1000  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: pluginName: "ParquetS3Cataloger"  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: incremental: false  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: type: "Cataloger"  2021-02-07 18:10:59.355 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: bucketFilter:  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: mode: "INCLUDE"  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: patterns:  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: - "asgqaparquetautomation"  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: objectFilter:  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: dirFilter:  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: mode: "INCLUDE"  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: patterns: []  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: fileFilter:  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: mode: "INCLUDE"  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: patterns:  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: - "simple.parquet"  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: dirPrefixes:  2021-02-07 18:10:59.356 INFO  - ANALYSIS-0073: Plugin ParquetS3Cataloger Configuration: - "/ParquetTestData" | ANALYSIS-0073 | ParquetS3Cataloger |                |
      | INFO | Plugin ParquetS3Cataloger Start Time:2020-03-19 23:07:12.773, End Time:2020-03-19 23:07:17.401, Processed Count:2, Errors:0, Warnings:3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0072 | ParquetS3Cataloger |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.628)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0020 |                    |                |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#18:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  Scenario: SC#19-Configure & run the ParquetS3Cataloger for SC25
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                         | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc25ParquetS3ConfigDryRunTrue.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                              | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                              | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                             | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                              | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936990
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#19- Verify ParquetS3Cataloger doesn't collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC25Parquet" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Directory |
      | File      |
      | Field     |
      | Cluster   |
    And user enters the search text "testtagSC25Parquet" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 1             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%" should display below info/error/warning
      | type | logValue                                          | logCode       | pluginName         | removableText |
      | INFO | Plugin ParquetS3Cataloger running on dry run mode | ANALYSIS-0069 | ParquetS3Cataloger |               |
   # And user clicks on logout button

  @sanity @positive
  Scenario:SC#19:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis |       |       |

  Scenario: SC#20-Configure & run the ParquetS3Cataloger for SC3
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                         | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc3ParquetS3ConfigFileExclude.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                              | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                              | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                             | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                              | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |


  #6936991
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#20- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include)/Directory/File(exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC3Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC3Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ParquetTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | asgqaparquetautomation |
      | ParquetTestData |
      | TestParquet     |
      | NonParquet      |
      | version         |
      | Incremental     |
    And user enters the search text "testtagSC3Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC3Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
      | incremental.parquet       |
    Then user "verify non presence" of following "Items List" in Search Results Page
      | simple.parquet |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#20:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |


  Scenario: SC#21-Configure & run the ParquetS3Cataloger for SC21
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                       | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc5ParquetS3ConfigDirectory.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                            | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                           | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |


  #6936973 #6936979
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#21- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include)/Directory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC5Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC5Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ParquetTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | asgqaparquetautomation |
      | ParquetTestData |
      | TestParquet     |
      | NonParquet      |
      | version         |
      | Incremental     |
    And user enters the search text "testtagSC5Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC5Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
      | incremental.parquet       |
      | simple.parquet            |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#21:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

    # 6619971
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC22#Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with  region and Bucketname (Include)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                  | body                                                                            | response code | response message   | jsonPath                                                |
      |        |       |       | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc32ParquetS3ConfigBucketInclude.json | 204           |                    |                                                         |
      |        |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                 | 200           | ParquetS3Cataloger |                                                         |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                | 200           |                    |                                                         |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC32_S3_ParquetS3" and clicks on search
    And user performs "facet selection" in "testtagSC32_S3_ParquetS3" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
      | Field     |
    And user enters the search text "testtagSC32_S3_ParquetS3" and clicks on search
    And user performs "facet selection" in "testtagSC32_S3_ParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ParquetTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | asgqaparquetautomation |
      | ParquetTestData |
      | NonParquet      |
      | TestParquet     |
      | version         |
      | Incremental     |
    And user enters the search text "testtagSC32_S3_ParquetS3" and clicks on search
    And user performs "facet selection" in "testtagSC32_S3_ParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | simple.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
      | incremental.parquet       |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#22:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

#  Scenario: SC#23-Configure & run the ParquetS3Cataloger for SC6
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                           | response code | response message   | jsonPath                                                |
#      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc6ParquetS3ConfigBucketExclude.json | 204           |                    |                                                         |
#      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                | 200           | ParquetS3Cataloger |                                                         |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                               | 200           |                    |                                                         |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
#
#    #6936972
#  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
#  Scenario: SC#23- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Exclude)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "testtagSC6Parquet" and clicks on search
#    And user performs "facet selection" in "testtagSC6Parquet" attribute under "Tags" facets in Item Search results page
#    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
#      | facetType | count |
#      | Service   | 1     |
#      | Cluster   | 1     |
#      | Analysis  | 1     |
#      | Directory | 6     |
#      | File      | 14    |
#      | Field     | 88    |
#    Then user "verify displayed" for listed "Metadata Type" facet in Search results page
#      | ItemType  |
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#      | Field     |
#    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
#    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | asgqaparquetautomation |
#      | ParquetTestData        |
#      | NonParquet             |
#      | TestParquet            |
#      | version                |
#      | Incremental            |
#    And user enters the search text "testtagSC6Parquet" and clicks on search
#    And user performs "facet selection" in "testtagSC6Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | baseversion.parquet       |
#      | HiveParquet.parquet       |
#      | Spark.parquet             |
#      | nation.parquet            |
#      | region.parquet            |
#      | simple.parquet            |
#      | testcomplex.parquet       |
#      | userDiffDataTypes.parquet |
#      | userdata1.parquet         |
#      | weather.parquet           |
#      | employee.parquet          |
#      | userdetails.parquet       |
#      | source.parquet            |
#      | incremental.parquet       |
#    And user enters the search text "testtagSC6Parquet" and clicks on search
#    And user performs "facet selection" in "testtagSC6Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
#    Then user "verify non presence" of following "Items List" in Search Results Page
#      | asgqa2parquetautomation |
#      | uploadtestautomation    |
#      | asgcoms3primarybucket   |
#      | asg-training-template   |
#    #And user clicks on logout button
#
#  @sanity @positive
#  Scenario:SC#23:Delete id's
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                              | type      | query | param |
#      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
#      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |
#      | MultipleIDDelete | Default | asgqacsv%                                         | Directory |       |       |

  Scenario: SC#24-Configure & run the ParquetS3Cataloger for SC24
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                           | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc7ParquetS3ConfigSubDirInclude.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                               | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936974 #6936980
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#24- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Directory(include)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC7Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC7Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaparquetautomation |
      | ParquetTestData        |
      | TestParquet            |
      | version                |
    Then user "verify non presence" of following "Items List" in Search Results Page
      | NonParquet  |
      | Incremental |
    And user enters the search text "testtagSC7Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC7Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | source.parquet            |
      | simple.parquet            |
    Then user "verify non presence" of following "Items List" in Search Results Page
      | employee.parquet    |
      | userdetails.parquet |
      | incremental.parquet |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#24:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  Scenario: SC#25-Configure & run the ParquetS3Cataloger for SC25
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                              | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc8ParquetS3ConfigFileIncludeRegex.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                   | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                   | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                  | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                   | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936981
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#25- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Directory(include)/File(include with Regex *)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC8Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC8Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaparquetautomation |
      | ParquetTestData        |
      | TestParquet            |
    And user enters the search text "testtagSC8Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC8Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | simple.parquet |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#25:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  Scenario: SC#26-Configure & run the ParquetS3Cataloger for SC9
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                           | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc9ParquetS3ConfigSubDirExclude.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                               | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936975 #6936994
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#26- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Directory(exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC9Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC9Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaparquetautomation |
      | ParquetTestData        |
      | NonParquet             |
      | Incremental            |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | TestParquet |
      | version     |
    And user enters the search text "testtagSC9Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC9Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | employee.parquet    |
      | userdetails.parquet |
      | incremental.parquet |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | source.parquet            |
      | baseversion.parquet       |
      | simple.parquet            |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#26:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  Scenario: SC#27-Configure & run the ParquetS3Cataloger for SC27
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                                       | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc10ParquetS3ConfigSubDirIncludeFileInclude.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                            | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                           | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936976
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#27- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Directory(Include)/File(Include)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC10Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC10Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaparquetautomation |
      | ParquetTestData        |
      | TestParquet            |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | NonParquet  |
      | version     |
      | Incremental |
    And user enters the search text "testtagSC10Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC10Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
      | simple.parquet            |
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | region.parquet |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#27:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  Scenario: SC#28-Configure & run the ParquetS3Cataloger for SC28
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                                       | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc11ParquetS3ConfigSubDirIncludeFileExclude.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                            | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                           | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936977
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#28- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Directory(Include)/File(Exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC11Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC11Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaparquetautomation |
      | ParquetTestData        |
      | NonParquet             |
    And user enters the search text "testtagSC11Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC11Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | userdetails.parquet       |
      | simple.parquet            |
      | source.parquet            |
      | incremental.parquet       |
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | employee.parquet |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#28:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |


  Scenario: SC#29-Configure & run the ParquetS3Cataloger for SC12
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                                 | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc12ParquetS3ConfigBucketIncludeRegex.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                      | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                      | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                     | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                      | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

    #6936978
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#29- Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when ParquetS3Cataloger is run with region and Bucketname(Include with *)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC12Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC12Parquet" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
      | Field     |
    And user enters the search text "testtagSC12Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC12Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ParquetTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | asgqaparquetautomation |
      | ParquetTestData |
      | NonParquet      |
      | TestParquet     |
      | version         |
      | Incremental     |
    And user enters the search text "testtagSC12Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC12Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | simple.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#29:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  Scenario: SC#30-Configure & run the ParquetS3Cataloger for SC30
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                                     | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc14ParquetS3ConfigInvalidBucketDirectory.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                          | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                         | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#30- Verify ParquetS3Cataloger does not collect any Directory/File items when Invalid bucket is provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC14Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC14Parquet" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Directory |
      | File      |
      | Field     |
      | Cluster   |
    And user enters the search text "testtagSC14Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC14Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 1             | Description |
      | Number of errors          | 0             | Description |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%" should display below info/error/warning
      | type | logValue                                                                                                                                | logCode       | pluginName         | removableText |
      | INFO | Plugin ParquetS3Cataloger Start Time:2020-03-22 21:53:58.951, End Time:2020-03-22 21:54:00.089, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | ParquetS3Cataloger |               |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#30:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis |       |       |

  @aws
  Scenario:SC#30:Delete the asgqaparquetautomation bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "ParquetTestData" in bucket "asgqaparquetautomation"
    And sync the test execution for "20" seconds
    Then user "Delete" a bucket "asgqaparquetautomation" in amazon storage service

  Scenario: SC#31-Configure & run the ParquetS3Cataloger for SC16
    Given user "Create" a bucket "asgqaparquetautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix               | dirPath                                       | recursive |
      | asgqaparquetautomation | ParquetData/TestParquet | ida/S3ParquetPayloads/ParquetData/TestParquet | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                               | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc16ParquetS3ConfigIncrementalFalse.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                    | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                    | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                   | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                    | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936982
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#31- Verify incremental scan with settings:false works properly with ParquetS3Cataloger
    Given user gets amazon bucket "asgqaparquetautomation" file count in "ParquetData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC16Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC16Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "Search Results" should be displayed as "tempStoredValue" in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | incremental.parquet |

  Scenario: SC#31-Configure & run the ParquetS3Cataloger
    Given user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix               | dirPath                                    | recursive |
      | asgqaparquetautomation | ParquetData/Incremental | ida/S3ParquetPayloads/TestData/Incremental | false     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                              | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc16ParquetS3ConfigIncrementalTrue.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                   | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                   | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                  | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                   | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |


  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#31- Verify incremental scan with settings:true works properly with ParquetS3Cataloger
    Given user gets amazon bucket "asgqaparquetautomation" file count in "ParquetData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC16Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC16Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And results panel "Search Results" should be displayed as "tempStoredValue" in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | incremental.parquet |
   # And user clicks on logout button

  @sanity @positive
  Scenario:SC#31:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  @aws
  Scenario: SC#31-Delete the asgqaparquetautomation bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "ParquetData" in bucket "asgqaparquetautomation"
    And sync the test execution for "20" seconds
    Then user "Delete" a bucket "asgqaparquetautomation" in amazon storage service

  Scenario: SC#32-Configure & run the ParquetS3Cataloger for SC32
    Given user "Create" a bucket "asgqaparquetautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix       | dirPath                         | recursive |
      | asgqaparquetautomation | ParquetTestData | ida/S3ParquetPayloads/TestData/ | true      |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName             | status  |
      | asgqaparquetautomation | Enabled |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix                                               | dirPath                                                                |
      | asgqaparquetautomation | ParquetTestData/TestParquet/version/baseversion.parquet | ida/S3ParquetPayloads/TestData/TestParquet/version/baseversion.parquet |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                      | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc20ParquetS3ConfigVersion.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                           | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                           | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                          | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                           | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936983
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#32- Verify file versions are collected correctly when scan mode is set as versions in ParquetS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC20Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC20Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet |
    And user get objects list from "ParquetTestData/TestParquet/version/" in bucket "asgqaparquetautomation" with maximum count of "50"
    Then results panel "Search Results" should be displayed as "tempStoredValue" in Item Search results page
    #And user clicks on logout button

  Scenario: SC#33-Configure & run the ParquetS3Cataloger for SC33
    Given user performs "single upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix                                               | dirPath                                                                |
      | asgqaparquetautomation | ParquetTestData/TestParquet/version/baseversion.parquet | ida/S3ParquetPayloads/TestData/TestParquet/version/baseversion.parquet |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                          | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc22ParquetS3ConfigVersionIncr.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                               | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                               | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                              | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                               | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936992
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#34- Verify file versions are collected correctly when scan mode is set as versions in ParquetS3Cataloger and Incremental collection is ON
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC20Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC20Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet |
    And user get objects list from "ParquetTestData/TestParquet/version/" in bucket "asgqaparquetautomation" with maximum count of "50"
    Then results panel "Search Results" should be displayed as "tempStoredValue" in Item Search results page

  @sanity @positive
  Scenario:SC#34:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |


  @aws
  Scenario:SC34#Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "ParquetTestData" in bucket "asgqaparquetautomation"
    And sync the test execution for "20" seconds
    Then user "Delete" a bucket "asgqaparquetautomation" in amazon storage service

  #6938866
  @MLP-17683 @webtest @positive @regression @sanity @IDA-10.3 @pluginManager
  Scenario: SC#35- Verify proper error message is shown if mandatory fields are not filled in ParquetS3Cataloger configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Cataloger          |
      | Plugin    | ParquetS3Cataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @MLP-17683 @webtest @positive @regression @sanity @IDA-10.3 @pluginManager
  Scenario: SC#36- Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in Parquet S3 Datasource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute           |
      | Data Source Type | ParquetS3DataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @MLP-17683 @webtest @positive @regression @sanity @IDA-10.3 @pluginManager
  Scenario: SC#37-Verify captions and tool tip text in ParquetS3DataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute           |
      | Data Source Type | ParquetS3DataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |


  @MLP-17683 @webtest @positive @regression @sanity @IDA-10.3 @pluginManager
  Scenario: SC#38-Verify captions and tool tip text in ParquetS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Cataloger          |
      | Plugin    | ParquetS3Cataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Business Application       |
      | Bucket filter              |
      | Bucket names               |
      | S3 Objects filter          |
      | Directory prefixes to scan |
      | Sub Directory filter       |
      | File filter                |
      | Data Source*               |
      | Credential*                |

  @aws
  Scenario: SC#39-Create a bucket and folder with parquet files in S3 Amazon storage
    Given user "Create" a bucket "asgqaparquetautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix       | dirPath                         | recursive |
      | asgqaparquetautomation | ParquetTestData | ida/s3ParquetPayloads/TestData/ | true      |


  Scenario Outline: SC#39- Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                           | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/s3ParquetPayloads/DataSource/AmazonS3DataSourceConfig.json                 | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                                                | 200           | AmazonS3DataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc32AmazonS3ConfigBucketInclude.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                                | 200           | AmazonS3Cataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                               | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                                | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Cataloger')].status |

  Scenario Outline: SC#39_Delete cataloger config for Parquet S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3Cataloger |      | 200           |                  |          |

  Scenario Outline: SC#39- Run the Plugin configurations for DataSource and ParquetS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                  | body                                                                              | response code | response message    | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3DataSource                               | ida/s3ParquetPayloads/DataSource/ParquetS3DataSourceConfig.json                   | 204           |                     |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3DataSource                               |                                                                                   | 200           | ParquetS3DataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc32_1ParquetS3ConfigBucketInclude.json | 204           |                     |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                   | 200           | ParquetS3Cataloger  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                   | 200           | IDLE                | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                  | 200           |                     |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                   | 200           | IDLE                | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  Scenario Outline: SC#39-user retrieves the item ids of different items of SC32 and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                | type | targetFile                             | jsonpath            |
      | APPDBPOSTGRES | Default | asgqaparquetautomation                              |      | response/parquetS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger%DYN |      | response/parquetS3/actual/itemIds.json | $..has_Analysis.id  |
      | APPDBPOSTGRES | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog%DYN     |      | response/parquetS3/actual/itemIds.json | $..has_Analysis.id  |


  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-18061 @MLPQA-18064
  Scenario: MLP-17683:SC39#Verify ParquetS3Cataloger runs above the cataloged items from S3 Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC32_S3_ParquetS3" and clicks on search
    And user performs "facet selection" in "testtagSC32_S3_ParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Parquet,testtagSC32_S3_ParquetS3,ParquetS3BusinessApplication" should get displayed for the column "cataloger/ParquetS3Cataloger"
    And user enters the search text "testtagSC32_S3_AmazonS3" and clicks on search
    And user performs "facet selection" in "testtagSC32_S3_AmazonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Amazon S3,testtagSC32_S3_AmazonS3" should get displayed for the column "cataloger/AmazonS3Cataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                                                                             | fileName        | userTag                  |
      | Default     | Field     | Metadata Type | Amazon S3,Parquet,testtagSC32_S3_ParquetS3,ParquetS3BusinessApplication                         | InCity          | testtagSC32_S3_ParquetS3 |
      | Default     | File      | Metadata Type | Amazon S3,testtagSC32_S3_AmazonS3                                                               | userInfo.json   | testtagSC32_S3_AmazonS3  |
      | Default     | Directory | Metadata Type | Amazon S3,testtagSC32_S3_AmazonS3,Parquet,testtagSC32_S3_ParquetS3,ParquetS3BusinessApplication | ParquetTestData | testtagSC32_S3_ParquetS3 |
      | Default     | Cluster   | Metadata Type | Amazon S3,testtagSC32_S3_AmazonS3,Parquet,testtagSC32_S3_ParquetS3,ParquetS3BusinessApplication | amazonaws.com   | testtagSC32_S3_ParquetS3 |
      | Default     | Service   | Metadata Type | Amazon S3,testtagSC32_S3_AmazonS3,Parquet,testtagSC32_S3_ParquetS3,ParquetS3BusinessApplication | AmazonS3        | testtagSC32_S3_ParquetS3 |


  @sanity @positive @MLP-17683 @webtest @IDA-10.3 @MLPQA-18061 @MLPQA-18064
  Scenario: SC#40-Verify the technology tags/explicit tags/business application got assigned to all S3 and Parquet S3 catalogued items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                                                                             | fileName               | userTag                  |
      | Default     | Directory | Metadata Type | ParquetS3BusinessApplication,testtagSC32_S3_ParquetS3,Amazon S3,Parquet,testtagSC32_S3_AmazonS3 | asgqaparquetautomation | testtagSC32_S3_ParquetS3 |
      | Default     | Cluster   | Metadata Type | ParquetS3BusinessApplication,testtagSC32_S3_ParquetS3,Amazon S3,Parquet,testtagSC32_S3_AmazonS3 | amazonaws.com          | testtagSC32_S3_ParquetS3 |
      | Default     | Field     | Metadata Type | ParquetS3BusinessApplication,testtagSC32_S3_ParquetS3,Parquet,Amazon S3                         | InCity                 | testtagSC32_S3_ParquetS3 |
      | Default     | File      | Metadata Type | ParquetS3BusinessApplication,testtagSC32_S3_ParquetS3,Amazon S3,Parquet,testtagSC32_S3_AmazonS3 | simple.parquet         | testtagSC32_S3_ParquetS3 |
      | Default     | File      | Metadata Type | Amazon S3,testtagSC32_S3_AmazonS3                                                               | userInfo.json          | testtagSC32_S3_AmazonS3  |
      | Default     | Service   | Metadata Type | ParquetS3BusinessApplication,testtagSC32_S3_ParquetS3,Amazon S3,Parquet,testtagSC32_S3_AmazonS3 | AmazonS3               | testtagSC32_S3_ParquetS3 |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#40:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger/%   | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |


  @cr-data @sanity @positive
  Scenario: SC#42-Configure the Parquet S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                    | body                                                                       | response code | response message               | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/ParquetS3DataSource | ida/s3ParquetPayloads/DataSource/AmazonParquetS3ValidDataSourceConfig.json | 204           |                                |          |
      |                  |       |       | Get  | settings/analyzers/ParquetS3DataSource |                                                                            | 200           | AmazonParquetS3ValidDataSource |          |


  Scenario: SC#42-Configure & run the ParquetS3Cataloger for SC42
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                                          | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc42ParquetS3ConfigValidBucketInvalidDirectory.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                               | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                               | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                              | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                               | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#42- Verify ParquetS3Cataloger does not collect any Directory/File items when valid bucket/Invalid Directory is provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text " testtagSC42Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC42Parquet" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Directory |
      | File      |
      | Field     |
      | Cluster   |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 1             | Description |
      | Number of errors          | 0             | Description |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%" should display below info/error/warning
      | type | logValue                                                                                                                                | logCode       | pluginName         | removableText |
      | INFO | Plugin ParquetS3Cataloger Start Time:2021-02-05 21:49:46.263, End Time:2021-02-05 21:49:47.479, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | ParquetS3Cataloger |               |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#42:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis |       |       |

  @cr-data @sanity @positive
  Scenario Outline:SC#42:Delete ParquetS3Cataloger config.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3Cataloger |      | 204           |                  |          |


  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC43#MLP_14320_Verify the ParquetS3Cataloger does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration and log shown processed count:0
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                                                                                     | response code | response message                 | jsonPath                                                              |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3DataSource                                  | ida/s3ParquetPayloads/DataSource/AmazonParquetS3InValidDataSourceConfig.json                             | 204           |                                  |                                                                       |
      |                  |       |       | Get          | settings/analyzers/ParquetS3DataSource                                  |                                                                                                          | 200           | AmazonParquetS3InValidDataSource |                                                                       |
      |                  |       |       | Put          | settings/analyzers/ParquetS3Cataloger                                   | ida/s3ParquetPayloads/PluginConfiguration/sc43ParquetS3InvalidDataSourceAndInvalidCredentialsConfig.json | 204           |                                  |                                                                       |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                   |                                                                                                          | 200           | ParquetS3Cataloger               |                                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/ParquetS3DataSource/* |                                                                                                          | 200           | IDLE                             | $.[?(@.configurationName=='AmazonParquetS3InValidDataSource')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/ParquetS3DataSource/*  | ida/amazonGluePayloads/empty.json                                                                        | 200           |                                  |                                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/ParquetS3DataSource/* |                                                                                                          | 200           | IDLE                             | $.[?(@.configurationName=='AmazonParquetS3InValidDataSource')].status |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/*    |                                                                                                          | 200           | IDLE                             | $.[?(@.configurationName=='ParquetS3Cataloger')].status               |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*     | ida/amazonGluePayloads/empty.json                                                                        | 200           |                                  |                                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/*    |                                                                                                          | 200           | IDLE                             | $.[?(@.configurationName=='ParquetS3Cataloger')].status               |
    And user enters the search text "testtagSC43Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC43Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 1             | Description |
      | Number of errors          | 2             | Description |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%" should display below info/error/warning
      | type | logValue                                                                                                                                | logCode       | pluginName         | removableText |
      | INFO | Plugin ParquetS3Cataloger Start Time:2020-03-05 18:44:12.750, End Time:2020-03-05 18:44:18.209, Processed Count:0, Errors:2, Warnings:0 | ANALYSIS-0072 | ParquetS3Cataloger |               |
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#43:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis |       |       |

  @cr-data @sanity @positive
  Scenario Outline:SC#43:Delete ParquetS3Cataloger config.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3Cataloger |      | 204           |                  |          |

#  @edibus @positive
#  Scenario: SC#-Clearing of Subject Area in Rochade
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

  @cr-data @sanity @positive
  Scenario: SC#44-Configure the Parquet S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                    | body                                                                                    | response code | response message                  | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/ParquetS3DataSource | ida/s3ParquetPayloads/DataSource/AmazonParquetS3ValidDataSourceConfigNodeCondition.json | 204           |                                   |          |
      |                  |       |       | Get  | settings/analyzers/ParquetS3DataSource |                                                                                         | 200           | AmazonParquetS3DataSourceInternal |          |


#6936987
  @cr-data @sanity @positive
  Scenario: SC#44-Configure & run the ParquetS3Cataloger in InternalNode
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                                                                        | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                   | ida/s3ParquetPayloads/PluginConfiguration/sc1ParquetS3ConfigBucketIncludeNodeCondition.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                   |                                                                                             | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/ParquetS3Cataloger/* |                                                                                             | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                            | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/ParquetS3Cataloger/* |                                                                                             | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |


  # 6619971
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: SC#44-Verify ParquetS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when parquetS3Cataloger is run with  region and Bucketname (Include) under Internal Node.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagInternalParquet" and clicks on search
    And user performs "facet selection" in "testtagInternalParquet" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
      | Field     |
    And user enters the search text "testtagInternalParquet" and clicks on search
    And user performs "facet selection" in "testtagInternalParquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ParquetTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | version         |
#      | asgqaparquetautomation |
      | ParquetTestData |
      | NonParquet      |
      | TestParquet     |
      | Incremental     |
    And user enters the search text "testtagInternalParquet" and clicks on search
    And user performs "facet selection" in "testtagInternalParquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.parquet       |
      | HiveParquet.parquet       |
      | Spark.parquet             |
      | nation.parquet            |
      | region.parquet            |
      | simple.parquet            |
      | testcomplex.parquet       |
      | userDiffDataTypes.parquet |
      | userdata1.parquet         |
      | weather.parquet           |
      | employee.parquet          |
      | userdetails.parquet       |
      | source.parquet            |
      | incremental.parquet       |

  @aws
  Scenario:SC#44:Delete the asgqaparquetautomation bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "ParquetTestData" in bucket "asgqaparquetautomation"
    And sync the test execution for "20" seconds
    Then user "Delete" a bucket "asgqaparquetautomation" in amazon storage service

  @sanity @positive
  Scenario:SC#44:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory |       |       |

  @cr-data @sanity @positive
  Scenario Outline:SC#44:Delete ParquetS3Cataloger config.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3Cataloger |      | 204           |                  |          |

    ####################################### Incremental scenario - Cataloged at verification ###############################

  @cr-data @sanity @positive
  Scenario: SC#45:Configure the Parquet S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                    | body                                                                       | response code | response message               | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/ParquetS3DataSource | ida/s3ParquetPayloads/DataSource/AmazonParquetS3ValidDataSourceConfig.json | 204           |                                |          |
      |                  |       |       | Get  | settings/analyzers/ParquetS3DataSource |                                                                            | 200           | AmazonParquetS3ValidDataSource |          |


  Scenario: SC#45-Configure & run the ParquetS3Cataloger for SC16
    Given user "Create" a bucket "asgqaparquetautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix               | dirPath                                       | recursive |
      | asgqaparquetautomation | ParquetData/TestParquet | ida/S3ParquetPayloads/ParquetData/TestParquet | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                               | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                | ida/s3ParquetPayloads/PluginConfiguration/sc16ParquetS3ConfigIncrementalFalse.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                                    | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                    | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  | ida/s3ParquetPayloads/empty.json                                                   | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                                    | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  #6936982
  @MLP-17683 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: SC#45- Verify incremental scan with settings:false works properly with ParquetS3Cataloger
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "testtagSC16Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC16Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 11    |
    And user performs "item click" on "simple.parquet" item from search results
    And user "store" the value of item "simple.parquet" of attribute "Last catalogued at" with temporary text
    And user "store as Static" the value of item "simple.parquet" of attribute "Last catalogued at" with temporary text
    Given user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix               | dirPath                                    | recursive |
      | asgqaparquetautomation | ParquetData/Incremental | ida/S3ParquetPayloads/TestData/Incremental | false     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                                              | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                 | ida/s3ParquetPayloads/PluginConfiguration/sc16ParquetS3ConfigIncrementalTrue.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                                 |                                                                                   | 200           | ParquetS3Cataloger |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger |                                                                                   | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  | ida/s3ParquetPayloads/empty.json                                                  | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger |                                                                                   | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
    And user enters the search text "testtagSC16Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC16Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 12    |
    And user performs "item click" on "simple.parquet" item from search results
    Then user "verify equals" the value of item "simple.parquet" of attribute "Last catalogued at" with temporary text
    And user enters the search text "testtagSC16Parquet" and clicks on search
    And user performs "facet selection" in "testtagSC16Parquet" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "incremental.parquet" item from search results
    Then user "verify not equals" the value of item "incremental.parquet" of attribute "Last catalogued at" with temporary text
    #And user clicks on logout button

  @sanity @positive
  Scenario:SC#45:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type                | query | param |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/% | Analysis            |       |       |
      | MultipleIDDelete | Default | asgqaparquetautomation                            | Directory           |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                     | Cluster             |       |       |
      | MultipleIDDelete | Default | AmazonS3                                          | Service             |       |       |
      | SingleItemDelete | Default | Test_BA_ParquetS3                                 | BusinessApplication |       |       |


  @aws
  Scenario: SC#45-Delete the asgqaparquetautomation bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "ParquetData" in bucket "asgqaparquetautomation"
    And sync the test execution for "20" seconds
    Then user "Delete" a bucket "asgqaparquetautomation" in amazon storage service

  @MLP-14874 @webtest
  Scenario: SC#46 Verify whether the background of the panel is displayed in red when test connection is not successful for ParquetS3DataSource in LocalNode for disabled/unsupported region
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute           |
      | Data Source Type | ParquetS3DataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                |
      | Name*     | ParquetS3DataSourceTest3 |
      | Label     | ParquetS3DataSourceTest3 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                        |
      | Region*     | China (Ningxia) [cn-northwest-1] |
      | Credential* | ValidParquetCredentials          |
      | Node        | LocalNode                        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                       |
      | Region*   | Africa (Cape Town) [af-south-1] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                                   |
      | Region*   | Asia Pacific (Osaka-Local) [ap-northeast-3] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Cannot create enum from ap-northeast-3 value!" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  @cr-data @sanity @positive
  Scenario Outline: Delete Credentials, Datasource and cataloger config for Parquet S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3Cataloger            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3DataSource           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidParquetCredentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/IncorrectParquetCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyParquetCredentials     |      | 200           |                  |          |


  @sanity @positive @regression
  Scenario Outline: Delete BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                | body                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | items/Default/root | ida/s3ParquetPayloads/ParquetS3BusinessApplication.json | 200           |                  |          |