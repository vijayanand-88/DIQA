@9621 @MLP-14645 @12960 @12942
Feature:Support DataSource/Credential support for S3 CSV Cataloger

#############################################################################PRE-CONDITION#########################################################################################

  @aws @precondition
  Scenario: SC1#Update the aws credential Json
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                          | accessKeyPath | secretKeyPath |
      | ida/s3CSVPayloads/credentials/awsCredentials.json | $..accessKey  | $..secretKey  |

  @aws @precondition
  Scenario Outline:SC#1 Run the Plugin configurations for DataSource and Amazon Spectrum Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | body                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_CSV_Credentials         | ida/s3CSVPayloads/credentials/awsCredentials.json        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_CSV_Invalid_Credentials | ida/s3CSVPayloads/credentials/awsInvalidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_CSV_EMPTY_Credentials   | ida/s3CSVPayloads/credentials/awsEmptyCredentials.json   | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials      | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials      |                                                            | 200           |                  |          |


  @csv @positve @regression @sanity @webtest
  Scenario:SC#1 Verify whether the background of the panel is displayed in green when connection is successful in Csvs3DataSource
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute       |
      | Data Source Type | CsvS3DataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute        |
      | Name      | CsvS3_DataSource |
      | Label     | CsvS3_DataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | AWS_CSV_Credentials               |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#1 Verify whether the background of the panel is displayed in green when connection is successful (csvS3Cataloger)
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
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute     |
      | Name*     | Csv_Cataloger |
      | Label     | Csv_Cataloger |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName    | attribute           |
      | Type*        | Cataloger           |
      | Plugin*      | CsvS3Cataloger      |
      | Data Source* | CsvS3_DataSource    |
      | Credential*  | AWS_CSV_Credentials |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Page"

######################################################################DATA CREATION###############################################################################################

  @webtest
  Scenario: SC#2 Set the Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                | body                                                          | response code | response message | jsonPath              |
      | application/json | raw   | false | Put  | settings/analyzers/CsvS3DataSource | ida/s3CSVPayloads/DataSource/AmazonCSVS3DataSourceConfig.json | 204           |                  |                       |
      |                  |       |       | Get  | settings/analyzers/CsvS3DataSource |                                                               | 200           |                  | AmazonCSVS3DataSource |


  @webtest
  Scenario: MLP-14645:SC#2 Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqacsvtestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix    | dirPath                     | recursive |
      | asgqacsvtestautomation | AutoTestData | ida/s3CSVPayloads/TestData/ | true      |


