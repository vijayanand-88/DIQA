@MLP-27618
Feature: Verification of OrcS3Analyzer IDA Plugin

  Pre-requisites to be done in script before every run:
  1. Give a name to create a cluster in step SC#1 (Under Pre condition)
  2. Give the same cluster name in step SC#1 for retreiving the cluster ID (Under Pre condition)
  3. Give the same cluster name in step SC#31 for terminating the cluster (Under Post condition)

  ############################################# Pre Conditions ##########################################################
  @aws @precondition
  Scenario:SC#1: Update AWS secret key and access from config file
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                         | accessKeyPath               | secretKeyPath               |
      | ida/s3OrcAnalyzerPayloads/Credentials/orcS3ValidCredentials.json | $.orcCredentials..accessKey | $.orcCredentials..secretKey |
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                         | accessKeyPath                       | secretKeyPath                       |
      | ida/s3OrcAnalyzerPayloads/Credentials/orcS3ValidCredentials.json | $.orcReadOnlyCredentials..accessKey | $.orcReadOnlyCredentials..secretKey |

  @cr-data
  Scenario Outline:SC#1: Configure the Credentials for Orc S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                               | bodyFile                                                                  | path                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidOrcReadWriteCredentials | payloads/ida/s3OrcAnalyzerPayloads/Credentials/orcS3ValidCredentials.json | $.orcCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidOrcReadOnlyCredentials  | payloads/ida/s3OrcAnalyzerPayloads/Credentials/orcS3ValidCredentials.json | $.orcReadOnlyCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/InvalidOrcCredentials        | payloads/ida/s3OrcAnalyzerPayloads/Credentials/orcS3ValidCredentials.json | $.orcInvalidCredentials  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EmptyOrcCredentials          | payloads/ida/s3OrcAnalyzerPayloads/Credentials/orcS3ValidCredentials.json | $.orcEmptyCredentials    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidOrcReadWriteCredentials |                                                                           |                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidOrcReadOnlyCredentials  |                                                                           |                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/InvalidOrcCredentials        |                                                                           |                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EmptyOrcCredentials          |                                                                           |                          | 200           |                  |          |

  @cr-data
  Scenario Outline:SC#1: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3OrcAnalyzerPayloads/OrcS3AnalyzerBA.json | 200           |                  |          |

  @cr-data
  Scenario: SC#1: Configure the Orc S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                | body                                                      | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/OrcS3DataSource | ida/s3OrcAnalyzerPayloads/DataSource/orcS3DataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/OrcS3DataSource |                                                           | 200           | OrcS3DataSource  |          |

  @aws @cr-data
  Scenario: SC#1:Create a bucket and folder with orc files in S3 Amazon storage
    Given user "Create" a bucket "asgqaorcanalyzer" in amazon storage service
    Given user "Create" a bucket "asgqaorcanalyzerb2" in amazon storage service
    Given user "Create" a bucket "asg-qa-emr-orcanalyzer" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix        | dirPath                                             | recursive |
      | asgqaorcanalyzer   | TestAnalyzerAll  | ida/s3OrcAnalyzerPayloads/TestData/TestAnalyzerAll  | true      |
      | asgqaorcanalyzer   | TestDataSeperate | ida/s3OrcAnalyzerPayloads/TestData/TestDataSeperate | true      |
      | asgqaorcanalyzerb2 | TestAnalyzer     | ida/s3OrcAnalyzerPayloads/TestData/Bucket2          | true      |

