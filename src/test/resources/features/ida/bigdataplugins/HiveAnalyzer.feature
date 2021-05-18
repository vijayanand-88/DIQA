Feature:MLP-24272 Implement db reboot changes for Hive Analyzer


#####################################################################################################################################################################
##############Scenario 1 - HiveCataloger with Hive Analyzer with analyzer triggered manually and cluster name resolution is disabled in HiveCataloger.
##############################################################################################################################################################

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                     | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HiveMonitor/HiveMonitor%            | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |


  @positve @regression @sanity @MLP-24272 @IDA-1.1.0
  Scenario Outline: Set the Credentials, Datasource, Bussiness Application and Cataloger for Hive Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                             | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveValidCredential   | ida/hivePayloads/Credentials/hiveValidCredentials.json           | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveInValidCredential | ida/hivePayloads/Credentials/hiveInValidCredentials.json         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveEmptyCredential   | ida/hivePayloads/Credentials/hiveEmptyCredentials.json           | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveValidCredential   |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveInValidCredential |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveEmptyCredential   |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\hivePayloads\Bussiness_Application\BussinessApplication.json | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HiveDataSource          | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json       | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HiveDataSource          |                                                                  | 200           | HiveDataSource_Valid |          |


  @MLP-24272 @sanity @positive
  Scenario:Creating a table in hiveview
    And user executes the following Query in the Hive JDBC
      | queryEntry               |
      | CreateHiveBDADatabase    |
      | CreateHiveBDATable11     |
      | InsertHiveBDATable11Row1 |
      | InsertHiveBDATable11Row2 |
      | InsertHiveBDATable11Row3 |
      | InsertHiveBDATable11Row4 |
      | InsertHiveBDATable11Row5 |
      | CreateHiveDatabase       |
      | CreateHiveTable33        |
      | InsertHiveTable33Row1    |
      | InsertHiveTable33Row2    |
      | InsertHiveTable33Row3    |
      | InsertHiveTable33Row4    |
      | InsertHiveTable33Row5    |
    And sync the test execution for "10" seconds


  Scenario Outline:MLP-24272:SC1#Run the Plugin configurations for HiveCataloger and HiveAnalyzer.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                           | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                      | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBHiveAnalyzerFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                      |                                                                                | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                   | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfig.json                   | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                   |                                                                                | 200           | HiveAnalyzer     |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger       | ida/hivePayloads/PluginConfiguration/empty.json                                | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer  | ida/hivePayloads/PluginConfiguration/empty.json                                | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |


   ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @hiveanalyzer
  Scenario Outline:SC1#Verify the data sampling works fine after HiveAnalyzer is manually triggered after HiveCataloger
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name    | asg_scopeid   | targetFile                               | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | hivebda | diffdatatypes | payloads/ida/hivePayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @hiveanalyzer
  Scenario Outline: SC1:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                | outPutFile                                      | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/hivePayloads/API/items.json | payloads\ida\hivePayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @hiveanalyzer
  Scenario: SC#1 Verify the DataSamples values are as expected
    Then file content in "ida\hivePayloads\API\Actual\File1.json" should be same as the content in "ida\hivePayloads\API\Expected\File1.json"

#######################################################################################################################################################################

#7154115 Bug MLP-26016 raised for issue.
  @positve @regression @sanity
  Scenario:SC2#Verify data profiling appears for numeric columns in Hive Tables.
    Given Verify the metadata properties of the item types via api call
      | TabName  | widgetName           | filePath                                   | jsonPath                  | Action                    | query                    | TableName/Filename | ClusterName  | ServiceName | DatabaseName | columnName/FieldName |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | inttype              |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Statistics   | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | inttype              |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | biginttype           |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_2 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | biginttype           |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | floattype            |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_5 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | floattype            |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | decimaltype          |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_6 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | decimaltype          |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | tinyinttype          |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_7 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | tinyinttype          |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | smallinttype         |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_8 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | smallinttype         |
      | Overview | Most frequent values | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget1      | verify widget presence    | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | inttype              |
      | Overview | Data Distribution    | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget2      | verify widget presence    | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | inttype              |

#7154115
  @positve @regression @sanity
  Scenario:SC3#Verify data profiling appears for string,date,timestamp,boolean columns in Hive Tables.
    Given Verify the metadata properties of the item types via api call
      | TabName  | widgetName           | filePath                                   | jsonPath                   | Action                     | query                    | TableName/Filename | ClusterName  | ServiceName | DatabaseName | columnName/FieldName |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence  | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | stringtype           |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_9  | metadataValuePresence      | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | stringtype           |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence  | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | datetype             |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_10 | metadataValuePresence      | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | datetype             |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence  | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | timestamptype        |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_11 | metadataValuePresence      | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | timestamptype        |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence  | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | booleantype          |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_12 | metadataValuePresence      | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | booleantype          |
      | Overview | Most frequent values | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget1       | verify widget presence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | booleantype          |
      | Overview | Data Distribution    | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget2       | verify widget non presence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | booleantype          |


