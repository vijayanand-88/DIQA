@MLP-23701
Feature: Verification of ParquetS3Analyzer IDA Plugin

  Pre-requisites to be done in script before every run:
  1. Give a name to create a cluster in step SC#1 (Under Pre condition)
  2. Give the same cluster name in step SC#1 for retreiving the cluster ID (Under Pre condition)
  3. Give the same cluster name in step SC#31 for terminating the cluster (Under Post condition)

  ############################################# Pre Conditions ##########################################################
  @aws @precondition
  Scenario:SC#1: Update AWS secret key and access from config file
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                                 | accessKeyPath                   | secretKeyPath                   |
      | ida/s3ParquetAnalyzerPayloads/Credentials/parquetS3ValidCredentials.json | $.parquetCredentials..accessKey | $.parquetCredentials..secretKey |
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                                 | accessKeyPath                           | secretKeyPath                           |
      | ida/s3ParquetAnalyzerPayloads/Credentials/parquetS3ValidCredentials.json | $.parquetReadOnlyCredentials..accessKey | $.parquetReadOnlyCredentials..secretKey |

  @cr-data
  Scenario Outline:SC#1: Configure the Credentials for Parquet S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                   | bodyFile                                                                          | path                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidParquetReadWriteCredentials | payloads/ida/s3ParquetAnalyzerPayloads/Credentials/parquetS3ValidCredentials.json | $.parquetCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidParquetReadOnlyCredentials  | payloads/ida/s3ParquetAnalyzerPayloads/Credentials/parquetS3ValidCredentials.json | $.parquetReadOnlyCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/InvalidParquetCredentials        | payloads/ida/s3ParquetAnalyzerPayloads/Credentials/parquetS3ValidCredentials.json | $.parquetInvalidCredentials  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EmptyParquetCredentials          | payloads/ida/s3ParquetAnalyzerPayloads/Credentials/parquetS3ValidCredentials.json | $.parquetEmptyCredentials    | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials           | payloads/ida/s3ParquetAnalyzerPayloads/Credentials/parquetS3ValidCredentials.json | $.validEDIBusCredentials     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidParquetReadWriteCredentials |                                                                                   |                              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidParquetReadOnlyCredentials  |                                                                                   |                              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/InvalidParquetCredentials        |                                                                                   |                              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EmptyParquetCredentials          |                                                                                   |                              | 200           |                  |          |

  @cr-data
  Scenario Outline:SC#1: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3ParquetAnalyzerPayloads/ParquetS3AnalyzerBA.json | 200           |                  |          |

  @cr-data
  Scenario: SC#1: Configure the Parquet S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                    | body                                                              | response code | response message    | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/ParquetS3DataSource | ida/s3ParquetAnalyzerPayloads/DataSource/parquetS3DataSource.json | 204           |                     |          |
      |                  |       |       | Get  | settings/analyzers/ParquetS3DataSource |                                                                   | 200           | ParquetS3DataSource |          |

  @aws @cr-data
  Scenario: SC#1:Create a bucket and folder with parquet files in S3 Amazon storage
    Given user "Create" a bucket "asgqaparquetanalyzer" in amazon storage service
    Given user "Create" a bucket "asgqaparquetanalyzerb2" in amazon storage service
    Given user "Create" a bucket "asg-qa-emr-parquetanalyzer" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName             | keyPrefix        | dirPath                                                 | recursive |
      | asgqaparquetanalyzer   | TestAnalyzerAll  | ida/s3ParquetAnalyzerPayloads/TestData/TestAnalyzerAll  | true      |
      | asgqaparquetanalyzer   | TestDataSeperate | ida/s3ParquetAnalyzerPayloads/TestData/TestDataSeperate | true      |
      | asgqaparquetanalyzerb2 | TestAnalyzer     | ida/s3ParquetAnalyzerPayloads/TestData/Bucket2          | true      |

  @aws @cr-data
  Scenario: SC#1:Create an EMR cluster or Retrieve EMR Cluster ID in Amazon EMR service
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action                    | clusterName                  | filePath                                                                                             | jsonPath        |
      | CreateCluster             | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/ClusterData/clusterdata.json                                           |                 |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerDryRunTrue.json                   | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerSC1.json                          | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerBucketInclude.json                | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerBucketExcludeRegex.json           | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerDirectoryInclude.json             | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerSubDirIncludeRegex.json           | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerSubDirExclude.json                | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerFileInclude.json                  | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerFileExcludeRegex.json             | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3Analyzer_NodeCondition_WorkingBucket.json | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerPIITags.json                      | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerNonExistingBucket.json            | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerNonExistingSubDir.json            | $..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaparquet4 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerNonExistingFile.json              | $..emrClusterId |

  #################### DataSource TestConnection - UI Validation Error in Mandatory Fields ####################
  #7110835#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in green when test connection is successful for ParquetS3DataSource in LocalNode
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
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute               |
      | Name      | ParquetS3TestDataSource |
      | Label     | ParquetS3TestDataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | ValidParquetReadWriteCredentials  |
      | Deployment | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  #7110835#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in red when test connection is not successful for ParquetS3DataSource in LocalNode
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
      | Credential | InvalidParquetCredentials         |
      | Deployment | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute               |
      | Credential | EmptyParquetCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"

  #7110832#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#2:Verify proper error message is shown if mandatory fields are not filled in ParquetS3Analyzer configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute         |
      | Type      | Dataanalyzer      |
      | Plugin    | ParquetS3Analyzer |
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
      | Data Source*               |
      | Credential*                |
      | File filter                |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName             | validationMessage                               |
      | Name                  | Name field should not be empty                  |
      | Bucket Name           | Bucket Name field should not be empty           |
      | Amazon EMR Cluster ID | Amazon EMR Cluster ID field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ######################################## PluginRun - ParquetS3Cataloger ########################################
  @cr-data
  Scenario Outline: SC#3:Configure & run the ParquetS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                         | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                 | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                 |                                                                              | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger |                                                                              | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  | ida/empty.json                                                               | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger |                                                                              | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |

  ######################################## PluginRun - ParquetS3Analyzer - DryRun True ########################################
  #7110835#
  @cr-data
  Scenario Outline: SC#4:Configure & run the ParquetS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                               | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerDryRunTrue.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                    | 200           | ParquetS3Analyzer |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                    | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                    | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |

  @MLP-23701 @parquets3analyzer
  Scenario: SC#4:UI_Validation: Verify ParquetS3Analyzer plugin functionality with dry run as true
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                           | Action                | query         | TableName/Filename                               |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_true.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |
    Then Analysis log "dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer%" should display below info/error/warning
      | type | logValue                                         | logCode       | pluginName        | removableText |
      | INFO | Plugin ParquetS3Analyzer running on dry run mode | ANALYSIS-0069 | ParquetS3Analyzer |               |

  @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |

  ######################################## Invalid EMR Cluster ID ########################################
  #7110833#
  @cr-data
  Scenario Outline: SC#5:Configure & run the ParquetS3Analyzer with Invalid EMR Cluster ID
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerInvalidEMRCluster.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                           | 200           | ParquetS3Analyzer |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                           | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                           | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |

  @MLP-23701 @parquets3analyzer
  Scenario: SC#5:Verify ParquetS3Analyzer is not executed successfully even when Invalid EMR Cluster ID is passed as input.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                             | Action                | query         | TableName/Filename                               |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_Invalid_EMRID.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |
    Then Analysis log "dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer%" should display below info/error/warning
      | type  | logValue                                                                                    | logCode     | pluginName | removableText |
      | ERROR | An error occurred while running Amazon S3 analyzer plugin: Specified job flow ID not valid. | AWS_S3-0014 |            |               |

  @sanity @positive
  Scenario:SC#5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |

  ######################################## PluginRun - ParquetS3Analyzer - DryRun False ########################################
  @cr-data
  Scenario Outline: SC#6:Configure & run the ParquetS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                        | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerSC1.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                             | 200           | ParquetS3Analyzer |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                             | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                              | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                             | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |

  ############################ Logging Enhancements ############################
  #7110835#
  @MLP-23701 @parquets3analyzer
  Scenario: SC#7:LoggingEnhancements: Verify ParquetS3Analyzer collects Analysis item with proper log messages
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                            | Action                | query         | TableName/Filename                               |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_false.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |
    Then Analysis log "dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:ParquetS3Analyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:e5915a6c4e83, Plugin Configuration name:ParquetS3Analyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0071 | ParquetS3Analyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: ---  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: name: "ParquetS3Analyzer"  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: pluginVersion: "LATEST"  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: label:  2020-06-24 10:27:25.816 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: : ""  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: catalogName: "Default"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: eventClass: null  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: eventCondition: null  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: maxWorkSize: 100  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: tags:  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: - "AnalyzeParquetS3"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: pluginType: "dataanalyzer"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: dataSource: "ParquetS3DataSource"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: credential: "ValidParquetReadWriteCredentials"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: businessApplicationName: "Test_BA_ParquetS3Analyzer"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: schedule: null  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: filter: null  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: emrClusterId: "j-12133O1NV2B1XKOXB"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: histogramBuckets: 100  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: bucketName: "asg-qa-emr-parquetanalyzer"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: dryRun: false  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: cleanupAfterRun: true  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: pluginName: "ParquetS3Analyzer"  2020-06-24 10:27:25.817 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: incremental: true  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: type: "Dataanalyzer"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: bucketFilter:  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: mode: "INCLUDE"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: patterns: []  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: objectFilter:  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: dirFilter:  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: mode: "INCLUDE"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: patterns: []  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: fileFilter:  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: mode: "INCLUDE"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: patterns: []  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: dirPrefixes: []  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: dataSampleSize: 25  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: restrictRegion: "us-east-1"  2020-06-24 10:27:25.818 INFO  - ANALYSIS-0073: Plugin ParquetS3Analyzer Configuration: topValues: 10 | ANALYSIS-0073 | ParquetS3Analyzer | emrClusterId   |
      | INFO | Plugin ParquetS3Analyzer Start Time:2020-06-24 10:27:25.815, End Time:2020-06-24 10:31:19.002, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | ParquetS3Analyzer |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0020 |                   |                |

  ############################ Metadata Lifecycle & Statistics Validation ############################
  #7110816#
  @MLP-23701 @parquets3analyzer
  Scenario:SC#8:Verify the 'Number of rows' and 'Last analyzed at' attribute for File type after ParquetS3Analyzer is executed.
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                                | jsonPath                | Action                    | query     | TableName/Filename       | ClusterName   | ServiceName | directoryName |
      | Lifecycle  | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle  | metadataAttributePresence | FileQuery | userpatternmatch.parquet | amazonaws.com | AmazonS3    | parquet       |
      | Statistics | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Statistics | metadataValuePresence     | FileQuery | userpatternmatch.parquet | amazonaws.com | AmazonS3    | parquet       |

  ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @parquets3analyzer
  Scenario Outline:SC9:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid                    | targetFile                                            | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | all  | parquetExampleEmployee.parquet | payloads/ida/s3ParquetAnalyzerPayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @parquets3analyzer
  Scenario Outline: SC9:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                             | outPutFile                                                   | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/s3ParquetAnalyzerPayloads/API/items.json | payloads\ida\s3ParquetAnalyzerPayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @parquets3analyzer
  Scenario: SC#9 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\s3ParquetAnalyzerPayloads\API\Actual\File1.json" should be same as the content in "ida\s3ParquetAnalyzerPayloads\API\Expected\File1.json"

