@MLP-24274 @MLP-2116
Feature:MLP-2116: Conversion/migration of BigData QueryParser as IDA Plugin
  MLP-24274 Implement db reboot changes for Hive Query Parser
  Description: using MonitorHive, get Hive query logs. We’ll need to adapt MonitorHive to configure if we’re interested into DML queries on top of DDL, and then it will need to write the event maybe in a different format. Then the monitor processor can send these events to a different class that will be do the query processing and do whatever we want with them. Which is of course another question, we’ll need to see what we want to do with these queries: write statistics or lineage information into IDC, store these queries in a big data file for batch processing…


  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                     | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HiveMonitor/HiveMonitor%            | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | parser/HiveQueryParser/HiveQueryParser%     | Analysis |       |       |
      | MultipleIDDelete | Default | parser/HiveQueryParser/HiveMonitor%         | Analysis |       |       |


  @positve @regression @sanity @MLP-24274 @IDA-1.1.0
  Scenario Outline: Set the Credentials, Datasource, Bussiness Application and Cataloger for Hive Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                            | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveValidCredential   | ida/queryParser/Credentials/hiveValidCredentials.json           | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveInValidCredential | ida/queryParser/Credentials/hiveInValidCredentials.json         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveEmptyCredential   | ida/queryParser/Credentials/hiveEmptyCredentials.json           | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveValidCredential   |                                                                 | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveInValidCredential |                                                                 | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveEmptyCredential   |                                                                 | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\queryParser\Bussiness_Application\BussinessApplication.json | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HiveDataSource          | ida/queryParser/DataSource/hiveValidDataSourceConfig.json       | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HiveDataSource          |                                                                 | 200           | HiveDataSource_Valid |          |


  Scenario Outline:Create Plugin configurations for HiveCataloger, HiveMonitor and HiveQueryParser disabled.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                        | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                  | ida/queryParser/PluginConfiguration/HiveConfigForHiveMonitor.json           | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                  |                                                                             | 200           | HiveCataloger    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveQueryParser                                                | ida/queryParser/PluginConfiguration/HiveQueryParserConfiguration.json       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveQueryParser                                                |                                                                             | 200           | HiveQueryParser  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveMonitor                                                    | ida/queryParser/PluginConfiguration/HiveMonitorConfigurationQPDisabled.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveMonitor                                                    |                                                                             | 200           | HiveMonitor      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/monitor/HiveMonitor/HiveMonitor         |                                                                             | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/parser/HiveQueryParser/HiveQueryParser |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='HiveQueryParser')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/monitor/HiveMonitor/HiveMonitor        |                                                                             | 200           | RUNNING          | $.[?(@.configurationName=='HiveMonitor')].status     |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Verify whether the Hive database is created in Hive and log entry present.
    Given user executes the following Query in the Hive JDBC
      | queryEntry  |
      | QPCreateDB1 |
    And sync the test execution for "30" seconds


    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC1#:Verify HiveQueryParser does not get triggered and operations/executions are not collected when HiveQueryParser is disabled in HiveMonitor configuration.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | hivequeryparserdb |
    And user enters the search text "HiveCatalogerTag1" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Table     |
      | Column    |
      | Operation |
      | Execution |


  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                     | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/HiveCataloger%      | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HiveMonitor/HiveMonitor%            | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HiveDataAnalyzer/HiveAnalyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | parser/HiveQueryParser/HiveQueryParser%     | Analysis |       |       |
      | MultipleIDDelete | Default | parser/HiveQueryParser/HiveMonitor%         | Analysis |       |       |


  Scenario Outline:Create 1: Create Plugin configurations for HiveCataloger, HiveMonitor and HiveQueryParser enabled.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                  | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                  | ida/queryParser/PluginConfiguration/HiveConfigForHiveMonitor.json     | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                  |                                                                       | 200           | HiveCataloger    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveMonitor                                                    | ida/queryParser/PluginConfiguration/HiveMonitorConfiguration.json     | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveMonitor                                                    |                                                                       | 200           | HiveMonitor      |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveQueryParser                                                | ida/queryParser/PluginConfiguration/HiveQueryParserConfiguration.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveQueryParser                                                |                                                                       | 200           | HiveQueryParser  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/parser/HiveQueryParser/HiveQueryParser |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='HiveQueryParser')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/monitor/HiveMonitor/HiveMonitor        |                                                                       | 200           | RUNNING          | $.[?(@.configurationName=='HiveMonitor')].status     |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 1:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry  |
      | QPDropDB    |
      | QPCreateDB1 |
    And sync the test execution for "40" seconds

    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC2#:Verify HiveQueryParser creates operation/execution/sql source for dropdb,createdb.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | createdatabasehivequeryparserdb |
      | dropdatabasehivequeryparserdb   |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "createdatabasehivequeryparserdb" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                           | Action               | RetainPrevwindow | indexSwitch |
      | Data  | createdatabasehivequeryparserdb | click and switch tab | No               |             |
    Then sync the test execution for "5" seconds
    Then the "Data" metadata of item "createdatabasehivequeryparserdb" should be as expected
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "dropdatabasehivequeryparserdb" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                         | Action               | RetainPrevwindow | indexSwitch |
      | Data  | dropdatabasehivequeryparserdb | click and switch tab | No               |             |
    Then sync the test execution for "5" seconds
    Then the "Data" metadata of item "dropdatabasehivequeryparserdb" should be as expected


    #7154116
  @sanity @positive @webtest
  Scenario: SC3# Verify the technology tags got assigned to all HiveQueryParsed items.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "HiveQueryParserTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Hive,HiveQueryParserTag1,HiveQueryParser_BA" should get displayed for the column "parser/HiveQueryParser"
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "HiveQueryParserTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Hive,HiveQueryParserTag1,HiveQueryParser_BA" should get displayed for the column "anonymous@"
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "HiveQueryParserTag1" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                                                   | fileName                        | userTag             |
      | Default     | Cluster   | Metadata Type | Hive,HiveQueryParserTag1,HiveQueryParser_BA,Hive_BA,HiveCatalogerTag1 | Cluster Demo                    | HiveQueryParserTag1 |
      | Default     | Database  | Metadata Type | Hive,HiveQueryParserTag1,HiveQueryParser_BA,Hive_BA,HiveCatalogerTag1 | hivequeryparserdb               | HiveQueryParserTag1 |
      | Default     | Operation | Metadata Type | Hive,HiveQueryParserTag1,HiveQueryParser_BA                           | createdatabasehivequeryparserdb | HiveQueryParserTag1 |