#7154116 Open Bug MLP-26107
  @sanity @positive
  Scenario: SC4# Verify the technology tags got assigned to all HiveAnalyzed items.
    Given Tag verification of UI items in API for all the DataTypes
      | HostName | ClusterName  | ServiceName | DatabaseName | TableName/Filename | Column  | Tags                                   | Query                    | Action      |
      |          | Cluster Demo |             |              |                    |         | Hive,HiveTag1,HiveAnalyzerTag1,Hive_BA | ClusterQuery             | TagAssigned |
      |          | Cluster Demo | HIVE        | hivebda      | diffdatatypes      | inttype | Hive,HiveTag1,HiveAnalyzerTag1,Hive_BA | ColumnQuerywithoutSchema | TagAssigned |
      |          | Cluster Demo | HIVE        | hivebda      |                    |         | Hive,HiveTag1,HiveAnalyzerTag1,Hive_BA | DatabaseQuery            | TagAssigned |
      |          | Cluster Demo | HIVE        |              |                    |         | Hive,HiveTag1,HiveAnalyzerTag1,Hive_BA | ServiceQuery             | TagAssigned |
      |          | Cluster Demo | HIVE        | hivebda      | diffdatatypes      |         | Hive,HiveTag1,Hive_BA,HiveAnalyzerTag1 | TableQuerywithoutSchema  | TagAssigned |


    #7154116
  @sanity @positive @MLP-24873 @IDA-1.1.0
  Scenario:SC5#Verify log entries/log enhancements(processed Items widget and Processed count) check for HiveAnalyzer plugin logs.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                   | jsonPath                            | Action                | query         | TableName/Filename                         |
      | Description | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_dryrun_false.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |
    And Analysis log "dataanalyzer/HiveDataAnalyzer/HiveAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:HiveDataAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:HiveAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0071 | HiveDataAnalyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: ---  2020-10-04 17:30:43.297 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: name: "HiveAnalyzer"  2020-10-04 17:30:43.298 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: pluginVersion: "LATEST"  2020-10-04 17:30:43.298 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: label:  2020-10-04 17:30:43.298 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: : ""  2020-10-04 17:30:43.298 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: catalogName: "Default"  2020-10-04 17:30:43.298 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: eventClass: null  2020-10-04 17:30:43.298 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: eventCondition: null  2020-10-04 17:30:43.299 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-10-04 17:30:43.299 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: maxWorkSize: 100  2020-10-04 17:30:43.299 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: tags:  2020-10-04 17:30:43.299 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: - "HiveAnalyzerTag1"  2020-10-04 17:30:43.299 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: pluginType: "dataanalyzer"  2020-10-04 17:30:43.299 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: dataSource: null  2020-10-04 17:30:43.299 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: credential: null  2020-10-04 17:30:43.300 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: businessApplicationName: "Hive_BA"  2020-10-04 17:30:43.300 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: dryRun: false  2020-10-04 17:30:43.300 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: schedule: null  2020-10-04 17:30:43.300 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: filter: null  2020-10-04 17:30:43.300 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: histogramBuckets: 100  2020-10-04 17:30:43.300 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: sparkOptions:  2020-10-04 17:30:43.301 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: - key: "deploy.mode"  2020-10-04 17:30:43.301 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: value: "client"  2020-10-04 17:30:43.301 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: - key: "spark.network.timeout"  2020-10-04 17:30:43.301 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: value: "600s"  2020-10-04 17:30:43.301 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: pluginName: "HiveDataAnalyzer"  2020-10-04 17:30:43.302 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: runAfter: []  2020-10-04 17:30:43.302 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: dataSample:  2020-10-04 17:30:43.302 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: sampleSize: 25  2020-10-04 17:30:43.302 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: type: "Dataanalyzer"  2020-10-04 17:30:43.302 INFO  - ANALYSIS-0073: Plugin HiveDataAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | HiveDataAnalyzer |                |
      | INFO | Plugin HiveDataAnalyzer Start Time:2020-08-04 18:20:14.107, End Time:2020-08-04 18:22:29.387, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | HiveDataAnalyzer |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |               |                  |                |

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |


  Scenario Outline:MLP-24272:SC6#Run the Plugin configurations for HiveCataloger and HiveAnalyzer with dry run as true.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                      | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                      | ida/hivePayloads/PluginConfiguration/HiveConfigDryRunTrueForAnalyzer.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                      |                                                                           | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                   | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfigDryRunTrue.json    | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                   |                                                                           | 200           | HiveAnalyzer     |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger       | ida/hivePayloads/PluginConfiguration/empty.json                           | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer  | ida/hivePayloads/PluginConfiguration/empty.json                           | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |


      #7154116 Bug MLP-24578 raised for issue.
  @MLP-24873 @webtest @regression @sanity
  Scenario: SC6#Verify HiveAnalyzer doesn't collects Cluster,Service,Database,Table,Column when run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveAnalyzerTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service  |
      | Cluster  |
      | Database |
      | Table    |
      | Column   |
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                   | jsonPath                           | Action                | query         | TableName/Filename                         |
      | Description | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_dryrun_true.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |
    And Analysis log "dataanalyzer/HiveDataAnalyzer/HiveAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                              | logCode       | pluginName       | removableText |
      | INFO | Plugin HiveDataAnalyzer running on dry run mode                                                                                       | ANALYSIS-0069 | HiveDataAnalyzer |               |
      | INFO | Plugin HiveDataAnalyzer processed 2 items on dry run mode and not written to the repository                                           | ANALYSIS-0070 | HiveDataAnalyzer |               |
      | INFO | Plugin HiveDataAnalyzer Start Time:2020-08-04 19:06:26.536, End Time:2020-08-04 19:06:26.804, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | HiveDataAnalyzer |               |
    And user clicks on logout button


    #7154118
  @MLP-24272 @webtest @positive @regression @sanity
  Scenario: SC7#Verify proper error message is shown if mandatory fields are not filled in HiveAnalyzer configuration page
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
      | fieldName | attribute        |
      | Type      | Dataanalyzer     |
      | Plugin    | HiveDataAnalyzer |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

#7155361
  @webtest @jdbc @MLP-24272
  Scenario:SC8#Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in HiveAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Dataanalyzer     |
      | Plugin    | HiveDataAnalyzer |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HiveAnalyzerTest       |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample size           |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName   | errorMessage                          |
      | Sample size | Sample size field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample size           | 1001                   |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName   | errorMessage                                         |
      | Sample size | Value of Sample size should not be greater than 1000 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample size           | 9                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName   | errorMessage                                      |
      | Sample size | Value of Sample size should not be lesser than 10 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                         |
      | Top values | Top values field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                    |
      | Top values | Value of Top values should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 31                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                      |
      | Top values | Value of Top values should not be greater than 30 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                |
      | Histogram buckets | Histogram buckets field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                           |
      | Histogram buckets | Value of Histogram buckets should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 21                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                             |
      | Histogram buckets | Value of Histogram buckets should not be greater than 20 |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

