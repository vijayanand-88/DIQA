@MLP-24319
Feature: Verification of JsonS3Analyzer IDA Plugin

  Pre-requisites to be done in script before every run:
  1. Give a name to create a cluster in step SC#1 (Under Pre condition)
  2. Give the same cluster name in step SC#1 for retreiving the cluster ID (Under Pre condition)
  3. Give the same cluster name in step POST-CONDITIONS for terminating the cluster (Under Post condition)

  ############################################# Pre Conditions ##########################################################
  @aws @precondition
  Scenario:SC#1: Update AWS secret key and access from config file
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                           | accessKeyPath                | secretKeyPath                |
      | ida/s3JsonAnalyzerPayloads/Credentials/jsonS3ValidCredentials.json | $.jsonCredentials..accessKey | $.jsonCredentials..secretKey |
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                           | accessKeyPath                        | secretKeyPath                        |
      | ida/s3JsonAnalyzerPayloads/Credentials/jsonS3ValidCredentials.json | $.jsonReadOnlyCredentials..accessKey | $.jsonReadOnlyCredentials..secretKey |

  @cr-data
  Scenario Outline:SC#1: Configure the Credentials for Json S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                | bodyFile                                                                    | path                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidJsonReadWriteCredentials | payloads/ida/s3JsonAnalyzerPayloads/Credentials/jsonS3ValidCredentials.json | $.jsonCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidJsonReadOnlyCredentials  | payloads/ida/s3JsonAnalyzerPayloads/Credentials/jsonS3ValidCredentials.json | $.jsonReadOnlyCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/InvalidJsonCredentials        | payloads/ida/s3JsonAnalyzerPayloads/Credentials/jsonS3ValidCredentials.json | $.jsonInvalidCredentials  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EmptyJsonCredentials          | payloads/ida/s3JsonAnalyzerPayloads/Credentials/jsonS3ValidCredentials.json | $.jsonEmptyCredentials    | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials        | payloads/ida/s3JsonAnalyzerPayloads/Credentials/jsonS3ValidCredentials.json | $.validEDIBusCredentials  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidJsonReadWriteCredentials |                                                                             |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidJsonReadOnlyCredentials  |                                                                             |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/InvalidJsonCredentials        |                                                                             |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EmptyJsonCredentials          |                                                                             |                           | 200           |                  |          |

  @cr-data
  Scenario Outline:SC#1: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3JsonAnalyzerPayloads/JsonS3AnalyzerBA.json | 200           |                  |          |

  @cr-data
  Scenario: SC#1: Configure Amazon and Json S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                   | body                                                          | response code | response message   | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/JsonS3DataSource   | ida/s3JsonAnalyzerPayloads/DataSource/jsonS3DataSource.json   | 204           |                    |          |
      |                  |       |       | Get  | settings/analyzers/JsonS3DataSource   |                                                               | 200           | JsonS3DataSource   |          |
      |                  |       |       | Put  | settings/analyzers/AmazonS3DataSource | ida/s3JsonAnalyzerPayloads/DataSource/AmazonS3DataSource.json | 204           |                    |          |
      |                  |       |       | Get  | settings/analyzers/AmazonS3DataSource |                                                               | 200           | AmazonS3DataSource |          |

  @aws @cr-data
  Scenario: SC#1:Create a bucket and folder with json files in S3 Amazon storage
    Given user "Create" a bucket "asgqajsonanalyzer" in amazon storage service
    Given user "Create" a bucket "asgqajsonanalyzerb2" in amazon storage service
    Given user "Create" a bucket "asg-qa-emr-jsonanalyzer" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName          | keyPrefix        | dirPath                                              | recursive |
      | asgqajsonanalyzer   | TestAnalyzerAll  | ida/s3JsonAnalyzerPayloads/TestData/TestAnalyzerAll  | true      |
      | asgqajsonanalyzer   | TestDataSeperate | ida/s3JsonAnalyzerPayloads/TestData/TestDataSeperate | true      |
      | asgqajsonanalyzerb2 | TestAnalyzer     | ida/s3JsonAnalyzerPayloads/TestData/Bucket2          | true      |

  @aws @cr-data
  Scenario: SC#1:Create an EMR cluster or Retrieve EMR Cluster ID in Amazon EMR service
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action                    | clusterName              | filePath                                                          | jsonPath                                                  |
      | CreateCluster             | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/ClusterData/clusterdata.json           |                                                           |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerDryRunTrue.emrClusterId                   |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerSC1.emrClusterId                          |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerBucketInclude.emrClusterId                |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerBucketExcludeRegex.emrClusterId           |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerDirectoryInclude.emrClusterId             |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerSubDirIncludeRegex.emrClusterId           |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerSubDirExclude.emrClusterId                |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerFileInclude.emrClusterId                  |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerFileExcludeRegex.emrClusterId             |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3Analyzer_NodeCondition_WorkingBucket.emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerPIITags.emrClusterId                      |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerNonExistingBucket.emrClusterId            |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerNonExistingSubDir.emrClusterId            |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-json03 | ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerNonExistingFile.emrClusterId              |

  #################### DataSource TestConnection - UI Validation Error in Mandatory Fields ####################
  #7123310#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in green when test connection is successful for JsonS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | JsonS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | Region*    |
      | Credential |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name      | JsonS3TestDataSource |
      | Label     | JsonS3TestDataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | ValidJsonReadWriteCredentials     |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  #7123310#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in red when test connection is not successful for JsonS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | JsonS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | Region*    |
      | Credential |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name      | JsonS3DataSourceTest2 |
      | Label     | JsonS3DataSourceTest2 |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | InvalidJsonCredentials            |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute            |
      | Credential | EmptyJsonCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"

  #7123292#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#2:Verify proper error message is shown if mandatory fields are not filled in JsonS3Analyzer configuration page
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
      | fieldName | attribute      |
      | Type      | Dataanalyzer   |
      | Plugin    | JsonS3Analyzer |
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

  ######################################## PluginRun - JsonS3Cataloger ########################################


  @positve @amazon @regression @positive @sanity @IDA-1.1.0
  Scenario Outline: SC3-Configure and Run Catalogers for CSV, Json, Avro, Parquet and DynamoDB Catalogers
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | bodyFile                                                                   | path                 | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                              | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                              |                                                                            |                      | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger |                                                                            |                      | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger |                                                                            |                      | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |


  ######################################## PluginRun - JsonS3Analyzer - DryRun True ########################################
  #7123310#
  @cr-data
  Scenario Outline: SC#3:Configure & run the JsonS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                       | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerDryRunTrue | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                            | 200           | JsonS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                            | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                            | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                            | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |


  Scenario Outline: SC#3:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for dry run true
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                   |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id |

  #7123310#
  @MLP-24319 @jsons3analyzer
  Scenario: SC#3:UI_Validation: Verify JsonS3Analyzer plugin functionality with dry run as true
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                           | Action                | query         | TableName/Filename                         |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_true.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |
    Then Analysis log "dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName     | removableText |
      | INFO | Plugin JsonS3Analyzer running on dry run mode                                               | ANALYSIS-0069 | JsonS3Analyzer |               |
      | INFO | Plugin JsonS3Analyzer processed 182 items on dry run mode and not written to the repository | ANALYSIS-0070 | JsonS3Analyzer |               |

  Scenario Outline: SC#3:ItemDeletion: User deletes the JsonS3Analyzer analysis item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                  | inputFile                                   |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |

  ######################################## Invalid EMR Cluster ID ########################################
  #7123289#
  @cr-data
  Scenario Outline: SC#4:Configure & run the JsonS3Analyzer with Invalid EMR Cluster ID
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                              | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerInvalidEMRCluster | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                                   | 200           | JsonS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |


  Scenario Outline: SC4:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for Invalid EMR Cluster ID
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                   |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id |

  @MLP-24319 @jsons3analyzer
  Scenario: SC#4:Verify JsonS3Analyzer is not executed successfully even when Invalid EMR Cluster ID is passed as input.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                             | Action                | query         | TableName/Filename                         |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_Invalid_EMRID.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |
    Then Analysis log "dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%" should display below info/error/warning
      | type  | logValue                                                                                    | logCode     | pluginName | removableText |
      | ERROR | An error occurred while running Amazon S3 analyzer plugin: Specified job flow ID not valid. | AWS_S3-0014 |            |               |

  Scenario Outline: SC#4:ItemDeletion: User deletes the JsonS3Analyzer analysis item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                  | inputFile                                   |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |

  ######################################## PluginRun - JsonS3Analyzer - DryRun False ########################################
  @cr-data
  Scenario Outline: SC#5:Configure & run the JsonS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerSC1 | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                     | 200           | JsonS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                     | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                     | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |

  Scenario Outline: SC#5:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for dry run false
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  ############################ Logging Enhancements ############################
  ##7123310##
  @MLP-24319 @jsons3analyzer
  Scenario: SC#5:LoggingEnhancements: Verify JsonS3Analyzer collects Analysis item with proper log messages
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                            | Action                | query         | TableName/Filename                         |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_false.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |
    Then Analysis log "dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0019 |                |                |
      | INFO | Plugin Name:JsonS3Analyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:e5915a6c4e83, Plugin Configuration name:JsonS3Analyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0071 | JsonS3Analyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: ---  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: name: "JsonS3Analyzer"  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: pluginVersion: "LATEST"  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: label:  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: : ""  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: auditFields:  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: createdBy: "TestSystem"  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: createdAt: "2021-04-21T06:45:30.583"  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: modifiedBy: "TestSystem"  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: modifiedAt: "2021-04-21T07:28:04.085"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: catalogName: "Default"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: eventClass: null  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: eventCondition: null  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: maxWorkSize: 100  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: tags:  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: - "AnalyzeJsonS3"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: pluginType: "dataanalyzer"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: dataSource: "JsonS3DataSource"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: credential: "ValidJsonReadWriteCredentials"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: businessApplicationName: "Test_BA_JsonS3Analyzer"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: schedule: null  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: filter: null  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: emrClusterId: "j-12133O1NV2B1XKOXB"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: histogramBuckets: 100  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: bucketName: "asg-qa-emr-jsonanalyzer"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: dryRun: false  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: cleanupAfterRun: true  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: pluginName: "JsonS3Analyzer"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: incremental: true  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: type: "Dataanalyzer"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: bucketFilter:  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: mode: "INCLUDE"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: patterns: []  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: objectFilter:  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: dirFilter:  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: mode: "INCLUDE"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: patterns: []  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: fileFilter:  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: mode: "INCLUDE"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: patterns: []  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: dirPrefixes: []  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: dataSampleSize: 25  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: restrictRegion: "us-east-1"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin JsonS3Analyzer Configuration: topValues: 10 | ANALYSIS-0073 | JsonS3Analyzer | emrClusterId   |
      | INFO | Plugin JsonS3Analyzer Start Time:2020-06-24 10:27:25.815, End Time:2020-06-24 10:31:19.002, Errors:0, Warnings:5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0072 | JsonS3Analyzer |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0020 |                |                |

  ############################ UI Validation ############################
  #7123276#
  @MLP-24319 @jsons3analyzer
  Scenario:SC#6:Verify the 'Number of rows' and 'Last analyzed at' attribute for File type after JsonS3Analyzer is executed.
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                             | jsonPath                | Action                    | query     | TableName/Filename                 | ClusterName   | ServiceName | directoryName |
      | Lifecycle  | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle  | metadataAttributePresence | FileQuery | userpatternmatchsimpleOneLine.json | amazonaws.com | AmazonS3    | json          |
      | Statistics | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Statistics | metadataValuePresence     | FileQuery | userpatternmatchsimpleOneLine.json | amazonaws.com | AmazonS3    | json          |


   ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @jsons3analyzer
  Scenario Outline:SC7:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid              | targetFile                                         | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | all  | jsonExampleEmployee.json | payloads/ida/s3JsonAnalyzerPayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @jsons3analyzer
  Scenario Outline: SC7:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                          | outPutFile                                                | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/s3JsonAnalyzerPayloads/API/items.json | payloads\ida\s3JsonAnalyzerPayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @jsons3analyzer
  Scenario: SC#7 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\s3JsonAnalyzerPayloads\API\Actual\File1.json" should be same as the content in "ida\s3JsonAnalyzerPayloads\API\Expected\File1.json"

