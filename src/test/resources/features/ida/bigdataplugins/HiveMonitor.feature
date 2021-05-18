Feature:MLP-26715: Testing Hive Hook and Hive monitor



  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                     | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HiveMonitor/HiveMonitor%            | Analysis |       |       |
      | MultipleIDDelete | Default | linker/HiveLinker/HiveLinker%               | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |


  @positve @regression @sanity @MLP-26715 @IDA-1.1.0
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

  @ambari @positve @hdfs @regression @sanity
  Scenario: verify the message.log is cleared.
    Given user connects to the sftp server and runs spark commands
      | command         | RemoteMachinePath | Filename     |
      | ClearFileinUnix | /home/log         | messages.log |


  Scenario Outline:Create Plugin configurations for HiveCataloger and HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                              | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger | ida/hivePayloads/PluginConfiguration/HiveConfigForHiveMonitor.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger |                                                                    | 200           | HiveCataloger    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveMonitor   | ida/hivePayloads/PluginConfiguration/HiveMonitorConfiguration.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveMonitor   |                                                                    | 200           | HiveMonitor      |          |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Verify whether the Hive database is created in Hive and log entry present.
    Given user executes the following Query in the Hive JDBC
      | queryEntry                |
      | CreateHiveMonitorDatabase |
    And sync the test execution for "100" seconds
    And user connects to the SFTP server and downloads the "messages.log"
    Then user validates the entries in "message.log"
      | logEntry                       |
      | HiveMonitorDatabaseFilterEntry |
      | HiveMonitorScanKickOff         |
      | HiveMonitortoScannerMessage    |
      | HiveMonitorClearEvent          |



#7142554
  @webtest @MLP-26715 @sanity @positive @regression
  Scenario:SC1#:Verify whether Hive monitor triggers Hive Cataloger(Filter criteria is met) when new Database is created in Ambari .
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | hivemonitordb |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Verify whether the Hive tables are created in Hive and log entry present.
    Given user executes the following Query in the Hive JDBC
      | queryEntry              |
      | CreateHiveMonitorTable1 |
      | CreateHiveMonitorTable2 |
    And sync the test execution for "30" seconds


      #7142554
  @webtest @MLP-26715 @sanity @positive @regression
  Scenario:SC2#:Verify whether Hive monitor triggers Hive Cataloger(Filter criteria is met) when new tables are add created in Ambari
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable1 |
      | monitortable2 |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 1:Verify whether the additional Hive tables are created in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry              |
      | CreateHiveMonitorTable3 |
      | CreateHiveMonitorTable4 |
    And sync the test execution for "30" seconds


    #7142554
  @webtest @MLP-26715 @sanity @positive @regression
  Scenario:SC3#:Verify whether Hive monitor triggers Hive Cataloger(Filter criteria is met) when create table as select is done in Ambari .
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable1 |
      | monitortable2 |
      | monitortable3 |
      | monitortable4 |

  Scenario Outline:Create multiple Plugin configurations for HiveCataloger and single HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger/HiveCataloger  |                                                                     | 200           | HiveCataloger    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger/HiveCataloger1 | ida/hivePayloads/PluginConfiguration/HiveConfigForHiveMonitor1.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger/HiveCataloger1 |                                                                     | 200           | HiveCataloger1   |          |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 2:Verify whether the additional Hive tables in different dbs are created in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry              |
      | CreateHiveMonitorTable5 |
      | CreateHiveMonitorTable6 |
    And sync the test execution for "30" seconds