#7154117
  @MLP-23777 @webtest @positive @regression @sanity
  Scenario: SC9-Verify captions in HiveAnalyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Dataanalyzer     |
      | Plugin    | HiveDataAnalyzer |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Type*                |
      | Name*                |
      | Plugin*              |
      | Label                |
      | Business Application |
      | Sample size*         |
      | Histogram buckets*   |
      | Top values*          |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Plugin version    |
      | Event condition   |
      | Dry Run           |
      | Event class       |
      | Maximum work size |
      | Node condition    |


    #7132255
  @positve @regression @sanity  @MLP-24873 @IDA-1.1.0
  Scenario Outline: Get the Hive Analyzer Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                     | response code | response message | filePath                                   | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/hive/body/ToolTip_Analyzer.json | 200           |                  | response/hive/actual/ToolTip_Analyzer.json |          |


    #7154117
  @positve @regression @sanity  @MLP-24873 @IDA-1.1.0
  Scenario Outline:SC10# Validate ToolTip for all the fields in Hive Analyzer plugin.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                      | actualValues                               | valueType     | expectedJsonPath                               | actualJsonPath                                                  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip   | $..[?(@.label=='Type')].tooltip                                 |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.pluginName.tooltip              | $.properties[0].value.prototype.properties[1].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.PluginConfigName.tooltip        | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.pluginVersion.tooltip           | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.label.tooltip                   | $.properties[0].value.prototype.properties[4].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.businessApplicationName.tooltip | $.properties[0].value.prototype.properties[15].tooltip          |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.Samplesize.tooltip              | $.properties[0].value.prototype.properties[16].value[0].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.Histogrambuckets.tooltip        | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.Topvalues.tooltip               | $.properties[0].value.prototype.properties[18].tooltip          |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.eventCondition.tooltip          | $.properties[0].value.prototype.properties[5].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.dryRun.tooltip                  | $.properties[0].value.prototype.properties[6].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.eventClass.tooltip              | $.properties[0].value.prototype.properties[7].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.maxWorkSize.tooltip             | $.properties[0].value.prototype.properties[8].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.nodeCondition.tooltip           | $.properties[0].value.prototype.properties[10].tooltip          |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.autoStart.tooltip               | $.properties[0].value.prototype.properties[11].tooltip          |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.tags.tooltip                    | $.properties[0].value.prototype.properties[12].tooltip          |
#      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.schedule.tooltip                | $.properties[0].value.prototype.properties[15].tooltip          |
#      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Analyzer.json | stringCompare | $.Commonfields.runAfter.tooltip                | $.properties[0].value.prototype.properties[11].tooltip          |


  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |



#####################################################################################################################################################################
##############Scenario 2 - HiveCataloger with Hive Analyzer with analyzer triggered automatically and cluster name resolution is enabled in HiveCataloger.
##############################################################################################################################################################

  Scenario Outline:MLP-24272:SC11#Run the Plugin configurations for HiveCataloger and HiveAnalyzer with automatic triggering of analyzer.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                                                | response code | response message                       | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveDataSource                                                     | ida/hivePayloads/DataSource/hiveValidDataSourceResolveClusterNameTrueConfig.json                    | 204           |                                        |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                     |                                                                                                     | 200           | HiveDataSource_ValidResolveClusterTrue |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                      | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBFilterResolveClusterNameTrueForAnalyzer.json | 204           |                                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                      |                                                                                                     | 200           | HiveCataloger                          |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                   | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfig.json                                        | 204           |                                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                   |                                                                                                     | 200           | HiveAnalyzer                           |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                                     | 200           | IDLE                                   | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger       | ida/hivePayloads/PluginConfiguration/empty.json                                                     | 200           |                                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                                     | 200           | IDLE                                   | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                                     | 200           | IDLE                                   | $.[?(@.configurationName=='HiveAnalyzer')].status  |

   ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @hiveanalyzer
  Scenario Outline:SC11#Verify the data sampling works fine after HiveAnalyzer is manually triggered after HiveCataloger
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name    | asg_scopeid   | targetFile                               | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | hivebda | diffdatatypes | payloads/ida/hivePayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @hiveanalyzer
  Scenario Outline: SC11:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                | outPutFile                                      | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/hivePayloads/API/items.json | payloads\ida\hivePayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @hiveanalyzer
  Scenario: SC#11 Verify the DataSamples values are as expected
    Then file content in "ida\hivePayloads\API\Actual\File1.json" should be same as the content in "ida\hivePayloads\API\Expected\File1.json"

##############################################################################################################################################################

 #7154131
  @positve @regression @sanity @webtest
  Scenario:SC12#Verify data profiling appears for numeric columns in Hive Tables.(HiveAnalyzer automatically triggered after HiveCataloger)
    Given Verify the metadata properties of the item types via api call
      | TabName  | widgetName           | filePath                                   | jsonPath                  | Action                    | query                    | TableName/Filename | ClusterName  | ServiceName | DatabaseName | columnName/FieldName |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | inttype              |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Statistics   | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | inttype              |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | biginttype           |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_2 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | biginttype           |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | floattype            |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_5 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | floattype            |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | decimaltype          |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_6 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | decimaltype          |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | tinyinttype          |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_7 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | tinyinttype          |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle    | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | smallinttype         |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_8 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | smallinttype         |
      | Overview | Most frequent values | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget1      | verify widget presence    | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | inttype              |
      | Overview | Data Distribution    | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget2      | verify widget presence    | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | inttype              |