############################################################### Data Profiling #########################################################################################

  #7123279#
  @MLP-24319 @jsons3analyzer
  Scenario:SC#8:Verify the data profiling metadata information for string datatype in S3 Json file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query          | TableName/Filename      | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_1 | metadataValuePresence | FileFieldQuery | combo_jsonEmployee.json | amazonaws.com | AmazonS3    | combo         | empname              |
      | Statistics  | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_1  | metadataValuePresence | FileFieldQuery | combo_jsonEmployee.json | amazonaws.com | AmazonS3    | combo         | empname              |

  #7123280#
  @MLP-24319 @jsons3analyzer
  Scenario:SC#9:Verify the data profiling metadata information for numeric datatype in S3 Json file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                    | query          | TableName/Filename      | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Lifecycle   | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence | FileFieldQuery | combo_jsonEmployee.json | amazonaws.com | AmazonS3    | combo         | empid                |
      | Statistics  | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_2  | metadataValuePresence     | FileFieldQuery | combo_jsonEmployee.json | amazonaws.com | AmazonS3    | combo         | empid                |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_2 | metadataValuePresence     | FileFieldQuery | combo_jsonEmployee.json | amazonaws.com | AmazonS3    | combo         | empid                |


  #7123280#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#10:Verify breadcrumb hierarchy appears correctly in JsonS3Analyzer analyzed items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "state" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "userpatternmatchOneLine.json [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "state" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com                |
      | AmazonS3                     |
      | asgqajsonanalyzer            |
      | TestDataSeperate             |
      | json                         |
      | userpatternmatchOneLine.json |
      | address                      |
      | state                        |

  ############################ Tags verification ############################
  #7123310#
  @MLP-24319 @jsons3analyzer
  Scenario: SC#11:Tech_tags_Explicit_Tags verification: Verify the technology tags, Business Application, Explicit tags got assigned to the analyzed items
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                 | Column  | Tags                                                              | Query          | Action         |
      | amazonaws.com | AmazonS3    | json          | userpatternmatchsimpleOneLine.json |         | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery      | TagAssigned    |
      | amazonaws.com | AmazonS3    | combo         | combo_jsonEmployee.json            | empname | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | userpatternmatchsimpleOneLine.json |         | Data Files                                                        | FileQuery      | TagNotAssigned |

  ############################ EDIBus verification ############################
  #7123310#