############################################################### Data Profiling #########################################################################################

  #7110818# #7110821#
  @MLP-23701 @parquets3analyzer
  Scenario:SC#10:Verify the data profiling metadata information for string datatype in S3 Parquet file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                   | Action                | query          | TableName/Filename            | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_1 | metadataValuePresence | FileFieldQuery | combo_parquetEmployee.parquet | amazonaws.com | AmazonS3    | combo         | empname              |
      | Statistics  | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_1  | metadataValuePresence | FileFieldQuery | combo_parquetEmployee.parquet | amazonaws.com | AmazonS3    | combo         | empname              |


  #7110818# #7110823#
  @MLP-23701 @parquets3analyzer
  Scenario:SC#11:Verify the data profiling metadata information for numeric datatype in S3 Parquet file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                   | Action                    | query          | TableName/Filename            | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Lifecycle   | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence | FileFieldQuery | combo_parquetEmployee.parquet | amazonaws.com | AmazonS3    | combo         | empid                |
      | Statistics  | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_2  | metadataValuePresence     | FileFieldQuery | combo_parquetEmployee.parquet | amazonaws.com | AmazonS3    | combo         | empid                |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_6 | metadataValuePresence     | FileFieldQuery | combo_parquetEmployee.parquet | amazonaws.com | AmazonS3    | combo         | empid                |

  #7110818# #7110822#
  @MLP-23701 @parquets3analyzer
  Scenario:SC#12:Verify the data profiling metadata information for date datatype in S3 Parquet file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                   | Action                    | query          | TableName/Filename           | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Lifecycle   | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence | FileFieldQuery | dateTimestampExample.parquet | amazonaws.com | AmazonS3    | parquet       | date                 |
      | Statistics  | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_4  | metadataValuePresence     | FileFieldQuery | dateTimestampExample.parquet | amazonaws.com | AmazonS3    | parquet       | date                 |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_2 | metadataValuePresence     | FileFieldQuery | dateTimestampExample.parquet | amazonaws.com | AmazonS3    | parquet       | date                 |

  #7110835#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#13:Verify breadcrumb hierarchy appears correctly in ParquetS3Analyzer analyzed items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "state" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "userpatternmatch.parquet [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "state" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com            |
      | AmazonS3                 |
      | asgqaparquetanalyzer     |
      | TestDataSeperate         |
      | parquet                  |
      | userpatternmatch.parquet |
      | address                  |
      | state                    |
    And user clicks on logout button

  ############################ Tags verification ############################
  #7110835#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#14:Tech_tags_Explicit_Tags verification: Verify the technology tags, Business Application, Explicit tags got assigned to the analyzed items
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename             | Column | Tags                                                                          | Query          | Action         |
      | amazonaws.com | AmazonS3    | parquet       | userpatternmatchsimple.parquet |        | AnalyzeParquetS3,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3 | FileQuery      | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | dateTimestampExample.parquet   | date   | AnalyzeParquetS3,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | userpatternmatchsimple.parquet |        | Data Files                                                                    | FileQuery      | TagNotAssigned |

  ############################ EDIBus verification ############################
