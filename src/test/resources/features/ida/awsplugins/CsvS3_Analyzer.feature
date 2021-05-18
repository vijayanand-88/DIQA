@MLP-24318
Feature: Verification of CsvS3Analyzer IDA Plugin

  Pre-requisites to be done in script before every run:
  1. Give a name to create a cluster in step SC#1 (Under Pre condition)
  2. Give the same cluster name in step SC#1 for retreiving the cluster ID (Under Pre condition)
  3. Give the same cluster name in step SC#31 for terminating the cluster (Under Post condition)

  ############################################# Pre Conditions ##########################################################
  @aws @precondition
  Scenario:SC#1: Update AWS secret key and access from config file
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                         | accessKeyPath               | secretKeyPath               |
      | ida/s3CsvAnalyzerPayloads/Credentials/csvS3ValidCredentials.json | $.csvCredentials..accessKey | $.csvCredentials..secretKey |
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                         | accessKeyPath                       | secretKeyPath                       |
      | ida/s3CsvAnalyzerPayloads/Credentials/csvS3ValidCredentials.json | $.csvReadOnlyCredentials..accessKey | $.csvReadOnlyCredentials..secretKey |

  @cr-data
  Scenario Outline:SC#1: Configure the Credentials for Csv S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                               | bodyFile                                                                  | path                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidCsvReadWriteCredentials | payloads/ida/s3CsvAnalyzerPayloads/Credentials/csvS3ValidCredentials.json | $.csvCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidCsvReadOnlyCredentials  | payloads/ida/s3CsvAnalyzerPayloads/Credentials/csvS3ValidCredentials.json | $.csvReadOnlyCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/InvalidCsvCredentials        | payloads/ida/s3CsvAnalyzerPayloads/Credentials/csvS3ValidCredentials.json | $.csvInvalidCredentials  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EmptyCsvCredentials          | payloads/ida/s3CsvAnalyzerPayloads/Credentials/csvS3ValidCredentials.json | $.csvEmptyCredentials    | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials       | payloads/ida/s3CsvAnalyzerPayloads/Credentials/csvS3ValidCredentials.json | $.validEDIBusCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidCsvReadWriteCredentials |                                                                           |                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidCsvReadOnlyCredentials  |                                                                           |                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/InvalidCsvCredentials        |                                                                           |                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EmptyCsvCredentials          |                                                                           |                          | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials       |                                                                           |                          | 200           |                  |          |
#
  @cr-data
  Scenario Outline:SC#1: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3CsvAnalyzerPayloads/CsvS3AnalyzerBA.json | 200           |                  |          |

  @cr-data
  Scenario: SC#1: Configure the Csv S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                   | body                                                         | response code | response message   | jsonPath           |
      | application/json | raw   | false | Put  | settings/analyzers/CsvS3DataSource    | ida/s3CsvAnalyzerPayloads/DataSource/csvS3DataSource.json    | 204           |                    |                    |
      |                  |       |       | Get  | settings/analyzers/CsvS3DataSource    |                                                              | 200           | CsvS3DataSource    | CsvS3DataSource    |
      |                  |       |       | Put  | settings/analyzers/AmazonS3DataSource | ida/s3CsvAnalyzerPayloads/DataSource/amazonS3DataSource.json | 204           |                    |                    |
      |                  |       |       | Get  | settings/analyzers/AmazonS3DataSource |                                                              | 200           | AmazonS3DataSource | AmazonS3DataSource |

  @aws @cr-data
  Scenario: SC#1:Create a bucket and folder with csv files in S3 Amazon storage
    Given user "Create" a bucket "asgqacsvanalyzer" in amazon storage service
    Given user "Create" a bucket "asgqacsvanalyzerb2" in amazon storage service
    Given user "Create" a bucket "asg-qa-emr-csvanalyzer" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix        | dirPath                                             | recursive |
      | asgqacsvanalyzer   | TestAnalyzerAll  | ida/s3CsvAnalyzerPayloads/TestData/TestAnalyzerAll  | true      |
      | asgqacsvanalyzer   | TestDataSeperate | ida/s3CsvAnalyzerPayloads/TestData/TestDataSeperate | true      |
      | asgqacsvanalyzerb2 | TestAnalyzer     | ida/s3CsvAnalyzerPayloads/TestData/Bucket2          | true      |

