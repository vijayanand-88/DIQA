@MLP-22488
Feature: Verification of AvroS3Analyzer IDA Plugin

  Pre-requisites to be done in script before every run:
  1. Give a name to create a cluster in step SC#1 (Under Pre condition)
  2. Give the same cluster name in step SC#1 for retreiving the cluster ID (Under Pre condition)
  3. Give the same cluster name in step SC#31 for terminating the cluster (Under Post condition)

  ############################################# Pre Conditions ##########################################################
  @aws @precondition
  Scenario:SC#1: Update AWS secret key and access from config file
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                      | accessKeyPath                | secretKeyPath                |
      | ida/s3AvroAnalyzerPayloads/Credentials/avroS3Credentials.json | $.avroCredentials..accessKey | $.avroCredentials..secretKey |
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                      | accessKeyPath                        | secretKeyPath                        |
      | ida/s3AvroAnalyzerPayloads/Credentials/avroS3Credentials.json | $.avroReadOnlyCredentials..accessKey | $.avroReadOnlyCredentials..secretKey |

  @cr-data
  Scenario Outline:SC#1: Configure the Credentials for Avro S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                | bodyFile                                                               | path                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidAvroReadWriteCredentials | payloads/ida/s3AvroAnalyzerPayloads/Credentials/avroS3Credentials.json | $.avroCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidAvroReadOnlyCredentials  | payloads/ida/s3AvroAnalyzerPayloads/Credentials/avroS3Credentials.json | $.avroReadOnlyCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/InvalidAvroCredentials        | payloads/ida/s3AvroAnalyzerPayloads/Credentials/avroS3Credentials.json | $.avroInvalidCredentials  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EmptyAvroCredentials          | payloads/ida/s3AvroAnalyzerPayloads/Credentials/avroS3Credentials.json | $.avroEmptyCredentials    | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials        | payloads/ida/s3AvroAnalyzerPayloads/Credentials/avroS3Credentials.json | $.validEDIBusCredentials  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidAvroReadWriteCredentials |                                                                        |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidAvroReadOnlyCredentials  |                                                                        |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/InvalidAvroCredentials        |                                                                        |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EmptyAvroCredentials          |                                                                        |                           | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials        |                                                                        |                           | 200           |                  |          |

  @cr-data
  Scenario Outline:SC#1: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3AvroAnalyzerPayloads/AvroS3AnalyzerBA.json | 200           |                  |          |

  @cr-data
  Scenario: SC#1: Configure the Avro S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                 | body                                                        | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AvroS3DataSource | ida/s3AvroAnalyzerPayloads/DataSource/avroS3DataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/AvroS3DataSource |                                                             | 200           | AvroS3DataSource |          |

  @aws @cr-data
  Scenario: SC#1:Create a bucket and folder with avro files in S3 Amazon storage
    Given user "Create" a bucket "asgqaavroanalyzer" in amazon storage service
    Given user "Create" a bucket "asgqaavroanalyzerb2" in amazon storage service
    Given user "Create" a bucket "asg-qa-emr-avroanalyzer" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName          | keyPrefix        | dirPath                                              | recursive |
      | asgqaavroanalyzer   | TestAnalyzerAll  | ida/s3AvroAnalyzerPayloads/TestData/TestAnalyzerAll  | true      |
      | asgqaavroanalyzer   | TestDataSeperate | ida/s3AvroAnalyzerPayloads/TestData/TestDataSeperate | true      |
      | asgqaavroanalyzerb2 | TestAnalyzer     | ida/s3AvroAnalyzerPayloads/TestData/Bucket2          | true      |