#  @MLP-24319 @webtest @jsons3analyzer @edibus
#  Scenario: SC#12 Verify the Json S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "CatalogJsonS3" and clicks on search
#    And user performs "facet selection" in "CatalogJsonS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "JSON" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#      | Field     |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/datasource/EDIBusDS_JsonS3Analyzer.json" file for following values using property loader
#      | jsonPath        | jsonValues  |
#      | $..['EDI host'] | EDIHostName |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                       | body                                                       | response code | response message | jsonPath                                                  |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                       | idc/EdiBusPayloads/datasource/EDIBusDS_JsonS3Analyzer.json | 204           |                  |                                                           |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/JsonS3AnalyzerEDIConfig.json            | 204           |                  |                                                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJsonS3Analyzer |                                                            | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJsonS3Analyzer')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJsonS3Analyzer  |                                                            | 200           |                  |                                                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJsonS3Analyzer |                                                            | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJsonS3Analyzer')].status |
#    And user enters the search text "EDIBusJsonS3Analyzer" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusJsonS3Analyzer%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "AnalyzeJsonS3" and clicks on search
#    And user performs "facet selection" in "AnalyzeJsonS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "JSON" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                 |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/JSON |
#      | $..selections.['type_s'][*]                   | File                                       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AnalyzeJsonS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "AnalyzeJsonS3" and clicks on search
#    And user performs "facet selection" in "AnalyzeJsonS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "JSON" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @*Json≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @*Json≫DEFAULT≫DWR_DAT_FIELD≫@* ),AND,( TYPE = DWR_IDC ) |

  Scenario Outline: SC#12:user deletes the SC1 item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  ############################################# Filter Scenarios ##########################################################
  #Filter - Bucket Include#
  @cr-data
  Scenario Outline: SC#13:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: Bucket Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                          | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1          | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                               | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerBucketInclude | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                               | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#13:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for filters - BucketName Include
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123281#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#13: Verify JsonS3Analyzer is executed successfully with filters - BucketName Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeJsonS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.json                            |
      | userpatternmatchOneLine.json                     |
      | userpatternmatchOneLineArray.json                |
      | userpatternmatchsimpleOneLine.json               |
      | quizNested.json                                  |
      | employeeArray.json                               |
      | userpatternmatchsimple.json                      |
      | userhugedata.json                                |
      | tagdetails_allmatch.json                         |
      | tagdetails_allempty.json                         |
      | tagdetails_ratiolessthan05emptyfalse.json        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue.json |
      | tagdetails_ratioequalto05emptyfalse.json         |
      | tagdetails_ratiogreaterthan05matchfulltrue.json  |
      | tagdetails_ratiolesserthan05matchfulltrue.json   |
      | combo_jsonEmployee.json                          |
      | jsonExampleEmployee.json                         |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_jsonEmployee.json |
    And user enters the search text "userpatternmatchOneLine.json" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchOneLine.json" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "b2_jsonEmployee.json" and clicks on search
    And user performs "facet selection" in "CatalogJsonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "b2_jsonEmployee.json" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    And Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename           | Column | Tags                                                              | Query     | Action      |
      | amazonaws.com | AmazonS3    | json          | userpatternmatchOneLine.json |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
      | amazonaws.com | AmazonS3    | TestAnalyzer  | b2_jsonEmployee.json         |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
    And user clicks on logout button

  Scenario Outline: SC#13:user deletes the item from database using dynamic id stored in json for filters - BucketName Include
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  #Filter - Bucket Exclude#
  @cr-data
  Scenario Outline: SC#14:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: Bucket Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                               | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1               | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                                    | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                    | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                                    | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                    | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerBucketExcludeRegex | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                                    | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                    | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                    | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                    | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#14:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for filters - Bucket Exclude Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123282#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#14: Verify JsonS3Analyzer is executed successfully with filters - Bucket Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "b2_jsonEmployee.json" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3BucketExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | b2_jsonEmployee.json |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.json                            |
      | userpatternmatchsimple.json                      |
      | userhugedata.json                                |
      | tagdetails_allmatch.json                         |
      | tagdetails_allempty.json                         |
      | tagdetails_ratiolessthan05emptyfalse.json        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue.json |
      | tagdetails_ratioequalto05emptyfalse.json         |
      | tagdetails_ratiogreaterthan05matchfulltrue.json  |
      | tagdetails_ratiolesserthan05matchfulltrue.json   |
      | combo_jsonEmployee.json                          |
      | jsonExampleEmployee.json                         |
      | userpatternmatchOneLine.json                     |
      | userpatternmatchOneLineArray.json                |
      | userpatternmatchsimpleOneLine.json               |
    And user performs "item click" on "b2_jsonEmployee.json" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "userpatternmatchOneLine.json" and clicks on search
    And user performs "facet selection" in "CatalogJsonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchOneLine.json" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    And Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename           | Column | Tags                                                              | Query     | Action      |
      | amazonaws.com | AmazonS3    | json          | userpatternmatchOneLine.json |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
      | amazonaws.com | AmazonS3    | TestAnalyzer  | b2_jsonEmployee.json         |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
    And user clicks on logout button

  Scenario Outline: SC#14:user deletes the item from database using dynamic id stored in json for filters - Bucket Exclude Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  #Filter - Directory Include#
  @cr-data
  Scenario Outline: SC#15:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: Bucketname (Include)/Directory
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                             | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1             | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                                  | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerDirectoryInclude | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                                  | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#15:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for filters - Bucketname (Include)/Directory
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123283#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#15:Verify JsonS3Analyzer is executed successfully with filters - Bucketname (Include)/Directory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "jsonExampleEmployee.json" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3DirectoryInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | jsonExampleEmployee.json |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.json                            |
      | userpatternmatchsimple.json                      |
      | userhugedata.json                                |
      | tagdetails_allmatch.json                         |
      | tagdetails_allempty.json                         |
      | tagdetails_ratiolessthan05emptyfalse.json        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue.json |
      | tagdetails_ratioequalto05emptyfalse.json         |
      | tagdetails_ratiogreaterthan05matchfulltrue.json  |
      | tagdetails_ratiolesserthan05matchfulltrue.json   |
      | combo_jsonEmployee.json                          |
      | b2_jsonEmployee.json                             |
      | userpatternmatchOneLine.json                     |
      | userpatternmatchOneLineArray.json                |
      | userpatternmatchsimpleOneLine.json               |
    And user performs "item click" on "jsonExampleEmployee.json" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "b2_jsonEmployee.json" and clicks on search
    And user performs "facet selection" in "CatalogJsonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "b2_jsonEmployee.json" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    And Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename       | Column | Tags                                                              | Query     | Action      |
      | amazonaws.com | AmazonS3    | all           | jsonExampleEmployee.json |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allempty.json |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
    And user clicks on logout button

  Scenario Outline: SC#15:user deletes the item from database using dynamic id stored in json for filters - Bucketname (Include)/Directory
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  #Filter - Sub Directory Include#
  @cr-data
  Scenario Outline: SC#16:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: Bucket Include & SubDirectory Include Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                               | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1               | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                                    | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                    | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                                    | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                    | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerSubDirIncludeRegex | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                                    | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                    | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                    | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                    | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#16:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for filters - Bucket Include & SubDirectory Include Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123284#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#16: Verify JsonS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Include Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeJsonS3SubDirInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3SubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.json                            |
      | userpatternmatchsimple.json                      |
      | userhugedata.json                                |
      | tagdetails_allmatch.json                         |
      | tagdetails_allempty.json                         |
      | tagdetails_ratiolessthan05emptyfalse.json        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue.json |
      | tagdetails_ratioequalto05emptyfalse.json         |
      | tagdetails_ratiogreaterthan05matchfulltrue.json  |
      | tagdetails_ratiolesserthan05matchfulltrue.json   |
      | userpatternmatchOneLine.json                     |
      | userpatternmatchOneLineArray.json                |
      | userpatternmatchsimpleOneLine.json               |
      | quizNested.json                                  |
      | employeeArray.json                               |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_jsonEmployee.json     |
      | combo_jsonEmployee.json  |
      | jsonExampleEmployee.json |
    And user enters the search text "userpatternmatchOneLine.json" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3SubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchOneLine.json" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "combo_jsonEmployee.json" and clicks on search
    And user performs "facet selection" in "CatalogJsonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "combo_jsonEmployee.json" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    And Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename           | Column | Tags                                                              | Query     | Action      |
      | amazonaws.com | AmazonS3    | json          | userpatternmatchOneLine.json |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
      | amazonaws.com | AmazonS3    | combo         | combo_jsonEmployee.json      |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
    And user clicks on logout button

  Scenario Outline: SC#16:user deletes the item from database using dynamic id stored in json for filters - Bucket Include & SubDirectory Include Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  #Filter - SubDirectory Exclude#
  @cr-data
  Scenario Outline: SC#17:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: Bucket Include & SubDirectory Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                          | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1          | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                               | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerSubDirExclude | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                               | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                               | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#17:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for filters - Bucket Include & SubDirectory Exclude
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123285#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#17: Verify JsonS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeJsonS3SubDirExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3SubDirExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | combo_jsonEmployee.json  |
      | jsonExampleEmployee.json |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_jsonEmployee.json                             |
      | userpatternmatch.json                            |
      | userpatternmatchsimple.json                      |
      | userhugedata.json                                |
      | tagdetails_allmatch.json                         |
      | tagdetails_allempty.json                         |
      | tagdetails_ratiolessthan05emptyfalse.json        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue.json |
      | tagdetails_ratioequalto05emptyfalse.json         |
      | tagdetails_ratiogreaterthan05matchfulltrue.json  |
      | tagdetails_ratiolesserthan05matchfulltrue.json   |
      | userpatternmatchOneLine.json                     |
      | userpatternmatchOneLineArray.json                |
      | userpatternmatchsimpleOneLine.json               |
      | quizNested.json                                  |
      | employeeArray.json                               |
    And user performs "item click" on "combo_jsonEmployee.json" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "userpatternmatchsimpleOneLine.json" and clicks on search
    And user performs "facet selection" in "CatalogJsonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchsimpleOneLine.json" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    And Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                 | Column | Tags                                                              | Query     | Action      |
      | amazonaws.com | AmazonS3    | json          | userpatternmatchsimpleOneLine.json |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
      | amazonaws.com | AmazonS3    | combo         | combo_jsonEmployee.json            |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
    And user clicks on logout button

  Scenario Outline: SC#17:user deletes the item from database using dynamic id stored in json for filters - Bucket Include & SubDirectory Exclude
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  #Filter - File Include#
  @cr-data
  Scenario Outline: SC#18:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: File Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                        | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1        | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                             | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                             | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                             | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                             | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerFileInclude | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                             | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                             | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                             | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                             | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#18:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for filters - File Include
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123286#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#18: Verify JsonS3Analyzer is executed successfully with filters - File Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userpatternmatchOneLine.json" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3FileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatchOneLine.json |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_jsonEmployee.json                             |
      | combo_jsonEmployee.json                          |
      | jsonExampleEmployee.json                         |
      | userpatternmatchsimple.json                      |
      | userhugedata.json                                |
      | dateTimestampExample.json                        |
      | tagdetails_allmatch.json                         |
      | tagdetails_allempty.json                         |
      | tagdetails_ratiolessthan05emptyfalse.json        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue.json |
      | tagdetails_ratioequalto05emptyfalse.json         |
      | tagdetails_ratiogreaterthan05matchfulltrue.json  |
      | tagdetails_ratiolesserthan05matchfulltrue.json   |
      | userpatternmatch.json                            |
      | userpatternmatchOneLineArray.json                |
      | userpatternmatchsimpleOneLine.json               |
      | quizNested.json                                  |
      | employeeArray.json                               |
    And user performs "item click" on "userpatternmatchOneLine.json" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "combo_jsonEmployee.json" and clicks on search
    And user performs "facet selection" in "CatalogJsonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "combo_jsonEmployee.json" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    And Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename           | Column | Tags                                                              | Query     | Action      |
      | amazonaws.com | AmazonS3    | json          | userpatternmatchOneLine.json |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
      | amazonaws.com | AmazonS3    | combo         | combo_jsonEmployee.json      |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
    And user clicks on logout button

  Scenario Outline: SC#18:user deletes the item from database using dynamic id stored in json for filters - File Include
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  #Filter - File Exclude#
  @cr-data
  Scenario Outline: SC#19:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: File Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                             | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1             | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                                  | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerFileExcludeRegex | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                                  | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#19:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for filters - File Exclude Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123287# #7123288#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#19: Verify JsonS3Analyzer is executed successfully with filters - File Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeJsonS3FileExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3FileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.json              |
      | userpatternmatchsimple.json        |
      | userhugedata.json                  |
      | userpatternmatchOneLine.json       |
      | userpatternmatchOneLineArray.json  |
      | userpatternmatchsimpleOneLine.json |
      | employeeArray.json                 |
      | quizNested.json                    |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_jsonEmployee.json                             |
      | combo_jsonEmployee.json                          |
      | jsonExampleEmployee.json                         |
      | tagdetails_allmatch.json                         |
      | tagdetails_allempty.json                         |
      | tagdetails_ratiolessthan05emptyfalse.json        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue.json |
      | tagdetails_ratioequalto05emptyfalse.json         |
      | tagdetails_ratiogreaterthan05matchfulltrue.json  |
      | tagdetails_ratiolesserthan05matchfulltrue.json   |
    And user enters the search text "employeeArray.json" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3FileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "employeeArray.json" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "combo_jsonEmployee.json" and clicks on search
    And user performs "facet selection" in "CatalogJsonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "combo_jsonEmployee.json" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    And Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename           | Column | Tags                                                              | Query     | Action      |
      | amazonaws.com | AmazonS3    | json          | userpatternmatchOneLine.json |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
      | amazonaws.com | AmazonS3    | combo         | combo_jsonEmployee.json      |        | AnalyzeJsonS3,CatalogJsonS3,Test_BA_JsonS3Analyzer,JSON,Amazon S3 | FileQuery | TagAssigned |
    And user clicks on logout button

  Scenario Outline: SC#19:user deletes the item from database using dynamic id stored in json for filters - File Exclude Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  ############################################# Node Condition Internal Node ##########################################################
  @cr-data
  Scenario Outline: SC#20:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: Specific Node condition and non-existing working bucket name and Analyzing files from AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | bodyFile                                                                   | path                                         | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger                              | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.AmazonS3CatalogerSC1                       | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger                              |                                                                            |                                              | 200           | AmazonS3Cataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                            |                                              | 200           | IDLE              | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger  |                                                                            |                                              | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                            |                                              | 200           | IDLE              | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                    | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3Analyzer_NodeCondition_WorkingBucket | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                    |                                                                            |                                              | 200           | JsonS3Analyzer    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                              | 200           | IDLE              | $.[?(@.configurationName=='JsonS3Analyzer')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                              | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                              | 200           | IDLE              | $.[?(@.configurationName=='JsonS3Analyzer')].status    |


  Scenario Outline: SC#20:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for scenario: Specific Node condition and non-existing working bucket name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                              | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                     |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN    |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123291# #7123311# #7123290#
  @MLP-24319 @webtest @jsons3analyzer
  Scenario: SC#20: Verify JsonS3Analyzer is executed successfully for scenario: Specific Node condition and non-existing working bucket name and Analyzing files catalgoed from AmazonS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeJsonS3NodeCondition" and clicks on search
    And user performs "facet selection" in "AnalyzeJsonS3NodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.json                            |
      | userpatternmatchOneLine.json                     |
      | userpatternmatchOneLineArray.json                |
      | userpatternmatchsimpleOneLine.json               |
      | quizNested.json                                  |
      | employeeArray.json                               |
      | userpatternmatchsimple.json                      |
      | userhugedata.json                                |
      | tagdetails_allmatch.json                         |
      | tagdetails_allempty.json                         |
      | tagdetails_ratiolessthan05emptyfalse.json        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue.json |
      | tagdetails_ratioequalto05emptyfalse.json         |
      | tagdetails_ratiogreaterthan05matchfulltrue.json  |
      | tagdetails_ratiolesserthan05matchfulltrue.json   |
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                             | jsonPath                  | Action                | query     | TableName/Filename | ClusterName   | ServiceName | directoryName |
      | Statistics | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_3 | metadataValuePresence | FileQuery | employeeArray.json | amazonaws.com | AmazonS3    | json          |
    And user clicks on logout button

  Scenario Outline: SC#20:user deletes the item from database using dynamic id stored in json for scenario: Specific Node condition and non-existing working bucket name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  ######################################## Non existing buckets/ sub-directory/ file ########################################
  @cr-data
  Scenario Outline: SC#21:Configure & run the JsonS3Analyzer for Non existing buckets
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1              | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                                   | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerNonExistingBucket | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                                   | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#21:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for Non existing buckets
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                 |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  @MLP-24319 @jsons3analyzer
  Scenario: SC#21:Verify the error message in logs when JsonS3Analyzer is executed with Non existing buckets in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         | ClusterName   | ServiceName | directoryName |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer | amazonaws.com | AmazonS3    | json          |
    Then Analysis log "dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#21:Configure & run the JsonS3Analyzer for Non existing sub directories
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                              | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerNonExistingSubDir | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                                   | 200           | JsonS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |


  @MLP-24319 @jsons3analyzer
  Scenario: SC#22:Verify the error message in logs when JsonS3Analyzer is executed with Non existing sub directory in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         | ClusterName   | ServiceName | directoryName |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer | amazonaws.com | AmazonS3    | json          |
    Then Analysis log "dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#22:Configure & run the JsonS3Analyzer for Non existing file
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                            | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerNonExistingFile | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                                 | 200           | JsonS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                 | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                                 | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                                 | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status |


  @MLP-24319 @jsons3analyzer
  Scenario: SC#22:Verify the error message in logs when JsonS3Analyzer is executed with Non existing file in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         | ClusterName   | ServiceName | directoryName |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer | amazonaws.com | AmazonS3    | json          |
    Then Analysis log "dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  Scenario Outline: SC#22:ItemDeletion: User deletes the JsonS3Analyzer analysis item with dry run as true from database using dynamic id stored in json for Non existing buckets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |

  Scenario:SC#23:Delete all the JsonS3Analyzer analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer% | Analysis |       |       |

  ############################################# Policy Patterns - PII Tagging ##########################################################
  Scenario Outline:SC#23:Create root tag and sub tag for JsonS3 and Update policy tags for JsonS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/s3JsonAnalyzerPayloads/policyEngine/jsonS3TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/s3JsonAnalyzerPayloads/policyEngine/jsonS3_policy1.1.0.json | 204           |                  |          |

  @cr-data
  Scenario Outline: SC#23:Configure & run the JsonS3Cataloger and JsonS3Analyzer for scenario: Policy Patterns - PII Tagging
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                    | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerSC1    | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                         | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                         | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerPIITags | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                         | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                         | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |


  Scenario Outline: SC#23:RetrieveItemID: User retrieves the item ids of analysis of JsonS3Analyzer and copy them to a json file for Policy Patterns - PII Tagging
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/jsonS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN  |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer%DYN |      | response/jsonS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7123294# #7123295# #7123296# #7123297# #7123298# #7123299# #7123300# #7123301# #7123302# #7123303# #7123304# #7123305# #7123306# #7123307#
  @MLP-24319 @jsons3analyzer @PIITag
  Scenario: SC#23: Verify PII Tags gets assigned to the below fields in file: tagdetails_allmatch.json
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename       | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | GENDER    | JsonS3GenderPII_SC1Tag,JsonS3GenderPII_SC3Tag,JsonS3GenderPII_SC8Tag,JSON,Amazon S3                                                  | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | FULL_NAME | JsonS3FullNamePII_SC1Tag,JsonS3FullNamePII_SC3Tag,JsonS3FullNamePII_SC8Tag,JSON,Amazon S3                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | SSN       | JsonS3SSNPII_SC1Tag,JsonS3SSNPII_SC3Tag,JsonS3SSNPII_SC8Tag,JSON,Amazon S3                                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | IPADDRESS | JsonS3IPAddressPII_SC1Tag,JsonS3IPAddressPII_SC3Tag,JsonS3IPAddressPII_SC8Tag,JSON,Amazon S3                                         | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | GENDER    | JsonS3GenderPII_SC2Tag,JsonS3GenderPII_SC4Tag,JsonS3GenderPII_SC11Tag,JsonS3GenderPII_SC12Tag,JsonS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | EMAIL     | JsonS3EmailPII_SC2Tag,JsonS3EmailPII_SC4Tag,JsonS3EmailPII_SC11Tag,JsonS3EmailPII_SC12Tag,JsonS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | FULL_NAME | JsonS3FullNamePII_SC2Tag,JsonS3FullNamePII_SC4Tag,JsonS3FullNamePII_SC11Tag,JsonS3FullNamePII_SC12Tag,JsonS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | SSN       | JsonS3SSNPII_SC2Tag,JsonS3SSNPII_SC4Tag,JsonS3SSNPII_SC11Tag,JsonS3SSNPII_SC12Tag,JsonS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allmatch.json | IPADDRESS | JsonS3IPAddressPII_SC2Tag,JsonS3IPAddressPII_SC4Tag,JsonS3IPAddressPII_SC11Tag,JsonS3IPAddressPII_SC12Tag,JsonS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7123294# #7123295# #7123296# #7123297# #7123298# #7123299# #7123300# #7123301# #7123302# #7123303# #7123304# #7123305# #7123306# #7123307#
  @MLP-24319 @jsons3analyzer @PIITag
  Scenario: SC#24: Verify PII Tags gets assigned to the below fields in file: tagdetails_allempty.json
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename       | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allempty.json | SSN       | JsonS3SSNPII_SC1Tag,JsonS3SSNPII_SC3Tag,JsonS3SSNPII_SC14Tag,JSON,Amazon S3                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allempty.json | IPADDRESS | JsonS3IPAddressPII_SC1Tag,JsonS3IPAddressPII_SC3Tag,JsonS3IPAddressPII_SC14Tag,JSON,Amazon S3                                        | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allempty.json | GENDER    | JsonS3GenderPII_SC2Tag,JsonS3GenderPII_SC4Tag,JsonS3GenderPII_SC11Tag,JsonS3GenderPII_SC12Tag,JsonS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allempty.json | EMAIL     | JsonS3EmailPII_SC2Tag,JsonS3EmailPII_SC4Tag,JsonS3EmailPII_SC11Tag,JsonS3EmailPII_SC12Tag,JsonS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allempty.json | FULL_NAME | JsonS3FullNamePII_SC2Tag,JsonS3FullNamePII_SC4Tag,JsonS3FullNamePII_SC11Tag,JsonS3FullNamePII_SC12Tag,JsonS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allempty.json | SSN       | JsonS3SSNPII_SC2Tag,JsonS3SSNPII_SC4Tag,JsonS3SSNPII_SC11Tag,JsonS3SSNPII_SC12Tag,JsonS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_allempty.json | IPADDRESS | JsonS3IPAddressPII_SC2Tag,JsonS3IPAddressPII_SC4Tag,JsonS3IPAddressPII_SC11Tag,JsonS3IPAddressPII_SC12Tag,JsonS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7123294# #7123295# #7123296# #7123297# #7123298# #7123299# #7123300# #7123301# #7123302# #7123303# #7123304# #7123305# #7123306# #7123307#
  @MLP-24319 @jsons3analyzer @PIITag
  Scenario: SC#25: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolessthan05emptyfalse.json
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                        | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | GENDER    | JsonS3GenderPII_SC1Tag,JsonS3GenderPII_SC3Tag,JsonS3GenderPII_SC5Tag,JsonS3GenderPII_SC10Tag,JSON,Amazon S3                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | SSN       | JsonS3SSNPII_SC5Tag,JsonS3SSNPII_SC10Tag,JSON,Amazon S3                                                                              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | IPADDRESS | JsonS3IPAddressPII_SC1Tag,JsonS3IPAddressPII_SC3Tag,JsonS3IPAddressPII_SC5Tag,JsonS3IPAddressPII_SC10Tag,JSON,Amazon S3              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | FULL_NAME | JsonS3FullNamePII_SC5Tag,JsonS3FullNamePII_SC10Tag,JSON,Amazon S3                                                                    | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | GENDER    | JsonS3GenderPII_SC2Tag,JsonS3GenderPII_SC4Tag,JsonS3GenderPII_SC11Tag,JsonS3GenderPII_SC12Tag,JsonS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | EMAIL     | JsonS3EmailPII_SC2Tag,JsonS3EmailPII_SC4Tag,JsonS3EmailPII_SC11Tag,JsonS3EmailPII_SC12Tag,JsonS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | FULL_NAME | JsonS3FullNamePII_SC2Tag,JsonS3FullNamePII_SC4Tag,JsonS3FullNamePII_SC11Tag,JsonS3FullNamePII_SC12Tag,JsonS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | SSN       | JsonS3SSNPII_SC2Tag,JsonS3SSNPII_SC4Tag,JsonS3SSNPII_SC11Tag,JsonS3SSNPII_SC12Tag,JsonS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolessthan05emptyfalse.json | IPADDRESS | JsonS3IPAddressPII_SC2Tag,JsonS3IPAddressPII_SC4Tag,JsonS3IPAddressPII_SC11Tag,JsonS3IPAddressPII_SC12Tag,JsonS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7123294# #7123295# #7123296# #7123297# #7123298# #7123299# #7123300# #7123301# #7123302# #7123303# #7123304# #7123305# #7123306# #7123307#
  @MLP-24319 @jsons3analyzer @PIITag
  Scenario: SC#26: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05emptyfalsetrue.json
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                               | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | GENDER    | JsonS3GenderPII_SC1Tag,JsonS3GenderPII_SC3Tag,JsonS3GenderPII_SC7Tag,JSON,Amazon S3                                                  | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | SSN       | JsonS3SSNPII_SC1Tag,JsonS3SSNPII_SC3Tag,JsonS3SSNPII_SC7Tag,JSON,Amazon S3                                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | IPADDRESS | JsonS3IPAddressPII_SC1Tag,JsonS3IPAddressPII_SC3Tag,JsonS3IPAddressPII_SC6Tag,JsonS3IPAddressPII_SC7Tag,JSON,Amazon S3               | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | FULL_NAME | JsonS3FullNamePII_SC1Tag,JsonS3FullNamePII_SC3Tag,JsonS3FullNamePII_SC7Tag,JSON,Amazon S3                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | GENDER    | JsonS3GenderPII_SC2Tag,JsonS3GenderPII_SC4Tag,JsonS3GenderPII_SC11Tag,JsonS3GenderPII_SC12Tag,JsonS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | EMAIL     | JsonS3EmailPII_SC2Tag,JsonS3EmailPII_SC4Tag,JsonS3EmailPII_SC11Tag,JsonS3EmailPII_SC12Tag,JsonS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | FULL_NAME | JsonS3FullNamePII_SC2Tag,JsonS3FullNamePII_SC4Tag,JsonS3FullNamePII_SC11Tag,JsonS3FullNamePII_SC12Tag,JsonS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | SSN       | JsonS3SSNPII_SC2Tag,JsonS3SSNPII_SC4Tag,JsonS3SSNPII_SC11Tag,JsonS3SSNPII_SC12Tag,JsonS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05emptyfalsetrue.json | IPADDRESS | JsonS3IPAddressPII_SC2Tag,JsonS3IPAddressPII_SC4Tag,JsonS3IPAddressPII_SC11Tag,JsonS3IPAddressPII_SC12Tag,JsonS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7123294# #7123295# #7123296# #7123297# #7123298# #7123299# #7123300# #7123301# #7123302# #7123303# #7123304# #7123305# #7123306# #7123307#
  @MLP-24319 @jsons3analyzer @PIITag
  Scenario: SC#27: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratioequalto05emptyfalse.json
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                       | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | GENDER    | JsonS3GenderPII_SC1Tag,JsonS3GenderPII_SC3Tag,JsonS3GenderPII_SC9Tag,JSON,Amazon S3                                                  | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | SSN       | JsonS3SSNPII_SC1Tag,JsonS3SSNPII_SC3Tag,JsonS3SSNPII_SC9Tag,JSON,Amazon S3                                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | IPADDRESS | JsonS3IPAddressPII_SC1Tag,JsonS3IPAddressPII_SC3Tag,JsonS3IPAddressPII_SC9Tag,JSON,Amazon S3                                         | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | FULL_NAME | JsonS3FullNamePII_SC1Tag,JsonS3FullNamePII_SC3Tag,JsonS3FullNamePII_SC9Tag,JSON,Amazon S3                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | GENDER    | JsonS3GenderPII_SC2Tag,JsonS3GenderPII_SC4Tag,JsonS3GenderPII_SC11Tag,JsonS3GenderPII_SC12Tag,JsonS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | EMAIL     | JsonS3EmailPII_SC2Tag,JsonS3EmailPII_SC4Tag,JsonS3EmailPII_SC11Tag,JsonS3EmailPII_SC12Tag,JsonS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | FULL_NAME | JsonS3FullNamePII_SC2Tag,JsonS3FullNamePII_SC4Tag,JsonS3FullNamePII_SC11Tag,JsonS3FullNamePII_SC12Tag,JsonS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | SSN       | JsonS3SSNPII_SC2Tag,JsonS3SSNPII_SC4Tag,JsonS3SSNPII_SC11Tag,JsonS3SSNPII_SC12Tag,JsonS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratioequalto05emptyfalse.json | IPADDRESS | JsonS3IPAddressPII_SC2Tag,JsonS3IPAddressPII_SC4Tag,JsonS3IPAddressPII_SC11Tag,JsonS3IPAddressPII_SC12Tag,JsonS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


   #7123308#
  @MLP-24319 @jsons3analyzer @PIITag
  Scenario: SC#28: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05matchfulltrue.json
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                              | Column   | Tags                                                                                                                                                                                                                                                                     | Query          | Action         |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05matchfulltrue.json | COMMENTS | Amazon S3,AnalyzeJsonS3,AnalyzeJsonS3PIITags,CatalogJsonS3,JSON,JsonS3FullMatchPII_SC2Tag,JsonS3FullMatchPII_SC4Tag,JsonS3FullNamePII_SC14Tag,JsonS3FullNamePII_SC1Tag,JsonS3FullNamePII_SC5Tag,JsonS3FullNamePII_SC8Tag,JsonS3FullNamePII_SC9Tag,Test_BA_JsonS3Analyzer | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiogreaterthan05matchfulltrue.json | COMMENTS | JsonS3FullMatchPII_SC1Tag                                                                                                                                                                                                                                                | FileFieldQuery | TagNotAssigned |


  #7123309#
  @MLP-24319 @jsons3analyzer @PIITag
  Scenario: SC#29: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolesserthan05matchfulltrue.json
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                             | Column   | Tags                                     | Query          | Action         |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolesserthan05matchfulltrue.json | COMMENTS | JsonS3FullMatchPII_SC4Tag,JSON,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | json          | tagdetails_ratiolesserthan05matchfulltrue.json | COMMENTS | JsonS3FullMatchPII_SC3Tag                | FileFieldQuery | TagNotAssigned |


  Scenario Outline: SC#29:user deletes the item from database using dynamic id stored in json for scenario: Policy Patterns - PII Tagging
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/jsonS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/jsonS3Analyzer/actual/itemIds.json |

  ############################################# Incremental scenario ##########################################################
  @cr-data
  Scenario Outline: SC#30:Configure & run the JsonS3Cataloger - Incremental scenario Run 1
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerIncRun1 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                          | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                          | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerSC1      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                          | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                          | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |

  #7123293#
  @MLP-24319 @Jsons3analyzer
  Scenario: SC#30: Verify JsonS3Analyzer is executed successfully for scenario: Incremental scenario Run 1
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         | ClusterName   | ServiceName | directoryName |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_4 | metadataValuePresence | AnalysisQuery | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer | amazonaws.com | AmazonS3    | json          |

  @cr-data
  Scenario Outline: SC#30:Configure & run the JsonS3Cataloger - Incremental scenario Run 2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                                                   | path                     | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3CatalogerIncRun2 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                               |                                                                            |                          | 200           | JsonS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger   |                                                                            |                          | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger  |                                                                            |                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 | payloads/ida/s3JsonAnalyzerPayloads/PluginConfiguration/JsonS3Anayzer.json | $.JsonS3AnalyzerSC1      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                 |                                                                            |                          | 200           | JsonS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer  |                                                                            |                          | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/JsonS3Analyzer |                                                                            |                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Analyzer')].status  |

  #7123293#
  @MLP-24319 @webtest @Jsons3analyzer
  Scenario: SC#30: Verify JsonS3Analyzer is executed successfully for scenario: Incremental scenario Run 2
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         | ClusterName   | ServiceName | directoryName |
      | Description | ida/s3JsonAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_5 | metadataValuePresence | AnalysisQuery | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer | amazonaws.com | AmazonS3    | json          |


  Scenario: SC#30: Delete the items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                               | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/JsonS3Analyzer/JsonS3Analyzer% | Analysis |       |       |

  ############################################# Post Conditions ##########################################################

  @aws
  Scenario: PostConditions-Terminate an EMR cluster in Amazon EMR service
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action           | clusterName              | filePath | jsonPath |
      | TerminateCluster | asg-di-emrcluster-json03 |          |          |

  @aws
  Scenario: PostConditions-Delete the AWS bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "TestAnalyzer" in bucket "asgqajsonanalyzerb2"
    Given user "Delete" objects in amazon directory "TestDataSeperate" in bucket "asgqajsonanalyzer"
    Given user "Delete" objects in amazon directory "TestAnalyzerAll" in bucket "asgqajsonanalyzer"
    Given user "Delete" objects in amazon directory "" in bucket "asg-qa-emr-jsonanalyzer"
    Then user "Delete" a bucket "asgqajsonanalyzerb2" in amazon storage service
    Then user "Delete" a bucket "asgqajsonanalyzer" in amazon storage service
    Then user "Delete" a bucket "asg-qa-emr-jsonanalyzer" in amazon storage service

  @cr-data
  Scenario Outline: PostConditions-Delete Credentials, Datasource and cataloger config for Json S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                 | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger                              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JsonS3Analyzer/JsonS3Analyzer                                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JsonS3DataSource/JsonS3DataSource                                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JsonS3DataSource/JsonS3DataSource                                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource/AmazonS3DataSource                            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidJsonReadWriteCredentials                                  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidJsonReadOnlyCredentials                                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidJsonCredentials                                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyJsonCredentials                                           |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EDIBusValidCredentials                                         |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusDS_JsonS3Analyzer                         |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBusJsonS3Analyzer                                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=JsonS3Analyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/JsonS3PII                                                        |      | 204           |                  |          |

  @cr-data
  Scenario: PostConditions-Delete the businessApplication tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type                | query | param |
      | SingleItemDelete | Default | Test_BA_JsonS3Analyzer | BusinessApplication |       |       |