#  @aws @cr-data
#  Scenario: SC#1:Create an EMR cluster or Retrieve EMR Cluster ID in Amazon EMR service
#    Given user performs the below operation related to a cluster in Amazon EMR service
#      | action                    | clusterName              | filePath                                                                                     | jsonPath        |
#      | CreateCluster             | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/ClusterData/clusterdata.json                                       |                 |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerDryRunTrue.json                   | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSC1.json                          | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSC1_HeaderTrue.json               | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerBucketInclude.json                | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerBucketExcludeRegex.json           | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerDirectoryInclude.json             | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSubDirIncludeRegex.json           | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSubDirExclude.json                | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerFileInclude.json                  | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerFileExcludeRegex.json             | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerNonExistingBucket.json            | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerNonExistingSubDir.json            | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerNonExistingFile.json              | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3Analyzer_NodeCondition_WorkingBucket.json | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerIncRunFalse.json                  | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qacsv4 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerPIITags.json                      | $..emrClusterId |

  ################### DataSource TestConnection - UI Validation Error in Mandatory Fields ####################
  #7123262#

  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in green when test connection is successful for CsvS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute       |
      | Data Source Type | CsvS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | Region*    |
      | Credential |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute           |
      | Name      | CsvS3TestDataSource |
      | Label     | CsvS3TestDataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | ValidCsvReadWriteCredentials      |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  #7123262#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in red when test connection is not successful for CsvS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute       |
      | Data Source Type | CsvS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | Region*    |
      | Credential |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name      | CsvS3DataSourceTest2 |
      | Label     | CsvS3DataSourceTest2 |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | InvalidCsvCredentials             |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute           |
      | Credential | EmptyCsvCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"

  #7123244#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#2:Verify proper error message is shown if mandatory fields are not filled in CsvS3Analyzer configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute     |
      | Type*     | Dataanalyzer  |
      | Plugin*   | CsvS3Analyzer |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Business Application       |
      | Restrict to Region*        |
      | Bucket Name*               |
      | Amazon EMR Cluster ID*     |
      | Bucket filter              |
      | Bucket names               |
      | S3 Objects filter          |
      | Directory prefixes to scan |
      | Sub Directory filter       |
      | Data Source                |
      | Credential                 |
      | File filter                |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName             | validationMessage                               |
      | Name                  | Name field should not be empty                  |
      | Bucket Name           | Bucket Name field should not be empty           |
      | Amazon EMR Cluster ID | Amazon EMR Cluster ID field should not be empty |
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ####################################### PluginRun - CsvS3Cataloger firstRowAsHeader: false ########################################
  @cr-data
  Scenario Outline: SC#3:Configure & run the CsvS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | body                                                                             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                             | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                             |                                                                                  | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |

  ######################################## PluginRun - CsvS3Analyzer - DryRun True ########################################
  #7123262#
  @cr-data
  Scenario Outline: SC#4:Configure & run the CsvS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                       | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerDryRunTrue.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                            | 200           | CsvS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                             | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |

  Scenario Outline: SC#4:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for dry run true
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                   |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id |

  @MLP-24318 @csvs3analyzer
  Scenario: SC#4:UI_Validation: Verify CsvS3Analyzer plugin functionality with dry run as true
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                           | Action                | query         | TableName/Filename                       |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_true.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |
    Then Analysis log "dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%" should display below info/error/warning
      | type | logValue                                     | logCode       | pluginName    | removableText |
      | INFO | Plugin CsvS3Analyzer running on dry run mode | ANALYSIS-0069 | CsvS3Analyzer |               |

  Scenario Outline: SC#4:ItemDeletion: User deletes the CsvS3Analyzer analysis item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                  | inputFile                                  |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |

  ####################################### Invalid EMR Cluster ID ########################################
  #7123241#

  @cr-data
  Scenario Outline: SC#5:Configure & run the CsvS3Analyzer with Invalid EMR Cluster ID
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                              | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerInvalidEMRCluster.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                   | 200           | CsvS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                    | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |

  Scenario Outline: SC#5:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for Invalid EMR Cluster ID
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                   |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id |

  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#5:Verify CsvS3Analyzer is not executed successfully even when Invalid EMR Cluster ID is passed as input.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                             | Action                | query         | TableName/Filename                       |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_Invalid_EMRID.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |
    Then Analysis log "dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%" should display below info/error/warning
      | type  | logValue                                                                                    | logCode     | pluginName | removableText |
      | ERROR | An error occurred while running Amazon S3 analyzer plugin: Specified job flow ID not valid. | AWS_S3-0014 |            |               |

  Scenario Outline: SC#5:ItemDeletion: User deletes the CsvS3Analyzer analysis item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                  | inputFile                                  |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |

  ######################################## PluginRun - CsvS3Analyzer - DryRun False ########################################
  @cr-data
  Scenario Outline: SC#6:Configure & run the CsvS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSC1.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                     | 200           | CsvS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |

  Scenario Outline: SC#6:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for dry run false
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  ############################ Logging Enhancements ############################
  #7123262#
  @MLP-24318 @csvs3analyzer
  Scenario: SC#7:LoggingEnhancements: Verify CsvS3Analyzer collects Analysis item with proper log messages
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                            | Action                | query         | TableName/Filename                       |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_false.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |
    Then Analysis log "dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                 | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                           | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:CsvS3Analyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:317c69aea289, Plugin Configuration name:CsvS3Analyzer | ANALYSIS-0071 | CsvS3Analyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: ---  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: name: "CsvS3Analyzer"  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: pluginVersion: "LATEST"  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: label:  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: : ""  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: catalogName: "Default"  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: eventClass: null  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: eventCondition: null  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: maxWorkSize: 100  2020-07-09 10:17:12.523 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: tags:  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: - "AnalyzeCsvS3"  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: pluginType: "dataanalyzer"  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: dataSource: "CsvS3DataSource"  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: credential: "ValidCsvReadWriteCredentials"  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: businessApplicationName: "Test_BA_CsvS3Analyzer"  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: dryRun: false  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: schedule: null  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: filter: null  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: bucketName: "asg-qa-emr-csvanalyzer"  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: cleanupAfterRun: true  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: incremental: true  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: type: "Dataanalyzer"  2020-07-09 10:17:12.524 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: restrictRegion: "us-east-1"  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: emrClusterId: "j-3S9PUCSVP0SZF"  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: histogramBuckets: 100  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: pluginName: "CsvS3Analyzer"  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: delimiter: ","  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: bucketFilter:  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: mode: "INCLUDE"  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: patterns: []  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: objectFilter:  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: dirFilter:  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: mode: "INCLUDE"  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: patterns: []  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: fileFilter:  2020-07-09 10:17:12.525 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: mode: "INCLUDE"  2020-07-09 10:17:12.526 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: patterns: []  2020-07-09 10:17:12.526 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: dirPrefixes: []  2020-07-09 10:17:12.526 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: dataSampleSize: 25  2020-07-09 10:17:12.526 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: topValues: 10  2020-07-09 10:17:12.526 INFO  - ANALYSIS-0073: Plugin CsvS3Analyzer Configuration: firstRowAsHeader: false | ANALYSIS-0073 | CsvS3Analyzer | emrClusterId   |
      | INFO | Plugin CsvS3Analyzer Start Time:2021-05-06 03:48:26.765, End Time:2021-05-06 03:53:25.947, Errors:0, Warnings:0                                                          | ANALYSIS-0072 | CsvS3Analyzer |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:04:59.182)                                                                                                           | ANALYSIS-0020 |               |                |

  ############################ UI Validation ############################
  #7123228#
  @MLP-24318 @csvs3analyzer
  Scenario:SC#8:Verify the 'Number of rows' and 'Last analyzed at' attribute for File type after CsvS3Analyzer is executed.
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                            | jsonPath                | Action                    | query     | TableName/Filename      | ClusterName   | ServiceName | directoryName |
      | Lifecycle  | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle  | metadataAttributePresence | FileQuery | hugeData_withHeader.csv | amazonaws.com | AmazonS3    | csv           |
      | Statistics | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Statistics | metadataValuePresence     | FileQuery | hugeData_withHeader.csv | amazonaws.com | AmazonS3    | csv           |

 ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @csvs3analyzer
  Scenario Outline:SC9:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid            | targetFile                                        | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | all  | csvExampleEmployee.csv | payloads/ida/s3CsvAnalyzerPayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @csvs3analyzer
  Scenario Outline: SC9:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                         | outPutFile                                               | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/s3CsvAnalyzerPayloads/API/items.json | payloads\ida\s3CsvAnalyzerPayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @csvs3analyzer
  Scenario: SC#9 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\s3CsvAnalyzerPayloads\API\Actual\File1.json" should be same as the content in "ida\s3CsvAnalyzerPayloads\API\Expected\File1.json"

    ############################################################### Data Profiling #########################################################################################

  #7110818# #7110821#
  @MLP-23701 @csvs3analyzer
  Scenario:SC#10:Verify the data profiling metadata information for string datatype in S3 Csv file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query          | TableName/Filename    | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_1 | metadataValuePresence | FileFieldQuery | combo_csvEmployee.csv | amazonaws.com | AmazonS3    | combo         | _c0                  |
      | Statistics  | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_1  | metadataValuePresence | FileFieldQuery | combo_csvEmployee.csv | amazonaws.com | AmazonS3    | combo         | _c0                  |

  #7123230# #7123232#
  @MLP-24318 @csvs3analyzer
  Scenario:SC#11:Verify the data profiling metadata information for numeric datatype in S3 CSV file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query          | TableName/Filename | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_2 | metadataValuePresence | FileFieldQuery | usertag_1.csv      | amazonaws.com | AmazonS3    | combo         | _c0                  |
      | Statistics  | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_2  | metadataValuePresence | FileFieldQuery | usertag_1.csv      | amazonaws.com | AmazonS3    | combo         | _c0                  |

  #7123262#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#12:Verify breadcrumb hierarchy appears correctly in CsvS3Analyzer analyzed items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "AnalyzeCsvS3" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "usertag_1.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "_c12" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com    |
      | AmazonS3         |
      | asgqacsvanalyzer |
      | TestDataSeperate |
      | csv              |
      | usertag_1.csv    |
      | _c12             |
    And user clicks on logout button

  ############################ Tags verification ############################
  #7123262#
  @MLP-24318 @csvs3analyzer
  Scenario: SC#13:Tech_tags_Explicit_Tags verification: Verify the technology tags, Business Application, Explicit tags got assigned to the analyzed items
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename          | Column | Tags                                                          | Query     | Action         |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv |        | AnalyzeCsvS3,CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV,Amazon S3 | FileQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | usertag_1.csv               |        | Data Files                                                    | FileQuery | TagNotAssigned |

  ############################ EDIBus verification ############################
  #7123262#