#  @aws @cr-data
#  Scenario: SC#1:Create an EMR cluster or Retrieve EMR Cluster ID in Amazon EMR service
#    Given user performs the below operation related to a cluster in Amazon EMR service
#      | action | clusterName | filePath | jsonPath |
#      | CreateCluster             | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/ClusterData/clusterdata.json                                        |                 |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerSC1.json                          | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerDryRunTrue.json                   | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerInvalidEMRRelease.json            | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerBucketInclude.json                | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerBucketExcludeRegex.json           | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerDirectoryInclude.json             | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerSubDirIncludeRegex.json           | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerSubDirExclude.json                | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerFileInclude.json                  | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerFileExcludeRegex.json             | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerNonExistingBucket.json            | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerNonExistingSubDir.json            | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerNonExistingFile.json              | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3Analyzer_NodeCondition_WorkingBucket.json | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerIncRunFalse.json                  | $..emrClusterId |
#      | GetClusterIDAndUpdateFile | asg-di-emrcluster-qaavro5 | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerPIITags.json                      | $..emrClusterId |

  ################### DataSource TestConnection - UI Validation Error in Mandatory Fields ####################
  #7110897#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in green when test connection is successful for AvroS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Data Sources" in "Landing page"
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | AvroS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | Region*    |
      | Credential |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name      | AvroS3TestDataSource |
      | Label     | AvroS3TestDataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | ValidAvroReadWriteCredentials     |
      | Deployment | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  #7110897#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#2:Verify whether the background of the panel is displayed in red when test connection is not successful for AvroS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Data Sources" in "Landing page"
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | AvroS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | Region*    |
      | Credential |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name      | AvroS3DataSourceTest2 |
      | Label     | AvroS3DataSourceTest2 |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | InvalidAvroCredentials            |
      | Deployment | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute            |
      | Credential | EmptyAvroCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"

  #7110868#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#2:Verify proper error message is shown if mandatory fields are not filled in AvroS3Analyzer configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Dataanalyzer   |
      | Plugin    | AvroS3Analyzer |
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
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ######################################## PluginRun - AvroS3Cataloger ########################################
  @cr-data
  Scenario Outline: SC#3:Configure & run the AvroS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body                                                                   | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                              | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                              |                                                                        | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  | ida/empty.json                                                         | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |

  ######################################## PluginRun - AvroS3Analyzer - DryRun True ########################################
  #7110897#
  @cr-data
  Scenario Outline: SC#4:Configure & run the AvroS3Analyzer - DryRun True
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                         | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerDryRunTrue.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                              | 200           | AvroS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                               | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |

  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#4:UI_Validation: Verify AvroS3Analyzer plugin functionality with dry run as true
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                           | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_true.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |
    Then Analysis log "dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%" should display below info/error/warning
      | type | logValue                                                                                   | logCode       | pluginName     | removableText |
      | INFO | Plugin AvroS3Analyzer running on dry run mode                                              | ANALYSIS-0069 | AvroS3Analyzer |               |
      | INFO | Plugin AvroS3Analyzer processed 14 items on dry run mode and not written to the repository | ANALYSIS-0070 | AvroS3Analyzer |               |

  @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer/% | Analysis |       |       |


  ############################ Invalid EMR Cluster ID & Invalid EMR Cluster Release version #############################
  @cr-data
  Scenario Outline: SC#5:Configure & run the AvroS3Analyzer with Invalid EMR Cluster ID
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerInvalidEMRCluster.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                     | 200           | AvroS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                      | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |

  #7110864#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#5:Verify AvroS3Analyzer is not executed successfully even when Invalid EMR Cluster ID is passed as input.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                             | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_Invalid_EMRID.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |
    Then Analysis log "dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%" should display below info/error/warning
      | type  | logValue                                                                                    | logCode     | pluginName | removableText |
      | ERROR | An error occurred while running Amazon S3 analyzer plugin: Specified job flow ID not valid. | AWS_S3-0014 |            |               |

  Scenario: SC#5:ItemDeletion: User deletes the AvroS3Analyzer analysis item with Invalid EMR Cluster ID
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer% | Analysis |       |       |

  @cr-data
  Scenario Outline: SC#5:Configure & run the AvroS3Analyzer with Invalid EMR Cluster Release version
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerInvalidEMRRelease.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                     | 200           | AvroS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                      | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |

  #7110865#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#5:Verify AvroS3Analyzer is not executed successfully even when Invalid EMR Cluster Release version is passed as input.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                             | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_Invalid_EMRID.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |
    Then Analysis log "dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%" should display below info/error/warning
      | type  | logValue                                                          | logCode     | pluginName | removableText |
      | ERROR | EMR Cluster step stops with state FAILED / reason: Unknown Error. | AWS_S3-0017 |            |               |

  Scenario: SC#5:ItemDeletion: User deletes the AvroS3Analyzer analysis item with Invalid EMR Cluster Release version
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer% | Analysis |       |       |

  ######################################## PluginRun - AvroS3Analyzer - DryRun False ########################################
  @cr-data
  Scenario Outline: SC#6:Configure & run the AvroS3Analyzer - DryRun False
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                  | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerSC1.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                       | 200           | AvroS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                        | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |

  Scenario Outline: SC#6:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for dry run false
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  ############################ Logging Enhancements ############################
  #7110897#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#7:LoggingEnhancements: Verify AvroS3Analyzer collects Analysis item with proper log messages
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                            | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_dryrun_false.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |
    Then Analysis log "dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0019 |                |                |
      | INFO | Plugin Name:AvroS3Analyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:74163c5adcbf, Plugin Configuration name:AvroS3Analyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0071 | AvroS3Analyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: ---  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: name: "AvroS3Analyzer"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: pluginVersion: "LATEST"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: label:  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: : ""  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: catalogName: "Default"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: eventClass: null  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: eventCondition: null  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: maxWorkSize: 100  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: tags:  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: - "AnalyzeAvroS3"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: pluginType: "dataanalyzer"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: dataSource: "AvroS3DataSource"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: credential: "ValidAvroReadWriteCredentials"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: businessApplicationName: "Test_BA_AvroS3Analyzer"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: dryRun: false  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: filter: null  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: emrClusterId: "j-C0NHXXNCUZOM"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: histogramBuckets: 100  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: bucketName: "asg-qa-emr-avroanalyzer"  2020-07-03 09:36:55.179 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: cleanupAfterRun: true  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: pluginName: "AvroS3Analyzer"  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: incremental: true  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: type: "Dataanalyzer"  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: emrClusterRelease: "emr6.0.0"  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: bucketFilter:  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: mode: "INCLUDE"  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: patterns: []  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: objectFilter:  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: dirFilter:  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: mode: "INCLUDE"  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: patterns: []  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: fileFilter:  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: mode: "INCLUDE"  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: patterns: []  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: dirPrefixes: []  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: dataSampleSize: 25  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: restrictRegion: "us-east-1"  2020-07-03 09:36:55.180 INFO  - ANALYSIS-0073: Plugin AvroS3Analyzer Configuration: topValues: 10 | ANALYSIS-0073 | AvroS3Analyzer | emrClusterId   |
      | INFO | Plugin AvroS3Analyzer Start Time:2020-06-24 10:27:25.815, End Time:2020-06-24 10:31:19.002, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0072 | AvroS3Analyzer |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:04:59.182)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0020 |                |                |

  ############################ UI Validation ############################
  #7110841#
  @MLP-22488 @webtest @avros3analyzer
  Scenario:SC#8:Verify the 'Number of rows' and 'Last analyzed at' attribute for File type after AvroS3Analyzer is executed.
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                             | jsonPath                | Action                    | query     | TableName/Filename    | ClusterName   | ServiceName | directoryName |
      | Lifecycle  | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle  | metadataAttributePresence | FileQuery | userpatternmatch.avro | amazonaws.com | AmazonS3    | avro          |
      | Statistics | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Statistics | metadataValuePresence     | FileQuery | userpatternmatch.avro | amazonaws.com | AmazonS3    | avro          |


     ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @avros3analyzer
  Scenario Outline:SC9:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid              | targetFile                                         | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | all  | avroExampleEmployee.avro | payloads/ida/s3AvroAnalyzerPayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @avros3analyzer
  Scenario Outline: SC9:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                          | outPutFile                                                | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/s3AvroAnalyzerPayloads/API/items.json | payloads\ida\s3AvroAnalyzerPayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @avros3analyzer
  Scenario: SC#9 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\s3AvroAnalyzerPayloads\API\Actual\File1.json" should be same as the content in "ida\s3AvroAnalyzerPayloads\API\Expected\File1.json"