#  #7110835#
#  @MLP-23701 @webtest @parquets3analyzer @edibus
#  Scenario: Verify the Parquet S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "CatalogParquetS3" and clicks on search
#    And user performs "facet selection" in "CatalogParquetS3" attribute under "Tags" facets in Item Search results page
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
#    And user update json file "idc/EdiBusPayloads/datasource/EDIBusDS_ParquetS3Analyzer.json" file for following values using property loader
#      | jsonPath        | jsonValues  |
#      | $..['EDI host'] | EDIHostName |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                          | body                                                          | response code | response message | jsonPath                                                     |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                          | idc/EdiBusPayloads/datasource/EDIBusDS_ParquetS3Analyzer.json | 204           |                  |                                                              |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                                    | idc/EdiBusPayloads/ParquetS3AnalyzerEDIConfig.json            | 204           |                  |                                                              |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusParquetS3Analyzer |                                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusParquetS3Analyzer')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusParquetS3Analyzer  |                                                               | 200           |                  |                                                              |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusParquetS3Analyzer |                                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusParquetS3Analyzer')].status |
#    And user enters the search text "EDIBusParquetS3Analyzer" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusParquetS3Analyzer%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "AnalyzeParquetS3" and clicks on search
#    And user performs "facet selection" in "AnalyzeParquetS3" attribute under "Tags" facets in Item Search results page
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
#      | Header | Query | Param | type | url                                                                                                             | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AnalyzeParquetS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "AnalyzeParquetS3" and clicks on search
#    And user performs "facet selection" in "AnalyzeParquetS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Parquet" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @*Parquet≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | S3PARQUET   | 1.0                | (XNAME * *  ~/ @*Parquet≫DEFAULT≫DWR_DAT_FIELD≫@* ),AND,( TYPE = DWR_IDC ) |

  @sanity @positive
  Scenario:SC#14:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  ############################################# Filter Scenarios ##########################################################
  #Filter - Bucket Include#
  @cr-data
  Scenario Outline: SC#15:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: Bucket Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                  | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json          | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                       | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                        | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerBucketInclude.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                       | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                        | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7110824#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#15: Verify ParquetS3Analyzer is executed successfully with filters - BucketName Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeParquetS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.parquet                                    |
      | userpatternmatchsimple.parquet                              |
      | userhugedata.parquet                                        |
      | dateTimestampExample.parquet                                |
      | tagdetails_allmatch_parquet.parquet                         |
      | tagdetails_allempty_parquet.parquet                         |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   |
      | combo_parquetEmployee.parquet                               |
      | parquetExampleEmployee.parquet                              |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_parquetEmployee.parquet |
    And user enters the search text "AnalyzeParquetS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatch.parquet" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogParquetS3" and clicks on search
    And user performs "facet selection" in "CatalogParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "b2_parquetEmployee.parquet" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                                        | fileName                   | userTag                       |
      | Default     | File | Metadata Type | AnalyzeParquetS3BucketInclude,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3 | userpatternmatch.parquet   | AnalyzeParquetS3BucketInclude |
      | Default     | File | Metadata Type | CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3                               | b2_parquetEmployee.parquet | CatalogParquetS3              |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#15:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  #Filter - Bucket Exclude#
  @cr-data
  Scenario Outline: SC#16:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: Bucket Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                       | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json               | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                            | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                             | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerBucketExcludeRegex.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                            | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                             | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7110825#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#16: Verify ParquetS3Analyzer is executed successfully with filters - Bucket Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeParquetS3BucketExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3BucketExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | b2_parquetEmployee.parquet |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.parquet                                    |
      | userpatternmatchsimple.parquet                              |
      | userhugedata.parquet                                        |
      | dateTimestampExample.parquet                                |
      | tagdetails_allmatch_parquet.parquet                         |
      | tagdetails_allempty_parquet.parquet                         |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   |
      | combo_parquetEmployee.parquet                               |
      | parquetExampleEmployee.parquet                              |
    And user performs "item click" on "b2_parquetEmployee.parquet" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogParquetS3" and clicks on search
    And user performs "facet selection" in "CatalogParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatch.parquet" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                                        | fileName                   | userTag                       |
      | Default     | File | Metadata Type | AnalyzeParquetS3BucketExclude,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3 | b2_parquetEmployee.parquet | AnalyzeParquetS3BucketExclude |
      | Default     | File | Metadata Type | CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3                               | userpatternmatch.parquet   | CatalogParquetS3              |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#16:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  #Filter - Directory Include#
  @cr-data
  Scenario Outline: SC#17:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: Bucketname (Include)/Directory
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                     | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json             | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                          | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                           | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerDirectoryInclude.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                          | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                           | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7110826#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#17:Verify ParquetS3Analyzer is executed successfully with filters - Bucketname (Include)/Directory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeParquetS3DirectoryInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3DirectoryInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | parquetExampleEmployee.parquet |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_parquetEmployee.parquet                                  |
      | userpatternmatch.parquet                                    |
      | userpatternmatchsimple.parquet                              |
      | userhugedata.parquet                                        |
      | dateTimestampExample.parquet                                |
      | tagdetails_allmatch_parquet.parquet                         |
      | tagdetails_allempty_parquet.parquet                         |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   |
      | combo_parquetEmployee.parquet                               |
    And user performs "item click" on "parquetExampleEmployee.parquet" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogParquetS3" and clicks on search
    And user performs "facet selection" in "CatalogParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "b2_parquetEmployee.parquet" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                                           | fileName                            | userTag                          |
      | Default     | File | Metadata Type | AnalyzeParquetS3DirectoryInclude,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3 | parquetExampleEmployee.parquet      | AnalyzeParquetS3DirectoryInclude |
      | Default     | File | Metadata Type | CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3                                  | tagdetails_allempty_parquet.parquet | CatalogParquetS3                 |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#17:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  #Filter - Sub Directory Include#
  @cr-data
  Scenario Outline: SC#18:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: Bucket Include & SubDirectory Include Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                       | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json               | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                            | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                             | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerSubDirIncludeRegex.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                            | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                             | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |


  #7110827#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#18: Verify ParquetS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Include Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeParquetS3SubDirInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3SubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.parquet                                    |
      | userpatternmatchsimple.parquet                              |
      | userhugedata.parquet                                        |
      | dateTimestampExample.parquet                                |
      | tagdetails_allmatch_parquet.parquet                         |
      | tagdetails_allempty_parquet.parquet                         |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_parquetEmployee.parquet     |
      | combo_parquetEmployee.parquet  |
      | parquetExampleEmployee.parquet |
    And user enters the search text "AnalyzeParquetS3SubDirInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3SubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatch.parquet" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogParquetS3" and clicks on search
    And user performs "facet selection" in "CatalogParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_parquetEmployee.parquet" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                                        | fileName                      | userTag                       |
      | Default     | File | Metadata Type | AnalyzeParquetS3SubDirInclude,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3 | userpatternmatch.parquet      | AnalyzeParquetS3SubDirInclude |
      | Default     | File | Metadata Type | CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3                               | combo_parquetEmployee.parquet | CatalogParquetS3              |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#18:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  #Filter - SubDirectory Exclude#
  @cr-data
  Scenario Outline: SC#19:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: Bucket Include & SubDirectory Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                  | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json          | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                       | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                        | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerSubDirExclude.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                       | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                        | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7110828#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#19: Verify ParquetS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeParquetS3SubDirExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3SubDirExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | combo_parquetEmployee.parquet  |
      | parquetExampleEmployee.parquet |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_parquetEmployee.parquet                                  |
      | userpatternmatch.parquet                                    |
      | userpatternmatchsimple.parquet                              |
      | userhugedata.parquet                                        |
      | dateTimestampExample.parquet                                |
      | tagdetails_allmatch_parquet.parquet                         |
      | tagdetails_allempty_parquet.parquet                         |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   |
    And user performs "item click" on "combo_parquetEmployee.parquet" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogParquetS3" and clicks on search
    And user performs "facet selection" in "CatalogParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchsimple.parquet" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                                        | fileName                       | userTag                       |
      | Default     | File | Metadata Type | AnalyzeParquetS3SubDirExclude,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3 | combo_parquetEmployee.parquet  | AnalyzeParquetS3SubDirExclude |
      | Default     | File | Metadata Type | CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet,Amazon S3                               | userpatternmatchsimple.parquet | CatalogParquetS3              |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#19:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  #Filter - File Include#
  @cr-data
  Scenario Outline: SC#20:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: File Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json        | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                     | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                     | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                      | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                     | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerFileInclude.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                     | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                     | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                      | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                     | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |


  #7110830#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#20: Verify ParquetS3Analyzer is executed successfully with filters - File Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeParquetS3FileInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3FileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.parquet |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_parquetEmployee.parquet                                  |
      | combo_parquetEmployee.parquet                               |
      | parquetExampleEmployee.parquet                              |
      | userpatternmatchsimple.parquet                              |
      | userhugedata.parquet                                        |
      | dateTimestampExample.parquet                                |
      | tagdetails_allmatch_parquet.parquet                         |
      | tagdetails_allempty_parquet.parquet                         |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   |
    And user performs "item click" on "userpatternmatch.parquet" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogParquetS3" and clicks on search
    And user performs "facet selection" in "CatalogParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_parquetEmployee.parquet" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                            | fileName                      | userTag                     |
      | Default     | File | Metadata Type | AnalyzeParquetS3FileInclude,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet | userpatternmatch.parquet      | AnalyzeParquetS3FileInclude |
      | Default     | File | Metadata Type | CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet                             | combo_parquetEmployee.parquet | CatalogParquetS3            |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#20:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  #Filter - File Exclude#
  @cr-data
  Scenario Outline: SC#21:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: File Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                     | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json             | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                          | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                           | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerFileExcludeRegex.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                          | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                           | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7110831#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#21: Verify ParquetS3Analyzer is executed successfully with filters - File Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeParquetS3FileExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3FileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.parquet       |
      | userpatternmatchsimple.parquet |
      | userhugedata.parquet           |
      | dateTimestampExample.parquet   |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_parquetEmployee.parquet                                  |
      | combo_parquetEmployee.parquet                               |
      | parquetExampleEmployee.parquet                              |
      | tagdetails_allmatch_parquet.parquet                         |
      | tagdetails_allempty_parquet.parquet                         |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   |
    And user performs "item click" on "userpatternmatch.parquet" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogParquetS3" and clicks on search
    And user performs "facet selection" in "CatalogParquetS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_parquetEmployee.parquet" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                            | fileName                      | userTag                     |
      | Default     | File | Metadata Type | AnalyzeParquetS3FileExclude,CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet | userpatternmatch.parquet      | AnalyzeParquetS3FileExclude |
      | Default     | File | Metadata Type | CatalogParquetS3,Test_BA_ParquetS3Analyzer,Parquet                             | combo_parquetEmployee.parquet | CatalogParquetS3            |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#21:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  ############################################# Node Condition Internal Node ##########################################################
  @cr-data
  Scenario Outline: SC#22:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: Specific Node condition and non-existing working bucket name
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                                                 | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                     | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3Cataloger_NodeCondition.json              | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                     |                                                                                                      | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                                      | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                                       | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                                      | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                      | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3Analyzer_NodeCondition_WorkingBucket.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                      |                                                                                                      | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                                      | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                                       | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                                      | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7110835# #7110836#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#22: Verify ParquetS3Analyzer is executed successfully for scenario: Specific Node condition and non-existing working bucket name
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeParquetS3NodeCondition" and clicks on search
    And user performs "facet selection" in "AnalyzeParquetS3NodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.parquet                                    |
      | userpatternmatchsimple.parquet                              |
      | userhugedata.parquet                                        |
      | dateTimestampExample.parquet                                |
      | b2_parquetEmployee.parquet                                  |
      | combo_parquetEmployee.parquet                               |
      | parquetExampleEmployee.parquet                              |
      | tagdetails_allmatch_parquet.parquet                         |
      | tagdetails_allempty_parquet.parquet                         |
      | tagdetails_ratiolessthan05emptyfalse_parquet.parquet        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet |
      | tagdetails_ratioequalto05emptyfalse_parquet.parquet         |
      | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet  |
      | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet   |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#22:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  ######################################## Non existing buckets/ sub-directory/ file ########################################
  #7110834#
  @cr-data
  Scenario Outline: SC#23:Configure & run the ParquetS3Analyzer for Non existing buckets
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                      | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json              | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                           | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                           | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                           | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerNonExistingBucket.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                           | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                           | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                            | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                           | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  @MLP-23701 @parquets3analyzer
  Scenario: SC#23:Verify the error message in logs when ParquetS3Analyzer is executed with Non existing buckets in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                   | Action                | query         | TableName/Filename                               |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |
    Then Analysis log "dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#23:Configure & run the ParquetS3Analyzer for Non existing sub directories
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerNonExistingSubDir.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                           | 200           | ParquetS3Analyzer |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                           | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                           | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |

  @MLP-23701 @parquets3analyzer
  Scenario: SC#23:Verify the error message in logs when ParquetS3Analyzer is executed with Non existing sub directory in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                   | Action                | query         | TableName/Filename                               |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |
    Then Analysis log "dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#23:Configure & run the ParquetS3Analyzer for Non existing file
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                    | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerNonExistingFile.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                         | 200           | ParquetS3Analyzer |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                         | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                          | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                         | 200           | IDLE              | $.[?(@.configurationName=='ParquetS3Analyzer')].status |

  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#23:Verify the error message in logs when ParquetS3Analyzer is executed with Non existing file in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                   | Action                | query         | TableName/Filename                               |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |
    Then Analysis log "dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @sanity @positive
  Scenario:SC#23:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |

  ############################################ Policy Patterns - PII Tagging ##########################################################
  Scenario Outline:SC#24:Create root tag and sub tag for ParquetS3 and Update policy tags for ParquetS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/s3ParquetAnalyzerPayloads/policyEngine/parquetS3TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/s3ParquetAnalyzerPayloads/policyEngine/parquetS3_policy1.1.0.json | 204           |                  |          |

  @cr-data
  Scenario Outline: SC#24:Configure & run the ParquetS3Cataloger and ParquetS3Analyzer for scenario: Policy Patterns - PII Tagging
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                            | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerSC1.json    | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                 | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                  | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerPIITags.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                 | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                  | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7110837# #7110838# #7110840# #7110842# #7110887# #7110893# #7110895# #7110898# #7110859#
  @MLP-23701 @webtest @parquets3analyzer @PIITag
  Scenario: SC#24: Verify PII Tags gets assigned to the below fields in file: tagdetails_allmatch_parquet.parquet
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                  | Column    | Tags                                                                                                                                                | Query          | Action         |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | GENDER    | ParquetS3GenderPII_SC1Tag,ParquetS3GenderPII_SC3Tag,ParquetS3GenderPII_SC8Tag,PARQUET,Amazon S3                                                     | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC1Tag,ParquetS3FullNamePII_SC3Tag,ParquetS3FullNamePII_SC8Tag,PARQUET,Amazon S3                                               | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | SSN       | ParquetS3SSNPII_SC1Tag,ParquetS3SSNPII_SC3Tag,ParquetS3SSNPII_SC8Tag,PARQUET,Amazon S3                                                              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC1Tag,ParquetS3IPAddressPII_SC3Tag,ParquetS3IPAddressPII_SC8Tag,PARQUET,Amazon S3                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | GENDER    | ParquetS3GenderPII_SC2Tag,ParquetS3GenderPII_SC4Tag,ParquetS3GenderPII_SC11Tag,ParquetS3GenderPII_SC12Tag,ParquetS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | EMAIL     | ParquetS3EmailPII_SC2Tag,ParquetS3EmailPII_SC4Tag,ParquetS3EmailPII_SC11Tag,ParquetS3EmailPII_SC12Tag,ParquetS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC2Tag,ParquetS3FullNamePII_SC4Tag,ParquetS3FullNamePII_SC11Tag,ParquetS3FullNamePII_SC12Tag,ParquetS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | SSN       | ParquetS3SSNPII_SC2Tag,ParquetS3SSNPII_SC4Tag,ParquetS3SSNPII_SC11Tag,ParquetS3SSNPII_SC12Tag,ParquetS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allmatch_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC2Tag,ParquetS3IPAddressPII_SC4Tag,ParquetS3IPAddressPII_SC11Tag,ParquetS3IPAddressPII_SC12Tag,ParquetS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7110837# #7110838# #7110840# #7110842# #7110887# #7110893# #7110895# #7110898# #7110899#
  @MLP-23701 @webtest @parquets3analyzer @PIITag
  Scenario: SC#25: Verify PII Tags gets assigned to the below fields in file: tagdetails_allempty_parquet.parquet
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                  | Column    | Tags                                                                                                                                                | Query          | Action         |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allempty_parquet.parquet | SSN       | ParquetS3SSNPII_SC1Tag,ParquetS3SSNPII_SC3Tag,ParquetS3SSNPII_SC14Tag,PARQUET,Amazon S3                                                             | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allempty_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC1Tag,ParquetS3IPAddressPII_SC3Tag,ParquetS3IPAddressPII_SC14Tag,PARQUET,Amazon S3                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allempty_parquet.parquet | GENDER    | ParquetS3GenderPII_SC2Tag,ParquetS3GenderPII_SC4Tag,ParquetS3GenderPII_SC11Tag,ParquetS3GenderPII_SC12Tag,ParquetS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allempty_parquet.parquet | EMAIL     | ParquetS3EmailPII_SC2Tag,ParquetS3EmailPII_SC4Tag,ParquetS3EmailPII_SC11Tag,ParquetS3EmailPII_SC12Tag,ParquetS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allempty_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC2Tag,ParquetS3FullNamePII_SC4Tag,ParquetS3FullNamePII_SC11Tag,ParquetS3FullNamePII_SC12Tag,ParquetS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allempty_parquet.parquet | SSN       | ParquetS3SSNPII_SC2Tag,ParquetS3SSNPII_SC4Tag,ParquetS3SSNPII_SC11Tag,ParquetS3SSNPII_SC12Tag,ParquetS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_allempty_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC2Tag,ParquetS3IPAddressPII_SC4Tag,ParquetS3IPAddressPII_SC11Tag,ParquetS3IPAddressPII_SC12Tag,ParquetS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7110837# #7110838# #7110840# #7110842# #7110887# #7110893# #7110895# #7110898# #7110845#
  @MLP-23701 @webtest @parquets3analyzer @PIITag
  Scenario: SC#26: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolessthan05emptyfalse_parquet.parquet
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                   | Column    | Tags                                                                                                                                                | Query          | Action         |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | GENDER    | ParquetS3GenderPII_SC1Tag,ParquetS3GenderPII_SC3Tag,ParquetS3GenderPII_SC5Tag,PARQUET,Amazon S3                                                     | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC5Tag,ParquetS3FullNamePII_SC10Tag,PARQUET,Amazon S3                                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | SSN       | ParquetS3SSNPII_SC5Tag,ParquetS3SSNPII_SC10Tag,PARQUET,Amazon S3                                                                                    | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC1Tag,ParquetS3IPAddressPII_SC3Tag,ParquetS3IPAddressPII_SC5Tag,ParquetS3IPAddressPII_SC10Tag,PARQUET,Amazon S3              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | GENDER    | ParquetS3GenderPII_SC2Tag,ParquetS3GenderPII_SC4Tag,ParquetS3GenderPII_SC11Tag,ParquetS3GenderPII_SC12Tag,ParquetS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | EMAIL     | ParquetS3EmailPII_SC2Tag,ParquetS3EmailPII_SC4Tag,ParquetS3EmailPII_SC11Tag,ParquetS3EmailPII_SC12Tag,ParquetS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC2Tag,ParquetS3FullNamePII_SC4Tag,ParquetS3FullNamePII_SC11Tag,ParquetS3FullNamePII_SC12Tag,ParquetS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | SSN       | ParquetS3SSNPII_SC2Tag,ParquetS3SSNPII_SC4Tag,ParquetS3SSNPII_SC11Tag,ParquetS3SSNPII_SC12Tag,ParquetS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolessthan05emptyfalse_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC2Tag,ParquetS3IPAddressPII_SC4Tag,ParquetS3IPAddressPII_SC11Tag,ParquetS3IPAddressPII_SC12Tag,ParquetS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7110837# #7110838# #7110840# #7110842# #7110887# #7110893# #7110895# #7110898# #71110850# #71110853#
  @MLP-23701 @webtest @parquets3analyzer @PIITag
  Scenario: SC#27: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                          | Column    | Tags                                                                                                                                                | Query          | Action         |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetS3GenderPII_SC1Tag,ParquetS3GenderPII_SC3Tag,ParquetS3GenderPII_SC7Tag,PARQUET,Amazon S3                                                     | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC1Tag,ParquetS3FullNamePII_SC3Tag,ParquetS3FullNamePII_SC7Tag,PARQUET,Amazon S3                                               | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetS3SSNPII_SC1Tag,ParquetS3SSNPII_SC3Tag,ParquetS3SSNPII_SC7Tag,PARQUET,Amazon S3                                                              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC1Tag,ParquetS3IPAddressPII_SC3Tag,ParquetS3IPAddressPII_SC6Tag,ParquetS3IPAddressPII_SC7Tag,PARQUET,Amazon S3               | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | GENDER    | ParquetS3GenderPII_SC2Tag,ParquetS3GenderPII_SC4Tag,ParquetS3GenderPII_SC11Tag,ParquetS3GenderPII_SC12Tag,ParquetS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | EMAIL     | ParquetS3EmailPII_SC2Tag,ParquetS3EmailPII_SC4Tag,ParquetS3EmailPII_SC11Tag,ParquetS3EmailPII_SC12Tag,ParquetS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC2Tag,ParquetS3FullNamePII_SC4Tag,ParquetS3FullNamePII_SC11Tag,ParquetS3FullNamePII_SC12Tag,ParquetS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | SSN       | ParquetS3SSNPII_SC2Tag,ParquetS3SSNPII_SC4Tag,ParquetS3SSNPII_SC11Tag,ParquetS3SSNPII_SC12Tag,ParquetS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05emptyfalsetrue_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC2Tag,ParquetS3IPAddressPII_SC4Tag,ParquetS3IPAddressPII_SC11Tag,ParquetS3IPAddressPII_SC12Tag,ParquetS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7110837# #7110838# #7110840# #7110842# #7110887# #7110893# #7110895# #7110898# #7110875#
  @MLP-23701 @webtest @parquets3analyzer @PIITag
  Scenario: SC#28: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratioequalto05emptyfalse_parquet.parquet
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                  | Column    | Tags                                                                                                                                                | Query          | Action         |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | GENDER    | ParquetS3GenderPII_SC1Tag,ParquetS3GenderPII_SC3Tag,ParquetS3GenderPII_SC9Tag,PARQUET,Amazon S3                                                     | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC1Tag,ParquetS3FullNamePII_SC3Tag,ParquetS3FullNamePII_SC9Tag,PARQUET,Amazon S3                                               | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | SSN       | ParquetS3SSNPII_SC1Tag,ParquetS3SSNPII_SC3Tag,ParquetS3SSNPII_SC9Tag,PARQUET,Amazon S3                                                              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC1Tag,ParquetS3IPAddressPII_SC3Tag,ParquetS3IPAddressPII_SC9Tag,PARQUET,Amazon S3                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | GENDER    | ParquetS3GenderPII_SC2Tag,ParquetS3GenderPII_SC4Tag,ParquetS3GenderPII_SC11Tag,ParquetS3GenderPII_SC12Tag,ParquetS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | EMAIL     | ParquetS3EmailPII_SC2Tag,ParquetS3EmailPII_SC4Tag,ParquetS3EmailPII_SC11Tag,ParquetS3EmailPII_SC12Tag,ParquetS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | FULL_NAME | ParquetS3FullNamePII_SC2Tag,ParquetS3FullNamePII_SC4Tag,ParquetS3FullNamePII_SC11Tag,ParquetS3FullNamePII_SC12Tag,ParquetS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | SSN       | ParquetS3SSNPII_SC2Tag,ParquetS3SSNPII_SC4Tag,ParquetS3SSNPII_SC11Tag,ParquetS3SSNPII_SC12Tag,ParquetS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratioequalto05emptyfalse_parquet.parquet | IPADDRESS | ParquetS3IPAddressPII_SC2Tag,ParquetS3IPAddressPII_SC4Tag,ParquetS3IPAddressPII_SC11Tag,ParquetS3IPAddressPII_SC12Tag,ParquetS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7110900#
  @MLP-23701 @webtest @parquets3analyzer @PIITag
  Scenario: SC#29: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                         | Column   | Tags                         | Query          | Action         |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet | COMMENTS | ParquetS3FullMatchPII_SC2Tag | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiogreaterthan05matchfulltrue_parquet.parquet | COMMENTS | ParquetS3FullMatchPII_SC1Tag | FileFieldQuery | TagNotAssigned |


  #7110901#
  @MLP-23701 @webtest @parquets3analyzer @PIITag
  Scenario: SC#30: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                        | Column   | Tags                         | Query          | Action         |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet | COMMENTS | ParquetS3FullMatchPII_SC4Tag | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | parquet       | tagdetails_ratiolesserthan05matchfulltrue_parquet.parquet | COMMENTS | ParquetS3FullMatchPII_SC3Tag | FileFieldQuery | TagNotAssigned |


  @sanity @positive
  Scenario:SC#30:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |


  ############################################# Incremental scenario ##########################################################
  @cr-data
  Scenario Outline: SC#31:Configure & run the ParquetS3Cataloger - Incremental scenario Run 1
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                             | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerIncRun1.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                  | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Analyzer                                                   | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3AnalyzerSC1.json      | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Analyzer                                                   |                                                                                  | 200           | ParquetS3Analyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7125855#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#31: Verify ParquetS3Analyzer is executed successfully for scenario: Incremental scenario Run 1
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                   | Action                | query         | TableName/Filename                               |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_4 | metadataValuePresence | AnalysisQuery | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |

  @cr-data
  Scenario Outline: SC#31:Configure & run the ParquetS3Cataloger - Incremental scenario Run 2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                             | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                  | ida/s3ParquetAnalyzerPayloads/PluginConfiguration/ParquetS3CatalogerIncRun2.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                  |                                                                                  | 200           | ParquetS3Cataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger   | ida/empty.json                                                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger  |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer  | ida/empty.json                                                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='ParquetS3Analyzer')].status  |

  #7125855#
  @MLP-23701 @webtest @parquets3analyzer
  Scenario: SC#31: Verify ParquetS3Analyzer is executed successfully for scenario: Incremental scenario Run 2
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                | jsonPath                   | Action                | query         | TableName/Filename                               |
      | Description | ida/s3ParquetAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_5 | metadataValuePresence | AnalysisQuery | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer |


  Scenario: SC#31: Delete the items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                                     | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetS3Analyzer/ParquetS3Analyzer% | Analysis |       |       |


