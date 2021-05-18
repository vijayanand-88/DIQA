@MLP-7847
Feature:Support for Amazon S3 Cataloger provided by Softserv


  @aws @precondition
  Scenario: MLP-1960:SC1#Update the aws credential Json
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                           | accessKeyPath | secretKeyPath |
      | ida/amazonPayloads/credentials/awsCredentials.json | $..accessKey  | $..secretKey  |


  @aws @precondition
  Scenario Outline: SC1#-Set the Credentials for AWSS3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | body                                                        | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                               | ida\hbasePayloads\DataSource\license_DS.json                | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/AWS_S3Credentials         | ida/amazonPayloads/credentials/awsCredentials.json          | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/AWS_S3Invalid_Credentials | ida/amazonPayloads/credentials/awsInvalidCredentials.json   | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/AWS_S3EMPTY_Credentials   | ida/amazonPayloads/credentials/awsEmptyCredentials.json     | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonS3DataSource          | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonS3DataSource          |                                                             | 200           | AmazonS3DataSource |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials    | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json  | 200           |                    |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials    |                                                             | 200           |                    |          |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#01_Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute                         |
      | Data Source Type | AmazonS3DataSource                |
      | Region           | US East (N. Virginia) [us-east-1] |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute           |
      | Name*     | AmazonS3_DataSource |
      | Label     | AmazonS3_DataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute         |
      | Credential* | AWS_S3Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"