############################################################### Data Profiling #########################################################################################

  #7110844# #7110846#
  @MLP-23701 @avros3analyzer
  Scenario:SC#10:Verify the data profiling metadata information for string datatype in S3 Avro file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query          | TableName/Filename      | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_1 | metadataValuePresence | FileFieldQuery | combo_avroEmployee.avro | amazonaws.com | AmazonS3    | combo         | empname              |
      | Statistics  | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_1  | metadataValuePresence | FileFieldQuery | combo_avroEmployee.avro | amazonaws.com | AmazonS3    | combo         | empname              |

#7110818# #7110823#
  @MLP-23701 @avros3analyzer
  Scenario:SC#11:Verify the data profiling metadata information for numeric datatype in S3 Avro file
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                             | jsonPath                  | Action                    | query          | TableName/Filename      | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Lifecycle  | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | FileFieldQuery | combo_avroEmployee.avro | amazonaws.com | AmazonS3    | combo         | empid                |
      | Statistics | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_2 | metadataValuePresence     | FileFieldQuery | combo_avroEmployee.avro | amazonaws.com | AmazonS3    | combo         | empid                |

  #7110818# #7110822#
  @MLP-23701 @avros3analyzer
  Scenario:SC#12:Verify the data profiling metadata information for date datatype in S3 Avro file
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                    | query          | TableName/Filename        | ClusterName   | ServiceName | directoryName | columnName/FieldName |
      | Lifecycle   | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence | FileFieldQuery | dateTimestampExample.avro | amazonaws.com | AmazonS3    | avro          | date                 |
      | Statistics  | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_4  | metadataValuePresence     | FileFieldQuery | dateTimestampExample.avro | amazonaws.com | AmazonS3    | avro          | date                 |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_2 | metadataValuePresence     | FileFieldQuery | dateTimestampExample.avro | amazonaws.com | AmazonS3    | avro          | date                 |


  #7110897#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#13:Verify breadcrumb hierarchy appears correctly in AvroS3Analyzer analyzed items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "AnalyzeAvroS3" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "userpatternmatch.avro [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "state" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com         |
      | AmazonS3              |
      | asgqaavroanalyzer     |
      | TestDataSeperate      |
      | avro                  |
      | userpatternmatch.avro |
      | address               |
      | state                 |
    And user clicks on logout button

     ############################ Tags verification ############################
  #7110835#
  @MLP-23701 @avrots3analyzer
  Scenario: SC#14:Tech_tags_Explicit_Tags verification: Verify the technology tags, Business Application, Explicit tags got assigned to the analyzed items
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename          | Column            | Tags                                                              | Query          | Action         |
      | amazonaws.com | AmazonS3    | avro          | userpatternmatchsimple.avro |                   | AnalyzeAvroS3,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro,Amazon S3 | FileQuery      | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | userhugedata.avro           | registration_dttm | AnalyzeAvroS3,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | userpatternmatchsimple.avro |                   | Data Files                                                        | FileQuery      | TagNotAssigned |

  ########################### EDIBus verification ############################