#7142563#
  @sanity @positive @MLP-24873 @webtest @IDA-1.1.0
  Scenario:SC4#Verify log entries/log enhancements(processed Items widget and Processed count) check for HiveQueryParser plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "HiveQueryParserTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "parser/HiveQueryParser/HiveQueryParser%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Cluster Demo |
      | HIVE         |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "parser/HiveQueryParser/HiveQueryParser%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:HiveQueryParser, Plugin Type:parser, Plugin Version:1.1.0.RC1-SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:HiveQueryParser                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0071 | HiveQueryParser   | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin HiveQueryParser Configuration: ---  2020-10-01 15:20:17.762 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: name: "HiveQueryParser"  2020-10-01 15:20:17.762 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: pluginVersion: "LATEST"  2020-10-01 15:20:17.762 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: label:  2020-10-01 15:20:17.762 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: : ""  2020-10-01 15:20:17.763 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: catalogName: "Default"  2020-10-01 15:20:17.763 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: eventClass: null  2020-10-01 15:20:17.763 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: eventCondition: null  2020-10-01 15:20:17.763 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-10-01 15:20:17.763 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: maxWorkSize: 100  2020-10-01 15:20:17.763 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: tags:  2020-10-01 15:20:17.763 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: - "HiveQueryParserTag1"  2020-10-01 15:20:17.764 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: pluginType: "parser"  2020-10-01 15:20:17.764 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: dataSource: null  2020-10-01 15:20:17.764 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: credential: null  2020-10-01 15:20:17.764 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: businessApplicationName: "HiveQueryParser_BA"  2020-10-01 15:20:17.764 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: dryRun: false  2020-10-01 15:20:17.764 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: schedule: null  2020-10-01 15:20:17.764 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: filter: null  2020-10-01 15:20:17.765 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: pluginName: "HiveQueryParser"  2020-10-01 15:20:17.765 INFO  - ANALYSIS-0073: Plugin HiveQueryParser Configuration: type: "Parser" | ANALYSIS-0073 | HiveQueryParser |                |
      | INFO | Plugin HiveQueryParser Start Time:2020-08-31 22:26:04.174, End Time:2020-08-31 22:26:04.542, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0072 | HiveQueryParser |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0020 |                 |                |

  @sanity @positive @regression
  Scenario:Delete 1: Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type    | query | param |
      | SingleItemDelete | Default | Sandbox      | Cluster |       |       |
      | SingleItemDelete | Default | Cluster Demo | Cluster |       |       |

  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 2:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry     |
      | QPCreateTable2 |
      | QPCreateTable1 |
      | QueryLog_Q1    |
    And sync the test execution for "40" seconds
    

    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC5#:Verify HiveQueryParser creates operation/execution/sql source for create,create table as select,select.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | select*fromhivequeryparserdb.customers                                                                             |
      | createtablehivequeryparserdb.customers1asselect*fromhivequeryparserdb.customers                                    |
      | createtablehivequeryparserdb.customers(customer_idint,product_idint,product_namevarchar(60),brand_namevarchar(60)) |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "createtablehivequeryparserdb.customers(customer_idint,product_idint,product_namevarchar(60),brand_namevarchar(60))" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                                                                                                              | Action               | RetainPrevwindow | indexSwitch |
      | Data  | createtablehivequeryparserdb.customers(customer_idint,product_idint,product_namevarchar(60),brand_namevarchar(60)) | click and switch tab | No               |             |
    Then sync the test execution for "5" seconds
    Then the "Data" metadata of item "createtablehivequeryparserdb.customers(customer_idint,product_idint,product_namevarchar(60),brand_namevarchar(60))" should be as expected
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Execution | 3     |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "select*fromhivequeryparserdb.customers" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                                  | Action               | RetainPrevwindow | indexSwitch |
      | Data  | select*fromhivequeryparserdb.customers | click and switch tab | No               |             |
    Then sync the test execution for "5" seconds
    Then the "Data" metadata of item "select*fromhivequeryparserdb.customers" should be as expected
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "createtablehivequeryparserdb.customers1asselect*fromhivequeryparserdb.customers" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                                                                           | Action               | RetainPrevwindow | indexSwitch |
      | Data  | createtablehivequeryparserdb.customers1asselect*fromhivequeryparserdb.customers | click and switch tab | No               |             |
    Then sync the test execution for "5" seconds
    Then the "Data" metadata of item "createtablehivequeryparserdb.customers1asselect*fromhivequeryparserdb.customers" should be as expected

    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario Outline:SC6#:Verify lineage got generated between two tables when create table as select from another table query operation is done.
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name      | asg_scopeid | targetFile                                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | customers |             | response/Lineage/HiveQueryParser/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                    | bodyFile                                          | path                        | response code | response message | jsonPath | targetFile                                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=CONTROL&excludeUnusedViewColumns=false | response\Lineage\HiveQueryParser\bulkLineage.json | $.lineagePayLoads.customers | 200           |                  | edges    | response\Lineage\HiveQueryParser\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                  | JsonPath  |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | customers |
    And user sort the json file using the following value
      | fileName                                                                  | JsonPath  | value  |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | customers | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "createtablehivequeryparserdb.customers1asselect*fromhivequeryparserdb.customers" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value        | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | brand_name   | verify widget contains | No               |             |
      | uses  | customer_id  | verify widget contains | No               |             |
      | uses  | product_id   | verify widget contains | No               |             |
      | uses  | product_name | verify widget contains | No               |             |
      | uses  | brand_name   | verify widget contains | No               |             |
      | uses  | customer_id  | verify widget contains | No               |             |
      | uses  | product_id   | verify widget contains | No               |             |
      | uses  | product_name | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                     | actual_json                                                               | item      |
      | Constant.REST_DIR/response/HiveQueryParser/expected/hivequeryparserexpected1.json | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | customers |

  @sanity @positive @regression
  Scenario:Delete 2: Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type    | query | param |
      | SingleItemDelete | Default | Sandbox      | Cluster |       |       |
      | SingleItemDelete | Default | Cluster Demo | Cluster |       |       |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 3:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry    |
      | QueryLog_Q4   |
      | QueryLog_Q4_1 |
      | QueryLog_Q4_2 |
      | QueryLog_Q4_3 |
    And sync the test execution for "40" seconds



    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC7#:Verify HiveQueryParser creates operation/execution/sql source for create,insert select.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | createtablehivequeryparserdb.productstore(store_idint,product_idint,product_namestring,store_namestring) |
      | createtablehivequeryparserdb.productasselect*fromfoodmart.product                                        |
      | createtablehivequeryparserdb.storeasselect*fromfoodmart.store                                            |
      | insertintohivequeryparserdb.productstore(store_id,product_id,pro_D73989246CD4FDDA17E37902E5E4983         |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Execution | 4     |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insertintohivequeryparserdb.productstore(store_id,product_id,pro_D73989246CD4FDDA17E37902E5E4983" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                                                                                            | Action               | RetainPrevwindow | indexSwitch |
      | Data  | insertintohivequeryparserdb.productstore(store_id,product_id,pro_D73989246CD4FDDA17E37902E5E4983 | click and switch tab | No               |             |
    Then sync the test execution for "5" seconds
    Then the "Data" metadata of item "insertintohivequeryparserdb.productstore(store_id,product_id,pro_D73989246CD4FDDA17E37902E5E4983" should be as expected


    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario Outline:SC8#:Verify lineage got generated between two tables when insert select from another table query operation is done.
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name         | asg_scopeid | targetFile                                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | productstore |             | response/Lineage/HiveQueryParser/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                      | bodyFile                                          | path                           | response code | response message | jsonPath | targetFile                                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&exclude=CONTROL&excludeUnusedViewColumns=false | response\Lineage\HiveQueryParser\bulkLineage.json | $.lineagePayLoads.productstore | 200           |                  | edges    | response\Lineage\HiveQueryParser\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                  | JsonPath     |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | productstore |
    And user sort the json file using the following value
      | fileName                                                                  | JsonPath     | value  |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | productstore | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insertintohivequeryparserdb.productstore(store_id,product_id,pro_D73989246CD4FDDA17E37902E5E4983" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value        | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | product_id   | verify widget contains | No               |             |
      | uses  | product_id   | verify widget contains | No               |             |
      | uses  | product_name | verify widget contains | No               |             |
      | uses  | product_name | verify widget contains | No               |             |
      | uses  | store_id     | verify widget contains | No               |             |
      | uses  | store_id     | verify widget contains | No               |             |
      | uses  | store_name   | verify widget contains | No               |             |
      | uses  | store_name   | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                     | actual_json                                                               | item         |
      | Constant.REST_DIR/response/HiveQueryParser/expected/hivequeryparserexpected2.json | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | productstore |

  @sanity @positive @regression
  Scenario:Delete 3:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type    | query | param |
      | SingleItemDelete | Default | Sandbox      | Cluster |       |       |
      | SingleItemDelete | Default | Cluster Demo | Cluster |       |       |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 4:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry  |
      | QueryLog_Q3 |
    And sync the test execution for "40" seconds


    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC9#:Verify HiveQueryParser creates operation/execution and lineage for create external table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | createexternaltableifnotexistshivequeryparserdb.city(idstring,na_7CADA5C483F4D8CACFED042984FE6 |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Execution | 1     |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "createexternaltableifnotexistshivequeryparserdb.city(idstring,na_7CADA5C483F4D8CACFED042984FE6" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                                                                                          | Action               | RetainPrevwindow | indexSwitch |
      | Data  | createexternaltableifnotexistshivequeryparserdb.city(idstring,na_7CADA5C483F4D8CACFED042984FE6 | click and switch tab | No               |             |
    Then sync the test execution for "5" seconds
    Then the "Data" metadata of item "createexternaltableifnotexistshivequeryparserdb.city(idstring,na_7CADA5C483F4D8CACFED042984FE6" should be as expected


    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario Outline:SC10#:Verify lineage got generated for create external table query.
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name | asg_scopeid | targetFile                                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city |             | response/Lineage/HiveQueryParser/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                      | bodyFile                                          | path                   | response code | response message | jsonPath | targetFile                                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&exclude=CONTROL&excludeUnusedViewColumns=false | response\Lineage\HiveQueryParser\bulkLineage.json | $.lineagePayLoads.city | 200           |                  | edges    | response\Lineage\HiveQueryParser\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | city     |
    And user sort the json file using the following value
      | fileName                                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | city     | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "createexternaltableifnotexistshivequeryparserdb.city(idstring,na_7CADA5C483F4D8CACFED042984FE6" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | city  | verify widget contains | No               |             |
      | uses  | csv   | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                     | actual_json                                                               | item |
      | Constant.REST_DIR/response/HiveQueryParser/expected/hivequeryparserexpected3.json | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | city |


  @sanity @positive @regression
  Scenario:Delete 4:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type    | query | param |
      | SingleItemDelete | Default | Sandbox      | Cluster |       |       |
      | SingleItemDelete | Default | Cluster Demo | Cluster |       |       |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 5:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry    |
      | QueryLog_Q2   |
      | QueryLog_Q6   |
      | QueryLog_Q6_1 |
    And sync the test execution for "40" seconds


        #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC11#:Verify HiveQueryParser creates operation/execution/sql source for insert overwrite table
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | insertoverwritetablehivequeryparserdb.cust_shop_listselect*fromhivequeryparserdb.customer_shopping_list                         |
      | createtablehivequeryparserdb.cust_shop_listasselect*fromhivequeryparserdb.customer_shopping_list                                |
      | createtablehivequeryparserdb.customer_shopping_list(customer_idint,product_idint,product_namevarchar(60),brand_namevarchar(60)) |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Execution | 3     |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insertoverwritetablehivequeryparserdb.cust_shop_listselect*fromhivequeryparserdb.customer_shopping_list" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                                                                                                   | Action               | RetainPrevwindow | indexSwitch |
      | Data  | insertoverwritetablehivequeryparserdb.cust_shop_listselect*fromhivequeryparserdb.customer_shopping_list | click and switch tab | No               |             |
    Then sync the test execution for "5" seconds
    Then the "Data" metadata of item "insertoverwritetablehivequeryparserdb.cust_shop_listselect*fromhivequeryparserdb.customer_shopping_list" should be as expected


#7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario Outline:SC12#:Verify lineage got generated between two tables when insert overwrite table query operation is done.
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name           | asg_scopeid | targetFile                                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | cust_shop_list |             | response/Lineage/HiveQueryParser/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                      | bodyFile                                          | path                             | response code | response message | jsonPath | targetFile                                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&exclude=CONTROL&excludeUnusedViewColumns=false | response\Lineage\HiveQueryParser\bulkLineage.json | $.lineagePayLoads.cust_shop_list | 200           |                  | edges    | response\Lineage\HiveQueryParser\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                  | JsonPath       |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | cust_shop_list |
    And user sort the json file using the following value
      | fileName                                                                  | JsonPath       | value  |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | cust_shop_list | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insertoverwritetablehivequeryparserdb.cust_shop_listselect*fromhivequeryparserdb.customer_shopping_list" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value        | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | customer_id  | verify widget contains | No               |             |
      | uses  | customer_id  | verify widget contains | No               |             |
      | uses  | brand_name   | verify widget contains | No               |             |
      | uses  | brand_name   | verify widget contains | No               |             |
      | uses  | product_id   | verify widget contains | No               |             |
      | uses  | product_id   | verify widget contains | No               |             |
      | uses  | product_name | verify widget contains | No               |             |
      | uses  | product_name | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                     | actual_json                                                               | item           |
      | Constant.REST_DIR/response/HiveQueryParser/expected/hivequeryparserexpected4.json | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | cust_shop_list |

  @sanity @positive @regression
  Scenario:Delete 5:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type    | query | param |
      | SingleItemDelete | Default | Sandbox      | Cluster |       |       |
      | SingleItemDelete | Default | Cluster Demo | Cluster |       |       |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 6:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry  |
      | QueryLog_Q5 |
   And sync the test execution for "40" seconds

    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC13#:Verify HiveQueryParser creates operation/execution/sql source for insert overwrite directory.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | insertoverwritedirectory'hivelinker/csv/testcsvfolder'select*fromhivequeryparserdb.customer_shopping_list |
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Execution | 1     |


    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario Outline:SC14#:Verify lineage got generated when insert overwrite directory query operation is done.
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                   | asg_scopeid | targetFile                                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | customer_shopping_list |             | response/Lineage/HiveQueryParser/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                      | bodyFile                                          | path                                     | response code | response message | jsonPath | targetFile                                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&exclude=CONTROL&excludeUnusedViewColumns=false | response\Lineage\HiveQueryParser\bulkLineage.json | $.lineagePayLoads.customer_shopping_list | 200           |                  | edges    | response\Lineage\HiveQueryParser\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                  | JsonPath               |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | customer_shopping_list |
    And user sort the json file using the following value
      | fileName                                                                  | JsonPath               | value  |
      | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | customer_shopping_list | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "insertoverwritedirectory'hivelinker/csv/testcsvfolder'select*fromhivequeryparserdb.customer_shopping_list" item from search results
    And user "widget presence" on "Runtime Executions" in Item view page
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | customer_shopping_list | verify widget contains | No               |             |
      | uses  | testcsvfolder          | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                     | actual_json                                                               | item                   |
      | Constant.REST_DIR/response/HiveQueryParser/expected/hivequeryparserexpected5.json | Constant.REST_DIR/response/Lineage/HiveQueryParser/actualLineagehops.json | customer_shopping_list |

  @sanity @positive @regression
  Scenario:Delete 6:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type    | query | param |
      | SingleItemDelete | Default | Sandbox      | Cluster |       |       |
      | SingleItemDelete | Default | Cluster Demo | Cluster |       |       |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 7:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry      |
      | DropQueryLog_Q3 |
      | DropQueryLog_Q2 |
      | DropQueryTable1 |
      | DropQueryTable2 |
      | DropQueryTable3 |
      | DropQueryTable4 |
      | DropQueryTable5 |
      | DropQueryTable6 |
    And sync the test execution for "40" seconds


    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC15#:Verify HiveQueryParser creates operation/execution/sql source for drop table/drop DB.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | droptablehivequeryparserdb.cus_shop_list          |
      | droptablehivequeryparserdb.customer_shopping_list |
      | droptablehivequeryparserdb.product                |
      | droptablehivequeryparserdb.productstore           |
      | droptablehivequeryparserdb.store                  |
      | droptablehivequeryparserdb.city                   |
      | droptablehivequeryparserdb.customers              |
      | droptablehivequeryparserdb.customers1             |

  @sanity @positive @regression
  Scenario:Delete 7:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type    | query | param |
      | SingleItemDelete | Default | Sandbox      | Cluster |       |       |
      | SingleItemDelete | Default | Cluster Demo | Cluster |       |       |


  @ambari @positve @hdfs @regression @sanity
  Scenario: Create 8:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry |
      | QPSkip1    |
      | QPSkip2    |
      | QPSkip3    |
      | QPSkip4    |
      | QPSkip5    |
      | QPSkip6    |
      | QPSkip7    |
      | QPSkip8    |
    And sync the test execution for "40" seconds

    #7142554
  @webtest @MLP-24274 @sanity @positive @regression
  Scenario:SC16#:Verify HiveQueryParser skips few listed operations.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Database  |
      | Table     |
      | Column    |
      | Analysis  |
      | Operation |
      | Execution |


    #7154118
  @MLP-26715 @webtest @positive @regression @sanity
  Scenario: SC17#Verify proper error message is shown if mandatory fields are not filled in HiveQueryParser configuration page
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
      | fieldName | attribute       |
      | Type      | Parser          |
      | Plugin    | HiveQueryParser |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  Scenario Outline:Create 2: Create Plugin configurations for HiveCataloger, HiveMonitor and HiveQueryParser with dryRun true.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                | body                                                                        | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger   | ida/queryParser/PluginConfiguration/HiveConfigForHiveMonitor.json           | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveCataloger   |                                                                             | 200           | HiveCataloger    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveMonitor     | ida/queryParser/PluginConfiguration/HiveMonitorConfiguration.json           | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveMonitor     |                                                                             | 200           | HiveMonitor      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HiveQueryParser | ida/queryParser/PluginConfiguration/HiveQueryParserConfigurationDryRun.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HiveQueryParser |                                                                             | 200           | HiveQueryParser  |          |

  @ambari @positve @hdfs @regression @sanity
  Scenario: Delete 8:Verify whether the Hive database is dropped and recreated in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry |
      | QPDropDB   |
    And sync the test execution for "40" seconds


    #7142570
  @MLP-24873 @webtest @regression @sanity
  Scenario: SC#18- Verify HiveQueryParser doesn't collects when run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveQueryParserTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Operation |
      | Cluster   |
      | Database  |
      | Execution |
      | Column    |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "parser/HiveQueryParser/HiveQueryParser/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "parser/HiveQueryParser/HiveQueryParser%" should display below info/error/warning
      | type | logValue                                                                                                                             | logCode       | pluginName      | removableText |
      | INFO | Plugin HiveQueryParser running on dry run mode                                                                                       | ANALYSIS-0069 | HiveQueryParser |               |
      | INFO | Plugin HiveQueryParser processed 2 items on dry run mode and not written to the repository                                           | ANALYSIS-0070 | HiveQueryParser |               |
      | INFO | Plugin HiveQueryParser Start Time:2020-08-31 23:00:34.669, End Time:2020-08-31 23:00:34.773, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | HiveQueryParser |               |
    And user clicks on logout button

  @sanity @positive @regression
  Scenario:Delete 9:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type    | query | param |
      | SingleItemDelete | Default | Sandbox      | Cluster |       |       |
      | SingleItemDelete | Default | Cluster Demo | Cluster |       |       |


  Scenario Outline:Delete Credentials and Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveValidCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveInValidCredential |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveEmptyCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveDataSource          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveMonitor             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveQueryParser         |      | 204           |                  |          |