###############################################################UI VALIDATION WHEN BUCKET AND REGION INCLUDED############################################################################################

    # 6619964
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-18059 @MLPQA-18064
  Scenario: MLP-14645:SC#3 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when CSVS3Cataloger is run with region  and Bucketname with Include and Logging is Verified for it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                      | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc1CSVS3Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                           | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                           | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |                                                           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                           | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user gets amazon bucket "asgqacsvtestautomation" file count in "AutoTestData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                 | fileName               | userTag |
      | Default     | Field     | Metadata Type | CSV,CSVS3,Amazon S3 | _c20                   | CSVS3   |
      | Default     | File      | Metadata Type | CSV,CSVS3,Amazon S3 | sample.csv             | CSVS3   |
      | Default     | Directory | Metadata Type | CSV,CSVS3,Amazon S3 | asgqacsvtestautomation | CSVS3   |
      | Default     | Cluster   | Metadata Type | CSV,CSVS3,Amazon S3 | amazonaws.com          | CSVS3   |
      | Default     | Service   | Metadata Type | CSV,CSVS3,Amazon S3 | AmazonS3               | CSVS3   |
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    Then user "verify displayed" for listed "Tags" facet in Search results page
      | ItemType   |
      | Data Files |
      | CSV        |
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Directory | 6     |
      | File      | 16    |
      | Field     | 232   |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CsvS3Cataloger/CSVS3Cataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 1             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | AmazonS3      |
      | amazonaws.com |
    Then Analysis log "cataloger/CsvS3Cataloger/CSVS3Cataloger/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0019 |                |                |
      | INFO | Plugin Name:CsvS3Cataloger, Plugin Type:cataloger, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:335da135ca5d, Plugin Configuration name:CSVS3Cataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0071 | CsvS3Cataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: credential: "AWS_CSV_Credentials" 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: businessApplicationName: null 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: dryRun: false 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: schedule: null 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: filter: null 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: versionMode: false 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: maxObjectsAmount: 1000 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: pluginName: "CsvS3Cataloger" 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: delimiter: ","2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: incremental: false 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: type: "Cataloger" 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: bucketFilter: 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: mode: "INCLUDE" 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: patterns: 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: - "asgqacsvtestautomation" 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: objectFilter: 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: dirFilter: 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: mode: "INCLUDE" 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: patterns: [] 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: fileFilter: 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: mode: "INCLUDE" 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: patterns: [] 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: dirPrefixes: 2020-03-07 20:06:30.294 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: - "/AutoTestData" 2020-03-07 20:06:30.295 INFO - ANALYSIS-0073: Plugin CsvS3Cataloger Configuration: firstRowAsHeader: false | ANALYSIS-0073 | CsvS3Cataloger |                |
      | INFO | Plugin CsvS3Cataloger Start Time:2020-03-07 20:06:30.290, End Time:2020-03-07 20:06:42.513, Processed Count:2, Errors:1, Warnings:3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0072 | CsvS3Cataloger |                |
      | INFO | lugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:12.223)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0020 |                |                |

    #6619966
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.3
  Scenario: MLP-14645:SC#3 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname(Include) and Directory(with /) and v
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    Then user "verify displayed" for listed "Metadata Type" facet in Search results page
      | ItemType  |
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
      | Field     |

  # 6619982
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#3 Verify breadcrumb hierarchy appears correctly in S3Cataloger cataloged items and Field Level Metadata
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sample.csv" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "asgqacsvtestautomation [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sample.csv" item from search results
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c5   | click and switch tab | No               |             |
    Then user "verify presence" of following "hierarchy" in Item View Page
      | amazonaws.com          |
      | AmazonS3               |
      | asgqacsvtestautomation |
      | AutoTestData           |
      | sample.csv             |
      | _c5                    |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | STRING        | Description |

  # 6619979
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#3 Verify File level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Data-sample-10MB.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Data-sample-10MB.csv" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                    | widgetName  |
      | File size         | 10.16 MB                                                         | Description |
      | Location          | asgqacsvtestautomation/AutoTestData/TestCSV/Data-sample-10MB.csv | Description |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | sample.csv                                |
#      | attributeName  | Technical Data                            |
#      | actualFilePath | ida/s3CSVPayloads/actualFileTechData.json |
#    And user remove the json attribute from file for following parameters
#      | filePath                                    | attributeName |
#      | ida/s3CSVPayloads/actualFileTechData.json   | Last-Modified |
#      | ida/s3CSVPayloads/expectedFileTechData.json | Last-Modified |
#      | ida/s3CSVPayloads/actualFileTechData.json   | ETag          |
#      | ida/s3CSVPayloads/expectedFileTechData.json | ETag          |
#    And user "update" the json file "ida/s3CSVPayloads/expectedFileTechData.json" file for following values
#      | jsonPath                     | jsonValues | type   |
#      | $.eTag                       |            | String |
#      | $.rawMetaData.Content-Length |            | String |
#    And user "update" the json file "ida/s3CSVPayloads/actualFileTechData.json" file for following values
#      | jsonPath                     | jsonValues | type   |
#      | $.eTag                       |            | String |
#      | $.rawMetaData.Content-Length |            | String |
#    Then file content in "ida/s3CSVPayloads/expectedFileTechData.json" should be same as the content in "ida/s3CSVPayloads/actualFileTechData.json"

    # 6619978
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#3 Verify Directory/sub directory level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AutoTestData" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "asgqacsvtestautomation [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AutoTestData" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                        | widgetName  |
      | Directory size            | 110628947                            | Statistics  |
      | Number of files           | 8                                    | Statistics  |
      | Size of files             | 110628947                            | Statistics  |
      | Location                  | asgqacsvtestautomation/AutoTestData/ | Description |
      | Number of sub-directories | 2                                    | Statistics  |
      | Size of sub-directories   | 10734958                             | Statistics  |
    And user enters the search text "Subdir" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "asgqacsvtestautomation [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Subdir" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                                       | widgetName  |
      | Directory size            | 40650                                               | Statistics  |
      | Number of files           | 2                                                   | Statistics  |
      | Size of files             | 40650                                               | Statistics  |
      | Location                  | asgqacsvtestautomation/AutoTestData/TestCSV/Subdir/ | Description |
      | Number of sub-directories | 0                                                   | Statistics  |
      | Size of sub-directories   | 0                                                   | Statistics  |


    # 6619977
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#3 Verify Bucket level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgqacsvtestautomation" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue           | widgetName  |
      | Directory size            | 0                       | Statistics  |
      | Number of files           | 0                       | Statistics  |
      | Size of files             | 0                       | Statistics  |
      | Location                  | asgqacsvtestautomation/ | Description |
      | Number of sub-directories | 1                       | Statistics  |
      | Size of sub-directories   | 0                       | Statistics  |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | asgqacsvtestautomation                    |
#      | attributeName  | Technical Data                            |
#      | actualFilePath | ida/s3CSVPayloads/actualBuckTechData.json |
#    Then file content in "ida/s3CSVPayloads/expectedBuckTechData.json" should be same as the content in "ida/s3CSVPayloads/actualBuckTechData.json"

  Scenario Outline: SC3#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC3#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |


 ####################################################################BUSINESS APLLICATION TAG##############################################################################

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: create BussinessApplication tag
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3CSVPayloads/BA/businessApplication.json | 200           |                  |          |

   ####################################################################UI VALIDATION BASED ON TAG NAME AND VALIDATING IN METABILITY##############################################################################

  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0 @MLPQA-18059 @MLPQA-18064
  Scenario: MLP-14645:SC#4 Verify CSVS3Cataloger runs above the cataloged items from S3 Cataloger with the businessApplicationName tag and Technology tag
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/AmazonS3DataSource                               | ida/S3CSVPayloads/DataSource/s3DataSourceConfig.json           | 204           |                  | AmazonS3DataSourceCSV                                     |
      |                  |       |       | Get          | settings/analyzers/AmazonS3DataSource                               |                                                                | 200           |                  |                                                           |
      |                  |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/S3CSVPayloads/PluginConfiguration/s3CatalogerConfig.json   | 204           |                  | AmazonS3CatalogerCSV                                      |
      |                  |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3CatalogerCSV')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='AmazonS3CatalogerCSV')].status |
      |                  |       |       | Put          | settings/analyzers/CsvS3Cataloger                                   | ida/S3CSVPayloads/PluginConfiguration/sc54CSVS3ConfigFile.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                   |                                                                | 200           |                  | CsvS3Cataloger                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status       |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*     |                                                                | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status       |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "CSV,CSVS3,CSVS3_BA" should get displayed for the column "cataloger/CsvS3Cataloger"
    Then the following tags "Amazon S3,CSVS3" should get displayed for the column "cataloger/AmazonS3Cataloger/AmazonS3CatalogerCSV"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                          | fileName               | userTag |
      | Default     | Field     | Metadata Type | CSV,CSVS3,Amazon S3,CSVS3_BA | _c20                   | CSVS3   |
      | Default     | File      | Metadata Type | CSV,CSVS3,Amazon S3,CSVS3_BA | sample.csv             | CSVS3   |
      | Default     | Directory | Metadata Type | CSV,CSVS3,Amazon S3,CSVS3_BA | asgqacsvtestautomation | CSVS3   |
      | Default     | Cluster   | Metadata Type | CSV,CSVS3,Amazon S3,CSVS3_BA | amazonaws.com          | CSVS3   |
      | Default     | Service   | Metadata Type | CSV,CSVS3,Amazon S3,CSVS3_BA | AmazonS3               | CSVS3   |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag        | fileName      | userTag |
      | Default     | Cluster   | Metadata Type | Data Files | amazonaws.com | CSVS3   |
      | Default     | Service   | Metadata Type | Data Files | AmazonS3      | CSVS3   |
      | Default     | File      | Metadata Type | Data Files | sample.csv    | CSVS3   |
      | Default     | Directory | Metadata Type | Data Files | AutoTestData  | CSVS3   |
      | Default     | Field     | Metadata Type | Data Files | _c4           | CSVS3   |


#  @sanity @positive @webtest @edibus
#  Scenario: MLP-9043: SC#4 Verify the CSV S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "CSVS3" and clicks on search
#    And user performs "facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Field     |
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/CsvS3Config.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                              | response code | response message | jsonPath                                       |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                            | idc/EdiBusPayloads/datasource/EDIBusDS_Csvs3.json | 204           |                  |                                                |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/CSVConfig.json                 | 204           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusCSV |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusCSV')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusCSV  |                                                   | 200           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusCSV |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusCSV')].status |
#    And user enters the search text "EDIBusCSV" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusCSV%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "CSVS3" and clicks on search
#    And user performs "facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/CSV |
#      | $..selections.['type_s'][*]                   | File                                      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                  | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=CSVS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "CSVS3" and clicks on search
#    And user performs "facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/CSV |
#      | $..selections.['type_s'][*]                   | Directory                                 |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                  | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=CSVS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user enters the search text "CSVS3" and clicks on search
#    And user performs "facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM) |
#    And user enters the search text "CSVS3" and clicks on search
#    And user performs "facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FIELD ) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @*CSV≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @*CSV≫DEFAULT≫DWR_DAT_DIRECTORY≫@* ),AND,( TYPE = DWR_IDC )   |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @*CSV≫DEFAULT≫DWR_DAT_FILE_SYSTEM≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @*CSV≫DEFAULT≫DWR_DAT_FIELD≫@* ),AND,( TYPE = DWR_IDC )       |


  Scenario Outline: SC#4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#4 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |


  Scenario Outline: SC#4 user retrieves the total items for a catalog and copy to a json file for Analysis file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/AmazonS3Cataloger/AmazonS3CatalogerCSV/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |


  Scenario Outline: SC#4 user deletes the item from database using dynamic id stored in json for Analysis file
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED ON BUCKET INCLUDE AND OTHER FILTER##########################################################################################

    # 6619967# 6619969
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#5 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when CSVS3Cataloger is run with region and Bucketname(Include)/Directory/File(include)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                 | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/S3CSVPayloads/PluginConfiguration/sc2CSVS3ConfigFileInclude.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                      | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |                                                                      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | sample.csv |


  Scenario Outline: SC#5 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

    # 6619968 # 6619970
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#5 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname(Include)/Directory/File(Exclude)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                 | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/S3CSVPayloads/PluginConfiguration/sc3CSVS3ConfigFileExclude.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                      | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |                                                                      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | sample1.csv |

  Scenario Outline: SC#5 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  #6619987 This test case is covered as part of SC43 due to new DataSource changes , hence commenting this case
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#5 Verify CSVS3Cataloger collects Analysis item when CSVS3Cataloger is run with region, incorrect Access Key, Secret Key
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                            | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3DataSource                               | ida/s3CSVPayloads/DataSource/AmazonCSVS3InvalidCredentialsDataSourceConfig.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                               |                                                                                 | 200           |                  | AmazonCSVS3InvalidCredentialsDataSource             |
      |                  |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc4CSVS3ConfigInCorrectAccessKey.json     | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                                 | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |                                                                                 | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CsvS3Cataloger/CSVS3Cataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/CsvS3Cataloger/CSVS3Cataloger/%" should display below info/error/warning
      | type | logValue                                                                                                                            | logCode       | pluginName     | removableText |
      | INFO | Plugin CsvS3Cataloger Start Time:2020-03-15 11:03:36.544, End Time:2020-03-15 11:03:37.190, Processed Count:0, Errors:2, Warnings:0 | ANALYSIS-0072 | CsvS3Cataloger |               |
    Then Analysis log "cataloger/CsvS3Cataloger/CSVS3Cataloger/%" should display below info/error/warning
      | type  | logValue                                                                | logCode     |
      | ERROR | Amazon S3 connection failed : AWS_S3-0006: Error retrieving bucket list | AWS_S3-0011 |


  Scenario Outline: SC#5 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline: SC#5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |


    # 6619988
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#5 Verify CSVS3Cataloger doesn't collects fields of invalid CSV files available in S3
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3DataSource                               | ida/s3CSVPayloads/DataSource/AmazonCSVS3DataSourceConfig.json       | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                               |                                                                     | 200           |                  | AmazonCSVS3DataSource                               |
      |                  |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc5CSVS3ConfigInvalidCSV.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                     | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |                                                                     | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    Then user "verify displayed" for listed "Metadata Type" facet in Search results page
      | ItemType  |
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Field |

  Scenario Outline: SC#5 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |


 #########################################################UI VALIDATION BASED ON BUCKET EXCLUDE AND OTHER FILTER##########################################################################################
  @webtest
  Scenario: MLP-14645:SC#6 User Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqacsvtestautomationexclude" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName                    | keyPrefix                | dirPath                                 | recursive |
      | asgqacsvtestautomationexclude | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |


     ##6619965##
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#6 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File when CSVS3Cataloger is run with region  and Bucketname with Exclude
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                   | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc6CSVS3ConfigBucketExclude.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                        | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |                                                                        | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | asgqacsvtestautomation |
    Then user "verify non presence" of following "Items List" in Search Results Page
      | asgqacsvtestautomationexclude |


  Scenario Outline: SC#6 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#6 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  @aws
  Scenario:  MLP-14645:SC#6 Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqacsvtestautomationexclude"
    Then user "Delete" a bucket "asgqacsvtestautomationexclude" in amazon storage service

  #########################################################UI VALIDATION BASED ON BUCKET AND DIRECTORY INCLUDE##################################################################################################

    # 6619966
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#7 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File when CSVS3Cataloger is run with region  and Bucketname(Include) and Directory(Include)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                                   | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                             | ida/s3CSVPayloads/PluginConfiguration/sc7CSVS3ConfigSubDirInclude.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                             |                                                                        | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger  |                                                                        | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user gets amazon bucket "asgqacsvtestautomation" file count in "AutoTestData/TestCSV/Subdir" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 2     |


  Scenario Outline: SC#7 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation                       | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CSVS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#7 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

   #########################################################UI VALIDATION BASED ON BUCKET AND DIRECTORY INCLUDE WITH FILE * ##################################################################################################
    # 6619967
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#7.1 Verify CSVS3 Cataloger collects Cluster,Service,Analysis,Directory,File when CSVS3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Include)/File(*)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                     | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc8CSVS3ConfigFileInludeRegex.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                          | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |                                                                          | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | sample-subdir.csv |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Subdir |


  Scenario Outline: SC#7.1 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#7.1 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED ON BUCKET AND DIRECTORY INCLUDE WITH SUB DIRECTORY EXCLUDE ##################################################################################################

    # 6619968
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#7.2 Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Exclude)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                   | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc9CSVS3ConfigSubDirExclude.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                        | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |                                                                        | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | sample-subdir.csv |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | Subdir |


  Scenario Outline: SC#7.2 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#7.2 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED ON BUCKET AND DIRECTORY INCLUDE WITH SUB DIRECTORY AND FILE INCLUDE ##################################################################################################
    # 6619969
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#7.3 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when CSVS3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Include)/File(include)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                               | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc10CSVS3ConfigSubDirIncludeFileInclude.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                                    | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                                   | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | sample-subdir.csv |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Subdir |

  Scenario Outline: SC#7.3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#7.3 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |


    #########################################################UI VALIDATION BASED ON BUCKET AND SUB DIRECTORY INCLUDE WITH FILE EXCLUDE ##################################################################################################

    # 6619970
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#7.4 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when CSVS3Cataloger is run with region and Bucketname(Include)/Directory/Sub Directory(Include)/File(exclude)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                               | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc11CSVS3ConfigSubDirIncludeFileExclude.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                                    | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                                   | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Subdir |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | sample-subdir1.csv |


  Scenario Outline: SC#7.4user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#7.4 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED ON WILD CARD CHARACTER* ##################################################################################################

    # 6619971
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#7.5 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when CSVS3Cataloger is run with region and Bucketname with wild card character(*)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                     | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc12CSVS3ConfigBucketWildCard.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                          | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                         | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    Then user "verify displayed" for listed "Metadata Type" facet in Search results page
      | ItemType  |
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
      | Field     |
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqacsvtestautomation |


  Scenario Outline: SC#7.5 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#7.5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  ###########################################################UI VALIDATION BASED REGION AND BUCKET INCLUDE* ##################################################################################################
     #6619972
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario:MLP-14645:SC#7.6 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when CSVS3Cataloger is run with region and Bucketname(Include)/Directory(Name with / and *)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc13CSVS3ConfigDirWithSlashStar.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                            | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user gets amazon bucket "asgqacsvtestautomation" file count in "AutoTestData/TestCSV/Subdir" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 2     |


  Scenario Outline: SC#7.6 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#7.6 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  @aws
  Scenario:SC#7.6 Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqacsvtestautomation"
    Then user "Delete" a bucket "asgqacsvtestautomation" in amazon storage service