#  7110897#
#  @MLP-22488 @webtest @avros3analyzer @edibus
#  Scenario: Verify the Avro S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "CatalogAvroS3" and clicks on search
#    And user performs "facet selection" in "CatalogAvroS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Avro" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#      | Field     |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/datasource/EDIBusDS_AvroS3Analyzer.json" file for following values using property loader
#      | jsonPath        | jsonValues  |
#      | $..['EDI host'] | EDIHostName |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                       | body                                                       | response code | response message | jsonPath                                                  |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                       | idc/EdiBusPayloads/datasource/EDIBusDS_AvroS3Analyzer.json | 204           |                  |                                                           |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/AvroS3AnalyzerEDIConfig.json            | 204           |                  |                                                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAvroS3Analyzer |                                                            | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAvroS3Analyzer')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAvroS3Analyzer  |                                                            | 200           |                  |                                                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAvroS3Analyzer |                                                            | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAvroS3Analyzer')].status |
#    And user enters the search text "EDIBusAvroS3Analyzer" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusAvroS3Analyzer%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "AnalyzeAvroS3" and clicks on search
#    And user performs "facet selection" in "AnalyzeAvroS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                 |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Avro |
#      | $..selections.['type_s'][*]                   | File                                       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AnalyzeAvroS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "AnalyzeAvroS3" and clicks on search
#    And user performs "facet selection" in "AnalyzeAvroS3" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Avro" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @*Avro≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | S3AVRO      | 1.0                | (XNAME * *  ~/ @*Avro≫DEFAULT≫DWR_DAT_FIELD≫@* ),AND,( TYPE = DWR_IDC ) |
#
#  Scenario: SC#14: Delete the EDIBus Analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                              | type     | query | param |
#      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusAvroS3Analyzer% | Analysis |       |       |

  Scenario Outline: SC#14:user deletes the SC1 item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

    ############################################# Filter Scenarios ##########################################################
  #Filter - Bucket Include#
  @cr-data
  Scenario Outline: SC#15:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: Bucket Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                            | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json          | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                                 | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerBucketInclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                 | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#15:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for filters - BucketName Include
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110848#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#15: Verify AvroS3Analyzer is executed successfully with filters - BucketName Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeAvroS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.avro                                 |
      | userpatternmatchsimple.avro                           |
      | userhugedata.avro                                     |
      | dateTimestampExample.avro                             |
      | tagdetails_allmatch_avro.avro                         |
      | tagdetails_allempty_avro.avro                         |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro   |
      | combo_avroEmployee.avro                               |
      | avroExampleEmployee.avro                              |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_avroEmployee.avro |
    And user enters the search text "AnalyzeAvroS3BucketInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3BucketInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatch.avro" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogAvroS3" and clicks on search
    And user performs "facet selection" in "CatalogAvroS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "b2_avroEmployee.avro" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                  | fileName              | userTag                    |
      | Default     | File | Metadata Type | AnalyzeAvroS3BucketInclude,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro | userpatternmatch.avro | AnalyzeAvroS3BucketInclude |
      | Default     | File | Metadata Type | CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro                            | b2_avroEmployee.avro  | CatalogAvroS3              |
    And user clicks on logout button

  Scenario Outline: SC#15:user deletes the item from database using dynamic id stored in json for filters - BucketName Include
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  #Filter - Bucket Exclude#
  @cr-data
  Scenario Outline: SC#16:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: Bucket Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                 | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json               | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                                      | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerBucketExcludeRegex.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                      | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#16:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for filters - Bucket Exclude Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110849#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#16: Verify AvroS3Analyzer is executed successfully with filters - Bucket Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeAvroS3BucketExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3BucketExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | b2_avroEmployee.avro |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.avro                                 |
      | userpatternmatchsimple.avro                           |
      | userhugedata.avro                                     |
      | dateTimestampExample.avro                             |
      | tagdetails_allmatch_avro.avro                         |
      | tagdetails_allempty_avro.avro                         |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro   |
      | combo_avroEmployee.avro                               |
      | avroExampleEmployee.avro                              |
    And user performs "item click" on "b2_avroEmployee.avro" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogAvroS3" and clicks on search
    And user performs "facet selection" in "CatalogAvroS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatch.avro" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                  | fileName              | userTag                    |
      | Default     | File | Metadata Type | AnalyzeAvroS3BucketExclude,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro | b2_avroEmployee.avro  | AnalyzeAvroS3BucketExclude |
      | Default     | File | Metadata Type | CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro                            | userpatternmatch.avro | CatalogAvroS3              |
    And user clicks on logout button

  Scenario Outline: SC#16:user deletes the item from database using dynamic id stored in json for filters - Bucket Exclude Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  #Filter - Directory Include#
  @cr-data
  Scenario Outline: SC#17:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: Bucketname (Include)/Directory
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                               | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json             | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                                    | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerDirectoryInclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                    | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#17:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for filters - Bucketname (Include)/Directory
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110851#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#17:Verify AvroS3Analyzer is executed successfully with filters - Bucketname (Include)/Directory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeAvroS3DirectoryInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3DirectoryInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | avroExampleEmployee.avro |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_avroEmployee.avro                                  |
      | userpatternmatch.avro                                 |
      | userpatternmatchsimple.avro                           |
      | userhugedata.avro                                     |
      | dateTimestampExample.avro                             |
      | tagdetails_allmatch_avro.avro                         |
      | tagdetails_allempty_avro.avro                         |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro   |
      | combo_avroEmployee.avro                               |
    And user performs "item click" on "avroExampleEmployee.avro" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogAvroS3" and clicks on search
    And user performs "facet selection" in "CatalogAvroS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "b2_avroEmployee.avro" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                     | fileName                      | userTag                       |
      | Default     | File | Metadata Type | AnalyzeAvroS3DirectoryInclude,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro | avroExampleEmployee.avro      | AnalyzeAvroS3DirectoryInclude |
      | Default     | File | Metadata Type | CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro                               | tagdetails_allempty_avro.avro | CatalogAvroS3                 |
    And user clicks on logout button

  Scenario Outline: SC#17:user deletes the item from database using dynamic id stored in json for filters - Bucketname (Include)/Directory
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  #Filter - Sub Directory Include#
  @cr-data
  Scenario Outline: SC#18:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: Bucket Include & SubDirectory Include Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                 | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json               | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                                      | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerSubDirIncludeRegex.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                      | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#18:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for filters - Bucket Include & SubDirectory Include Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110852#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#18: Verify AvroS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Include Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeAvroS3SubDirInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3SubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.avro                                 |
      | userpatternmatchsimple.avro                           |
      | userhugedata.avro                                     |
      | dateTimestampExample.avro                             |
      | tagdetails_allmatch_avro.avro                         |
      | tagdetails_allempty_avro.avro                         |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro   |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_avroEmployee.avro     |
      | combo_avroEmployee.avro  |
      | avroExampleEmployee.avro |
    And user enters the search text "AnalyzeAvroS3SubDirInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3SubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatch.avro" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogAvroS3" and clicks on search
    And user performs "facet selection" in "CatalogAvroS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_avroEmployee.avro" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                  | fileName                | userTag                    |
      | Default     | File | Metadata Type | AnalyzeAvroS3SubDirInclude,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro | userpatternmatch.avro   | AnalyzeAvroS3SubDirInclude |
      | Default     | File | Metadata Type | CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro                            | combo_avroEmployee.avro | CatalogAvroS3              |
    And user clicks on logout button

  Scenario Outline: SC#18:user deletes the item from database using dynamic id stored in json for filters - Bucket Include & SubDirectory Include Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  #Filter - SubDirectory Exclude#
  @cr-data
  Scenario Outline: SC#19:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: Bucket Include & SubDirectory Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                            | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json          | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                                 | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerSubDirExclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                 | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#19:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for filters - Bucket Include & SubDirectory Exclude
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110854#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#19: Verify AvroS3Analyzer is executed successfully with filters - Bucket Include & SubDirectory Exclude
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeAvroS3SubDirExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3SubDirExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | combo_avroEmployee.avro  |
      | avroExampleEmployee.avro |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_avroEmployee.avro                                  |
      | userpatternmatch.avro                                 |
      | userpatternmatchsimple.avro                           |
      | userhugedata.avro                                     |
      | dateTimestampExample.avro                             |
      | tagdetails_allmatch_avro.avro                         |
      | tagdetails_allempty_avro.avro                         |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro   |
    And user performs "item click" on "combo_avroEmployee.avro" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogAvroS3" and clicks on search
    And user performs "facet selection" in "CatalogAvroS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userpatternmatchsimple.avro" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                  | fileName                    | userTag                    |
      | Default     | File | Metadata Type | AnalyzeAvroS3SubDirExclude,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro | combo_avroEmployee.avro     | AnalyzeAvroS3SubDirExclude |
      | Default     | File | Metadata Type | CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro                            | userpatternmatchsimple.avro | CatalogAvroS3              |
    And user clicks on logout button

  Scenario Outline: SC#19:user deletes the item from database using dynamic id stored in json for filters - Bucket Include & SubDirectory Exclude
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  #Filter - File Include#
  @cr-data
  Scenario Outline: SC#20:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: File Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                          | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json        | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                               | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerFileInclude.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                               | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#20:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for filters - File Include
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110855#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#20: Verify AvroS3Analyzer is executed successfully with filters - File Include
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeAvroS3FileInclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3FileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.avro |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_avroEmployee.avro                                  |
      | combo_avroEmployee.avro                               |
      | avroExampleEmployee.avro                              |
      | userpatternmatchsimple.avro                           |
      | userhugedata.avro                                     |
      | dateTimestampExample.avro                             |
      | tagdetails_allmatch_avro.avro                         |
      | tagdetails_allempty_avro.avro                         |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro   |
    And user performs "item click" on "userpatternmatch.avro" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogAvroS3" and clicks on search
    And user performs "facet selection" in "CatalogAvroS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_avroEmployee.avro" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                | fileName                | userTag                  |
      | Default     | File | Metadata Type | AnalyzeAvroS3FileInclude,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro | userpatternmatch.avro   | AnalyzeAvroS3FileInclude |
      | Default     | File | Metadata Type | CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro                          | combo_avroEmployee.avro | CatalogAvroS3            |
    And user clicks on logout button

  Scenario Outline: SC#20:user deletes the item from database using dynamic id stored in json for filters - File Include
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  #Filter - File Exclude#
  @cr-data
  Scenario Outline: SC#21:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: File Exclude Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                               | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json             | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                                    | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerFileExcludeRegex.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                    | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#21:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for filters - File Exclude Regex
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110856#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#21: Verify AvroS3Analyzer is executed successfully with filters - File Exclude Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeAvroS3FileExclude" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3FileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.avro       |
      | userpatternmatchsimple.avro |
      | userhugedata.avro           |
      | dateTimestampExample.avro   |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | b2_avroEmployee.avro                                  |
      | combo_avroEmployee.avro                               |
      | avroExampleEmployee.avro                              |
      | tagdetails_allmatch_avro.avro                         |
      | tagdetails_allempty_avro.avro                         |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro   |
    And user performs "item click" on "userpatternmatch.avro" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "CatalogAvroS3" and clicks on search
    And user performs "facet selection" in "CatalogAvroS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "combo_avroEmployee.avro" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Last analyzed at |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                                                | fileName                | userTag                  |
      | Default     | File | Metadata Type | AnalyzeAvroS3FileExclude,CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro | userpatternmatch.avro   | AnalyzeAvroS3FileExclude |
      | Default     | File | Metadata Type | CatalogAvroS3,Test_BA_AvroS3Analyzer,Avro                          | combo_avroEmployee.avro | CatalogAvroS3            |
    And user clicks on logout button

  Scenario Outline: SC#21:user deletes the item from database using dynamic id stored in json for filters - File Exclude Regex
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  ############################################# Node Condition Internal Node ##########################################################
  @cr-data
  Scenario Outline: SC#22:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: Specific Node condition and non-existing working bucket name
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                                                           | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                                  | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3Cataloger_NodeCondition.json              | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                                  |                                                                                                | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                                 | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                   | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3Analyzer_NodeCondition_WorkingBucket.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                   |                                                                                                | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                                 | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#22:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for scenario: Specific Node condition and non-existing working bucket name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110897# #7110866#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#22: Verify AvroS3Analyzer is executed successfully for scenario: Specific Node condition and non-existing working bucket name
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeAvroS3NodeCondition" and clicks on search
    And user performs "facet selection" in "AnalyzeAvroS3NodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | userpatternmatch.avro                                 |
      | userpatternmatchsimple.avro                           |
      | userhugedata.avro                                     |
      | dateTimestampExample.avro                             |
      | b2_avroEmployee.avro                                  |
      | combo_avroEmployee.avro                               |
      | avroExampleEmployee.avro                              |
      | tagdetails_allmatch_avro.avro                         |
      | tagdetails_allempty_avro.avro                         |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro   |
    And user clicks on logout button

  Scenario Outline: SC#22:user deletes the item from database using dynamic id stored in json for scenario: Specific Node condition and non-existing working bucket name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  ######################################## Non existing buckets/ sub-directory/ file ########################################
  #7127084#
  @cr-data
  Scenario Outline: SC#23:Configure & run the AvroS3Cataloger and AvroS3Analyzer for Non existing buckets
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json              | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                                     | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerNonExistingBucket.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                     | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#23:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for Non existing buckets
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                 |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  @MLP-22488 @avros3analyzer
  Scenario: SC#23:Verify the error message in logs when AvroS3Analyzer is executed with Non existing buckets in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |
    Then Analysis log "dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#23:Configure & run the AvroS3Analyzer for Non existing sub directories
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerNonExistingSubDir.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                     | 200           | AvroS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                      | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |

  @MLP-22488 @avros3analyzer
  Scenario: SC#23:Verify the error message in logs when AvroS3Analyzer is executed with Non existing sub directory in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |
    Then Analysis log "dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  @cr-data
  Scenario Outline: SC#23:Configure & run the AvroS3Analyzer for Non existing file
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                              | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerNonExistingFile.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                                   | 200           | AvroS3Analyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                    | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status |

  @MLP-22488 @avros3analyzer
  Scenario: SC#23:Verify the error message in logs when AvroS3Analyzer is executed with Non existing file in filters
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |
    Then Analysis log "dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%" should display below info/error/warning
      | type | logValue                                 | logCode | pluginName | removableText |
      | INFO | No Files to analyze for region us-east-1 |         |            |               |

  Scenario Outline: SC#23:ItemDeletion: User deletes the AvroS3Analyzer analysis item with dry run as true from database using dynamic id stored in json for Non existing buckets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |

  Scenario:SC#23:Delete all the AvroS3Analyzer analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer% | Analysis |       |       |

  ############################################# Policy Patterns - PII Tagging ##########################################################
  Scenario Outline:SC#24:Create root tag and sub tag for AvroS3 and Update policy tags for AvroS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/s3AvroAnalyzerPayloads/policyEngine/avroS3TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/s3AvroAnalyzerPayloads/policyEngine/avroS3_policy1.1.0.json | 204           |                  |          |

  @cr-data
  Scenario Outline: SC#24:Configure & run the AvroS3Cataloger and AvroS3Analyzer for scenario: Policy Patterns - PII Tagging
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                      | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerSC1.json    | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                           | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                            | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerPIITags.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                           | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                            | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  Scenario Outline: SC#24:RetrieveItemID: User retrieves the item ids of analysis of AvroS3Analyzer and copy them to a json file for Policy Patterns - PII Tagging
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                           | type | targetFile                                  | jsonpath                    |
      | APPDBPOSTGRES | Default | amazonaws.com                                  |      | response/avroS3Analyzer/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%DYN  |      | response/avroS3Analyzer/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer%DYN |      | response/avroS3Analyzer/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  #7110870# #7110871# #7110872# #7110873# #7110886# #7110888# #7110889# #7110883#
  @MLP-22488 @avros3analyzer @PIITag
  Scenario: SC#24: Verify PII Tags gets assigned to the below fields in file: tagdetails_allmatch_avro.avro
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename            | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | GENDER    | AvroS3GenderPII_SC1Tag,AvroS3GenderPII_SC3Tag,AvroS3GenderPII_SC8Tag,AVRO,Amazon S3                                                  | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | FULL_NAME | AvroS3FullNamePII_SC1Tag,AvroS3FullNamePII_SC3Tag,AvroS3FullNamePII_SC8Tag,AVRO,Amazon S3                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | SSN       | AvroS3SSNPII_SC1Tag,AvroS3SSNPII_SC3Tag,AvroS3SSNPII_SC8Tag,AVRO,Amazon S3                                                           | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC1Tag,AvroS3IPAddressPII_SC3Tag,AvroS3IPAddressPII_SC8Tag,AVRO,Amazon S3                                         | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | GENDER    | AvroS3GenderPII_SC2Tag,AvroS3GenderPII_SC4Tag,AvroS3GenderPII_SC11Tag,AvroS3GenderPII_SC12Tag,AvroS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | EMAIL     | AvroS3EmailPII_SC2Tag,AvroS3EmailPII_SC4Tag,AvroS3EmailPII_SC11Tag,AvroS3EmailPII_SC12Tag,AvroS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | FULL_NAME | AvroS3FullNamePII_SC2Tag,AvroS3FullNamePII_SC4Tag,AvroS3FullNamePII_SC11Tag,AvroS3FullNamePII_SC12Tag,AvroS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | SSN       | AvroS3SSNPII_SC2Tag,AvroS3SSNPII_SC4Tag,AvroS3SSNPII_SC11Tag,AvroS3SSNPII_SC12Tag,AvroS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allmatch_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC2Tag,AvroS3IPAddressPII_SC4Tag,AvroS3IPAddressPII_SC11Tag,AvroS3IPAddressPII_SC12Tag,AvroS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |

  #7110870# #7110871# #7110872# #7110873# #7110890# #7110886# #7110888# #7110889#
  @MLP-22488 @avros3analyzer @PIITag
  Scenario: SC#25: Verify PII Tags gets assigned to the below fields in file: tagdetails_allempty_avro.avro
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename            | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allempty_avro.avro | SSN       | AvroS3SSNPII_SC1Tag,AvroS3SSNPII_SC3Tag,AvroS3SSNPII_SC14Tag,AVRO,Amazon S3                                                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allempty_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC1Tag,AvroS3IPAddressPII_SC3Tag,AvroS3IPAddressPII_SC14Tag,AVRO,Amazon S3                                        | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allempty_avro.avro | GENDER    | AvroS3GenderPII_SC2Tag,AvroS3GenderPII_SC4Tag,AvroS3GenderPII_SC11Tag,AvroS3GenderPII_SC12Tag,AvroS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allempty_avro.avro | EMAIL     | AvroS3EmailPII_SC2Tag,AvroS3EmailPII_SC4Tag,AvroS3EmailPII_SC11Tag,AvroS3EmailPII_SC12Tag,AvroS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allempty_avro.avro | FULL_NAME | AvroS3FullNamePII_SC2Tag,AvroS3FullNamePII_SC4Tag,AvroS3FullNamePII_SC11Tag,AvroS3FullNamePII_SC12Tag,AvroS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allempty_avro.avro | SSN       | AvroS3SSNPII_SC2Tag,AvroS3SSNPII_SC4Tag,AvroS3SSNPII_SC11Tag,AvroS3SSNPII_SC12Tag,AvroS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_allempty_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC2Tag,AvroS3IPAddressPII_SC4Tag,AvroS3IPAddressPII_SC11Tag,AvroS3IPAddressPII_SC12Tag,AvroS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7110870# #7110871# #7110872# #7110873# #7110885# #7110886# #7110888# #7110889# #7110876#
  @MLP-22488 @avros3analyzer @PIITag
  Scenario: SC#26: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolessthan05emptyfalse_avro.avro
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                             | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | GENDER    | AvroS3GenderPII_SC1Tag,AvroS3GenderPII_SC3Tag,AvroS3GenderPII_SC5Tag,AvroS3GenderPII_SC10Tag,AVRO,Amazon S3                          | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | FULL_NAME | AvroS3FullNamePII_SC5Tag,AvroS3FullNamePII_SC10Tag,AVRO,Amazon S3                                                                    | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | SSN       | AvroS3SSNPII_SC5Tag,AvroS3SSNPII_SC10Tag,AVRO,Amazon S3                                                                              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC1Tag,AvroS3IPAddressPII_SC3Tag,AvroS3IPAddressPII_SC5Tag,AvroS3IPAddressPII_SC10Tag,AVRO,Amazon S3              | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | GENDER    | AvroS3GenderPII_SC2Tag,AvroS3GenderPII_SC4Tag,AvroS3GenderPII_SC11Tag,AvroS3GenderPII_SC12Tag,AvroS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | EMAIL     | AvroS3EmailPII_SC2Tag,AvroS3EmailPII_SC4Tag,AvroS3EmailPII_SC11Tag,AvroS3EmailPII_SC12Tag,AvroS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | FULL_NAME | AvroS3FullNamePII_SC2Tag,AvroS3FullNamePII_SC4Tag,AvroS3FullNamePII_SC11Tag,AvroS3FullNamePII_SC12Tag,AvroS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | SSN       | AvroS3SSNPII_SC2Tag,AvroS3SSNPII_SC4Tag,AvroS3SSNPII_SC11Tag,AvroS3SSNPII_SC12Tag,AvroS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolessthan05emptyfalse_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC2Tag,AvroS3IPAddressPII_SC4Tag,AvroS3IPAddressPII_SC11Tag,AvroS3IPAddressPII_SC12Tag,AvroS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7110870# #7110871# #7110872# #7110873# #7110886# #7110888# #7110889# #7110881# #7110882#
  @MLP-22488 @avros3analyzer @PIITag
  Scenario: SC#27: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                    | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | AvroS3GenderPII_SC1Tag,AvroS3GenderPII_SC3Tag,AvroS3GenderPII_SC7Tag,AVRO,Amazon S3                                                  | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | AvroS3FullNamePII_SC1Tag,AvroS3FullNamePII_SC3Tag,AvroS3FullNamePII_SC7Tag,AVRO,Amazon S3                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | AvroS3SSNPII_SC1Tag,AvroS3SSNPII_SC3Tag,AvroS3SSNPII_SC7Tag,Amazon S3                                                                | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC1Tag,AvroS3IPAddressPII_SC3Tag,AvroS3IPAddressPII_SC6Tag,AvroS3IPAddressPII_SC7Tag,AVRO,Amazon S3               | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | AvroS3GenderPII_SC2Tag,AvroS3GenderPII_SC4Tag,AvroS3GenderPII_SC11Tag,AvroS3GenderPII_SC12Tag,AvroS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | AvroS3EmailPII_SC2Tag,AvroS3EmailPII_SC4Tag,AvroS3EmailPII_SC11Tag,AvroS3EmailPII_SC12Tag,AvroS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | AvroS3FullNamePII_SC2Tag,AvroS3FullNamePII_SC4Tag,AvroS3FullNamePII_SC11Tag,AvroS3FullNamePII_SC12Tag,AvroS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | AvroS3SSNPII_SC2Tag,AvroS3SSNPII_SC4Tag,AvroS3SSNPII_SC11Tag,AvroS3SSNPII_SC12Tag,AvroS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC2Tag,AvroS3IPAddressPII_SC4Tag,AvroS3IPAddressPII_SC11Tag,AvroS3IPAddressPII_SC12Tag,AvroS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7110870# #7110871# #7110872# #7110873# #7110886# #7110888# #7110889# #7110884#
  @MLP-22488 @avros3analyzer @PIITag
  Scenario: SC#28: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratioequalto05emptyfalse_avro.avro
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                            | Column    | Tags                                                                                                                                 | Query          | Action         |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | GENDER    | AvroS3GenderPII_SC1Tag,AvroS3GenderPII_SC3Tag,AvroS3GenderPII_SC9Tag,AVRO,Amazon S3                                                  | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | FULL_NAME | AvroS3FullNamePII_SC1Tag,AvroS3FullNamePII_SC3Tag,AvroS3FullNamePII_SC9Tag,AVRO,Amazon S3                                            | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | SSN       | AvroS3SSNPII_SC1Tag,AvroS3SSNPII_SC3Tag,AvroS3SSNPII_SC9Tag,Amazon S3                                                                | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC1Tag,AvroS3IPAddressPII_SC3Tag,AvroS3IPAddressPII_SC9Tag,AVRO,Amazon S3                                         | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | GENDER    | AvroS3GenderPII_SC2Tag,AvroS3GenderPII_SC4Tag,AvroS3GenderPII_SC11Tag,AvroS3GenderPII_SC12Tag,AvroS3GenderPII_SC13Tag                | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | EMAIL     | AvroS3EmailPII_SC2Tag,AvroS3EmailPII_SC4Tag,AvroS3EmailPII_SC11Tag,AvroS3EmailPII_SC12Tag,AvroS3EmailPII_SC13Tag                     | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | FULL_NAME | AvroS3FullNamePII_SC2Tag,AvroS3FullNamePII_SC4Tag,AvroS3FullNamePII_SC11Tag,AvroS3FullNamePII_SC12Tag,AvroS3FullNamePII_SC13Tag      | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | SSN       | AvroS3SSNPII_SC2Tag,AvroS3SSNPII_SC4Tag,AvroS3SSNPII_SC11Tag,AvroS3SSNPII_SC12Tag,AvroS3SSNPII_SC13Tag                               | FileFieldQuery | TagNotAssigned |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratioequalto05emptyfalse_avro.avro | IPADDRESS | AvroS3IPAddressPII_SC2Tag,AvroS3IPAddressPII_SC4Tag,AvroS3IPAddressPII_SC11Tag,AvroS3IPAddressPII_SC12Tag,AvroS3IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |


  #7110891#
  @MLP-22488 @avros3analyzer @PIITag
  Scenario: SC#29: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiogreaterthan05matchfulltrue_avro.avro
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                   | Column   | Tags                                     | Query          | Action         |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro | COMMENTS | AvroS3FullMatchPII_SC2Tag,AVRO,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro | COMMENTS | AvroS3FullMatchPII_SC1Tag,AVRO,Amazon S3 | FileFieldQuery | TagNotAssigned |

  #7110892#
  @MLP-22488 @avros3analyzer @PIITag
  Scenario: SC#30: Verify PII Tags gets assigned to the below fields in file: tagdetails_ratiolesserthan05matchfulltrue_avro.avro
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName   | ServiceName | directoryName | TableName/Filename                                  | Column   | Tags                                     | Query          | Action         |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolesserthan05matchfulltrue_avro.avro | COMMENTS | AvroS3FullMatchPII_SC4Tag,AVRO,Amazon S3 | FileFieldQuery | TagAssigned    |
      | amazonaws.com | AmazonS3    | avro          | tagdetails_ratiolesserthan05matchfulltrue_avro.avro | COMMENTS | AvroS3FullMatchPII_SC3Tag,AVRO,Amazon S3 | FileFieldQuery | TagNotAssigned |


  Scenario Outline: SC#30:user deletes the item from database using dynamic id stored in json for scenario: Policy Patterns - PII Tagging
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/avroS3Analyzer/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/avroS3Analyzer/actual/itemIds.json |

  ############################################# Incremental scenario ##########################################################
  @cr-data
  Scenario Outline: SC#31:Configure & run the AvroS3Cataloger and AvroS3Analyzer - Incremental scenario Run 1
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                          | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerIncRun1.json    | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                               | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerIncRunFalse.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                               | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  #7110869#
  @MLP-22488 @avros3analyzer
  Scenario: SC#31: Verify AvroS3Analyzer is executed successfully for scenario: Incremental scenario Run 1
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_4 | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |

  @cr-data
  Scenario Outline: SC#31:Configure & run the AvroS3Cataloger and AvroS3Analyzer - Incremental scenario Run 2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                       | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                               | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3CatalogerIncRun2.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                               |                                                                            | 200           | AvroS3Cataloger  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger   | ida/empty.json                                                             | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger  |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer                                                | ida/s3AvroAnalyzerPayloads/PluginConfiguration/AvroS3AnalyzerSC1.json      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Analyzer                                                |                                                                            | 200           | AvroS3Analyzer   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer  | ida/empty.json                                                             | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AvroS3Analyzer')].status  |

  #7110869#
  @MLP-22488 @webtest @avros3analyzer
  Scenario: SC#31: Verify AvroS3Analyzer is executed successfully for scenario: Incremental scenario Run 2
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                   | Action                | query         | TableName/Filename                         |
      | Description | ida/s3AvroAnalyzerPayloads/API/expectedmetadata.json | $.Analysis_2.Description_4 | metadataValuePresence | AnalysisQuery | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer |


  Scenario: SC#31: Delete the items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | amazonaws.com                               | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroS3Analyzer/AvroS3Analyzer% | Analysis |       |       |