#  @MLP-24318 @webtest @csvs3analyzer @edibus
#  Scenario: SC#14:Verify the Csv S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "CatalogCsvS3" and clicks on search
#    And user performs "facet selection" in "CatalogCsvS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "CSV" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#      | Field     |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/datasource/EDIBusDS_CsvS3Analyzer.json" file for following values using property loader
#      | jsonPath        | jsonValues  |
#      | $..['EDI host'] | EDIHostName |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                      | body                                                      | response code | response message | jsonPath                                                 |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                      | idc/EdiBusPayloads/datasource/EDIBusDS_CsvS3Analyzer.json | 204           |                  |                                                          |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/CsvS3AnalyzerEDIConfig.json            | 204           |                  |                                                          |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusCsvS3Analyzer |                                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusCsvS3Analyzer')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusCsvS3Analyzer  |                                                           | 200           |                  |                                                          |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusCsvS3Analyzer |                                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusCsvS3Analyzer')].status |
#    And user enters the search text "EDIBusCsvS3Analyzer" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusCsvS3Analyzer%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "AnalyzeCsvS3" and clicks on search
#    And user performs "facet selection" in "AnalyzeCsvS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "CSV" attribute under "Tags" facets in Item Search results page
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
#      | Header | Query | Param | type | url                                                                                                         | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AnalyzeCsvS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "AnalyzeCsvS3" and clicks on search
#    And user performs "facet selection" in "AnalyzeCsvS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "CSV" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @*CSV≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | S3CSV       | 1.0                | (XNAME * *  ~/ @*CSV≫DEFAULT≫DWR_DAT_FIELD≫@* ),AND,( TYPE = DWR_IDC ) |

  Scenario Outline: SC#14:user deletes the SC1 item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  ######################################## PluginRun - CsvS3Cataloger firstRowAsHeader: true ########################################
  @cr-data
  Scenario Outline: SC#15:Configure & run the CsvS3Cataloger with firstRowAsHeader: true and CsvS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                            | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderTrue.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                 | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                  | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSC1.json             | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                 | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                  | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#15:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for dry run false
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  ############################ UI Validation ############################
  #7123228#
  @MLP-24318 @csvs3analyzer
  Scenario:SC#16:Verify the 'Number of rows' and 'Last analyzed at' attribute for File type after CsvS3Analyzer is executed with firstRowAsHeader: true in CsvS3Cataloger.
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                            | jsonPath                 | Action                    | query     | TableName/Filename      | ClusterName   | ServiceName | directoryName |
      | Lifecycle  | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle   | metadataAttributePresence | FileQuery | hugeData_withHeader.csv | amazonaws.com | AmazonS3    | csv           |
      | Statistics | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Statistics1 | metadataValuePresence     | FileQuery | hugeData_withHeader.csv | amazonaws.com | AmazonS3    | csv           |

 ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @csvs3analyzer
  Scenario Outline:SC#17:Verify the Data Sampling tab displays proper data of the file after CsvS3Analyzer is executed with firstRowAsHeader: true in CsvS3Cataloger.
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid            | targetFile                                        | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | all  | csvExampleEmployee.csv | payloads/ida/s3CsvAnalyzerPayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @csvs3analyzer
  Scenario Outline: SC17:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                         | outPutFile                                               | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/s3CsvAnalyzerPayloads/API/items.json | payloads\ida\s3CsvAnalyzerPayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @csvs3analyzer
  Scenario: SC17 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\s3CsvAnalyzerPayloads\API\Actual\File1.json" should be same as the content in "ida\s3CsvAnalyzerPayloads\API\Expected\File1.json"

    ############################################################### Data Profiling #########################################################################################

  #7110818# #7110821#
  @MLP-23701 @csvs3analyzer
  Scenario:SC#18:Verify the data profiling metadata information for string datatype in S3 CSV file with firstRowAsHeader: true in CsvS3Cataloger
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query          | TableName/Filename      | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_1 | metadataValuePresence | FileFieldQuery | hugeData_withHeader.csv | amazonaws.com | AmazonS3    | combo         | Column9              |
      | Statistics  | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_5  | metadataValuePresence | FileFieldQuery | hugeData_withHeader.csv | amazonaws.com | AmazonS3    | combo         | Column9              |

  #7123230# #7123232#
  @MLP-24318 @csvs3analyzer
  Scenario:SC#19:Verify the data profiling metadata information for numeric datatype in S3 CSV file with firstRowAsHeader: true in CsvS3Cataloger
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query          | TableName/Filename          | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_2 | metadataValuePresence | FileFieldQuery | tagdetails_allmatch_csv.csv | amazonaws.com | AmazonS3    | csv           | EMPLOYEEID           |
      | Statistics  | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_6  | metadataValuePresence | FileFieldQuery | tagdetails_allmatch_csv.csv | amazonaws.com | AmazonS3    | csv           | EMPLOYEEID           |

  Scenario Outline: SC#19:user deletes the item from database using dynamic id stored in json with firstRowAsHeader: true in CsvS3Cataloger
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |


  ############################################# Filter Scenarios ##########################################################
  #Filter - Bucket Include#
  @cr-data
  Scenario Outline: SC#20:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: Bucket Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                  | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerBucketInclude.json    | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                  | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#20:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for filters - BucketName Include
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123233#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#20: Verify CsvS3Analyzer is executed successfully with filters - BucketName Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | usertag.csv                                         |
      | usertag_1.csv                                       |
      | hugeData_withHeader.csv                             |
      | hugeData_withoutHeader.csv                          |
      | tagdetails_allmatch_csv.csv                         |
      | tagdetails_allempty_csv.csv                         |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv   |
      | combo_csvEmployee.csv                               |
      | csvExampleEmployee.csv                              |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_csvEmployee.csv |
    And user enters the search text "AnalyzeCsvS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hugeData_withHeader.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogCsvS3" and clicks on search
    And user performs "facet selection" in "CatalogCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "b2_csvEmployee.csv" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                              | fileName                | userTag                   |
      | Default     | File | Metadata Type | AnalyzeCsvS3BucketInclude,CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV | hugeData_withHeader.csv | AnalyzeCsvS3BucketInclude |
      | Default     | File | Metadata Type | CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV                           | b2_csvEmployee.csv      | CatalogCsvS3              |
    And user clicks on logout button

  Scenario Outline: SC#20:user deletes the item from database using dynamic id stored in json for filters - BucketName Include
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  #Filter - Bucket Exclude#
  @cr-data
  Scenario Outline: SC#21:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: Bucket Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                               | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json   | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                    | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerBucketExcludeRegex.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                    | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#21:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for filters - Bucket Exclude Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123234#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#21: Verify CsvS3Analyzer is executed successfully with filters - Bucket Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3BucketExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3BucketExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | b2_csvEmployee.csv |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | usertag.csv                                         |
      | usertag_1.csv                                       |
      | hugeData_withHeader.csv                             |
      | hugeData_withoutHeader.csv                          |
      | tagdetails_allmatch_csv.csv                         |
      | tagdetails_allempty_csv.csv                         |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv   |
      | combo_csvEmployee.csv                               |
      | csvExampleEmployee.csv                              |
    And user performs "item click" on "b2_csvEmployee.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogCsvS3" and clicks on search
    And user performs "facet selection" in "CatalogCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hugeData_withHeader.csv" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                              | fileName                | userTag                   |
      | Default     | File | Metadata Type | AnalyzeCsvS3BucketExclude,CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV | b2_csvEmployee.csv      | AnalyzeCsvS3BucketExclude |
      | Default     | File | Metadata Type | CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV                           | hugeData_withHeader.csv | CatalogCsvS3              |
    And user clicks on logout button

  Scenario Outline: SC#21:user deletes the item from database using dynamic id stored in json for filters - Bucket Exclude Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  #Filter - Directory Include#
  @cr-data
  Scenario Outline: SC#22:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: Bucketname (Include)/Directory
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                  | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerDirectoryInclude.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                  | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#22:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for filters - Bucketname (Include)/Directory
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123235#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#22:Verify CsvS3Cataloger is executed successfully with filters - Bucketname (Include)/Directory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3DirectoryInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3DirectoryInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | csvExampleEmployee.csv |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_csvEmployee.csv                                  |
      | usertag.csv                                         |
      | usertag_1.csv                                       |
      | hugeData_withHeader.csv                             |
      | hugeData_withoutHeader.csv                          |
      | tagdetails_allmatch_csv.csv                         |
      | tagdetails_allempty_csv.csv                         |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv   |
      | combo_csvEmployee.csv                               |
    And user performs "item click" on "csvExampleEmployee.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogCsvS3" and clicks on search
    And user performs "facet selection" in "CatalogCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "b2_csvEmployee.csv" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                 | fileName                    | userTag                      |
      | Default     | File | Metadata Type | AnalyzeCsvS3DirectoryInclude,CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV | csvExampleEmployee.csv      | AnalyzeCsvS3DirectoryInclude |
      | Default     | File | Metadata Type | CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV                              | tagdetails_allempty_csv.csv | CatalogCsvS3                 |
    And user clicks on logout button

  Scenario Outline: SC#22:user deletes the item from database using dynamic id stored in json for filters - Bucketname (Include)/Directory
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  #Filter - Sub Directory Include#
  @cr-data
  Scenario Outline: SC#23:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: Bucket Include & SubDirectory Include Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                               | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json   | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                    | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSubDirIncludeRegex.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                    | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#23:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for filters - Bucket Include & SubDirectory Include Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123236#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#23: Verify CsvS3Cataloger is executed successfully with filters - Bucket Include & SubDirectory Include Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3SubDirInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3SubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | usertag.csv                                         |
      | usertag_1.csv                                       |
      | hugeData_withHeader.csv                             |
      | hugeData_withoutHeader.csv                          |
      | tagdetails_allmatch_csv.csv                         |
      | tagdetails_allempty_csv.csv                         |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv   |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_csvEmployee.csv     |
      | combo_csvEmployee.csv  |
      | csvExampleEmployee.csv |
    And user enters the search text "AnalyzeCsvS3SubDirInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3SubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hugeData_withHeader.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogCsvS3" and clicks on search
    And user performs "facet selection" in "CatalogCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_csvEmployee.csv" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                              | fileName                | userTag                   |
      | Default     | File | Metadata Type | AnalyzeCsvS3SubDirInclude,CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV | hugeData_withHeader.csv | AnalyzeCsvS3SubDirInclude |
      | Default     | File | Metadata Type | CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV                           | combo_csvEmployee.csv   | CatalogCsvS3              |
    And user clicks on logout button

  Scenario Outline: SC#23:user deletes the item from database using dynamic id stored in json for filters - Bucket Include & SubDirectory Include Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  #Filter - SubDirectory Exclude#
  @cr-data
  Scenario Outline: SC#24:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: Bucket Include & SubDirectory Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                  | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSubDirExclude.json    | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                  | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#24:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for filters - Bucket Include & SubDirectory Exclude
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123237#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#24: Verify CsvS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3SubDirExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3SubDirExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | combo_csvEmployee.csv  |
      | csvExampleEmployee.csv |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_csvEmployee.csv                                  |
      | usertag.csv                                         |
      | usertag_1.csv                                       |
      | hugeData_withHeader.csv                             |
      | hugeData_withoutHeader.csv                          |
      | tagdetails_allmatch_csv.csv                         |
      | tagdetails_allempty_csv.csv                         |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv   |
    And user performs "item click" on "combo_csvEmployee.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogCsvS3" and clicks on search
    And user performs "facet selection" in "CatalogCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hugeData_withHeader.csv" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                              | fileName                | userTag                   |
      | Default     | File | Metadata Type | AnalyzeCsvS3SubDirExclude,CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV | combo_csvEmployee.csv   | AnalyzeCsvS3SubDirExclude |
      | Default     | File | Metadata Type | CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV                           | hugeData_withHeader.csv | CatalogCsvS3              |
    And user clicks on logout button

  Scenario Outline: SC#24:user deletes the item from database using dynamic id stored in json for filters - Bucket Include & SubDirectory Exclude
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  #Filter - File Include#
  @cr-data
  Scenario Outline: SC#25:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: File Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                  | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerFileInclude.json      | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                  | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#25:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for filters - File Include
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123238#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#25: Verify CsvS3Analyzer is executed successfully with filters - File Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3FileInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3FileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | hugeData_withHeader.csv |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_csvEmployee.csv                                  |
      | combo_csvEmployee.csv                               |
      | csvExampleEmployee.csv                              |
      | usertag.csv                                         |
      | usertag_1.csv                                       |
      | hugeData_withoutHeader.csv                          |
      | tagdetails_allmatch_csv.csv                         |
      | tagdetails_allempty_csv.csv                         |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv   |
    And user performs "item click" on "hugeData_withHeader.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogCsvS3" and clicks on search
    And user performs "facet selection" in "CatalogCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_csvEmployee.csv" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                            | fileName                | userTag                 |
      | Default     | File | Metadata Type | AnalyzeCsvS3FileInclude,CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV | hugeData_withHeader.csv | AnalyzeCsvS3FileInclude |
      | Default     | File | Metadata Type | CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV                         | combo_csvEmployee.csv   | CatalogCsvS3            |
    And user clicks on logout button

  Scenario Outline: SC#25:user deletes the item from database using dynamic id stored in json for filters - File Include
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  #Filter - File Exclude#
  @cr-data
  Scenario Outline: SC#26:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: File Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                  | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerFileExcludeRegex.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                  | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#26:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for filters - File Exclude Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123239#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#26: Verify CsvS3Analyzer is executed successfully with filters - File Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3FileExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3FileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | usertag.csv                |
      | usertag_1.csv              |
      | hugeData_withHeader.csv    |
      | hugeData_withoutHeader.csv |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_csvEmployee.csv                                  |
      | combo_csvEmployee.csv                               |
      | csvExampleEmployee.csv                              |
      | tagdetails_allmatch_csv.csv                         |
      | tagdetails_allempty_csv.csv                         |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv   |
    And user performs "item click" on "hugeData_withHeader.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogCsvS3" and clicks on search
    And user performs "facet selection" in "CatalogCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_csvEmployee.csv" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                            | fileName                | userTag                 |
      | Default     | File | Metadata Type | AnalyzeCsvS3FileExclude,CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV | hugeData_withHeader.csv | AnalyzeCsvS3FileExclude |
      | Default     | File | Metadata Type | CatalogCsvS3,Test_BA_CsvS3Analyzer,CSV                         | combo_csvEmployee.csv   | CatalogCsvS3            |
    And user clicks on logout button

  Scenario Outline: SC#26:user deletes the item from database using dynamic id stored in json for filters - File Exclude Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  ############################################# Node Condition Internal Node ##########################################################
  @cr-data
  Scenario Outline: SC#27:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: Specific Node condition and non-existing working bucket name
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                                         | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                                 | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3Cataloger_NodeCondition.json              | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                                 |                                                                                              | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                               | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                                  | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3Analyzer_NodeCondition_WorkingBucket.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                                  |                                                                                              | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                               | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#27:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for scenario: Specific Node condition and non-existing working bucket name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123262# #7123243#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#27: Verify CsvS3Cataloger is executed successfully for scenario: Specific Node condition and non-existing working bucket name
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3NodeCondition" and clicks on search
    And user performs "facet selection" in "AnalyzeCsvS3NodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | usertag.csv                                         |
      | usertag_1.csv                                       |
      | hugeData_withHeader.csv                             |
      | hugeData_withoutHeader.csv                          |
      | b2_csvEmployee.csv                                  |
      | combo_csvEmployee.csv                               |
      | csvExampleEmployee.csv                              |
      | tagdetails_allmatch_csv.csv                         |
      | tagdetails_allempty_csv.csv                         |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv   |
    And user clicks on logout button

  Scenario Outline: SC#27:user deletes the item from database using dynamic id stored in json for scenario: Specific Node condition and non-existing working bucket name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  ######################################## Non existing buckets/ sub-directory/ file ########################################
  #7130714#
  @cr-data
  Scenario Outline: SC#28:Configure & run the CsvS3Cataloger and CsvS3Analyzer for Non existing buckets
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                              | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderFalse.json  | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                   | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                    | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerNonExistingBucket.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                   | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                    | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  Scenario Outline: SC#28:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for Non existing buckets
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                        | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                               |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  @MLP-24318 @csvs3analyzer
  Scenario: SC#28:Verify the error message in logs when CsvS3Analyzer is executed with Non existing buckets in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |
    Then Analysis log "dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#28:Configure & run the CsvS3Analyzer for Non existing sub directories
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                              | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerNonExistingSubDir.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                   | 200           | CsvS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                    | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |

  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#28:Verify the error message in logs when CsvS3Analyzer is executed with Non existing sub directory in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |
    Then Analysis log "dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#28:Configure & run the CsvS3Analyzer for Non existing file
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                            | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerNonExistingFile.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                                 | 200           | CsvS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                                  | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |

  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#28:Verify the error message in logs when CsvS3Analyzer is executed with Non existing file in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |
    Then Analysis log "dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  Scenario Outline: SC#28:ItemDeletion: User deletes the CsvS3Analyzer analysis item with dry run as true from database using dynamic id stored in json for Non existing buckets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |

  Scenario:SC#28:Delete all the CsvS3Analyzer analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer% | Analysis |       |       |

  ############################################# Policy Patterns - PII Tagging ##########################################################
  Scenario Outline:SC#29:Create root tag and sub tag for CsvS3 and Update policy tags for CsvS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/s3CsvAnalyzerPayloads/policyEngine/csvS3TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/s3CsvAnalyzerPayloads/policyEngine/csvS3_policy1.1.0.json | 204           |                  |          |

  @cr-data
  Scenario Outline: SC#29:Configure & run the CsvS3Cataloger and CsvS3Analyzer for scenario: Policy Patterns - PII Tagging
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                    | response code | response message | jsonPath                                           |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerSC1_HeaderTrue.json | 204           |                  |                                                     |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                                 | 200           | CsvS3Cataloger   |                                                     |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                                  | 200           |                  |                                                     |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerPIITags.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                         | 200           | CsvS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                          | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status |

  Scenario Outline: SC#29:RetrieveItemID: User retrieves the item ids of analysis of CsvS3Analyzer and copy them to a json file for Policy Patterns - PII Tagging
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                         | type | targetFile                                 | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                |      | response/csvS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN  |      | response/csvS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%DYN |      | response/csvS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123246# #7123247# #7123248# #7123249# #7123256# #7123257# #7123258# #7123253#
  @MLP-24318 @webtest @csvs3analyzer @PIITag
  Scenario: SC#29: Verify PII Tags gets assigned to the below fields in file: tagdetails_allmatch_csv.csv
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename          | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | GENDER    | CsvS3GenderPII_SC1Tag,CsvS3GenderPII_SC3Tag,CsvS3GenderPII_SC8Tag,CSV,Amazon S3                                                 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | FULL_NAME | CsvS3FullNamePII_SC1Tag,CsvS3FullNamePII_SC3Tag,CsvS3FullNamePII_SC8Tag,CSV,Amazon S3                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | SSN       | CsvS3SSNPII_SC1Tag,CsvS3SSNPII_SC3Tag,CsvS3SSNPII_SC8Tag,CSV,Amazon S3                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC1Tag,CsvS3IPAddressPII_SC3Tag,CsvS3IPAddressPII_SC8Tag,CSV,Amazon S3                                        | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | GENDER    | CsvS3GenderPII_SC2Tag,CsvS3GenderPII_SC4Tag,CsvS3GenderPII_SC11Tag,CsvS3GenderPII_SC12Tag,CsvS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | EMAIL     | CsvS3EmailPII_SC2Tag,CsvS3EmailPII_SC4Tag,CsvS3EmailPII_SC11Tag,CsvS3EmailPII_SC12Tag,CsvS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | FULL_NAME | CsvS3FullNamePII_SC2Tag,CsvS3FullNamePII_SC4Tag,CsvS3FullNamePII_SC11Tag,CsvS3FullNamePII_SC12Tag,CsvS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | SSN       | CsvS3SSNPII_SC2Tag,CsvS3SSNPII_SC4Tag,CsvS3SSNPII_SC11Tag,CsvS3SSNPII_SC12Tag,CsvS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allmatch_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC2Tag,CsvS3IPAddressPII_SC4Tag,CsvS3IPAddressPII_SC11Tag,CsvS3IPAddressPII_SC12Tag,CsvS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7123246# #7123247# #7123248# #7123249# #7123259# #7123256# #7123257# #7123258#
  @MLP-24318 @webtest @csvs3analyzer @PIITag
  Scenario: SC#31: Verify PII Tags gets assigned to the below fields in file: tagdetails_allempty_csv.csv
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename          | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allempty_csv.csv | SSN       | CsvS3SSNPII_SC1Tag,CsvS3SSNPII_SC3Tag,CsvS3SSNPII_SC14Tag,CSV,Amazon S3                                                         | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allempty_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC1Tag,CsvS3IPAddressPII_SC3Tag,CsvS3IPAddressPII_SC14Tag,CSV,Amazon S3                                       | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allempty_csv.csv | GENDER    | CsvS3GenderPII_SC2Tag,CsvS3GenderPII_SC4Tag,CsvS3GenderPII_SC11Tag,CsvS3GenderPII_SC12Tag,CsvS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allempty_csv.csv | EMAIL     | CsvS3EmailPII_SC2Tag,CsvS3EmailPII_SC4Tag,CsvS3EmailPII_SC11Tag,CsvS3EmailPII_SC12Tag,CsvS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allempty_csv.csv | FULL_NAME | CsvS3FullNamePII_SC2Tag,CsvS3FullNamePII_SC4Tag,CsvS3FullNamePII_SC11Tag,CsvS3FullNamePII_SC12Tag,CsvS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allempty_csv.csv | SSN       | CsvS3SSNPII_SC2Tag,CsvS3SSNPII_SC4Tag,CsvS3SSNPII_SC11Tag,CsvS3SSNPII_SC12Tag,CsvS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_allempty_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC2Tag,CsvS3IPAddressPII_SC4Tag,CsvS3IPAddressPII_SC11Tag,CsvS3IPAddressPII_SC12Tag,CsvS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7123246# #7123247# #7123248# #7123249# #7123256# #7123257# #7123258# #7123255# #7123250#
  @MLP-24318 @webtest @csvs3analyzer @PIITag
  Scenario: SC#31: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolessthan05emptyfalse_csv.csv
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                           | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | GENDER    | CsvS3GenderPII_SC1Tag,CsvS3GenderPII_SC3Tag,CsvS3GenderPII_SC5Tag,CsvS3GenderPII_SC10Tag,CSV,Amazon S3                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | FULL_NAME | CsvS3FullNamePII_SC5Tag,CsvS3FullNamePII_SC10Tag,CSV,Amazon S3                                                                  | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | SSN       | CsvS3SSNPII_SC5Tag,CsvS3SSNPII_SC10Tag,CSV,Amazon S3                                                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC1Tag,CsvS3IPAddressPII_SC3Tag,CsvS3IPAddressPII_SC5Tag,CsvS3IPAddressPII_SC10Tag,CSV,Amazon S3              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | GENDER    | CsvS3GenderPII_SC2Tag,CsvS3GenderPII_SC4Tag,CsvS3GenderPII_SC11Tag,CsvS3GenderPII_SC12Tag,CsvS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | EMAIL     | CsvS3EmailPII_SC2Tag,CsvS3EmailPII_SC4Tag,CsvS3EmailPII_SC11Tag,CsvS3EmailPII_SC12Tag,CsvS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | FULL_NAME | CsvS3FullNamePII_SC2Tag,CsvS3FullNamePII_SC4Tag,CsvS3FullNamePII_SC11Tag,CsvS3FullNamePII_SC12Tag,CsvS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | SSN       | CsvS3SSNPII_SC2Tag,CsvS3SSNPII_SC4Tag,CsvS3SSNPII_SC11Tag,CsvS3SSNPII_SC12Tag,CsvS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolessthan05emptyfalse_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC2Tag,CsvS3IPAddressPII_SC4Tag,CsvS3IPAddressPII_SC11Tag,CsvS3IPAddressPII_SC12Tag,CsvS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7123246# #7123247# #7123248# #7123249# #7123256# #7123257# #7123258# #7123251# #7123252#
  @MLP-24318 @webtest @csvs3analyzer @PIITag
  Scenario: SC#32: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                  | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | GENDER    | CsvS3GenderPII_SC1Tag,CsvS3GenderPII_SC3Tag,CsvS3GenderPII_SC7Tag,CSV,Amazon S3                                                 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | FULL_NAME | CsvS3FullNamePII_SC1Tag,CsvS3FullNamePII_SC3Tag,CsvS3FullNamePII_SC7Tag,CSV,Amazon S3                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | SSN       | CsvS3SSNPII_SC1Tag,CsvS3SSNPII_SC3Tag,CsvS3SSNPII_SC7Tag,CSV,Amazon S3                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC1Tag,CsvS3IPAddressPII_SC3Tag,CsvS3IPAddressPII_SC6Tag,CsvS3IPAddressPII_SC7Tag,CSV,Amazon S3               | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | GENDER    | CsvS3GenderPII_SC2Tag,CsvS3GenderPII_SC4Tag,CsvS3GenderPII_SC11Tag,CsvS3GenderPII_SC12Tag,CsvS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | EMAIL     | CsvS3EmailPII_SC2Tag,CsvS3EmailPII_SC4Tag,CsvS3EmailPII_SC11Tag,CsvS3EmailPII_SC12Tag,CsvS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | FULL_NAME | CsvS3FullNamePII_SC2Tag,CsvS3FullNamePII_SC4Tag,CsvS3FullNamePII_SC11Tag,CsvS3FullNamePII_SC12Tag,CsvS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | SSN       | CsvS3SSNPII_SC2Tag,CsvS3SSNPII_SC4Tag,CsvS3SSNPII_SC11Tag,CsvS3SSNPII_SC12Tag,CsvS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC2Tag,CsvS3IPAddressPII_SC4Tag,CsvS3IPAddressPII_SC11Tag,CsvS3IPAddressPII_SC12Tag,CsvS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7123246# #7123247# #7123248# #7123249# #7123256# #7123257# #7123258# #7123254#
  @MLP-24318 @webtest @csvs3analyzer @PIITag
  Scenario: SC#33: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratioequalto05emptyfalse_csv.csv
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                          | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | GENDER    | CsvS3GenderPII_SC1Tag,CsvS3GenderPII_SC3Tag,CsvS3GenderPII_SC9Tag,CSV,Amazon S3                                                 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | FULL_NAME | CsvS3FullNamePII_SC1Tag,CsvS3FullNamePII_SC3Tag,CsvS3FullNamePII_SC9Tag,CSV,Amazon S3                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | SSN       | CsvS3SSNPII_SC1Tag,CsvS3SSNPII_SC3Tag,CsvS3SSNPII_SC9Tag,CSV,Amazon S3                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC1Tag,CsvS3IPAddressPII_SC3Tag,CsvS3IPAddressPII_SC9Tag,CSV,Amazon S3                                        | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | GENDER    | CsvS3GenderPII_SC2Tag,CsvS3GenderPII_SC4Tag,CsvS3GenderPII_SC11Tag,CsvS3GenderPII_SC12Tag,CsvS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | EMAIL     | CsvS3EmailPII_SC2Tag,CsvS3EmailPII_SC4Tag,CsvS3EmailPII_SC11Tag,CsvS3EmailPII_SC12Tag,CsvS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | FULL_NAME | CsvS3FullNamePII_SC2Tag,CsvS3FullNamePII_SC4Tag,CsvS3FullNamePII_SC11Tag,CsvS3FullNamePII_SC12Tag,CsvS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | SSN       | CsvS3SSNPII_SC2Tag,CsvS3SSNPII_SC4Tag,CsvS3SSNPII_SC11Tag,CsvS3SSNPII_SC12Tag,CsvS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratioequalto05emptyfalse_csv.csv | IPADDRESS | CsvS3IPAddressPII_SC2Tag,CsvS3IPAddressPII_SC4Tag,CsvS3IPAddressPII_SC11Tag,CsvS3IPAddressPII_SC12Tag,CsvS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7123260#
  @MLP-24318 @webtest @csvs3analyzer @PIITag
  Scenario: SC#34: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05matchfulltrue_csv.csv
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                 | Column   | Tags                                   | Query          | Action         |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv | COMMENTS | CsvS3FullMatchPII_SC2Tag,CSV,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv | COMMENTS | CsvS3FullMatchPII_SC1Tag               | FileFieldQuery | TagNotAssigned |

  #7123261#
  @MLP-24318 @webtest @csvs3analyzer @PIITag
  Scenario: SC#35: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolesserthan05matchfulltrue_csv.csv
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                | Column   | Tags                                   | Query          | Action         |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolesserthan05matchfulltrue_csv.csv | COMMENTS | CsvS3FullMatchPII_SC4Tag,CSV,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | csv           | tagdetails_ratiolesserthan05matchfulltrue_csv.csv | COMMENTS | CsvS3FullMatchPII_SC3Tag               | FileFieldQuery | TagNotAssigned |

  Scenario Outline: SC#35:user deletes the item from database using dynamic id stored in json for scenario: Policy Patterns - PII Tagging
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                  |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/csvS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/csvS3Analyzer/actual/itemIds.json |

  ############################################# Incremental scenario ##########################################################
  @cr-data
  Scenario Outline: SC#36:Configure & run the CsvS3Cataloger and CsvS3Analyzer - Incremental scenario Run 1
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                        | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerIncRun1.json    | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                             | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerIncRunFalse.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                             | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  #7123245#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#36: Verify CsvS3Analyzer is executed successfully for scenario: Incremental scenario Run 1
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_4 | metadataValuePresence | AnalysisQuery | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |

  @cr-data
  Scenario Outline: SC#36:Configure & run the CsvS3Cataloger and CsvS3Analyzer - Incremental scenario Run 2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                     | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                              | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3CatalogerIncRun2.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                              |                                                                          | 200           | CsvS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger   | ida/empty.json                                                           | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger  |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                               | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSC1.json      | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                               |                                                                          | 200           | CsvS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer  | ida/empty.json                                                           | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CsvS3Analyzer')].status  |

  #7123245#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#36: Verify CsvS3Analyzer is executed successfully for scenario: Incremental scenario Run 2
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3CsvAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_5 | metadataValuePresence | AnalysisQuery | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer |

  Scenario: SC#36: Delete the items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                             | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer% | Analysis |       |       |

  ############################################# AmazonS3Cataloger & CsvS3Analyzer with firstRowAsHeader as false ##########################################################
  @cr-data
  Scenario Outline: SC#37:Configure & run the AmazonS3Cataloger and CsvS3Analyzer with firstRowAsHeader as false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                                    | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                | ida/s3CsvAnalyzerPayloads/PluginConfiguration/AmazonS3CatalogerSC1.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                |                                                                         | 200           | AmazonS3Cataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger  | ida/empty.json                                                          | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                                    | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSC1.json     | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                                    |                                                                         | 200           | CsvS3Analyzer     |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer      |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='CsvS3Analyzer')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer       | ida/empty.json                                                          | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer      |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='CsvS3Analyzer')].status     |

  #7123267#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#37: Verify CsvS3Analyzer is executed successfully and analyze the csv files for scenario: with firstRowAsHeader as false
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3" and clicks on search
    And user performs "definite facet selection" in "AnalyzeCsvS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "hugeData_withHeader.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | _c0 |
      | _c1 |
      | _c2 |
      | _c3 |
      | _c4 |
      | _c5 |
      | _c6 |
      | _c7 |
      | _c8 |
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hugeData_withHeader.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Number of rows    | 100000        | Statistics |

  Scenario: SC#37: Delete the items for scenario: with firstRowAsHeader as false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                                  | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%      | Analysis |       |       |

  ############################################# AmazonS3Cataloger & CsvS3Analyzer with firstRowAsHeader as true ##########################################################
  @cr-data
  Scenario Outline: SC#38:Configure & run the AmazonS3Cataloger and CsvS3Analyzer with firstRowAsHeader as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                                           | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                | ida/s3CsvAnalyzerPayloads/PluginConfiguration/AmazonS3CatalogerSC1.json        | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                |                                                                                | 200           | AmazonS3Cataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger  | ida/empty.json                                                                 | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer                                                    | ida/s3CsvAnalyzerPayloads/PluginConfiguration/CsvS3AnalyzerSC1_HeaderTrue.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Analyzer                                                    |                                                                                | 200           | CsvS3Analyzer     |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer      |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='CsvS3Analyzer')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer       | ida/empty.json                                                                 | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/CsvS3Analyzer      |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='CsvS3Analyzer')].status     |

  #7123242#
  @MLP-24318 @webtest @csvs3analyzer
  Scenario: SC#38: Verify CsvS3Analyzer is executed successfully and analyze the csv files for scenario: with firstRowAsHeader as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeCsvS3HeaderTrue" and clicks on search
    And user performs "definite facet selection" in "AnalyzeCsvS3HeaderTrue" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "hugeData_withHeader.csv [File]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Column1 |
      | Column2 |
      | Column3 |
      | Column4 |
      | Column5 |
      | Column6 |
      | Column7 |
      | Column8 |
      | Column9 |
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hugeData_withHeader.csv" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Number of rows    | 99999         | Statistics |

  Scenario: SC#38: Delete the items for scenario: with firstRowAsHeader as true
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                                  | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvS3Analyzer/CsvS3Analyzer%      | Analysis |       |       |

  ############################################# Post Conditions ##########################################################
  Scenario: SC#39: Delete the businessApplication tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type                | query | param |
      | SingleItemDelete | Default | Test_BA_CsvS3Analyzer            | BusinessApplication |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusCsvS3Analyzer% | Analysis            |       |       |

  @aws
  Scenario: SC#39:Terminate an EMR cluster in Amazon EMR service
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action           | clusterName              | filePath | jsonPath |
      | TerminateCluster | asg-di-emrcluster-qacsv3 |          |          |

  @aws
  Scenario: SC#39:Delete the AWS bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "TestAnalyzer" in bucket "asgqacsvanalyzerb2"
    Given user "Delete" objects in amazon directory "TestDataSeperate" in bucket "asgqacsvanalyzer"
    Given user "Delete" objects in amazon directory "TestAnalyzerAll" in bucket "asgqacsvanalyzer"
    Given user "Delete" objects in amazon directory "" in bucket "asg-qa-emr-csvanalyzer"
    Then user "Delete" a bucket "asgqacsvanalyzerb2" in amazon storage service
    Then user "Delete" a bucket "asgqacsvanalyzer" in amazon storage service
    Then user "Delete" a bucket "asg-qa-emr-csvanalyzer" in amazon storage service

  @cr-data
  Scenario Outline: SC#39:Delete Credentials, Datasource and cataloger config for Csv S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3Cataloger                                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3Analyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3DataSource                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidCsvReadWriteCredentials                                  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidCsvReadOnlyCredentials                                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidCsvCredentials                                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyCsvCredentials                                           |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EDIBusValidCredentials                                        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger                                               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource                                              |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                                                |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus                                                          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=CsvS3Analyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/CsvS3PII                                                        |      | 204           |                  |          |