#7142554
  @webtest @MLP-26715 @sanity @positive @regression
  Scenario:SC4#:verify Hive monitor trigger only the appropriate cataloger when Multiple Hive catalogers are configured with Hive monitor pointing to Hivecataloger with valid filter config (Hive ambari - changes should be done in the same filter items).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable1 |
      | monitortable2 |
      | monitortable3 |
      | monitortable4 |
      | monitortable5 |
    And user enters the search text "HiveCatalogerTag2" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Database |
      | Table    |
      | Column   |
      | Analysis |


  Scenario Outline:Delete Plugin configurations for HiveCataloger and HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger/HiveCataloger  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger/HiveCataloger1 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveMonitor/HiveMonitor      |      | 204           |                  |          |

  Scenario Outline:ReCreate Plugin configurations for HiveCataloger and HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                              | body                                                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger | ida/hivePayloads/PluginConfiguration/HiveConfigForHiveMonitor2.json                      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger |                                                                                          | 200           | HiveCataloger2   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveMonitor   | ida/hivePayloads/PluginConfiguration/HiveMonitorConfigurationInvalidFilterCataloger.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveMonitor   |                                                                                          | 200           | HiveMonitor1     |          |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 3:Verify whether the additional Hive tables in different dbs are created in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry              |
      | CreateHiveMonitorTable7 |
    And sync the test execution for "30" seconds


    #7142554
  @webtest @MLP-26715 @sanity @positive @regression
  Scenario:SC5#:verify Hive monitor doesn't trigger Hive cataloger when a Hive monitor pointing to Hivecataloger with Not-Matching filter config (Hive Ambari - modifications should be done on non filter items).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable1 |
      | monitortable2 |
      | monitortable3 |
      | monitortable4 |
      | monitortable5 |
    And user enters the search text "HiveCatalogerTag3" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Database |
      | Table    |
      | Column   |
      | Analysis |


  Scenario Outline:Delete 2: Delete Plugin configurations for HiveCataloger and HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger/HiveCataloger2 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveMonitor/HiveMonitor1     |      | 204           |                  |          |


  Scenario Outline:Create 4: Create multiple Plugin configurations for HiveCataloger and multiple HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger/HiveCataloger3 | ida/hivePayloads/PluginConfiguration/HiveConfigForHiveMonitor3.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger/HiveCataloger3 |                                                                     | 200           | HiveCataloger3   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger/HiveCataloger4 | ida/hivePayloads/PluginConfiguration/HiveConfigForHiveMonitor4.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger/HiveCataloger4 |                                                                     | 200           | HiveCataloger4   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveMonitor/HiveMonitor2     | ida/hivePayloads/PluginConfiguration/HiveMonitorConfiguration1.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveMonitor/HiveMonitor2     |                                                                     | 200           | HiveMonitor2     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveMonitor/HiveMonitor3     | ida/hivePayloads/PluginConfiguration/HiveMonitorConfiguration2.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveMonitor/HiveMonitor3     |                                                                     | 200           | HiveMonitor3     |          |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 4:Verify whether the additional Hive tables in different dbs are created in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry              |
      | CreateHiveMonitorTable8 |
    And sync the test execution for "30" seconds


    #7142554 This scenario will fail and there is an enhancemnent story for it.
  @webtest @MLP-26715 @sanity @positive @regression
  Scenario:SC6#:Verify whether multiple Hive Catalogers(Multiple catalogers - Filters Matching) are triggered when Multiple Hive monitors is configured and pointing to multiple catalogers.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable1 |
      | monitortable2 |
      | monitortable3 |
      | monitortable4 |
      | monitortable5 |
    And user enters the search text "HiveCatalogerTag4" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable8 |


  Scenario Outline:Delete 3: Delete Plugin configurations for HiveCataloger and HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger/HiveCataloger3 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger/HiveCataloger4 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveMonitor/HiveMonitor2     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveMonitor/HiveMonitor3     |      | 204           |                  |          |

  Scenario Outline:Create 5: Create multiple Plugin configurations for HiveCataloger and multiple HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger/HiveCataloger5 | ida/hivePayloads/PluginConfiguration/HiveConfigForHiveMonitor5.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger/HiveCataloger5 |                                                                     | 200           | HiveCataloger5   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger/HiveCataloger6 | ida/hivePayloads/PluginConfiguration/HiveConfigForHiveMonitor6.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger/HiveCataloger6 |                                                                     | 200           | HiveCataloger6   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveMonitor/HiveMonitor3     | ida/hivePayloads/PluginConfiguration/HiveMonitorConfiguration3.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveMonitor/HiveMonitor3     |                                                                     | 200           | HiveMonitor3     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveMonitor/HiveMonitor4     | ida/hivePayloads/PluginConfiguration/HiveMonitorConfiguration4.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveMonitor/HiveMonitor4     |                                                                     | 200           | HiveMonitor4     |          |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 5:Verify whether the additional Hive tables in different dbs are created in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry              |
      | CreateHiveMonitorTable9 |
    And sync the test execution for "30" seconds


    #7142554 This scenario will fail and there is an enhancemnent story for it.
  @webtest @MLP-26715 @sanity @positive @regression
  Scenario:SC7#:Verify whether valid Hive Cataloger is triggered when Multiple Hive monitors are configured and pointing to multiple catalogers(only one valid cataloger Filter Matching).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable1 |
      | monitortable2 |
      | monitortable3 |
      | monitortable4 |
      | monitortable5 |
    And user enters the search text "HiveCatalogerTag4" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable8 |
    And user enters the search text "HiveCatalogerTag5" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | monitortable9 |
    And user enters the search text "HiveCatalogerTag6" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Database |
      | Table    |
      | Column   |
      | Analysis |


  Scenario Outline:Stop the Hive Monitors.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | extensions/analyzers/stop/Cluster%20Demo/monitor/HiveMonitor/HiveMonitor3 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | extensions/analyzers/stop/Cluster%20Demo/monitor/HiveMonitor/HiveMonitor4 |      | 204           |                  |          |




    #7154116
  @sanity @positive @MLP-26715 @webtest @IDA-1.1.0
  Scenario:SC8#Verify log enhancements check for HiveMonitor plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveMonitor3" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "monitor/HiveMonitor/HiveMonitor3%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "monitor/HiveMonitor/HiveMonitor3%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | logCode       | pluginName  | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0019 |             |                |
      | INFO | Plugin Name:HiveMonitor, Plugin Type:monitor, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:HiveMonitor3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0071 | HiveMonitor | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin HiveMonitor Configuration: ---  2020-10-03 21:12:16.759 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: name: "HiveMonitor3"  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: pluginVersion: "LATEST"  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: label:  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: : ""  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: catalogName: "Default"  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: autoStart: true  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: eventClass: null  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: eventCondition: null  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: maxWorkSize: 100  2020-10-03 21:12:16.760 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: tags: []  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: pluginType: "monitor"  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: dataSource: null  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: credential: null  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: businessApplicationName: null  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: dryRun: false  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: schedule: null  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: filter: null  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: catalogerConfigurationName: "HiveCataloger5"  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: pluginName: "HiveMonitor"  2020-10-03 21:12:16.761 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: enableQueryParser: false  2020-10-03 21:12:16.762 INFO  - ANALYSIS-0073: Plugin HiveMonitor Configuration: type: "monitor" | ANALYSIS-0073 | HiveMonitor |                |
      | INFO | Plugin HiveMonitor Start Time:2020-08-29 17:59:03.596, End Time:2020-08-29 18:28:30.122, Processed Count:0, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0072 | HiveMonitor |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0020 |             |                |



  #7154118
  @MLP-26715 @webtest @positive @regression @sanity
  Scenario: SC9#Verify proper error message is shown if mandatory fields are not filled in HiveMonitor configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute   |
      | Type      | Monitor     |
      | Plugin    | HiveMonitor |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


    #7132255
  @positve @regression @sanity  @MLP-26715 @IDA-1.1.0
  Scenario Outline: Get the Hive monitor Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                    | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/hive/body/ToolTip_Monitor.json | 200           |                  | response/hive/actual/ToolTip_Monitor.json |          |


    #7154117
  @positve @regression @sanity  @MLP-24873 @IDA-1.1.0
  Scenario Outline:SC10# Validate ToolTip for all the fields in Hive Analyzer plugin.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                      | actualValues                              | valueType     | expectedJsonPath                                  | actualJsonPath                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip      | $..[?(@.label=='Type')].tooltip                        |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.pluginName.tooltip                 | $.properties[0].value.prototype.properties[1].tooltip  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.PluginConfigName.tooltip           | $.properties[0].value.prototype.properties[2].tooltip  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.pluginVersion.tooltip              | $.properties[0].value.prototype.properties[3].tooltip  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.label.tooltip                      | $.properties[0].value.prototype.properties[4].tooltip  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.businessApplicationName.tooltip    | $.properties[0].value.prototype.properties[15].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.EnableHivequeryparser.tooltip      | $.properties[0].value.prototype.properties[17].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.Catalogerconfigurationname.tooltip | $.properties[0].value.prototype.properties[16].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.eventCondition.tooltip             | $.properties[0].value.prototype.properties[5].tooltip  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.dryRun.tooltip                     | $.properties[0].value.prototype.properties[6].tooltip  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.eventClass.tooltip                 | $.properties[0].value.prototype.properties[7].tooltip  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.maxWorkSize.tooltip                | $.properties[0].value.prototype.properties[8].tooltip  |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.nodeCondition.tooltip              | $.properties[0].value.prototype.properties[10].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.autoStart.tooltip                  | $.properties[0].value.prototype.properties[11].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Monitor.json | stringCompare | $.Commonfields.tags.tooltip                       | $.properties[0].value.prototype.properties[12].tooltip |


  Scenario Outline:Delete 4: Delete Plugin configurations for HiveCataloger and HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveMonitor   |      | 204           |                  |          |


  Scenario Outline:Create 6:Plugin configurations for HiveCataloger and HiveMonitor.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                 | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger    | ida/hivePayloads/PluginConfiguration/HiveConfigForHiveMonitor.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger    |                                                                    | 200           | HiveCataloger    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveMonitor      | ida/hivePayloads/PluginConfiguration/HiveMonitorConfiguration.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveMonitor      |                                                                    | 200           | HiveMonitor      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveDataAnalyzer | ida/hivePayloads/PluginConfiguration/HiveAnalyzerConfig.json       | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveDataAnalyzer |                                                                    | 200           | HiveAnalyzer     |          |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 6:Verify whether the additional Hive tables in different dbs are created in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry                   |
      | CreateHiveMonitorTable11     |
      | InsertHiveMonitorTable11Row1 |
      | InsertHiveMonitorTable11Row2 |
      | InsertHiveMonitorTable11Row3 |
      | InsertHiveMonitorTable11Row4 |
      | InsertHiveMonitorTable11Row5 |
    And sync the test execution for "40" seconds


  @positve @regression @sanity @webtest
  Scenario:SC11#Verify an end to end flow of Hive Monitor triggering HiveCataloger and HiveCataloger triggering analyzer when automatic analysis is enabled.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "HiveAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "HiveAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "HiveAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "HiveAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "inttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |


  Scenario: Deleting the created database/table in hive view
    And user executes the following Query in the Hive JDBC
      | queryEntry             |
      | dropHiveMonitorTable11 |
      | dropHiveMonitorTable09 |
      | dropHiveMonitorTable08 |
      | dropHiveMonitorTable07 |
      | dropHiveMonitorTable06 |
      | dropHiveMonitorTable05 |
      | dropHiveMonitorTable04 |
      | dropHiveMonitorTable03 |
      | dropHiveMonitorTable02 |
      | dropHiveMonitorTable01 |
      | dropHiveMonitorDB      |


  Scenario Outline:Delete Plugin Configuration and credentials.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveValidCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveInValidCredential |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveEmptyCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveDataSource          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveDataAnalyzer        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveMonitor             |      | 204           |                  |          |