#  ############################################# Post Conditions ##########################################################

  @aws
  Scenario: SC#32:Terminate an EMR cluster in Amazon EMR service
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action           | clusterName               | filePath | jsonPath |
      | TerminateCluster | asg-di-emrcluster-qaavro5 |          |          |

  @aws
  Scenario: SC#32:Delete the AWS bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "TestAnalyzer" in bucket "asgqaavroanalyzerb2"
    Given user "Delete" objects in amazon directory "TestDataSeperate" in bucket "asgqaavroanalyzer"
    Given user "Delete" objects in amazon directory "TestAnalyzerAll" in bucket "asgqaavroanalyzer"
    Given user "Delete" objects in amazon directory "" in bucket "asg-qa-emr-avroanalyzer"
    Then user "Delete" a bucket "asgqaavroanalyzerb2" in amazon storage service
    Then user "Delete" a bucket "asgqaavroanalyzer" in amazon storage service
    Then user "Delete" a bucket "asg-qa-emr-avroanalyzer" in amazon storage service

  @cr-data
  Scenario Outline: SC#32:Delete Credentials, Datasource and cataloger config for Avro S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                 | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroS3Cataloger                                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroS3Analyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroS3DataSource                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidAvroReadWriteCredentials                                  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidAvroReadOnlyCredentials                                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidAvroCredentials                                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyAvroCredentials                                           |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EDIBusValidCredentials                                         |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource                                                 |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus                                                           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=AvroS3Analyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/AvroS3PII                                                        |      | 204           |                  |          |

  Scenario: SC#32: Delete the businessApplication tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type                | query | param |
      | SingleItemDelete | Default | Test_BA_AvroS3Analyzer | BusinessApplication |       |       |
#      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusAvroS3Analyzer% | Analysis            |       |       |