#7154131
  @positve @regression @sanity @webtest
  Scenario:SC13#Verify data profiling appears for string,date,timestamp,boolean columns in Hive Tables.(HiveAnalyzer automatically triggered after HiveCataloger)
    Given Verify the metadata properties of the item types via api call
      | TabName | widgetName | filePath                                   | jsonPath                   | Action                    | query                    | TableName/Filename | ClusterName  | ServiceName | DatabaseName | columnName/FieldName |
      |         | Lifecycle  | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | stringtype           |
      |         | Statistics | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_9  | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | stringtype           |
      |         | Lifecycle  | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | datetype             |
      |         | Statistics | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_10 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | datetype             |
      |         | Lifecycle  | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | timestamptype        |
      |         | Statistics | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_11 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | timestamptype        |
      |         | Lifecycle  | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | booleantype          |
      |         | Statistics | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_12 | metadataValuePresence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | booleantype          |


  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                     | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |


  Scenario Outline:MLP-24272:SC14#Run the Plugin configurations for HiveCataloger and HiveAnalyzer with non existing DB in cataloger.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                    | response code | response message     | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveDataSource                                                     | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json              | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                     |                                                                         | 200           | HiveDataSource_Valid |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                      | ida/hivePayloads/PluginConfiguration/HiveConfigNonexistingDBFilter.json | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                      |                                                                         | 200           | HiveCataloger        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                   | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfig.json            | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                   |                                                                         | 200           | HiveAnalyzer         |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                         | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger       | ida/hivePayloads/PluginConfiguration/empty.json                         | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                         | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                         | 200           | IDLE                 | $.[?(@.configurationName=='HiveAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer  | ida/hivePayloads/PluginConfiguration/empty.json                         | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                         | 200           | IDLE                 | $.[?(@.configurationName=='HiveAnalyzer')].status  |