#########################################################UI VALIDATION BASED ON INCREMENTAL ##################################################################################################
    # 6619975
  @webtest
  Scenario: MLP-14645:SC#8 Verify incremental scan works properly with CSVS3Cataloger
    Given user "Create" a bucket "asgqacsvtestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix            | dirPath                            | recursive |
      | asgqacsvtestautomation | AutoTestData/TestCSV | ida/S3CSVPayloads/TestData/TestCSV | true      |
    And user "update" the json file "ida/s3CSVPayloads/PluginConfiguration/sc16CSVS3ConfigIncremental.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                                  | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                             | ida/s3CSVPayloads/PluginConfiguration/sc16CSVS3ConfigIncremental.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                             |                                                                       | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger  | ida/s3CSVPayloads/PluginConfiguration/empty.json                      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user gets amazon bucket "asgqacsvtestautomation" file count in "AutoTestData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 7     |
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix                | dirPath                                | recursive |
      | asgqacsvtestautomation | AutoTestData/Incremental | ida/s3CSVPayloads/TestData/Incremental | false     |
    And user gets amazon bucket "asgqacsvtestautomation" file count in "AutoTestData" directory and store in temp variable
    And user "update" the json file "ida/s3CSVPayloads/PluginConfiguration/sc16CSVS3ConfigIncremental.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                           | body                                                                  | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/CsvS3Cataloger                                             | ida/s3CSVPayloads/PluginConfiguration/sc16CSVS3ConfigIncremental.json | 204           |                  |                                                     |
      |        |       |       | Get          | settings/analyzers/CsvS3Cataloger                                             |                                                                       | 200           |                  | CsvS3Cataloger                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger  |                                                                       | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 8     |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Incremental [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | sample-incremental.csv |

  Scenario Outline: SC#8 user retrieves the total items for a catalog and copy to a json file - First Catalgoed Data
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation                       | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CSVS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#8 user deletes the item from database using dynamic id stored in json - First Catalgoed Data
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  Scenario Outline: SC#8 user retrieves the total items for a catalog and copy to a json file - Incremental Catalgoed Data
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CSVS3Cataloger/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline: SC#8 user deletes the item from database using dynamic id stored in json - Incremental Catalgoed Data
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED DRY RUN TRUE ##################################################################################################
  @webtest
  Scenario: SC#9 Verify CSVS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when CsvS3Cataloger is run with dry run true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                            | response code | response message | jsonPath                                                  |
      | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/csvS3CatalogerDryRun.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                 | 200           |                  | CsvS3CatalogerDryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3CatalogerDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                   | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3CatalogerDryRun')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CsvS3Cataloger/CsvS3CatalogerDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/CsvS3Cataloger/CsvS3CatalogerDryRun%" should display below info/error/warning
      | type | logValue                                                                                  | logCode       | pluginName     | removableText |
      | INFO | Plugin CSVS3Cataloger running on dry run mode                                             | ANALYSIS-0069 | CsvS3Cataloger |               |
      | INFO | Plugin CsvS3Cataloger processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | CsvS3Cataloger |               |
      | INFO | Plugin completed                                                                          | ANALYSIS-0020 |                |               |

  Scenario Outline: SC#9 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                               | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3CatalogerDryRun/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline: SC#9 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |

#########################################################UI ERROR MESSAGE VALIDATION ##################################################################################################

    # 6619983
  @webtest @MLP-14645 @positive @regression @pluginManager
  Scenario: MLP-14645 SC#10 Verify proper error message is shown if mandatory fields are not filled in CSVS3Cataloger configuration page
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
      | fieldName | attribute      |
      | Type*     | Cataloger      |
      | Plugin*   | CsvS3Cataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |

  @aws
  Scenario:SC#10 Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqacsvtestautomation"
    Then user "Delete" a bucket "asgqacsvtestautomation" in amazon storage service

#########################################################UI FILE VERSION VALIDATION ##################################################################################################

    # 6619976 # 6619984
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645-SC#11 Verify file versions are collected correctly when scan mode is set as versions in CSVS3Cataloger
    Given user "Create" a bucket "asgqacsvtestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix    | dirPath                     | recursive |
      | asgqacsvtestautomation | AutoTestData | ida/S3CSVPayloads/TestData/ | true      |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName             | status  |
      | asgqacsvtestautomation | Enabled |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix                                       | dirPath                                                       |
      | asgqacsvtestautomation | AutoTestData/TestCSV/version/sample-version.csv | ida/s3CSVPayloads/TestData/TestCSV/version/sample-version.csv |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                              | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc20CSVS3ConfigVersion.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                   | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestCSV/version/" in bucket "asgqacsvtestautomation" with maximum count of "50"
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 1     |


  Scenario Outline: SC#11 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#11 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  @aws
  Scenario:SC#11 Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "asgqacsvtestautomation"
    Then user "Delete" a bucket "asgqacsvtestautomation" in amazon storage service

  #########################################################UI VERSION VALIDATION WHEN INCREMENTAL COLLECTION SET TO ON ##################################################################################################
    # 6619975
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645_SC#11.1 Verify file versions are collected correctly when scan mode is set as versions in CSVS3Cataloger and Incremental collection is ON
    Given user "Create" a bucket "asgqacsvtestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix    | dirPath                     | recursive |
      | asgqacsvtestautomation | AutoTestData | ida/s3CSVPayloads/TestData/ | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                  | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc22CSVS3ConfigVersionIncr.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                       | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName             | status  |
      | asgqacsvtestautomation | Enabled |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestCSV/version/" in bucket "asgqacsvtestautomation" with maximum count of "50"
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 1     |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName             | status  |
      | asgqacsvtestautomation | Enabled |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix                                       | dirPath                                                       |
      | asgqacsvtestautomation | AutoTestData/TestCSV/version/sample-version.csv | ida/s3CSVPayloads/TestData/TestCSV/version/sample-version.csv |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body | response code | response message | jsonPath                                            |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  |      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |      | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestCSV/version/" in bucket "asgqacsvtestautomation" with maximum count of "50"
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 2     |


  Scenario Outline: SC#11.1 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#11.1 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  Scenario Outline: SC#11.1.1 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline: SC#11.1.1 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED INTERNAL NODE ##################################################################################################
  @webtest
  Scenario: SC#12 -Set the Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                | body                                                                      | response code | response message | jsonPath                      |
      | application/json | raw   | false | Put  | settings/analyzers/CsvS3DataSource | ida/s3CSVPayloads/DataSource/AmazonCSVS3DataSourceConfigInternalNode.json | 204           |                  |                               |
      |                  |       |       | Get  | settings/analyzers/CsvS3DataSource |                                                                           | 200           |                  | AmazonCSVS3DataSourceInternal |

    # 6619980  # 6619981
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#12 Verify CSVS3Cataloger config gets mapped and run successfully when specific node condition is mentioned
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                       | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                   | ida/s3CSVPayloads/PluginConfiguration/sc23CSVS3Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                   |                                                            | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user gets amazon bucket "asgqacsvtestautomation" file count in "AutoTestData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sample.csv" and clicks on search
    And user performs "facet selection" in "asgqacsvtestautomation [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "CSV,CSVS3" should get displayed for the column "sample.csv"

  Scenario Outline: SC#12 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#12 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

#########################################################UI FILED DELIMITER MESSAGE VALIDATION AND FILTER ##################################################################################################
    # 6628696
  @webtest @MLP-14645 @positive @regression @pluginManager
  Scenario: MLP-14645 SC#13 Verify CSVS3Cataloger config throws proper error message when field delimiter value entered more than single character
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
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | CsvS3Cataloger |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Field Delimiter       | test                   |
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName       | errorMessage                                                                        |
      | Field Delimiter | Delimiter should be a single character and should not be backslash or double quotes |

    # 6628695
  @webtest @MLP-14645 @positive @regression @pluginManager
  Scenario: MLP-14645 SC#13 Verify CSVS3Cataloger config throws proper error message when field delimiter entered with invalid value \(Backslash) or double quotes
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
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | CsvS3Cataloger |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Field Delimiter       | "                      |
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName       | errorMessage                                                                        |
      | Field Delimiter | Delimiter should be a single character and should not be backslash or double quotes |

  @webtest
  Scenario: SC#13 Set the Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                | body                                                          | response code | response message | jsonPath              |
      | application/json | raw   | false | Put  | settings/analyzers/CsvS3DataSource | ida/s3CSVPayloads/DataSource/AmazonCSVS3DataSourceConfig.json | 204           |                  |                       |
      |                  |       |       | Get  | settings/analyzers/CsvS3DataSource |                                                               | 200           |                  | AmazonCSVS3DataSource |

    # 6628698
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#13 Verify CSVS3Cataloger scan and collects CSV files when CSVS3Cataloger configure and run with different format of field delimiters(!,@,#,$,%,^,&,*,(,),:,;,|,G,9,~)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc26CSVS3Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                            | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sample.csv" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    Then the following tags "CSV,CSVS3" should get displayed for the column "sample.csv"

  Scenario Outline: SC#13 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#13 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED RECORD SIZE##################################################################################################

    # 6635222
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#14 Verify CSVS3Cataloger collects fields when file is having 100 records which is more than 10MB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc27CSVS3Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                            | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "CSVData-105MB.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "CSV,CSVS3" should get displayed for the column "CSVData-105MB.csv"

  Scenario Outline: SC#14 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#14 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED MULTIPLE FILES##################################################################################################
    # 6636555
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#15 Verify CSVS3Cataloger collects only provided field delimiter value CSV file for multiple files having different delimiters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc28CSVS3Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                            | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sample-pipe.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | _c1 |


  Scenario Outline: SC#15 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#15 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  #########################################################UI VALIDATION BASED FIRST ROW HEADER TRUE ##################################################################################################

    ##Issue is there##
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#16 Verify CSV Cataloger collects actual header names of the provided CSV file when firstRowAsHeader=true(header names less than 50 characters)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc29CSVS3Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                            | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "store_sampleheader-comma.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | Id        |
      | NameCount |


  Scenario Outline: SC16 #user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#16 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED FIRST ROW HEADER FALSE ##################################################################################################

  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#16.1 Verify CSV Cataloger should collect header information as (_c0,_c1.....) of the provided CSV file when firstRowAsHeader=false(by default)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc30CSVS3Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                            | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "store_sampleheader-comma.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | Id        |
      | NameCount |

  Scenario Outline: SC#16.1 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#16.1 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

#########################################################UI VALIDATION BASED FIRST ROW HEADER BLANK ##################################################################################################
    #Issues are there#
  @MLP-14645 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-14645:SC#16.2 Verify CSV Cataloger should collect header information as (_c0,_c1...) of the provided CSV file when few of the header values has blank, spaces,tab, morethan50 characters , duplicate and firstRowAsHeader set as true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc36CSVS3Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                            | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sampleheader-Allcombined.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | equalto50cequalto50cequalto50cequalto50cequalto50c |
      | Name                                               |
      | Cond1                                              |
      | No                                                 |
      | Count                                              |
      | _c4                                                |


  Scenario Outline: SC#16.2 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#16.2 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |

  @aws
  Scenario:SC#16.2 Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "asgqacsvtestautomation"
    Then user "Delete" a bucket "asgqacsvtestautomation" in amazon storage service

  #########################################################UI VALIDATION WHEN MANDATORY NOT FILLED AND ITEMM DELETION##################################################################################################
    ##6836404##
  @MLP-14645 @webtest @positive @regression @pluginManager
  Scenario: SC#16.3 Verify proper error message is shown if mandatory fields are not filled in CSVS3DataSource configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | CsvS3DataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |

  @webtest
  Scenario: MLP-14645:SC#16.3 Create a bucket and folder with various file formats in S3 Amazon storage1
    Given user "Create" a bucket "asgqacsvtestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix    | dirPath                     | recursive |
      | asgqacsvtestautomation | AutoTestData | ida/s3CSVPayloads/TestData/ | true      |

#    ##6836410##
#  @MLP-14645 @webtest
#  Scenario: SC40#-Verify the Analysis succeeded notification displayed in IDC UI when the CSV DataSource plugin executed without any errors - Valid Amazon CSVS3 DataSource connectivity details
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                                          | response code | response message | jsonPath                                                   |
#      | application/json | raw   | false | Post         | settings/catalogs                                                   | ida/s3CSVPayloads/catalogs/CreateS3CatalogSC1.json            | 204           |                  |                                                            |
#      |                  |       |       | Put          | settings/analyzers/CsvS3DataSource                                  | ida/s3CSVPayloads/DataSource/AmazonCSVS3DataSourceConfig.json | 204           |                  |                                                            |
#      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                                  |                                                               | 200           |                  | AmazonCSVS3DataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/CsvS3DataSource/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3DataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/CsvS3DataSource/*  | ida/s3CSVPayloads/empty.json                                  | 200           |                  |                                                            |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/CsvS3DataSource/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3DataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis CsvS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis succeeded!" notification should have content "Analysis CsvS3DataSource on LocalNode has succeeded" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CSVS3SC1"
#    Then Status code 204 must be returned
#    And user clicks on logout button


  @MLP-14645 @webtest
  Scenario: SC#16.3 Verify captions and tool tip text in AmazonCSVS3DataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | CsvS3DataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |


  ##6836407##
  @webtest
  Scenario: SC#16.3 Verify captions and tool tip text in AmazonCSVS3Cataloger
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
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | CsvS3Cataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Business Application       |
      | Mode                       |
      | Field Delimiter*           |
      | Bucket filter              |
      | Bucket names               |
      | S3 Objects filter          |
      | Directory prefixes to scan |
      | Sub Directory filter       |
      | Data Source*               |
      | Credential*                |
      | File filter                |

    ##6836412##
#  @MLP-14645 @webtest
#  Scenario: SC43#-Verify the Analysis failed notification event displayed in IDC UI when user gives invalid Secret and Access Key for Amazon CSV S3 datasource plugin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                                                            | response code | response message | jsonPath                                                                     |
#      | application/json | raw   | false | Post         | settings/catalogs                                                   | ida/s3CSVPayloads/catalogs/CreateS3CatalogSC43.json                             | 204           |                  |                                                                              |
#      |                  |       |       | Put          | settings/analyzers/CsvS3DataSource                                  | ida/s3CSVPayloads/DataSource/AmazonCSVS3InvalidCredentialsDataSourceConfig.json | 204           |                  |                                                                              |
#      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                                  |                                                                                 | 200           |                  | AmazonCSVS3InvalidCredentialsDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/CsvS3DataSource/* |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3InvalidCredentialsDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/CsvS3DataSource/*  | ida/s3CSVPayloads/empty.json                                                    | 200           |                  |                                                                              |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/CsvS3DataSource/* |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3InvalidCredentialsDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis CsvS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis CsvS3DataSource on LocalNode has failed" in the notifications tab
#    And "Analysis failed!" notification should have content "AmazonS3 connection was failed" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CSVS3SC43"
#    Then Status code 204 must be returned
#    And user clicks on logout button

  ##6838359##
  @MLP-14645 @webtest
  Scenario: SC#16.3 Verify the Amazon S3 Cataloger does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                                                            | response code | response message | jsonPath                                                                    |
      | application/json |       |       | Put          | settings/analyzers/CsvS3DataSource                                | ida/S3CSVPayloads/DataSource/AmazonCSVS3InvalidCredentialsDataSourceConfig.json                 | 204           |                  |                                                                             |
      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                                |                                                                                                 | 200           |                  | AmazonCSVS3InvalidCredentialsDataSource                                     |
      |                  |       |       | Put          | settings/analyzers/CsvS3Cataloger                                 | ida/S3CSVPayloads/PluginConfiguration/sc44AmazonCsvS3InvalidDataSourceAndCredentialsConfig.json | 204           |                  |                                                                             |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                 |                                                                                                 | 200           |                  | AmazonCSVS3InvalidCredentialsCataloger                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3InvalidCredentialsCataloger')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/S3CSVPayloads/PluginConfiguration/empty.json                                                | 200           |                  |                                                                             |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3InvalidCredentialsCataloger')].status |
    And user enters the search text "CSVER" and clicks on search
    And user performs "facet selection" in "CSVER" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CsvS3Cataloger/AmazonCSVS3InvalidCredentialsCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/CsvS3Cataloger/AmazonCSVS3InvalidCredentialsCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                            | logCode       | pluginName     | removableText |
      | INFO | Plugin CsvS3Cataloger Start Time:2020-03-15 15:37:21.021, End Time:2020-03-15 15:37:21.666, Processed Count:0, Errors:2, Warnings:0 | ANALYSIS-0072 | CsvS3Cataloger |               |
    Then Analysis log "cataloger/CsvS3Cataloger/AmazonCSVS3InvalidCredentialsCataloger%" should display below info/error/warning
      | type  | logValue                                                                | logCode     |
      | ERROR | Amazon S3 connection failed : AWS_S3-0006: Error retrieving bucket list | AWS_S3-0011 |

  Scenario Outline: SC#16.3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline: SC16.3 #user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |

  ##6838360##
  @MLP-14645 @webtest
  Scenario: SC#16.3 Verify the Amazon S3 Cataloger collect all items when an Invalid Datasource(with wrong Credentials) and Valid Credentials are used in the Plugin Configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                                                 | response code | response message | jsonPath                                                                                      |
      | application/json |       |       | Put          | settings/analyzers/CsvS3DataSource                               | ida/s3CSVPayloads/DataSource/AmazonCSVS3InvalidCredentialsDataSourceConfig.json                      | 204           |                  |                                                                                               |
      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                               |                                                                                                      | 200           |                  | AmazonCSVS3InvalidCredentialsDataSource                                                       |
      |                  |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc45AmazonCsvS3InvalidDataSourceAndValidCredentialsConfig.json | 204           |                  |                                                                                               |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                                                      | 200           |                  | AmazonCSVS3InvalidDataSourceAndValidCredentialsCataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3InvalidDataSourceAndValidCredentialsCataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                                                     | 200           |                  |                                                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3InvalidDataSourceAndValidCredentialsCataloger')].status |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    Then user "verify not displayed" for listed "Metadata Type" facet in Search results page
      | Field     |
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |


  Scenario Outline: SC#16.3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type      | targetFile                         | jsonpath            |
      | APPDBPOSTGRES | Default | asgqacsvtestautomation        | Directory | response/csvS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |           | response/csvS3/actual/itemIds.json | $..has_Analysis.id  |

  Scenario Outline: SC#16.3 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                          |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/csvS3/actual/itemIds.json |


    ##6834271##