#  @webtest
  Scenario:SC1#Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                | dirPath                                 | recursive |
      | asgqas3testautomation | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC1#_create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/amazonPayloads/BussinessApplication.json | 200           |                  |          |


  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC1#_Verification of AmazonS3 plugin functionality for Bussiness Tag
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                      | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc1AmazonS3BusTag.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                           | 200           | AWSS3            |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                           | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json             | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                           | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  Scenario: ProcessedCount Verification for AmazonS3 cataloger with no filters
    Given Load the count of the type values to a Map
      | analysis                                    | type      | DBName | queryName | queryPage | actualcount |
      | cataloger/AmazonS3Cataloger/AmazonS3Catalog | Analysis  |        |           |           | 1           |
      | cataloger/AmazonS3Cataloger/AmazonS3Catalog | Cluster   |        |           |           | 1           |
      | cataloger/AmazonS3Cataloger/AmazonS3Catalog | Service   |        |           |           | 1           |
      | cataloger/AmazonS3Cataloger/AmazonS3Catalog | Directory |        |           |           | 6           |
      | cataloger/AmazonS3Cataloger/AmazonS3Catalog | File      |        |           |           | 10          |
    Given Verify the Processed Count with the API call
      | Action                    | type      | node      | configName      | analysisItemName                            |
      | ItemViewMap               | Analysis  |           |                 | cataloger/AmazonS3Cataloger/AmazonS3Catalog |
      | ItemViewMap               | Cluster   |           |                 |                                             |
      | ItemViewMap               | Service   |           |                 |                                             |
      | ItemViewMap               | Directory |           |                 |                                             |
      | ItemViewMap               | File      |           |                 |                                             |
      | VerifyCountInItemView     |           |           |                 |                                             |
      | VerifyCountInPluginConfig |           | LocalNode | AmazonS3Catalog |                                             |

  #QAC-6515138
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-18058
  Scenario:SC1#_Verify Bussiness tag appears correctly in S3Cataloger cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Amazon S3,S3Amazon_BA,AWSS3" should get displayed for the column "cataloger/AmazonS3Cataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                         | fileName      | userTag       |
      | Default     | Cluster   | Metadata Type | Amazon S3,S3Amazon_BA,AWSS3 | amazonaws.com | amazonaws.com |
      | Default     | Service   | Metadata Type | Amazon S3,S3Amazon_BA,AWSS3 | AmazonS3      | AmazonS3      |
      | Default     | Directory | Metadata Type | Amazon S3,S3Amazon_BA,AWSS3 | version       | version       |
      | Default     | File      | Metadata Type | Amazon S3,S3Amazon_BA,AWSS3 | userInfo.avro | userInfo.avro |
      | Default     | File      | Metadata Type | Amazon S3,S3Amazon_BA,AWSS3 | userInfo.avro | userInfo.avro |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag        | fileName      | userTag       |
      | Default     | Cluster | Metadata Type | Cloud Data | amazonaws.com | amazonaws.com |
      | Default     | Service | Metadata Type | Cloud Data | AmazonS3      | AmazonS3      |

  #6515134 #6515136
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12215
  Scenario: MLP-7847:SC1#Verify file and directory count appears correctly in S3Cataloger cataloged items
    Given user gets amazon bucket "asgqas3testautomation" file count in "AutoTestData/TestFolder1" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Directory | 6     |
      | File      | 10    |


  @regression @sanity @IDA-10.0
  Scenario: MLP-7847:SC1# Log validations for S3Amazon plugin
    Then Analysis log "cataloger/AmazonS3Cataloger/AmazonS3Catalog/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:AmazonS3Cataloger, Plugin Type:cataloger, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:c6cd8da304b3, Plugin Configuration name:AmazonS3Catalog                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0071 | AmazonS3Cataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: ---  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: name: "AmazonS3Catalog"  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: pluginVersion: "LATEST"  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: label:  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: : ""  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: auditFields:  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: createdBy: "TestSystem"  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: createdAt: "2021-02-06T17:49:09.346207"  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: modifiedBy: "TestSystem"  2021-02-06 17:49:34.170 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: modifiedAt: "2021-02-06T17:49:09.346207"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: catalogName: "Default"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: eventClass: null  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: eventCondition: null  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: nodeCondition: null  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: maxWorkSize: 1000  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: tags:  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: - "AWSS3"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: pluginType: "cataloger"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: dataSource: "AmazonS3DataSource"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: credential: "AWS_S3Credentials"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: businessApplicationName: "S3Amazon_BA"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: schedule: null  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: filter: null  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: dryRun: false  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: keepEmptyFolders: false  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: versionMode: false  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: maxObjectsAmount: 1000  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: pluginName: "AmazonS3Cataloger"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: incremental: false  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: type: "Cataloger"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: bucketFilter:  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: mode: "INCLUDE"  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: patterns:  2021-02-06 17:49:34.171 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: - "asgqas3testautomation"  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: objectFilter:  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: dirFilter:  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: mode: "INCLUDE"  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: patterns:  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: - "*/TestFolder1/*"  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: fileFilter:  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: mode: "INCLUDE"  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: patterns: []  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: dirPrefixes:  2021-02-06 17:49:34.172 INFO  - ANALYSIS-0073: Plugin AmazonS3Cataloger Configuration: - "/AutoTestData" | ANALYSIS-0073 | AmazonS3Cataloger |                |
      | INFO | Plugin AmazonS3Cataloger Start Time:2020-03-05 06:18:33.790, End Time:2020-03-05 06:18:42.908, Errors:0, Warnings:3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0072 | AmazonS3Cataloger |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:08.334)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0020 |                   |                |


   ##############################################SC1###############################################
  #6549303
#  @sanity @positive @webtest @edibus
#  Scenario:MLP-9043_Verify the Amazon S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "AWSS3" and clicks on search
#    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon S3" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/AmazonS3Config.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                               | body                                                 | response code | response message | jsonPath                                          |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                               | idc/EdiBusPayloads/datasource/EDIBusDS_Amazons3.json | 204           |                  |                                                   |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/AmazonS3Config.json               | 204           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAmazon |                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAmazon')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAmazon  |                                                      | 200           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAmazon |                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAmazon')].status |
#    And user enters the search text "EDIBusAmazon" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusAmazon%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "AWSS3" and clicks on search
#    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon S3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Storage/Amazon S3 |
#      | $..selections.['type_s'][*]                   | File                                          |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                  | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AWSS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "AWSS3" and clicks on search
#    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon S3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Storage/Amazon S3 |
#      | $..selections.['type_s'][*]                   | Directory                                     |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                  | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AWSS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user enters the search text "AWSS3" and clicks on search
#    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon S3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                               |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @*Amazon@ S3≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @*Amazon@ S3≫DEFAULT≫DWR_DAT_DIRECTORY≫@* ),AND,( TYPE = DWR_IDC )   |
#      | AP-DATA      | S3AWS       | 1.0                | (XNAME * *  ~/ @*Amazon@ S3≫DEFAULT≫DWR_DAT_FILE_SYSTEM≫@* ),AND,( TYPE = DWR_IDC ) |


#QAC-6515112
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12223
  Scenario: MLP-7847:SC1#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname(Include) and Directory(with /)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |

  #QAC-6515139
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12212
  Scenario: MLP-7847:SC1#Verify breadcrumb hierarchy appears correctly in S3Cataloger cataloged items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "avro.xlsx" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "avro.xlsx" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com         |
      | AmazonS3              |
      | asgqas3testautomation |
      | AutoTestData          |
      | TestFolder1           |
      | avro.xlsx             |

  #QAC-6515136
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12215
  Scenario: MLP-7847:SC1#Verify File level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "avro.xlsx" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "avro.xlsx" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                            | widgetName  |
      | File size         | 10.61 KB                                                 | Description |
      | Location          | asgqas3testautomation/AutoTestData/TestFolder1/avro.xlsx | Description |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | avro.xlsx                                  |
#      | attributeName  | Technical Data                             |
#      | actualFilePath | ida/amazonPayloads/actualFileTechData.json |
#    And user remove the json attribute from file for following parameters
#      | filePath                                     | attributeName |
#      | ida/amazonPayloads/actualFileTechData.json   | Last-Modified |
#      | ida/amazonPayloads/expectedFileTechData.json | Last-Modified |
#    Then file content in "ida/amazonPayloads/expectedFileTechData.json" should be same as the content in "ida/amazonPayloads/actualFileTechData.json"

  #QAC-6515134
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12216
  Scenario: MLP-7847:SC1#Verify Directory/sub directory level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TestFolder1" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TestFolder1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                                   | widgetName  |
      | Directory size            | 122275                                          | Statistics  |
      | Number of files           | 8                                               | Statistics  |
      | Size of files             | 122275                                          | Statistics  |
      | Location                  | asgqas3testautomation/AutoTestData/TestFolder1/ | Description |
      | Number of sub-directories | 2                                               | Statistics  |
      | Size of sub-directories   | 159414                                          | Statistics  |
    And user enters the search text "AutoTestData" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AutoTestData" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                       | widgetName  |
      | Directory size            | 0                                   | Statistics  |
      | Number of files           | 0                                   | Statistics  |
      | Size of files             | 0                                   | Statistics  |
      | Location                  | asgqas3testautomation/AutoTestData/ | Description |
      | Number of sub-directories | 1                                   | Statistics  |
      | Size of sub-directories   | 281689                              | Statistics  |

  #QAC-6515132
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12217
  Scenario: MLP-7847:SC1#Verify Bucket level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "asgqas3testautomation" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgqas3testautomation" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue          | widgetName  |
      | Directory size            | 0                      | Statistics  |
      | Number of files           | 0                      | Statistics  |
      | Size of files             | 0                      | Statistics  |
      | Location                  | asgqas3testautomation/ | Description |
      | Number of sub-directories | 1                      | Statistics  |
      | Size of sub-directories   | 0                      | Statistics  |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | asgqas3testautomation                      |
#      | attributeName  | Technical Data                             |
#      | actualFilePath | ida/amazonPayloads/actualBuckTechData.json |
#    Then file content in "ida/amazonPayloads/expectedBuckTechData.json" should be same as the content in "ida/amazonPayloads/actualBuckTechData.json"

  @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

  @aws
  Scenario:SC1#Delete the version bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service

    ############################################## SC2 ###############################################

  @MLP-7847
  Scenario:  MLP-7847:SC2#Create a bucket with empty sub directory in S3 Amazon storage
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "empty folder creation" in amazon storage service with below parameters
      | bucketName            | keyPrefix                  | dirPath                                  |
      | asgqas3testautomation | AutoTestData/EmptyFolder1/ | ida/amazonPayloads/TestData/EmptyFolder1 |
      | asgqas3testautomation | AutoTestData/EmptyFolder2/ | ida/amazonPayloads/TestData/EmptyFolder2 |


  Scenario Outline:MLP-7847:SC2#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc2AmazonS3ConfigEmptyFoldersOn.json     | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #QAC-6515130
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12218
  Scenario: MLP-7847:SC2#Verify S3Cataloger collects empty directories also when Keep empty folders is set to ON
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EmptyFolder" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | EmptyFolder1 |
      | EmptyFolder2 |

  @sanity @positive
  Scenario:SC#2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

    ##############################################SC3###############################################

  Scenario Outline:MLP-7847:SC3#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc3AmazonS3ConfigEmptyFoldersOFF.json    | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #QAC-6518158
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12155
  Scenario: MLP-7847:SC3#Verify S3Cataloger collects empty directories also when Keep empty folders is set to OFF
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EmptyFolder" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    Then user "verify non presence" of following "Empty Values" in Search Results Page
      | EmptyFolder1 | No data found |
      | EmptyFolder2 | No data found |


  @sanity @positive
  Scenario:SC#3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

  @aws
  Scenario:SC3#Delete the version bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service

    ##############################################SC4###############################################

  @webtest
  Scenario: MLP-7847:SC4#Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                | dirPath                                 | recursive |
      | asgqas3testautomation | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |


  Scenario Outline:MLP-7847:SC4#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc4AmazonS3ConfigBucketWildCard.json     | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  #QAC-6515109
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12224
  Scenario: MLP-7847:SC4#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname with wild card character(*)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |


  @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

    ##############################################SC5###############################################

  #QAC-6514990
  @MLP-7847  @aws @regression @sanity @IDA-10.0
  Scenario: MLP-7847:SC5#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include) and Directory(Include)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                    | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc5AmazonS3ConfigBucketWildCard.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                         | 200           | AWSS3            |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                         | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                         | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                         | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  #QAC-6514990
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12229
  Scenario:SC#5 Verify File count when S3Cataloger is run with region  and Bucketname(Include) and Directory(Include)
    Given user gets amazon bucket "asgqas3testautomation" file count in "AutoTestData/TestFolder1" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 10    |

  @sanity @positive
  Scenario:SC#5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

        ##############################################SC6###############################################


  Scenario Outline:MLP-7847:SC6#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc6AmazonS3ConfigFileExclude.json        | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #QAC-6514998
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12228
  Scenario: MLP-7847:SC6#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname(Include)/Directory/Sub Directory(Include)/File(Exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | File      |
      | Analysis  |
      | Directory |
      | Cluster   |
      | Service   |
    And user enters the search text "Capture.jpg" and clicks on search
    Then user "verify non presence" of following "Items List" in Search Results Page
      | Capture.jpg |


  @sanity @positive
  Scenario:SC#6:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |


          ##############################################SC7###############################################

  Scenario Outline:MLP-7847:SC7#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc7AmazonS3ConfigFileInludeRegex.json    | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  #QAC-6515106
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10. @MLPQA-12226
  Scenario: MLP-7847:SC7#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Include)/File(*)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "city.csv" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | city.csv |
    And user enters the search text "city" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | city |

  @sanity @positive
  Scenario:SC#7:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

        ##############################################SC8###############################################

  Scenario Outline:MLP-7847:SC8#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc8AmazonS3ConfigSubDirExclude.json      | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #6515089
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12227
  Scenario: MLP-7847:SC8#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | city |


  @sanity @positive
  Scenario:SC#8:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

          ##############################################SC9###############################################

  Scenario Outline:MLP-7847:SC9#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                          | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json   | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                               | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc9AmazonS3ConfigFileExcludeWithNoDir.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                               | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                               | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                                 | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                               | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #QAC-6518162
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12153
  Scenario: MLP-7847:SC9#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname(Include)/Directory/File(Exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | AWSS3Errors.txt |


  @sanity @positive
  Scenario:SC#9:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

          ##############################################SC10###############################################

  @MLP-7847  @aws @regression @sanity @IDA-10.0
  Scenario Outline:MLP-7847:SC10#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/s10AmazonS3ConfigBucketInclude.json      | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #QAC-6514983
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12231
  Scenario: MLP-7847:SC10#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname with Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "city" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | city |

  @sanity @positive
  Scenario:SC#10:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

  @aws
  Scenario:SC10#Delete the version bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service


         ##############################################SC11###############################################

  @aws
  Scenario: MLP-7847:SC11#User Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqas3testautomationexclude" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName                   | keyPrefix                | dirPath                                 | recursive |
      | asgqas3testautomationexclude | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |


  Scenario Outline:MLP-7847:SC11#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/s11AmazonS3ConfigBucketExclude.json      | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #QAC-6514984
  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12230
  Scenario: MLP-7847:SC11#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname with Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "asgqatestautomation [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | version |
    And user enters the search text "asgqas3testautomationexclude" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | asgqas3testautomationexclude |

  @sanity @positive
  Scenario:SC#11:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqatestautomation                           | Directory |       |       |

  @aws
  Scenario:  MLP-8708:SC11#Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomationexclude"
    Then user "Delete" a bucket "asgqas3testautomationexclude" in amazon storage service

            ##############################################SC12###############################################

  #QAC-6515140
  @webtest @MLP-7847 @positive @regression @pluginManager @MLPQA-12211
  Scenario: MLP-7847 SC12# Verify proper error message is shown if mandatory fields are not filled in S3Cataloger configuration page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute         |
      | Type      | Cataloger         |
      | Plugin    | AmazonS3Cataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


 ##############################################SC13###############################################

  @webtest
  Scenario: MLP-7847:SC13#User Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                | dirPath                                 | recursive |
      | asgqas3testautomation | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |

  Scenario Outline:MLP-7847:SC13#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/s14AmazonS3ConfigIncremental.json        | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12216
  Scenario: MLP-7847:SC13#User Create a bucket & folder with various file formats in S3 Amazon storage
    Given user gets amazon bucket "asgqas3testautomation" file count in "AutoTestData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 10    |
#    Then results panel "file count" should be displayed as "20 Results" in Item Search results page
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                | dirPath                      | recursive |
      | asgqas3testautomation | AutoTestData/Incremental | ida/amazonPayloads/TestData/ | false     |
    And user gets amazon bucket "asgqas3testautomation" file count in "AutoTestData" directory and store in temp variable
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body                                               | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                              | ida/amazonPayloads/s14AmazonS3TrueIncremental.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                              |                                                    | 200           | AWSS3            |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog |                                                    | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog  | ida/amazonPayloads/empty.json                      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog |                                                    | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 11    |
#    Then results panel "file count" should be displayed as "11 Results" in Item Search results page
    And user enters the search text "incremental.avro" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | incremental.avro |

  @sanity @positive
  Scenario:SC#13:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |


  @aws
  Scenario:  MLP-7847:SC14#Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service

 ##############################################SC15##############################################

  #QAC-6515127
  @MLP-8708 @aws @regression @sanity @IDA-10.0
  Scenario: MLP-7847-SC15# Verify file versions are collected correctly when scan mode is set as versions in S3Cataloger
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix    | dirPath                      | recursive |
      | asgqas3testautomation | AutoTestData | ida/amazonPayloads/TestData/ | true      |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName            | status  |
      | asgqas3testautomation | Enabled |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                                         | dirPath                                                          |
      | asgqas3testautomation | AutoTestData/TestFolder1/version/baseversion.xlsx | ida/amazonPayloads/TestData/TestFolder1/version/baseversion.xlsx |


  Scenario Outline:MLP-7847:SC15#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc16AmazonS3ConfigVersion.json           | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  #QAC-6515127
  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12219
  Scenario: MLP-7847-SC#15 Verify file versions are collected correctly when scan mode is set as versions in AmazonS3Cataloger
    Given user gets amazon bucket "asgqas3testautomation" file count in "AutoTestData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestFolder1/version/" in bucket "asgqas3testautomation" with maximum count of "50"
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 1     |
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.xlsx |
#    Then results panel "file count" should be displayed as "2 Results" in Item Search results page

  @sanity @positive
  Scenario:SC#15:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

  @aws
  Scenario: MLP-7847_SC15#Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service


    ##############################################SC16###############################################

  #QAC-6515123
  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-7847_SC16# Verify file versions are collected correctly when scan mode is set as versions in AmazonS3Cataloger and Incremental collection is ON
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix    | dirPath                      | recursive |
      | asgqas3testautomation | AutoTestData | ida/amazonPayloads/TestData/ | true      |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName            | status  |
      | asgqas3testautomation | Enabled |


  Scenario Outline:MLP-7847:SC16#Run the Plugin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc18AmazonS3ConfigVersionIncrOn.json     | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #6515123
  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12220
  Scenario: MLP-7847_SC16#Verify file versions are collected after run  when scan mode is set as versions in AmazonS3Cataloger and Incremental collection is ON
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestFolder1/version/" in bucket "asgqas3testautomation" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page


   ##############################################SC17###############################################

  #QAC-6518163
  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-12152
  Scenario: MLP-7847_SC17# Verify file versions are collected correctly when scan mode is set as versions in AmazonS3 Cataloger and Incremental collection is ON
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestFolder1/version/" in bucket "asgqas3testautomation" with maximum count of "50"
    Then results panel "file count" should be displayed as "Select all 1 items" in Item Search results page
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName            | status  |
      | asgqas3testautomation | Enabled |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                                         | dirPath                                                          |
      | asgqas3testautomation | AutoTestData/TestFolder1/version/baseversion.xlsx | ida/amazonPayloads/TestData/TestFolder1/version/baseversion.xlsx |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body | response code | response message | jsonPath                                             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog |      | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog  |      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog |      | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestFolder1/version/" in bucket "asgqas3testautomation" with maximum count of "50"
    Then results panel "file count" should be displayed as "1 Results" in Item Search results page


     ##############################################SC18###############################################
#  @amazonSpectrum @positve @regression @sanity @webtest
#  Scenario:SC#18_Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Google cloud
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem          |
#      | mouse hover | Settings Icon       |
#      | click       | Manage Data Sources |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute                         |
#      | Data Source Type | AmazonS3DataSource                |
#      | Plugin Version   | LATEST                            |
##      | Catalog Name     | Default                           |
#      | Region           | US East (N. Virginia) [us-east-1] |
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute            |
#      | Name      | AmazonS3_DataSource1 |
#      | Label     | AmazonS3_DataSource1 |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute         |
#      | Credential | AWS_S3Credentials |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute   |
#      | Deployment | GoogleCloud |
#    And user "click" on "Test Connection" button in "Add Data Sources Page"
#    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
#    And user "click" on "Save" button in "Add Data Sources Page"


  @sanity @positive
  Scenario:SC#18:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type      | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqas3testautomation                         | Directory |       |       |

  @aws
  Scenario:SC18#Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service


  ##############################################SC19###############################################

  #6515140
  @aws @positive @sanity @webtest @IDA_E2E @MLPQA-12211
  Scenario:SC19# Verify proper error message is shown if mandatory fields are not filled in Amazon S3 DataSource plugin configuration
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
      | fieldName | attribute          |
      | Type      | AmazonS3DataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  @MLP-14629 @webtest
  Scenario: SC19#-Verify captions and tool tip text in AmazonS3DataSource
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
      | fieldName        | attribute          |
      | Data Source Type | AmazonS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source Type* |
      | Name*             |
      | Label             |
      | Region*           |
      | Credential*       |
      | Node              |

    ##############################################SC20###############################################

  ##6836407##
  @webtest @MLPQA-2700
  Scenario: SC20#-Verify captions and tool tip text in AmazonS3Cataloger
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
      | fieldName | attribute         |
      | Type      | Cataloger         |
      | Plugin    | AmazonS3Cataloger |
    And user verifies the "Dynamic form" for "PluginConfiguration" in Add Manage Configuration Page
      | Name*                      |
      | Label                      |
      | Bucket names               |
      | Mode                       |
      | Directory prefixes to scan |
      | Data Source*               |
      | Credential*                |

  #QAC-7078250
  @aws @webtest @negative @MLPQA-17239
  Scenario:SC20_Verify whether the background of the panel is displayed in red when connection is unsuccessful due to invalid / Empty credentials in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Data Source Page
      | fieldName         | attribute                         |
      | Data Source Type* | AmazonS3DataSource                |
      | Region*           | US East (N. Virginia) [us-east-1] |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name*     | AmazonS3_DataSource1 |
      | Label     | AmazonS3_DataSource  |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                 |
      | Credential* | AWS_S3Invalid_Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - AmazonS3 connection was failed" is "displayed" in "Add Data Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute               |
      | Credential* | AWS_S3EMPTY_Credentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - Request timed out" is "displayed" in "Add Data Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #QAC-7078250
  @aws @webtest @negative @MLPQA-17239
  Scenario:SC#20_Verify whether the background of the panel is displayed in red when connection is unsuccessful in S3 cataloger when invalid / empty credential is used in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute                 |
      | Type        | Cataloger                 |
      | Plugin      | AmazonS3Cataloger         |
      | Data Source | AmazonS3DataSource        |
      | Credential  | AWS_S3Invalid_Credentials |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Name      | AmazonS3_Cataloger1 |
      | Label     | AmazonS3_Cataloger  |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "No connection with data source - AmazonS3 connection was failed" is "displayed" in "Add Manage Configuration Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute               |
      | Credential | AWS_S3EMPTY_Credentials |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "No connection with data source - Required attribute Secret key is blank" is "displayed" in "Add Manage Configuration Sources Page"


    ############################################### SC21 ####################################################

  @webtest
  Scenario:SC21#Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                | dirPath                                 | recursive |
      | asgqas3testautomation | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC21#_Run the AmazonCataloger with DRY RUN is set to TRUE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                       | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc21AmazonS3DryRun.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                            | 200           | AWSS3            |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                            | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json              | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                            | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  @webtest @regression @sanity @IDA-10.0
  Scenario: SC21# Verify AmazonCataloger plugin with Dry Run = True in IDC UI
    Then Analysis log "cataloger/AmazonS3Cataloger/AmazonS3Catalog/%" should display below info/error/warning
      | type | logValue                                                                                                                               | logCode       | pluginName        | removableText |
      | INFO | Plugin started                                                                                                                         | ANALYSIS-0019 |                   |               |
      | INFO | Plugin AmazonS3Cataloger running on dry run mode                                                                                       | ANALYSIS-0069 | AmazonS3Cataloger |               |
      | INFO | Plugin AmazonS3Cataloger processed 19 items on dry run mode and not written to the repository                                          | ANALYSIS-0070 | AmazonS3Cataloger |               |
      | INFO | Plugin AmazonS3Cataloger Start Time:2020-08-27 11:23:41.033, End Time:2020-08-27 11:23:49.146, Errors:0, Warnings:3 | ANALYSIS-0072 | AmazonS3Cataloger |               |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:08.353)                                                              | ANALYSIS-0020 |                   |               |

  @sanity @positive
  Scenario:SC#21:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis |       |       |

  @aws
  Scenario:SC21#Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service

   ######################################## SC22 ##################################################################

  #QAC-7078248
  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC22#_Verification of AmazonS3 plugin functionality for invalid data source
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc22AmazonS3ConfigInvalidDataSource.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3            |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |

  #QAC-7078248
  @webtest @regression @sanity @IDA-10.0
  Scenario: SC22# Verify AmazonCataloger plugin with invalid
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AmazonS3Cataloger/AmazonS3Catalog" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonS3Cataloger/AmazonS3Catalog%"
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/AmazonS3Cataloger/AmazonS3Catalog/%" should display below info/error/warning
      | type  | logValue                                                                                                            | logCode       | pluginName        | removableText |
      | INFO  | Plugin started                                                                                                      | ANALYSIS-0019 |                   |               |
      | INFO  | Plugin AmazonS3Cataloger Start Time:2021-02-09 13:08:14.451, End Time:2021-02-09 13:08:15.346, Errors:2, Warnings:0 | ANALYSIS-0072 | AmazonS3Cataloger |               |
      | INFO  | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:00.895)                                          | ANALYSIS-0075 |                   |               |
      | ERROR | Error retrieving bucket list                                                                                        | AWS_S3-0006   |                   |               |

  @sanity @positive
  Scenario:SC#22:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis |       |       |

    ######################################## SC23 ##################################################################

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC23#_Verification of AmazonS3 plugin functionality for non existing bucket
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                    | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc23AmazonS3ConfigInvalidBucket.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                         | 200           | AWSS3            |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                         | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                           | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                         | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  @webtest @regression @sanity @IDA-10.0
  Scenario: SC23# Verify AmazonCataloger plugin analysis for invalid bucket name in config
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "cataloger/AmazonS3Cataloger/AmazonS3Catalog" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonS3Cataloger/AmazonS3Catalog%"
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/AmazonS3Cataloger/AmazonS3Catalog/%" should display below info/error/warning
      | type | logValue                                                                                                           | logCode       | pluginName        | removableText |
      | INFO | Plugin started                                                                                                     | ANALYSIS-0019 |                   |               |
      | INFO | Plugin AmazonS3Cataloger Start Time:2020-03-05 06:18:33.790, End Time:2020-03-05 06:18:42.908,Errors:0, Warnings:0 | ANALYSIS-0072 | AmazonS3Cataloger |               |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:08.353)                                          | ANALYSIS-0020 |                   |               |

  @sanity @positive
  Scenario:SC#23:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis |       |       |

        ######################################## SC24 ##################################################################

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC24#_Verification of AmazonS3 plugin functionality for non existing folder in bucket
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/sc24AmazonS3ConfigInvalidDirName.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                          | 200           | AWSS3            |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                            | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  @webtest @regression @sanity @IDA-10.0
  Scenario: SC24# Verify AmazonCataloger plugin analysis for invalid bucket name in config
    Then Analysis log "cataloger/AmazonS3Cataloger/AmazonS3Catalog/%" should display below info/error/warning
      | type | logValue                                                                                                           | logCode       | pluginName        | removableText |
      | INFO | Plugin started                                                                                                     | ANALYSIS-0019 |                   |               |
      | INFO | Plugin AmazonS3Cataloger Start Time:2020-08-27 11:44:23.046, End Time:2020-08-27 11:44:24.759,Errors:0, Warnings:0 | ANALYSIS-0072 | AmazonS3Cataloger |               |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:08.353)                                          | ANALYSIS-0020 |                   |               |

     ######################################## SC25 ##################################################################

  @webtest
  Scenario: MLP-7847:SC25#User Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                | dirPath                                 | recursive |
      | asgqas3testautomation | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |

  Scenario Outline:MLP-7847:SC25#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                        | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                             | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/amazonPayloads/s14AmazonS3ConfigIncremental.json        | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                             | 200           | AWSS3              |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                               | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  @MLP-7847 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-7847:SC25#User Create a bucket & folder with various file formats in S3 Amazon storage
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 10    |
    And user enters the search text "userInfo.avro" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userInfo.avro" item from search results
    And user "store" the value of item "userInfo.avro" of attribute "Last catalogued at" with temporary text
    And user "store as Static" the value of item "userInfo.avro" of attribute "Last catalogued at" with temporary text
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                | dirPath                      | recursive |
      | asgqas3testautomation | AutoTestData/Incremental | ida/amazonPayloads/TestData/ | false     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body                                               | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                              | ida/amazonPayloads/s14AmazonS3TrueIncremental.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                              |                                                    | 200           | AWSS3            |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog |                                                    | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog  | ida/amazonPayloads/empty.json                      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Catalog |                                                    | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3Catalog')].status |
    And user enters the search text "AWSS3" and clicks on search
    And user performs "facet selection" in "AWSS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 11    |
    And user enters the search text "userInfo.avro" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userInfo.avro" item from search results
    Then user "verify equals" the value of item "userInfo.avro" of attribute "Last catalogued at" with temporary text
    And user enters the search text "incremental.avro" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "incremental.avro" item from search results
    Then user "verify not equals" the value of item "incremental.avro" of attribute "Last catalogued at" with temporary text

  @sanity @positive
  Scenario:SC#25:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type      | query | param |
      | MultipleIDDelete | Default | asgqas3testautomation | Directory |       |       |

  @aws
  Scenario: MLP-7847:SC25#Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service

  @sanity @positive
  Scenario:SC24#:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type                | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog/% | Analysis            |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                 | Cluster             |       |       |
      | MultipleIDDelete | Default | AmazonS3                                      | Service             |       |       |
      | SingleItemDelete | Default | S3Amazon_BA                                   | BusinessApplication |       |       |

  @MLP-14874 @webtest
  Scenario: SC#25 Verify whether the background of the panel is displayed in red when test connection is not successful for AmazonS3DataSource in LocalNode for disabled/unsupported region
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
      | fieldName        | attribute          |
      | Data Source Type | AmazonS3DataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute               |
      | Name*     | AmazonS3DataSourceTest3 |
      | Label     | AmazonS3DataSourceTest3 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                        |
      | Region*     | China (Ningxia) [cn-northwest-1] |
      | Credential* | AWS_S3Credentials                |
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
  Scenario Outline:SC#26_Delete Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                      | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger/AmazonS3Catalog     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource/AmazonS3DataSource |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource/AmazonS3_DataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/AWS_S3Credentials                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/AWS_S3EMPTY_Credentials             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/AWS_S3Invalid_Credentials           |      | 200           |                  |          |