#7154131
  @MLP-24272 @webtest @regression @sanity
  Scenario: SC14- Verify HiveAnalyzer does not analyze anything when the catalog does not contain any items.(HiveCataloger has invalid DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveAnalyzerTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service  |
      | Cluster  |
      | Database |
      | Table    |
      | Column   |

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |


  Scenario Outline:MLP-24272:SC15#Run the Plugin configurations for HiveCataloger and HiveAnalyzer for Analyzer rerun scenario.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                           | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                      | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBHiveAnalyzerFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                      |                                                                                | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                   | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfig.json                   | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                   |                                                                                | 200           | HiveAnalyzer     |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger       | ida/hivePayloads/PluginConfiguration/empty.json                                | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer  | ida/hivePayloads/PluginConfiguration/empty.json                                | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |



  #67154116 MLP-26255 Bug raised for the issue.
  @MLP-24272 @webtest @positve @hdfs @regression @sanity
  Scenario:SC15_Verify whether the data analysis is not performed once the HiveAnalyzer runs after HiveAnalyzer.
    Given User launch browser and traverse to login page
    And user enter credentials for "system Administrator1" role
    And user enters the search text "HiveAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "diffdatatypes" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "inttype" item from search results
    And user "store" the value of item "inttype" of attribute "Last analyzed at" with temporary text
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                            | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                 | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer  | ida/hivePayloads/PluginConfiguration/empty.json | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                 | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status |
    And user enters the search text "HiveAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "diffdatatypes" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "inttype" item from search results
    Then user "verify equals" the value of item "inttype" of attribute "Last analyzed at" with temporary text


  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |


  Scenario Outline:MLP-24272:SC16#Run the Plugin configurations for HiveAnalyzer alone without HiveCataloger ran.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                         | response code | response message | jsonPath                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                   | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfig.json | 204           |                  |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                   |                                                              | 200           | HiveAnalyzer     |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                              | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer  | ida/hivePayloads/PluginConfiguration/empty.json              | 200           |                  |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                              | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status |


  #7158896
  @MLP-24272 @webtest @regression @sanity
  Scenario: SC#16- Verify HiveAnalyzer is ran without HiveCataloger and the analyzer log shows proper message.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                   | jsonPath                   | Action                | query         | TableName/Filename                         |
      | Description | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Description_3 | metadataValuePresence | AnalysisQuery | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |
    And Analysis log "dataanalyzer/HiveDataAnalyzer/HiveAnalyzer%" should display below info/error/warning
      | type | logValue                                            | logCode               | pluginName       | removableText |
      | INFO | No more data which have to be analyzed. Proceeding. | BIGDATA-ANALYZER-0008 | HiveDataAnalyzer |               |

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |

  Scenario Outline:MLP-24272:SC17#Run the Plugin configurations for HiveCataloger and HiveAnalyzer analyze tables from multiple DBs.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                            | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                      | ida/hivePayloads/PluginConfiguration/HiveConfigMultipleDBFilterForAnalyzer.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                      |                                                                                 | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                   | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfigAutoRun.json             | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                   |                                                                                 | 200           | HiveAnalyzer     |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger       | ida/hivePayloads/PluginConfiguration/empty.json                                 | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer  | ida/hivePayloads/PluginConfiguration/empty.json                                 | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |


    #7154127 Bug MLP-26016 raised for issue.
    ########################################################Data Sample validation############################################################################
#7123277#
  @MLP-24319 @hiveanalyzer
  Scenario Outline:SC17#Verify the data sampling works fine after HiveAnalyzer is manually triggered after HiveCataloger
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name    | asg_scopeid   | targetFile                               | jsonpath                     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | hivebda | diffdatatypes | payloads/ida/hivePayloads/API/items.json | $.Directories.Filename.File1 |

  @MLP-24319 @hiveanalyzer
  Scenario Outline: SC17:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                    | inputFile                                | outPutFile                                      | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.File1 | payloads/ida/hivePayloads/API/items.json | payloads\ida\hivePayloads\API\Actual\File1.json |            |

#7152591
  @MLP-24319 @hiveanalyzer
  Scenario: SC#17 Verify the HiveAnalyzer does analysis for tables in multiple DBs.
    Then file content in "ida\hivePayloads\API\Actual\File1.json" should be same as the content in "ida\hivePayloads\API\Expected\File1.json"


  @MLP-24319 @hiveanalyzer
  Scenario: SC#17 Verify the HiveAnalyzer does analysis for tables in multiple DBs - Data Profiling
    Given Verify the metadata properties of the item types via api call
      | TabName  | widgetName           | filePath                                   | jsonPath                   | Action                     | query                    | TableName/Filename | ClusterName  | ServiceName | DatabaseName | columnName/FieldName |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence  | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | stringtype           |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_9  | metadataValuePresence      | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | stringtype           |
      | Overview | Most frequent values | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget1       | verify widget presence     | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | stringtype           |
      | Overview | Data Distribution    | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget2       | verify widget non presence | ColumnQuerywithoutSchema | diffdatatypes      | Cluster Demo | HIVE        | hivebda      | stringtype           |
      |          | Lifecycle            | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.Lifecycle     | metadataAttributePresence  | ColumnQuerywithoutSchema | zone_east          | Cluster Demo | HIVE        | hivesample   | store_name           |
      |          | Statistics           | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_2.Statistics_13 | metadataValuePresence      | ColumnQuerywithoutSchema | zone_east          | Cluster Demo | HIVE        | hivesample   | store_name           |
      | Overview | Most frequent values | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget1       | verify widget presence     | ColumnQuerywithoutSchema | zone_east          | Cluster Demo | HIVE        | hivesample   | store_name           |
      | Overview | Data Distribution    | ida/hivePayloads/API/expectedmetadata.json | $.Analysis_1.widget2       | verify widget non presence | ColumnQuerywithoutSchema | zone_east          | Cluster Demo | HIVE        | hivesample   | store_name           |

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |


#  Scenario Outline:MLP-24272:SC18#Run the Plugin configurations for HiveCataloger and HiveAnalyzer for Analyzer rerun scenario.
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                             | response code | response message | jsonPath                                           |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                      | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBHiveAnalyzerFilter.json   | 204           |                  |                                                    |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                      |                                                                                  | 200           | HiveCataloger    |                                                    |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                   | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfigVarySampleParameters.json | 204           |                  |                                                    |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                   |                                                                                  | 200           | HiveAnalyzer     |                                                    |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger       | ida/hivePayloads/PluginConfiguration/empty.json                                  | 200           |                  |                                                    |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger      |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer  | ida/hivePayloads/PluginConfiguration/empty.json                                  | 200           |                  |                                                    |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status  |
#
#
#
#        #7154119
#  @webtest @MLP-24272
#  Scenario:SC#18_Verify HiveAnalyzer does data sampling/data profiling properly for hive tables files when sample size/histogram/top values are varied.
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "HiveAnalyzerTag1" and clicks on search
#    And user performs "facet selection" in "HiveAnalyzerTag1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "diffdatatypes" item from search results
#    And user "navigatesToTab" name "Data Sample" in item view page
#    Then following "Data Sample" values should get displayed in item view page
#      | Inttype | Tinyinttype | Smallinttype | Biginttype | Floattype | Doubletype | Decimaltype | Stringtype | Varchartype | Chartype | Datetype   | Timestamptype         | Booleantype | Binarytype  |
#      | 10      | 5           | 2000         | 10000      | 234.5     | 5000.56    | 8500        | string1    | varchar1    | char1    | 2014-12-07 | 2014-12-07 23:00:00.0 | true        | UNSUPPORTED |
#      | 12      | 15          | 5000         | 15000      | 334.5     | 6000.56    | 8700        | string2    | varchar2    | char2    | 2015-10-03 | 2015-10-03 12:20:00.0 | false       | UNSUPPORTED |
#    And user enters the search text "HiveAnalyzerTag1" and clicks on search
#    And user performs "facet selection" in "HiveAnalyzerTag1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "diffdatatypes" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "chartype" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    And user "widget presence" on "Most frequent values" in Item view page
#
#
#  @sanity @positive @regression
#  Scenario:Delete Cluster , Cataloger Analysis file
#    Given Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                        | type     | query | param |
#      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
#      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
#      | SingleItemDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |


  #####################################################################################################################################################################
############## Deleting the created database/table in hive view
##############################################################################################################################################################

  @MLP-24272 @sanity @positive
  Scenario: MLP-24272: Deleting the created database/table in hive view
    And user executes the following Query in the Hive JDBC
      | queryEntry          |
      | DropHiveBDATable11  |
      | DropHiveBDADatabase |
      | dropHiveTable11     |
      | dropHiveTable33     |
      | DropDatabase        |
################################################Delete all the Cluster ,Cataloger and Analyzer################################

  @sanity @positive @regression
  Scenario:Delete Cluster ,Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | MultipleIDDelete | Default | Cluster Demo                    | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/%       | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HiveDataAnalyzer/% | Analysis |       |       |

  ############################################# Policy Patterns - PII Tagging ##########################################################

  Scenario: MLP-24873: Create Hive Database and Table to verify PII Data pattern
    Given user executes the following Query in the Hive JDBC
      | queryEntry                                      |
      | CreateHiveDatabase3                             |
      | CreateHiveTableALLMATCH                         |
      | CreateHiveTableALLEMPTY                         |
      | CreateHiveTableRatiolessthan05EmptyFalse        |
      | CreateHiveTableRatiogreaterthan05EmptyFalseTrue |
      | CreateHiveTableRatioEqualTo05EmptyFalse         |
      | CreateHiveTableRatiogreaterthan05MatchFullTrue  |
      | CreateHiveTableRatiolesserthan05MatchFullTrue   |

  Scenario: MLP-24873: Insert data into the database
    Given user executes the following Query in the Hive JDBC
      | queryEntry                                        |
      | InsertHiveTableALLMATCH1                          |
      | InsertHiveTableALLMATCH2                          |
      | InsertHiveTableALLMATCH3                          |
      | InsertHiveTableALLMATCH4                          |
      | InsertHiveTableALLMATCH5                          |
      | InsertHiveTableALLEMPTY1                          |
      | InsertHiveTableALLEMPTY2                          |
      | InsertHiveTableALLEMPTY3                          |
      | InsertHiveTableALLEMPTY4                          |
      | InsertHiveTableALLEMPTY5                          |
      | InsertHiveTableRatiolessthan05EmptyFalse1         |
      | InsertHiveTableRatiolessthan05EmptyFalse2         |
      | InsertHiveTableRatiolessthan05EmptyFalse3         |
      | InsertHiveTableRatiolessthan05EmptyFalse4         |
      | InsertHiveTableRatiolessthan05EmptyFalse5         |
      | InsertHiveTableRatiolessthan05EmptyFalse6         |
      | InsertHiveTableRatiolessthan05EmptyFalse7         |
      | InsertHiveTableRatiolessthan05EmptyFalse8         |
      | InsertHiveTableRatiolessthan05EmptyFalse9         |
      | InsertHiveTableRatiolessthan05EmptyFalse10        |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue1  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue2  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue3  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue4  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue5  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue6  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue7  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue8  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue9  |
      | InsertHiveTableRatiogreaterthan05EmptyFalseTrue10 |
      | InsertHiveTableRatioEqualTo05EmptyFalse1          |
      | InsertHiveTableRatioEqualTo05EmptyFalse2          |
      | InsertHiveTableRatioEqualTo05EmptyFalse3          |
      | InsertHiveTableRatioEqualTo05EmptyFalse4          |
      | InsertHiveTableRatioEqualTo05EmptyFalse5          |
      | InsertHiveTableRatioEqualTo05EmptyFalse6          |
      | InsertHiveTableRatioEqualTo05EmptyFalse7          |
      | InsertHiveTableRatioEqualTo05EmptyFalse8          |
      | InsertHiveTableRatioEqualTo05EmptyFalse9          |
      | InsertHiveTableRatioEqualTo05EmptyFalse10         |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue1   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue2   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue3   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue4   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue5   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue6   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue7   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue8   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue9   |
      | InsertHiveTableRatiogreaterthan05MatchFullTrue10  |
      | InsertHiveTableRatiolesserthan05MatchFullTrue1    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue2    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue3    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue4    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue5    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue6    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue7    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue8    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue9    |
      | InsertHiveTableRatiolesserthan05MatchFullTrue10   |
    And sync the test execution for "15" seconds

  Scenario Outline:Policy1:Create root tag and sub tag for HiveAnlayzer  and Update policy tags for HiveAnlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/hivePayloads/API/PolicyEngine/HIVE_TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/hivePayloads/API/PolicyEngine/HIVE_policy1.json      | 204           |                  |          |


#  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC19#-MLP_24889_set Hive data source with cluter resolve name false and run Hive cataloger for Hive  analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | body                                                                     | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                               | ida/hivePayloads/PluginConfiguration/HiveConfigPolictPatternDBTable.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                               |                                                                          | 200           | HiveCataloger_PolicyPattern |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataAnalyzer                                                            | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfig.json             | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveDataAnalyzer                                                            |                                                                          | 200           | HiveAnalyzer                |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger_PolicyPattern |                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='HiveCataloger_PolicyPattern')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger_PolicyPattern  |                                                                          | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger_PolicyPattern |                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='HiveCataloger_PolicyPattern')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer          |                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='HiveAnalyzer')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer          |                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='HiveAnalyzer')].status                |


     ###########Set the PIITags for Hive Table columns ,typePattern can be set as:VARCHAR or .*VAR.*minimumRatio:0.5, Match Empty=false, Match Full=false##############

  #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093
  @positve @regression @sanity  @PIITag
  Scenario:SC11#MLP_26807_Verify PIItags for Hive Table columns ,typePattern can be set as:VARCHAR or .*VAR.*minimumRatio:0.5, Match Empty=false, Match Full=false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | gender    | Hive_GenderPII_SC1Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ssn       | Hive_SSNPII_SC1Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ipaddress | Hive_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | full_name | Hive_FullNamePII_SC1Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | email     | Hive_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | email     | Hive_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ssn       | Hive_SSNPII_SC1Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ipaddress | Hive_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | email     | Hive_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | gender    | Hive_GenderPII_SC1Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | ipaddress | Hive_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | Hive_GenderPII_SC1Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | Hive_SSNPII_SC1Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | Hive_FullNamePII_SC1Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | gender    | Hive_GenderPII_SC1Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ssn       | Hive_SSNPII_SC1Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ipaddress | Hive_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | full_name | Hive_FullNamePII_SC1Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | email     | Hive_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |

  ########Set the PIITags for Hive Table columns , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5#########

#7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106
  @positve @regression @sanity  @PIITag
  Scenario:SC12#MLP_26807_Verify PIITags not set for Hive Table columns , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                     | Query                    | Action         |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | gender    | Hive_GenderPII_SC2Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ssn       | Hive_SSNPII_SC2Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ipaddress | Hive_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | full_name | Hive_FullNamePII_SC2Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | email     | Hive_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | email     | Hive_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ssn       | Hive_SSNPII_SC2Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ipaddress | Hive_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | email     | Hive_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | gender    | Hive_GenderPII_SC2Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | ipaddress | Hive_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | Hive_GenderPII_SC2Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | Hive_SSNPII_SC2Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | Hive_FullNamePII_SC2Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | gender    | Hive_GenderPII_SC2Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ssn       | Hive_SSNPII_SC2Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ipaddress | Hive_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | full_name | Hive_FullNamePII_SC2Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | email     | Hive_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |

###############PIITags for Hive Table columns , namePattern can be set as:.*FULL.*,ipaddress,gender,.*email.*,ssn, minimumRatio:0.5################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  @positve @regression @sanity  @PIITag
  Scenario:SC13#MLP_26807_Verify PIITags for Hive Table columns  , namePattern can be set as:.*FULL.*,.*IP.*,gender,.*email.*,ssn.*, minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | gender    | Hive_GenderPII_SC3Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ssn       | Hive_SSNPII_SC3Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ipaddress | Hive_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | full_name | Hive_FullNamePII_SC3Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | email     | Hive_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | email     | Hive_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ssn       | Hive_SSNPII_SC3Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ipaddress | Hive_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | email     | Hive_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | gender    | Hive_GenderPII_SC3Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | ipaddress | Hive_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | Hive_GenderPII_SC3Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | Hive_SSNPII_SC3Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | Hive_FullNamePII_SC3Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | gender    | Hive_GenderPII_SC3Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ssn       | Hive_SSNPII_SC3Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ipaddress | Hive_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | full_name | Hive_FullNamePII_SC3Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | email     | Hive_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |


###########PIITags for Hive Table columns , namePattern set as: .*F1ULL.*,IP1,1gender,.*EM1AIL.*,ssn11.*, minimumRatio:0.5###################

#7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106
  @positve @regression @sanity  @PIITag
  Scenario:SC14#MLP_26807_Verify PIItags not set for Hive Table columns , namePattern set as: .*F1ULL.*,IP1,1gender,.*EM1AIL.*,ssn11.*, minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                     | Query                    | Action         |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | gender    | Hive_GenderPII_SC4Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ssn       | Hive_SSNPII_SC4Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ipaddress | Hive_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | full_name | Hive_FullNamePII_SC4Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | email     | Hive_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | email     | Hive_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ssn       | Hive_SSNPII_SC4Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ipaddress | Hive_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | email     | Hive_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | gender    | Hive_GenderPII_SC4Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | ipaddress | Hive_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | Hive_GenderPII_SC4Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | Hive_SSNPII_SC4Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | Hive_FullNamePII_SC4Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | gender    | Hive_GenderPII_SC4Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ssn       | Hive_SSNPII_SC4Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ipaddress | Hive_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | full_name | Hive_FullNamePII_SC4Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | email     | Hive_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |


    #######Set the PIITags for Hive Table columns , valid name and type pattern minimumRatio:0.2#######################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC15#MLP_26807_Verify PIITags for Hive Table columns , valid name and type pattern minimumRatio:0.2
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                   | Column    | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | gender    | Hive_GenderPII_SC5Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | ssn       | Hive_SSNPII_SC5Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | ipaddress | Hive_IPAddressPII_SC5Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | full_name | Hive_FullNamePII_SC5Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | email     | Hive_EmailPII_SC5Tag     | ColumnQuerywithoutSchema | TagAssigned |

    ###########Set the PIItags for Hive Table columns , minimumRatio:0.6 matchfull false and matchempty true###############

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC16#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC6Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC6Tag     | ColumnQuerywithoutSchema | TagAssigned |

    #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC17#MLP_26807_Verify PIItags not set for Hive Table columns , minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column | Tags                  | Query                    | Action         |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | gender | Hive_GenderPII_SC6Tag | ColumnQuerywithoutSchema | TagNotAssigned |


      ###############Set the PIItags for Hive Table columns , minimumRatio:1 matchfull false and matchempty false#####################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC18#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:1 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename  | Column    | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch | gender    | Hive_GenderPII_SC8Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch | ssn       | Hive_SSNPII_SC8Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch | ipaddress | Hive_IPAddressPII_SC8Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch | full_name | Hive_FullNamePII_SC8Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch | email     | Hive_EmailPII_SC8Tag     | ColumnQuerywithoutSchema | TagAssigned |


     ###############Set the PIItags for Hive Table columns , minimumRatio:0.5 matchfull false and matchempty false#####################

  #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC19#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.5 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                  | Column    | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse | gender    | Hive_GenderPII_SC9Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse | ssn       | Hive_SSNPII_SC9Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse | ipaddress | Hive_IPAddressPII_SC9Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse | full_name | Hive_FullNamePII_SC9Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse | email     | Hive_EmailPII_SC9Tag     | ColumnQuerywithoutSchema | TagAssigned |


      ###############PIItags for Hive Table columns , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,ipaddress,gender,.*MAIL,.*ssn.*,#####################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC20#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,ipaddress,gender,.*MAIL,.*ssn.*
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                   | Column    | Tags                      | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | gender    | Hive_GenderPII_SC10Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | ssn       | Hive_SSNPII_SC10Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | ipaddress | Hive_IPAddressPII_SC10Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | full_name | Hive_FullNamePII_SC10Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse | email     | Hive_EmailPII_SC10Tag     | ColumnQuerywithoutSchema | TagAssigned |

  ######################PIITags for Hive Table columns , namePattern set as: FULL1.*,IPAD1DRESS,gender1,.*1MAIL,.*1ssn.*, minimumRatio:0.2################################

  #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  @positve @regression @sanity  @PIITag
  Scenario:SC21#MLP_26807_Verify PIITags not set for Hive Table columns , namePattern set as: FULL1.*,IPAD1DRESS,gender1,.*1MAIL,.*1ssn.*, minimumRatio:0.2
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                      | Query                    | Action         |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | gender    | Hive_GenderPII_SC11Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ssn       | Hive_SSNPII_SC11Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ipaddress | Hive_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | full_name | Hive_FullNamePII_SC11Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | email     | Hive_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | email     | Hive_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ssn       | Hive_SSNPII_SC11Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ipaddress | Hive_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | email     | Hive_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | gender    | Hive_GenderPII_SC11Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | ipaddress | Hive_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | Hive_GenderPII_SC11Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | Hive_SSNPII_SC11Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | Hive_FullNamePII_SC11Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | gender    | Hive_GenderPII_SC11Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ssn       | Hive_SSNPII_SC11Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ipaddress | Hive_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | full_name | Hive_FullNamePII_SC11Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | email     | Hive_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |



    ##############################PIItags for Hive Table columns , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false##################

  #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC22#MLP_26807_Verify PIITags not set for Hive Table columns , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                      | Query                    | Action         |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | gender    | Hive_GenderPII_SC12Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ssn       | Hive_SSNPII_SC12Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ipaddress | Hive_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | full_name | Hive_FullNamePII_SC12Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | email     | Hive_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | email     | Hive_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ssn       | Hive_SSNPII_SC12Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ipaddress | Hive_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | email     | Hive_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | gender    | Hive_GenderPII_SC12Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | ipaddress | Hive_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | Hive_GenderPII_SC12Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | Hive_SSNPII_SC12Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | Hive_FullNamePII_SC12Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | gender    | Hive_GenderPII_SC12Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ssn       | Hive_SSNPII_SC12Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ipaddress | Hive_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | full_name | Hive_FullNamePII_SC12Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | email     | Hive_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |

######################PIItags for Hive Table columns , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false##################

#7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC23#MLP_26807_Verify PIITags not set for Hive Table columns , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                      | Query                    | Action         |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | gender    | Hive_GenderPII_SC13Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ssn       | Hive_SSNPII_SC13Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | ipaddress | Hive_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | full_name | Hive_FullNamePII_SC13Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allmatch                         | email     | Hive_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | email     | Hive_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ssn       | Hive_SSNPII_SC13Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty                         | ipaddress | Hive_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | email     | Hive_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | gender    | Hive_GenderPII_SC13Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolessthan05emptyfalse        | ipaddress | Hive_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | Hive_GenderPII_SC13Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | Hive_SSNPII_SC13Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | Hive_FullNamePII_SC13Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | gender    | Hive_GenderPII_SC13Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ssn       | Hive_SSNPII_SC13Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | ipaddress | Hive_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | full_name | Hive_FullNamePII_SC13Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratioequalto05emptyfalse         | email     | Hive_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |



  #################PIItags for Hive Table columns , minimumRatio:0.5 matchfull false and matchempty true###########################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC24#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.5 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename  | Column    | Tags                      | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty | email     | Hive_EmailPII_SC14Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty | ssn       | Hive_SSNPII_SC14Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_allempty | ipaddress | Hive_IPAddressPII_SC14Tag | ColumnQuerywithoutSchema | TagAssigned |

   #################PIItags for Hive Table columns , minimumRatio:0.6 matchfull true and matchempty false###########################

  #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC25#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                         | Column   | Tags                     | Query                    | Action         |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05matchfulltrue | comments | Hive_FullMatchPII_SC1Tag | ColumnQuerywithoutSchema | TagNotAssigned |

#################PIItags for Hive Table columns , minimumRatio:0.2 matchfull true and matchempty false###########################

  #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC26#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                        | Column   | Tags                     | Query                    | Action         |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolesserthan05matchfulltrue | comments | Hive_FullMatchPII_SC3Tag | ColumnQuerywithoutSchema | TagNotAssigned |

#############################################################################################################################################################################################
 ##########################################################Re-Run Scenario PII tags#####################################################################################
 #######################################################################################################################################################


  Scenario Outline:Policy2:Create root tag and sub tag for Hive Analyzer and Update policy tags for Hive Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/hivePayloads/API/PolicyEngine/HIVE_policy2.json | 204           |                  |          |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC27#-MLP_26807_Verify Hive Analyzer set PII tags for the re-run scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | body | response code | response message | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger_PolicyPattern |      | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger_PolicyPattern')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger_PolicyPattern  |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger_PolicyPattern |      | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger_PolicyPattern')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer          |      | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer           |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HiveDataAnalyzer/HiveAnalyzer          |      | 200           | IDLE             | $.[?(@.configurationName=='HiveAnalyzer')].status                |


#     #################PIItags for Hive Table columns , minimumRatio:0.6 matchfull true and matchempty false###########################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC28#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                         | Column   | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05matchfulltrue | comments | Hive_FullMatchPII_SC2Tag | ColumnQuerywithoutSchema | TagAssigned |

#################PIItags for Hive Table columns , minimumRatio:0.2 matchfull true and matchempty false###########################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC29#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                        | Column   | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiolesserthan05matchfulltrue | comments | Hive_FullMatchPII_SC4Tag | ColumnQuerywithoutSchema | TagAssigned |


    ###############Set the PIItags for Hive Table columns , minimumRatio:0.6 matchfull true and matchempty true#####################

  #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC30#MLP_26807_Verify PIItags for Hive Table columns , minimumRatio:0.6 matchfull true and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName        | TableName/Filename                          | Column    | Tags                     | Query                    | Action      |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | Hive_IPAddressPII_SC7Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Cluster Demo | HIVE        | hivepolicypatterndb | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | Hive_EmailPII_SC7Tag     | ColumnQuerywithoutSchema | TagAssigned |

  Scenario: Deleting the created database/table in hive view
    And user executes the following Query in the Hive JDBC
      | queryEntry                                |
      | DropTableALLMATCH                         |
      | DropTableALLEMPTY                         |
      | DropTableRatiolessthan05EmptyFalse        |
      | DropTableRatiogreaterthan05EmptyFalseTrue |
      | DropTableRatioEqualTo05EmptyFalse         |
      | DropTableRatiogreaterthan05MatchFullTrue  |
      | DropTableRatiolesserthan05MatchFullTrue   |
      | Drophiveepolicypatterndb                  |

  Scenario Outline:Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveValidCredential                                              |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveInValidCredential                                            |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveEmptyCredential                                              |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveDataSource                                                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger                                                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveDataAnalyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=HiveDataAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/HIVE_PII                                                           |      | 204           |                  |          |