#  @MLP-14645 @webtest
#  Scenario: SC46#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started without Credentials in Datasource (Credentials will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                                                          | response code | response message | jsonPath                                                                   |
#      | application/json | raw   | false | Post         | settings/catalogs                                                   | ida/s3CSVPayloads/catalogs/CreateS3CatalogSC46.json                           | 204           |                  |                                                                            |
#      |                  |       |       | Put          | settings/analyzers/CsvS3DataSource                                  | ida/s3CSVPayloads/DataSource/AmazonCSVS3EmptyCredentialsDataSourceConfig.json | 204           |                  |                                                                            |
#      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                                  |                                                                               | 200           |                  | AmazonCSVS3EmptyCredentialsDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/CsvS3DataSource/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3EmptyCredentialsDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/CsvS3DataSource/*  | ida/s3CSVPayloads/empty.json                                                  | 200           |                  |                                                                            |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/CsvS3DataSource/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3EmptyCredentialsDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis CsvS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis CsvS3DataSource on LocalNode has failed" in the notifications tab
#    And "Analysis failed!" notification should have content "AWS_S3-0012: AmazonS3 datasource connection failed : AWS_S3-0011: Required attribute Access key is blank" in the notifications tab
#    And user clicks on logout button
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CSVS3SC46"
#    Then Status code 204 must be returned

  ##6838366##
  @MLP-14645 @webtest
  Scenario: SC#16.3 Verify the Amazon S3 Cataloger does not collect any items when an Datasource(with Empty Credentials) and Empty Credentials are used in the Plugin Configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                                                 | response code | response message | jsonPath                                                                                      |
      | application/json |       |       | Put          | settings/analyzers/CsvS3DataSource                               | ida/s3CSVPayloads/DataSource/AmazonCSVS3EmptyCredentialsDataSourceConfig.json                        | 204           |                  |                                                                                               |
      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                               |                                                                                                      | 200           |                  | AmazonCSVS3EmptyCredentialsDataSource                                                         |
      |                  |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc47AmazonCsvS3InvalidDataSourceAndEmptyCredentialsConfig.json | 204           |                  |                                                                                               |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                                                      | 200           |                  | AmazonCSVS3EmptyCredentialsCataloger                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3InvalidDataSourceAndEmptyCredentialsCataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                                                     | 200           |                  |                                                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3InvalidDataSourceAndEmptyCredentialsCataloger')].status |
    And user enters the search text "CSVER" and clicks on search
    And user performs "facet selection" in "CSVER" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CsvS3Cataloger/AmazonCSVS3InvalidDataSourceAndEmptyCredentialsCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/CsvS3Cataloger/AmazonCSVS3InvalidDataSourceAndEmptyCredentialsCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                            | logCode       | pluginName     | removableText |
      | INFO | Plugin CsvS3Cataloger Start Time:2020-03-15 15:37:21.021, End Time:2020-03-15 15:37:21.666, Processed Count:0, Errors:2, Warnings:0 | ANALYSIS-0072 | CsvS3Cataloger |               |
    Then Analysis log "cataloger/CsvS3Cataloger/AmazonCSVS3InvalidDataSourceAndEmptyCredentialsCataloger%" should display below info/error/warning
      | type  | logValue                                                                                                    | logCode         |
      | ERROR | An error occurred while running Amazon S3 CSV Cataloger AWS_S3-0010: Required attribute Secret key is blank | AWS_S3_CSV-0002 |

  Scenario Outline: SC#16.3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline: SC#16.3 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |

    ##6838367##