#  @aws @cr-data
#  Scenario: SC#1:Create an EMR cluster or Retrieve EMR Cluster ID in Amazon EMR service
#    Given user performs the below operation related to a cluster in Amazon EMR service
#      | action                    | clusterName              | filePath                                                                                     | jsonPath        |
#      | CreateCluster             | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/ClusterData/clusterdata.json                                       |                 |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerDryRunTrue.json                   | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerSC1.json                          | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerBucketInclude.json                | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerBucketExcludeRegex.json           | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerDirectoryInclude.json             | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerSubDirIncludeRegex.json           | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerSubDirExclude.json                | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerFileInclude.json                  | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerFileExcludeRegex.json             | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3Analyzer_NodeCondition_WorkingBucket.json | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerPIITags.json                      | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerNonExistingBucket.json            | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerNonExistingSubDir.json            | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerNonExistingFile.json              | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaorc7 | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerIncRunFalse.json                  | $..emrClusterId |

  #################### DataSource TestConnection - UI Validation Error in Mandatory Fields ####################
  #7194937#
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in green when test connection is successful for OrcS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute       |
      | Data Source Type | OrcS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute           |
      | Name      | OrcS3TestDataSource |
      | Label     | OrcS3TestDataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | ValidOrcReadWriteCredentials      |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  #7194937#
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in red when test connection is not successful for OrcS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute       |
      | Data Source Type | OrcS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name      | OrcS3DataSourceTest2 |
      | Label     | OrcS3DataSourceTest2 |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | InvalidOrcCredentials             |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute           |
      | Credential | EmptyOrcCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  #7194934#
  @MLP-27618 @webtest @positive @regression @sanity
  Scenario: SC#2: Verify captions and tool tip text in OrcS3Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                   |
      | mouse hover | Capture And Import Data Icon |
      | click       | Capture And Import Data Icon |
      | click       | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute     |
      | Type      | Dataanalyzer  |
      | Plugin    | OrcS3Analyzer |
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
      | File filter                |
      | Data Source*               |
      | Credential*                |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*                      | Plugin configuration name                                                                                       |
      | Label                      | Plugin configuration extended label and description                                                             |
      | Business Application       | Business Application                                                                                            |
      | Restrict to Region*        | Geographic area where the Amazon S3 resources and the EMR Cluster are available for data analysis               |
      | Bucket Name*               | The working bucket                                                                                              |
      | Amazon EMR Cluster ID*     | The unique Amazon EMR Cluster ID which is running on the given region                                           |
      | Bucket filter              | Apply filters to S3 buckets.                                                                                    |
      | Bucket names               | Add the bucket names to filter them based on the mode, Include/Exclude. All buckets are included if left empty. |
      | S3 Objects filter          | Apply filters to S3 objects, such as directories, sub-directories and files.                                    |
      | Directory prefixes to scan | Add the directory names/directory path prefixes to filter the S3 objects. Does not support regular expressions. |
      | Sub Directory filter       | Add the sub-directory names to filter the S3 objects. Supports regular expressions.                             |
      | File filter                | Add the file names to filter the S3 objects. Supports regular expressions.                                      |
      | Data Source*               | Data source connection to be used                                                                               |
      | Credential*                | Credential to be used                                                                                           |

  #7194933#
  @MLP-27618 @positive @sanity @webtest
  Scenario: SC#2: Verify proper error message is shown if mandatory fields are not filled in OrcS3Analyzer plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                   |
      | mouse hover | Capture And Import Data Icon |
      | click       | Capture And Import Data Icon |
      | click       | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute     |
      | Type      | Dataanalyzer  |
      | Plugin    | OrcS3Analyzer |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName             | validationMessage                               |
      | Name                  | Name field should not be empty                  |
      | Bucket Name           | Bucket Name field should not be empty           |
      | Amazon EMR Cluster ID | Amazon EMR Cluster ID field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ######################################## PluginRun - OrcS3Cataloger ########################################
  @cr-data
  Scenario Outline: SC#3:Configure & run the OrcS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | body                                                                 | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                              | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                             |                                                                      | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  | ida/empty.json                                                       | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |

  ######################################## PluginRun - OrcS3Analyzer - DryRun True ########################################
  ##7194938##
  @cr-data
  Scenario Outline: SC#4:Configure & run the OrcS3Analyzer - DryRun True
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                       | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerDryRunTrue.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                            | 200           | OrcS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                             | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |

  @MLP-27618 @orcs3analyzer
  Scenario: SC#4:UI_Validation: Verify OrcS3Analyzer plugin functionality with dry run as true
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                           | Action                | query         | TableName/Filename                       |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_true.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |
    Then Analysis log "dataanalyzer/OrcS3Analyzer/OrcS3Analyzer%" should display below info/error/warning
      | type | logValue                                     | logCode       | pluginName    | removableText |
      | INFO | Plugin OrcS3Analyzer running on dry run mode | ANALYSIS-0069 | OrcS3Analyzer |               |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#4:Delete id's for scenario: dry run as true
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer/% | Analysis |       |       |

  ######################################## Invalid EMR Cluster ID ########################################
  ##7194935##
  @cr-data
  Scenario Outline: SC#5:Configure & run the OrcS3Analyzer with Invalid EMR Cluster ID
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                              | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerInvalidEMRCluster.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                                   | 200           | OrcS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                    | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |

  @MLP-27618 @orcs3analyzer
  Scenario: SC#5:Verify OrcS3Analyzer is not executed successfully even when Invalid EMR Cluster ID is passed as input.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                             | Action                | query         | TableName/Filename                       |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_Invalid_EMRID.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |
    Then Analysis log "dataanalyzer/OrcS3Analyzer/OrcS3Analyzer%" should display below info/error/warning
      | type  | logValue                                                                                    | logCode     | pluginName | removableText |
      | ERROR | An error occurred while running Amazon S3 analyzer plugin: Specified job flow ID not valid. | AWS_S3-0014 |            |               |

  @sanity @positive
  Scenario:SC#5:Delete id's for scenario: when Invalid EMR Cluster ID is passed as input
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer/% | Analysis |       |       |

  ######################################## PluginRun - OrcS3Analyzer - DryRun False ########################################
  @cr-data
  Scenario Outline: SC#6:Configure & run the OrcS3Analyzer - DryRun False
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerSC1.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                     | 200           | OrcS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |

  ############################ Logging Enhancements ############################
  ##7194939##
  @MLP-27618 @orcs3analyzer
  Scenario: SC#7:LoggingEnhancements: Verify OrcS3Analyzer collects Analysis item with proper log messages
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                            | Action                | query         | TableName/Filename                       |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_false.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |
    Then Analysis log "dataanalyzer/OrcS3Analyzer/OrcS3Analyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:OrcS3Analyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:6f744148aad7, Plugin Configuration name:OrcS3Analyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | OrcS3Analyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: ---  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: name: "OrcS3Analyzer"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: pluginVersion: "LATEST"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: label:  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: : ""  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: catalogName: "Default"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: eventClass: null  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: eventCondition: null  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: maxWorkSize: 100  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: tags:  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: - "AnalyzeOrcS3"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: pluginType: "dataanalyzer"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: dataSource: "OrcS3DataSource"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: credential: "ValidOrcReadWriteCredentials"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: businessApplicationName: "Test_BA_OrcS3Analyzer"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: dryRun: false  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: schedule: null  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: filter: null  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: emrClusterId: "j-18D5YHMIBZEIK"  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: histogramBuckets: 100  2020-09-07 13:38:20.684 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: bucketName: "asg-qa-emr-orcanalyzer"  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: cleanupAfterRun: true  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: pluginName: "OrcS3Analyzer"  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: incremental: true  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: type: "Dataanalyzer"  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: bucketFilter:  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: mode: "INCLUDE"  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: patterns: []  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: objectFilter:  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: dirFilter:  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: mode: "INCLUDE"  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: patterns: []  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: fileFilter:  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: mode: "INCLUDE"  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: patterns: []  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: dirPrefixes: []  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: dataSampleSize: 25  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: restrictRegion: "us-east-1"  2020-09-07 13:38:20.685 INFO  - ANALYSIS-0073: Plugin OrcS3Analyzer Configuration: topValues: 10 | ANALYSIS-0073 | OrcS3Analyzer | emrClusterId   |
      | INFO | Plugin OrcS3Analyzer Start Time:2020-09-07 13:38:20.655, End Time:2020-09-07 13:44:49.513, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0072 | OrcS3Analyzer |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0020 |               |                |