#  ############################################# Post Conditions ##########################################################
  Scenario: SC#32: Delete the businessApplication tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type                | query | param |
      | SingleItemDelete | Default | Test_BA_ParquetS3Analyzer | BusinessApplication |       |       |

  @aws
  Scenario: SC#32:Terminate an EMR cluster in Amazon EMR service
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action           | clusterName                  | filePath | jsonPath |
      | TerminateCluster | asg-di-emrcluster-qaparquet4 |          |          |

  @aws
  Scenario: SC#32:Delete the AWS bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "TestAnalyzer" in bucket "asgqaparquetanalyzerb2"
    Given user "Delete" objects in amazon directory "TestDataSeperate" in bucket "asgqaparquetanalyzer"
    Given user "Delete" objects in amazon directory "TestAnalyzerAll" in bucket "asgqaparquetanalyzer"
    Given user "Delete" objects in amazon directory "" in bucket "asg-qa-emr-parquetanalyzer"
    Then user "Delete" a bucket "asgqaparquetanalyzerb2" in amazon storage service
    Then user "Delete" a bucket "asgqaparquetanalyzer" in amazon storage service
    Then user "Delete" a bucket "asg-qa-emr-parquetanalyzer" in amazon storage service

  @cr-data
  Scenario Outline: SC#32:Delete Credentials, Datasource and cataloger config for Parquet S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                    | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3Cataloger                                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3Analyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3DataSource                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidParquetReadWriteCredentials                                  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidParquetReadOnlyCredentials                                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidParquetCredentials                                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyParquetCredentials                                           |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EDIBusValidCredentials                                            |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                                                    |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus                                                              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=ParquetS3Analyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/ParquetS3PII                                                        |      | 204           |                  |          |