#  @MLP-14645 @webtest
#  Scenario: SC48#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started with No Region(Region will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                                                      | response code | response message | jsonPath                                                               |
#      | application/json | raw   | false | Post         | settings/catalogs                                                   | ida/s3CSVPayloads/catalogs/CreateS3CatalogSC48.json                       | 204           |                  |                                                                        |
#      |                  |       |       | Put          | settings/analyzers/CsvS3DataSource                                  | ida/s3CSVPayloads/DataSource/AmazonCSVS3DataSourceWithNoRegionConfig.json | 204           |                  |                                                                        |
#      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                                  |                                                                           | 200           |                  | AmazonCSVS3DataSourceWithNoRegion                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/CsvS3DataSource/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3DataSourceWithNoRegion')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/CsvS3DataSource/*  | ida/s3CSVPayloads/empty.json                                              | 200           |                  |                                                                        |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/CsvS3DataSource/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3DataSourceWithNoRegion')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis CsvS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis CsvS3DataSource on LocalNode has failed" in the notifications tab
#    And "Analysis failed!" notification should have content "AWS_S3-0012: AmazonS3 datasource connection failed : AWS_S3-0011: Required attribute Region is blank" in the notifications tab
#    And user clicks on logout button
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CSVS3SC48"
#    Then Status code 204 must be returned


  ##6838370##
  @MLP-14645 @webtest
  Scenario: SC#16.3 Verify the Amazon S3 Cataloger does not collect any items when an Datasource(with No Region) and Valid Credentials are used in the Plugin Configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                      | response code | response message | jsonPath                                                          |
      | application/json |       |       | Put          | settings/analyzers/CsvS3DataSource                               | ida/s3CSVPayloads/DataSource/AmazonCSVS3DataSourceWithNoRegionConfig.json | 204           |                  |                                                                   |
      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                               |                                                                           | 200           |                  | AmazonCSVS3DataSourceWithNoRegion                                 |
      |                  |       |       | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc49CSVS3ConfigWithNoRegion.json    | 204           |                  |                                                                   |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                           | 200           |                  | AmazonCSVS3NoRegionCataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3NoRegionCataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                          | 200           |                  |                                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3NoRegionCataloger')].status |
    And user enters the search text "CSVER" and clicks on search
    And user performs "facet selection" in "CSVER" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CsvS3Cataloger/AmazonCSVS3NoRegionCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/CsvS3Cataloger/AmazonCSVS3NoRegionCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                            | logCode       | pluginName     | removableText |
      | INFO | Plugin CsvS3Cataloger Start Time:2020-03-15 15:37:21.021, End Time:2020-03-15 15:37:21.666, Processed Count:0, Errors:2, Warnings:0 | ANALYSIS-0072 | CsvS3Cataloger |               |
    Then Analysis log "cataloger/CsvS3Cataloger/AmazonCSVS3NoRegionCataloger%" should display below info/error/warning
      | type  | logValue                                                                                                | logCode         |
      | ERROR | An error occurred while running Amazon S3 CSV Cataloger AWS_S3-0010: Required attribute Region is blank | AWS_S3_CSV-0002 |

  Scenario Outline: SC#16.3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline: SC#16.3 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |

  ##6838448##
  @MLP-14645 @webtest
  Scenario: SC# 16.3 Verify the Amazon S3 Cataloger does not collect any items when Datasource or Credential value in null in Json
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                                               | response code | response message | jsonPath                                                                  |
      | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                | ida/s3CSVPayloads/PluginConfiguration/sc51AmazonCsvS3WithNullDataSourceConfig.json | 204           |                  |                                                                           |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                                    | 200           |                  | AmazonCSVS3CatalogWithNullDataSource                                      |
      |                  |       |       | Put          | settings/analyzers/CsvS3DataSource                               | ida/s3CSVPayloads/DataSource/AmazonCSVS3DataSourceWithNullCredentialConfig.json    | 204           |                  |                                                                           |
      |                  |       |       | Get          | settings/analyzers/CsvS3DataSource                               |                                                                                    | 200           |                  | AmazonCSVS3DataSourceWithNullCredential                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3CatalogWithNullDataSource')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/s3CSVPayloads/PluginConfiguration/empty.json                                   | 200           |                  |                                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AmazonCSVS3CatalogWithNullDataSource')].status |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVER" and clicks on search
    And user performs "facet selection" in "CSVER" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CsvS3Cataloger/AmazonCSVS3CatalogWithNullDataSource%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/CsvS3Cataloger/AmazonCSVS3CatalogWithNullDataSource%" should display below info/error/warning
      | type | logValue                                                                                                                            | logCode       | pluginName     | removableText |
      | INFO | Plugin CsvS3Cataloger Start Time:2020-03-15 15:37:21.021, End Time:2020-03-15 15:37:21.666, Processed Count:0, Errors:2, Warnings:0 | ANALYSIS-0072 | CsvS3Cataloger |               |
    Then Analysis log "cataloger/CsvS3Cataloger/AmazonCSVS3CatalogWithNullDataSource%" should display below info/error/warning
      | type  | logValue                                                                                                     | logCode         |
      | ERROR | An error occurred while running Amazon S3 CSV Cataloger AWS_S3-0010: Required attribute Data Source is blank | AWS_S3_CSV-0002 |


  Scenario Outline: SC#16.3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                          | type | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/%DYN |      | response/csvS3/actual/itemIds.json | $..has_Analysis.id |
      | APPDBPOSTGRES | Default | CSVS3_BA                      |      | response/csvS3/actual/itemIds.json | $..has_BA.id       |

  Scenario Outline: SC#16.3 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson          | inputFile                          |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..has_Analysis.id | response/csvS3/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id       | response/csvS3/actual/itemIds.json |

  @aws
  Scenario:SC#16.3 Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqacsvtestautomation"
    Then user "Delete" a bucket "asgqacsvtestautomation" in amazon storage service

  @webtest
  Scenario: MLP-14645:SC#17 Verify incremental scan works properly with CSVS3Cataloger when newly added file
    Given user "Create" a bucket "asgqacsvtestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix            | dirPath                            | recursive |
      | asgqacsvtestautomation | AutoTestData/TestCSV | ida/S3CSVPayloads/TestData/TestCSV | true      |
    And user "update" the json file "ida/s3CSVPayloads/PluginConfiguration/sc16CSVS3ConfigIncremental.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                                  | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                             | ida/s3CSVPayloads/PluginConfiguration/sc16CSVS3ConfigIncremental.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                             |                                                                       | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger  | ida/s3CSVPayloads/PluginConfiguration/empty.json                      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 7     |
    And user performs "item click" on "sample-version.csv" item from search results
    And user "store" the value of item "sample-version.csv" of attribute "Last catalogued at" with temporary text
    And user "store as Static" the value of item "sample-version.csv" of attribute "Last catalogued at" with temporary text
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix                | dirPath                                | recursive |
      | asgqacsvtestautomation | AutoTestData/Incremental | ida/s3CSVPayloads/TestData/Incremental | false     |
    And user "update" the json file "ida/s3CSVPayloads/PluginConfiguration/sc16CSVS3ConfigIncremental.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                                  | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                             | ida/s3CSVPayloads/PluginConfiguration/sc16CSVS3ConfigIncremental.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/CsvS3Cataloger                                             |                                                                       | 200           |                  | CsvS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger  |                                                                       | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3Cataloger |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CSVS3Cataloger')].status |
    And user enters the search text "CSVS3" and clicks on search
    And user performs "definite facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 8     |
    And user performs "item click" on "sample-version.csv" item from search results
    Then user "verify equals" the value of item "sample-version.csv" of attribute "Last catalogued at" with temporary text
    And user enters the search text "CSVS3" and clicks on search
    And user performs "facet selection" in "CSVS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sample-incremental.csv" item from search results
    Then user "verify not equals" the value of item "sample-incremental.csv" of attribute "Last catalogued at" with temporary text

  @aws
  Scenario:SC17#Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqacsvtestautomation"
    Then user "Delete" a bucket "asgqacsvtestautomation" in amazon storage service

  @sanity @positive @IDA_E2E
  Scenario: SC#17-Delete the Id's
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/CsvS3Cataloger/CSVS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | amazonaws.com                            | Cluster   |       |       |
      | MultipleIDDelete | Default | AmazonS3                                 | Service   |       |       |
      | MultipleIDDelete | Default | asgqacsvtestautomation                   | Directory |       |       |

  @MLP-14874 @webtest
  Scenario: SC#18 Verify whether the background of the panel is displayed in red when test connection is not successful for CsvS3DataSource in LocalNode for disabled/unsupported region
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
      | fieldName        | attribute       |
      | Data Source Type | CsvS3DataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name*     | CsvS3DataSourceTest3 |
      | Label     | CsvS3DataSourceTest3 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                        |
      | Region*     | China (Ningxia) [cn-northwest-1] |
      | Credential* | AWS_CSV_Credentials              |
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

  @Csv @positve @regression @sanity
  Scenario Outline:SC#16.3 Delete plugin Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CsvS3DataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CsvS3Cataloger                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_CSV_Credentials         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_CSV_Invalid_Credentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_CSV_EMPTY_Credentials   |      | 200           |                  |          |