############################ Lifecycle & Statistics Validation ############################
  ##7194918##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario:SC#8:Verify the 'Number of rows' and 'Last analyzed at' attribute for File type after OrcS3Analyzer is executed.
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                            | jsonPath                | Action                    | query     | TableName/Filename | ClusterName   | ServiceName | directoryName |
      | Lifecycle  | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle  | metadataAttributePresence | FileQuery | userhugedata.orc   | amazonaws.com | AmazonS3    | orc           |
      | Statistics | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Statistics | metadataValuePresence     | FileQuery | userhugedata.orc   | amazonaws.com | AmazonS3    | orc           |

 ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @orcs3analyzer
  Scenario Outline:SC9:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid            | targetFile                                        | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | all  | orcExampleEmployee.orc | payloads/ida/s3OrcAnalyzerPayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @orcs3analyzer
  Scenario Outline: SC9:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                         | outPutFile                                               | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/s3OrcAnalyzerPayloads/API/items.json | payloads\ida\s3OrcAnalyzerPayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @orcs3analyzer
  Scenario: SC#9 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\s3OrcAnalyzerPayloads\API\Actual\File1.json" should be same as the content in "ida\s3OrcAnalyzerPayloads\API\Expected\File1.json"


 ############################################################### Data Profiling #########################################################################################

  #7110818# #7110821#
  @MLP-23701 @orcs3analyzer
  Scenario:SC#10:Verify the data profiling metadata information for string datatype in S3 Orc file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query          | TableName/Filename    | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_1 | metadataValuePresence | FileFieldQuery | combo_orcEmployee.orc | amazonaws.com | AmazonS3    | combo         | empname              |
      | Statistics  | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_1  | metadataValuePresence | FileFieldQuery | combo_orcEmployee.orc | amazonaws.com | AmazonS3    | combo         | empname              |

  ##7194921## ##7194924##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario:SC#11:Verify the data profiling metadata information for numeric datatype in S3 Orc file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query          | TableName/Filename    | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_2 | metadataValuePresence | FileFieldQuery | combo_orcEmployee.orc | amazonaws.com | AmazonS3    | combo         | empid                |
      | Statistics  | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_2  | metadataValuePresence | FileFieldQuery | combo_orcEmployee.orc | amazonaws.com | AmazonS3    | combo         | empid                |

  ##7194921## ##7194924##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario:SC#11_2:Verify the data profiling metadata information for numeric datatype in S3 Orc file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query          | TableName/Filename | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_6 | metadataValuePresence | FileFieldQuery | userhugedata.orc   | amazonaws.com | AmazonS3    | combo         | _col1                |
      | Statistics  | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_5  | metadataValuePresence | FileFieldQuery | userhugedata.orc   | amazonaws.com | AmazonS3    | combo         | _col1                |

  ##7194921## ##7194923##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario:SC#12:Verify the data profiling metadata information for timestamp datatype in S3 Orc file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query          | TableName/Filename | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_7 | metadataValuePresence | FileFieldQuery | userhugedata.orc   | amazonaws.com | AmazonS3    | combo         | _col0                |
      | Statistics  | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_4  | metadataValuePresence | FileFieldQuery | userhugedata.orc   | amazonaws.com | AmazonS3    | combo         | _col0                |

  ##7194939##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#13:Verify breadcrumb hierarchy appears correctly in OrcS3Analyzer analyzed items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "AnalyzeOrcS3" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "UsingHive.orc [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "middle" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com    |
      | AmazonS3         |
      | asgqaorcanalyzer |
      | TestDataSeperate |
      | orc              |
      | UsingHive.orc    |
      | middle           |
    And user clicks on logout button

  ############################ Tags verification ############################
  ##7194939##
  @MLP-27618 @orcs3analyzer
  Scenario: SC#14:Tech_tags_Explicit_Tags verification: Verify the technology tags, Business Application, Explicit tags got assigned to the analyzed items for Orc files
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename | Column           | Tags                                                          | Query          | Action         |
      | amazonaws.com | AmazonS3    | orc           | UsingHive.orc      |                  | AnalyzeOrcS3,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC,Amazon S3 | FileQuery      | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | UsingSpark.orc     | favorite_numbers | AnalyzeOrcS3,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | UsingSpark.orc     |                  | Data Files                                                    | FileQuery      | TagNotAssigned |

  @sanity @positive
  Scenario:SC#14:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  ############################################# Filter Scenarios ##########################################################
  #Filter - Bucket Include#
  @cr-data
  Scenario Outline: SC#15:Configure & run the OrcS3Cataloger and OrcS3Analyzer for scenario: Bucket Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                          | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json          | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                               | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                                | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerBucketInclude.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                               | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  ##7194925##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#15: Verify OrcS3Analyzer is executed successfully with filters - BucketName Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | combo_orcEmployee.orc                               |
      | orcExampleEmployee.orc                              |
      | userhugedata.orc                                    |
      | userpatternmatchsimple.orc                          |
      | allDataTypesOrc.orc                                 |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_orcEmployee.orc |
    And user enters the search text "AnalyzeOrcS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "UsingHive.orc" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogOrcS3" and clicks on search
    And user performs "facet selection" in "CatalogOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "b2_orcEmployee.orc" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                              | fileName           | userTag                   |
      | Default     | File | Metadata Type | AnalyzeOrcS3BucketInclude,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC | UsingHive.orc      | AnalyzeOrcS3BucketInclude |
      | Default     | File | Metadata Type | CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC                           | b2_orcEmployee.orc | CatalogOrcS3              |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#15:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  #Filter - Bucket Exclude#
  @cr-data
  Scenario Outline: SC#16:Configure & run the OrcS3Cataloger and OrcS3Analyzer for scenario: Bucket Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                               | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json               | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                                    | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerBucketExcludeRegex.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                                    | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  ##7194926##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#16: Verify OrcS3Analyzer is executed successfully with filters - Bucket Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3BucketExcludeRegex" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3BucketExcludeRegex" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | b2_orcEmployee.orc |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | combo_orcEmployee.orc                               |
      | orcExampleEmployee.orc                              |
      | userhugedata.orc                                    |
      | userpatternmatchsimple.orc                          |
      | allDataTypesOrc.orc                                 |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user performs "item click" on "b2_orcEmployee.orc" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogOrcS3" and clicks on search
    And user performs "facet selection" in "CatalogOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchsimple.orc" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                   | fileName                   | userTag                        |
      | Default     | File | Metadata Type | AnalyzeOrcS3BucketExcludeRegex,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC | b2_orcEmployee.orc         | AnalyzeOrcS3BucketExcludeRegex |
      | Default     | File | Metadata Type | CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC                                | userpatternmatchsimple.orc | CatalogOrcS3                   |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#16:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  #Filter - Directory Include#
  @cr-data
  Scenario Outline: SC#17:Configure & run the OrcS3Cataloger and OrcS3Analyzer for scenario: Bucketname (Include)/Directory
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json             | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                                  | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerDirectoryInclude.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                                  | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  ##7194927##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#17:Verify OrcS3Analyzer is executed successfully with filters - Bucketname (Include)/Directory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3DirectoryInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3DirectoryInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | orcExampleEmployee.orc |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_orcEmployee.orc                                  |
      | combo_orcEmployee.orc                               |
      | userhugedata.orc                                    |
      | userpatternmatchsimple.orc                          |
      | allDataTypesOrc.orc                                 |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user performs "item click" on "orcExampleEmployee.orc" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogOrcS3" and clicks on search
    And user performs "facet selection" in "CatalogOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "b2_orcEmployee.orc" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                 | fileName                    | userTag                      |
      | Default     | File | Metadata Type | AnalyzeOrcS3DirectoryInclude,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC | orcExampleEmployee.orc      | AnalyzeOrcS3DirectoryInclude |
      | Default     | File | Metadata Type | CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC                              | tagdetails_allempty_orc.orc | CatalogOrcS3                 |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#17:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

    #Filter - Sub Directory Include#
  @cr-data
  Scenario Outline: SC#18:Configure & run the OrcS3Cataloger and OrcS3Analyzer for scenario: Bucket Include & SubDirectory Include Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                               | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json               | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                                    | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerSubDirIncludeRegex.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                                    | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |


  ##7194928##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#18: Verify OrcS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Include Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3SubDirIncludeRegex" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3SubDirIncludeRegex" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userhugedata.orc                                    |
      | userpatternmatchsimple.orc                          |
      | allDataTypesOrc.orc                                 |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | orcExampleEmployee.orc |
      | b2_orcEmployee.orc     |
      | combo_orcEmployee.orc  |
    And user enters the search text "AnalyzeOrcS3SubDirIncludeRegex" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3SubDirIncludeRegex" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchsimple.orc" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogOrcS3" and clicks on search
    And user performs "facet selection" in "CatalogOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_orcEmployee.orc" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                   | fileName              | userTag                        |
      | Default     | File | Metadata Type | AnalyzeOrcS3SubDirIncludeRegex,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC | UsingSpark.orc        | AnalyzeOrcS3SubDirIncludeRegex |
      | Default     | File | Metadata Type | CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC                                | combo_orcEmployee.orc | CatalogOrcS3                   |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#18:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  #Filter - SubDirectory Exclude#
  @cr-data
  Scenario Outline: SC#19:Configure & run the OrcS3Cataloger and OrcS3Analyzer for scenario: Bucket Include & SubDirectory Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                          | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json          | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                               | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                                | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerSubDirExclude.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                               | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  ##7194929##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#19: Verify OrcS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3SubDirExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3SubDirExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | combo_orcEmployee.orc  |
      | orcExampleEmployee.orc |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_orcEmployee.orc                                  |
      | userhugedata.orc                                    |
      | userpatternmatchsimple.orc                          |
      | allDataTypesOrc.orc                                 |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user performs "item click" on "combo_orcEmployee.orc" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogOrcS3" and clicks on search
    And user performs "facet selection" in "CatalogOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchsimple.orc" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                              | fileName                   | userTag                   |
      | Default     | File | Metadata Type | AnalyzeOrcS3SubDirExclude,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC | combo_orcEmployee.orc      | AnalyzeOrcS3SubDirExclude |
      | Default     | File | Metadata Type | CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC                           | userpatternmatchsimple.orc | CatalogOrcS3              |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#19:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  #Filter - File Include#
  @cr-data
  Scenario Outline: SC#20:Configure & run the OrcS3Cataloger and OrcS3Analyzer for scenario: File Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                        | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json        | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                             | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerFileInclude.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                             | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |


  ##7194930##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#20: Verify OrcS3Analyzer is executed successfully with filters - File Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3FileInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3FileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatchsimple.orc |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | combo_orcEmployee.orc                               |
      | orcExampleEmployee.orc                              |
      | b2_orcEmployee.orc                                  |
      | userhugedata.orc                                    |
      | allDataTypesOrc.orc                                 |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user performs "item click" on "userpatternmatchsimple.orc" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogOrcS3" and clicks on search
    And user performs "facet selection" in "CatalogOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_orcEmployee.orc" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                            | fileName                   | userTag                 |
      | Default     | File | Metadata Type | AnalyzeOrcS3FileInclude,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC | userpatternmatchsimple.orc | AnalyzeOrcS3FileInclude |
      | Default     | File | Metadata Type | CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC                         | combo_orcEmployee.orc      | CatalogOrcS3            |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#20:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  #Filter - File Exclude#
  @cr-data
  Scenario Outline: SC#21:Configure & run the OrcS3Cataloger and OrcS3Analyzer for scenario: File Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json             | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                                  | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerFileExcludeRegex.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                                  | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  ##7194931##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#21: Verify OrcS3Analyzer is executed successfully with filters - File Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3FileExcludeRegex" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3FileExcludeRegex" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userhugedata.orc           |
      | allDataTypesOrc.orc        |
      | userpatternmatchsimple.orc |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | combo_orcEmployee.orc                               |
      | orcExampleEmployee.orc                              |
      | b2_orcEmployee.orc                                  |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user performs "item click" on "userpatternmatchsimple.orc" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogOrcS3" and clicks on search
    And user performs "facet selection" in "CatalogOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_orcEmployee.orc" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                 | fileName                   | userTag                      |
      | Default     | File | Metadata Type | AnalyzeOrcS3FileExcludeRegex,CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC | userpatternmatchsimple.orc | AnalyzeOrcS3FileExcludeRegex |
      | Default     | File | Metadata Type | CatalogOrcS3,Test_BA_OrcS3Analyzer,ORC                              | combo_orcEmployee.orc      | CatalogOrcS3                 |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#21:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  ############################################# Node Condition Internal Node ##########################################################
  @cr-data
  Scenario Outline: SC#22:Configure & run the OrcS3Cataloger and OrcS3Analyzer for scenario: Specific Node condition and non-existing working bucket name
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                                         | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                                  | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3Cataloger_NodeCondition.json              | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                 |                                                                                              | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                                               | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                                  | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3Analyzer_NodeCondition_WorkingBucket.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                                  |                                                                                              | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                               | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  ##7194940## ##7194974##
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#22: Verify OrcS3Analyzer is executed successfully for scenario: Specific Node condition and non-existing working bucket name
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3NodeCondition" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3NodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userhugedata.orc                                    |
      | allDataTypesOrc.orc                                 |
      | userpatternmatchsimple.orc                          |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | combo_orcEmployee.orc                               |
      | orcExampleEmployee.orc                              |
      | b2_orcEmployee.orc                                  |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#22:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  ######################################## Non existing buckets/ sub-directory/ file ########################################
  ##7194936##
  @cr-data
  Scenario Outline: SC#23:Configure & run the OrcS3Cataloger and OrcS3Analyzer for Non existing buckets
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                              | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json              | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                                   | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                                    | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerNonExistingBucket.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                                   | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                    | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#23:Verify the error message in logs when OrcS3Analyzer is executed with Non existing buckets in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |
    Then Analysis log "dataanalyzer/OrcS3Analyzer/OrcS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#23:Configure & run the OrcS3Analyzer for Non existing sub directories
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                              | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerNonExistingSubDir.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                                   | 200           | OrcS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                    | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |

  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#23:Verify the error message in logs when OrcS3Analyzer is executed with Non existing sub directory in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |
    Then Analysis log "dataanalyzer/OrcS3Analyzer/OrcS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#23:Configure & run the OrcS3Analyzer for Non existing file
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                            | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerNonExistingFile.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                                 | 200           | OrcS3Analyzer    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                                  | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status |

  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#23:Verify the error message in logs when OrcS3Analyzer is executed with Non existing file in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |
    Then Analysis log "dataanalyzer/OrcS3Analyzer/OrcS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @sanity @positive
  Scenario:SC#23:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                             | Cluster  |       |       |

  ############################################# Policy Patterns - PII Tagging ##########################################################
  ##7194944## ##7194945## ##7194946## ##7194948## ##7194949## ##7194951## ##7194952## ##7194954##
  ##7194955## ##7194956## ##7194957## ##7194958## ##7194960## ##7194961## ##7194962## ##7194964##
  Scenario Outline:SC#24:Create root tag and sub tag for OrcS3 and Update policy tags for OrcS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/s3OrcAnalyzerPayloads/policyEngine/orcS3TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/s3OrcAnalyzerPayloads/policyEngine/orcS3_policy1.1.0.json | 204           |                  |          |

  @cr-data
  Scenario Outline: SC#24:Configure & run the OrcS3Cataloger and OrcS3Analyzer - Policy Patterns - PII Tagging
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                    | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerSC1.json    | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                         | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                          | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerPIITags.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                         | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                          | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  @MLP-27618 @webtest @orcs3analyzer @PIITag
  Scenario: SC#24: Verify PII Tags gets assigned to the below fields in file: tagdetails_allmatch_orc.orc
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename          | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | GENDER    | OrcS3GenderPII_SC1Tag,OrcS3GenderPII_SC3Tag,OrcS3GenderPII_SC8Tag,ORC,Amazon S3                                                 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | FULL_NAME | OrcS3FullNamePII_SC1Tag,OrcS3FullNamePII_SC3Tag,OrcS3FullNamePII_SC8Tag,ORC,Amazon S3                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | SSN       | OrcS3SSNPII_SC1Tag,OrcS3SSNPII_SC3Tag,OrcS3SSNPII_SC8Tag,ORC,Amazon S3                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC1Tag,OrcS3IPAddressPII_SC3Tag,OrcS3IPAddressPII_SC8Tag,ORC,Amazon S3                                        | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | GENDER    | OrcS3GenderPII_SC2Tag,OrcS3GenderPII_SC4Tag,OrcS3GenderPII_SC11Tag,OrcS3GenderPII_SC12Tag,OrcS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | EMAIL     | OrcS3EmailPII_SC2Tag,OrcS3EmailPII_SC4Tag,OrcS3EmailPII_SC11Tag,OrcS3EmailPII_SC12Tag,OrcS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | FULL_NAME | OrcS3FullNamePII_SC2Tag,OrcS3FullNamePII_SC4Tag,OrcS3FullNamePII_SC11Tag,OrcS3FullNamePII_SC12Tag,OrcS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | SSN       | OrcS3SSNPII_SC2Tag,OrcS3SSNPII_SC4Tag,OrcS3SSNPII_SC11Tag,OrcS3SSNPII_SC12Tag,OrcS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allmatch_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC2Tag,OrcS3IPAddressPII_SC4Tag,OrcS3IPAddressPII_SC11Tag,OrcS3IPAddressPII_SC12Tag,OrcS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  @MLP-27618 @webtest @orcs3analyzer @PIITag
  Scenario: SC#25: Verify PII Tags gets assigned to the below fields in file: tagdetails_allempty_orc.orc
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename          | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allempty_orc.orc | SSN       | OrcS3SSNPII_SC1Tag,OrcS3SSNPII_SC3Tag,OrcS3SSNPII_SC14Tag,ORC,Amazon S3                                                         | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allempty_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC1Tag,OrcS3IPAddressPII_SC3Tag,OrcS3IPAddressPII_SC14Tag,ORC,Amazon S3                                       | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allempty_orc.orc | GENDER    | OrcS3GenderPII_SC2Tag,OrcS3GenderPII_SC4Tag,OrcS3GenderPII_SC11Tag,OrcS3GenderPII_SC12Tag,OrcS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allempty_orc.orc | EMAIL     | OrcS3EmailPII_SC2Tag,OrcS3EmailPII_SC4Tag,OrcS3EmailPII_SC11Tag,OrcS3EmailPII_SC12Tag,OrcS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allempty_orc.orc | FULL_NAME | OrcS3FullNamePII_SC2Tag,OrcS3FullNamePII_SC4Tag,OrcS3FullNamePII_SC11Tag,OrcS3FullNamePII_SC12Tag,OrcS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allempty_orc.orc | SSN       | OrcS3SSNPII_SC2Tag,OrcS3SSNPII_SC4Tag,OrcS3SSNPII_SC11Tag,OrcS3SSNPII_SC12Tag,OrcS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_allempty_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC2Tag,OrcS3IPAddressPII_SC4Tag,OrcS3IPAddressPII_SC11Tag,OrcS3IPAddressPII_SC12Tag,OrcS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  @MLP-27618 @webtest @orcs3analyzer @PIITag
  Scenario: SC#26: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolessthan05emptyfalse_orc.orc
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                           | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | GENDER    | OrcS3GenderPII_SC1Tag,OrcS3GenderPII_SC3Tag,OrcS3GenderPII_SC5Tag,ORC,Amazon S3                                                 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | FULL_NAME | OrcS3FullNamePII_SC5Tag,OrcS3FullNamePII_SC10Tag,ORC,Amazon S3                                                                  | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | SSN       | OrcS3SSNPII_SC5Tag,OrcS3SSNPII_SC10Tag,ORC,Amazon S3                                                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC1Tag,OrcS3IPAddressPII_SC3Tag,OrcS3IPAddressPII_SC5Tag,ORC,Amazon S3                                        | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | GENDER    | OrcS3GenderPII_SC2Tag,OrcS3GenderPII_SC4Tag,OrcS3GenderPII_SC11Tag,OrcS3GenderPII_SC12Tag,OrcS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | EMAIL     | OrcS3EmailPII_SC2Tag,OrcS3EmailPII_SC4Tag,OrcS3EmailPII_SC11Tag,OrcS3EmailPII_SC12Tag,OrcS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | FULL_NAME | OrcS3FullNamePII_SC2Tag,OrcS3FullNamePII_SC4Tag,OrcS3FullNamePII_SC11Tag,OrcS3FullNamePII_SC12Tag,OrcS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | SSN       | OrcS3SSNPII_SC2Tag,OrcS3SSNPII_SC4Tag,OrcS3SSNPII_SC11Tag,OrcS3SSNPII_SC12Tag,OrcS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolessthan05emptyfalse_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC2Tag,OrcS3IPAddressPII_SC4Tag,OrcS3IPAddressPII_SC11Tag,OrcS3IPAddressPII_SC12Tag,OrcS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  @MLP-27618 @webtest @orcs3analyzer @PIITag
  Scenario: SC#27: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                  | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | GENDER    | OrcS3GenderPII_SC1Tag,OrcS3GenderPII_SC3Tag,OrcS3GenderPII_SC7Tag,ORC,Amazon S3                                                 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | FULL_NAME | OrcS3FullNamePII_SC1Tag,OrcS3FullNamePII_SC3Tag,OrcS3FullNamePII_SC7Tag,ORC,Amazon S3                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | SSN       | OrcS3SSNPII_SC1Tag,OrcS3SSNPII_SC3Tag,OrcS3SSNPII_SC7Tag,ORC,Amazon S3                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC1Tag,OrcS3IPAddressPII_SC3Tag,OrcS3IPAddressPII_SC6Tag,OrcS3IPAddressPII_SC7Tag,ORC,Amazon S3               | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | GENDER    | OrcS3GenderPII_SC2Tag,OrcS3GenderPII_SC4Tag,OrcS3GenderPII_SC11Tag,OrcS3GenderPII_SC12Tag,OrcS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | EMAIL     | OrcS3EmailPII_SC2Tag,OrcS3EmailPII_SC4Tag,OrcS3EmailPII_SC11Tag,OrcS3EmailPII_SC12Tag,OrcS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | FULL_NAME | OrcS3FullNamePII_SC2Tag,OrcS3FullNamePII_SC4Tag,OrcS3FullNamePII_SC11Tag,OrcS3FullNamePII_SC12Tag,OrcS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | SSN       | OrcS3SSNPII_SC2Tag,OrcS3SSNPII_SC4Tag,OrcS3SSNPII_SC11Tag,OrcS3SSNPII_SC12Tag,OrcS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC2Tag,OrcS3IPAddressPII_SC4Tag,OrcS3IPAddressPII_SC11Tag,OrcS3IPAddressPII_SC12Tag,OrcS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  @MLP-27618 @webtest @orcs3analyzer @PIITag
  Scenario: SC#28: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratioequalto05emptyfalse_orc.orc
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                          | Column    | Tags                                                                                                                            | Query          | Action         |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | GENDER    | OrcS3GenderPII_SC1Tag,OrcS3GenderPII_SC3Tag,OrcS3GenderPII_SC9Tag,ORC,Amazon S3                                                 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | FULL_NAME | OrcS3FullNamePII_SC1Tag,OrcS3FullNamePII_SC3Tag,OrcS3FullNamePII_SC9Tag,ORC,Amazon S3                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | SSN       | OrcS3SSNPII_SC1Tag,OrcS3SSNPII_SC3Tag,OrcS3SSNPII_SC9Tag,ORC,Amazon S3                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC1Tag,OrcS3IPAddressPII_SC3Tag,OrcS3IPAddressPII_SC9Tag,ORC,Amazon S3                                        | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | GENDER    | OrcS3GenderPII_SC2Tag,OrcS3GenderPII_SC4Tag,OrcS3GenderPII_SC11Tag,OrcS3GenderPII_SC12Tag,OrcS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | EMAIL     | OrcS3EmailPII_SC2Tag,OrcS3EmailPII_SC4Tag,OrcS3EmailPII_SC11Tag,OrcS3EmailPII_SC12Tag,OrcS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | FULL_NAME | OrcS3FullNamePII_SC2Tag,OrcS3FullNamePII_SC4Tag,OrcS3FullNamePII_SC11Tag,OrcS3FullNamePII_SC12Tag,OrcS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | SSN       | OrcS3SSNPII_SC2Tag,OrcS3SSNPII_SC4Tag,OrcS3SSNPII_SC11Tag,OrcS3SSNPII_SC12Tag,OrcS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratioequalto05emptyfalse_orc.orc | IPADDRESS | OrcS3IPAddressPII_SC2Tag,OrcS3IPAddressPII_SC4Tag,OrcS3IPAddressPII_SC11Tag,OrcS3IPAddressPII_SC12Tag,OrcS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  @MLP-27618 @webtest @orcs3analyzer @PIITag
  Scenario: SC#29: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05matchfulltrue_orc.orc
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                 | Column   | Tags                                   | Query          | Action         |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc | COMMENTS | OrcS3FullMatchPII_SC2Tag,ORC,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc | COMMENTS | OrcS3FullMatchPII_SC1Tag               | FileFieldQuery | TagNotAssigned |

  @MLP-27618 @webtest @orcs3analyzer @PIITag
  Scenario: SC#30: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolesserthan05matchfulltrue_orc.orc
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                | Column   | Tags                                   | Query          | Action         |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolesserthan05matchfulltrue_orc.orc | COMMENTS | OrcS3FullMatchPII_SC4Tag,ORC,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | orc           | tagdetails_ratiolesserthan05matchfulltrue_orc.orc | COMMENTS | OrcS3FullMatchPII_SC3Tag               | FileFieldQuery | TagNotAssigned |

  Scenario: SC#30: Delete the items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                             | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |

  ############################################# Incremental scenario ##########################################################
  @cr-data
  Scenario Outline: SC#31:Configure & run the OrcS3Cataloger and OrcS3Analyzer - Incremental scenario Run 1
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                        | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerIncRun1.json    | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                             | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerIncRunFalse.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                             | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  #7194973#
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#31: Verify OrcS3Analyzer is executed successfully for scenario: Incremental scenario Run 1
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_4 | metadataValuePresence | AnalysisQuery | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |

  @cr-data
  Scenario Outline: SC#31:Configure & run the OrcS3Cataloger - Incremental scenario Run 2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                     | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3CatalogerIncRun2.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                                          | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger   | ida/empty.json                                                           | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                               | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerSC1.json      | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                               |                                                                          | 200           | OrcS3Analyzer    |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer  | ida/empty.json                                                           | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Analyzer')].status  |

  #7194973#
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#31: Verify OrcS3Analyzer is executed successfully for scenario: Incremental scenario Run 2
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                            | jsonPath                   | Action                | query         | TableName/Filename                       |
      | Description | ida/s3OrcAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_5 | metadataValuePresence | AnalysisQuery | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer |


  Scenario: SC#31: Delete the items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                             | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer% | Analysis |       |       |

  #################################### AmazonS3Cataloger & OrcS3Analyzer ####################################
  @cr-data
  Scenario Outline: SC#32:Configure & run the AmazonS3Cataloger & OrcS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                                    | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                               | ida/s3OrcAnalyzerPayloads/DataSource/amazonS3DataSource.json            | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                               |                                                                         | 200           | AmazonS3DataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                | ida/s3OrcAnalyzerPayloads/PluginConfiguration/AmazonS3CatalogerSC1.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                |                                                                         | 200           | AmazonS3Cataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                         | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger  | ida/empty.json                                                          | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                         | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Analyzer                                                    | ida/s3OrcAnalyzerPayloads/PluginConfiguration/OrcS3AnalyzerSC1.json     | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Analyzer                                                    |                                                                         | 200           | OrcS3Analyzer      |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer      |                                                                         | 200           | IDLE               | $.[?(@.configurationName=='OrcS3Analyzer')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer       | ida/empty.json                                                          | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OrcS3Analyzer/OrcS3Analyzer      |                                                                         | 200           | IDLE               | $.[?(@.configurationName=='OrcS3Analyzer')].status     |

  #7194941#
  @MLP-27618 @webtest @orcs3analyzer
  Scenario: SC#32: Verify OrcS3Analyzer is executed successfully for scenario: AmazonS3Cataloger & OrcS3Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeOrcS3" and clicks on search
    And user performs "facet selection" in "AnalyzeOrcS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userhugedata.orc                                    |
      | allDataTypesOrc.orc                                 |
      | userpatternmatchsimple.orc                          |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | combo_orcEmployee.orc                               |
      | orcExampleEmployee.orc                              |
      | b2_orcEmployee.orc                                  |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                              | fileName        | userTag      |
      | Default     | File | Metadata Type | Amazon S3,AnalyzeOrcS3,CatalogAmazonS3,Test_BA_OrcS3Analyzer,ORC | UsingOrcJar.orc | AnalyzeOrcS3 |
    And user clicks on logout button

  Scenario: SC#32: Delete the items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                                  | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OrcS3Analyzer/OrcS3Analyzer%      | Analysis |       |       |

  ############################################# Post Conditions ##########################################################
  Scenario: SC#33: Delete the businessApplication tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type                | query | param |
      | SingleItemDelete | Default | Test_BA_OrcS3Analyzer | BusinessApplication |       |       |

  @aws
  Scenario: SC#33:Terminate an EMR cluster in Amazon EMR service
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action           | clusterName              | filePath | jsonPath |
      | TerminateCluster | asg-di-emrcluster-qaorc7 |          |          |

  @aws
  Scenario: SC#33:Delete the AWS bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "TestAnalyzer" in bucket "asgqaorcanalyzerb2"
    Given user "Delete" objects in amazon directory "TestDataSeperate" in bucket "asgqaorcanalyzer"
    Given user "Delete" objects in amazon directory "TestAnalyzerAll" in bucket "asgqaorcanalyzer"
    Given user "Delete" objects in amazon directory "" in bucket "asg-qa-emr-orcanalyzer"
    Then user "Delete" a bucket "asgqaorcanalyzerb2" in amazon storage service
    Then user "Delete" a bucket "asgqaorcanalyzer" in amazon storage service
    Then user "Delete" a bucket "asg-qa-emr-orcanalyzer" in amazon storage service

  @cr-data
  Scenario Outline: SC#33:Delete Credentials, Datasource and cataloger config for Orc S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger                                               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OrcS3Cataloger                                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OrcS3Analyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource                                              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OrcS3DataSource                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidOrcReadWriteCredentials                                  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidOrcReadOnlyCredentials                                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidOrcCredentials                                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyOrcCredentials                                           |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=OrcS3Analyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/OrcS3PII                                                        |      | 204           |                  |          |

