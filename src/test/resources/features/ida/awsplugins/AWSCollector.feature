@MLP-16092
Feature: MLP-16092 Create AWSCollector bundle for collecting ETL job scripts

  @sanity @positive @MLP-16092 @IDA-10.3
  Scenario: SC1#MLP_16092:Create new Job in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                           |
      | createJob | ida/amazonGluePayloads/TestData/createTestJob.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                            |
      | createJob | ida/amazonGluePayloads/TestData/createTestJob1.json |

  @sanity @positive @regression @IDA-10.3
  Scenario Outline: create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/amazonCollectorPayloads/PluginConfiguration/BussinessApplication.json | 200           |                  |          |

  @aws @precondition
  Scenario: Update AWS secret key and access from config file
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                        | accessKeyPath | secretKeyPath |
      | ida/amazonGluePayloads/credentials/awsGlueValidCredentials.json | $..accessKey  | $..secretKey  |

  @jdbc
  Scenario Outline: SC1#-Set the Credentials for AWSGlueDatasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                              | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidGlueCredentials   | ida/amazonGluePayloads/Credentials/awsGlueValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/InvalidGlueCredentials | ida/amazonGluePayloads/Credentials/awsGlueInValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyGlueCredentials   | ida/amazonGluePayloads/Credentials/awsGlueEmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidGlueCredentials   |                                                                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/InvalidGlueCredentials |                                                                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyGlueCredentials   |                                                                   | 200           |                  |          |


  @sanity @positive
  Scenario: SC1#-Set the AWSGlueDatasource and AWSCollectorDataSource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                                                        | response code | response message | jsonPath                    |
      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource      | ida/amazonCollectorPayloads/DataSource/AmazonGlueDataSourceConfig.json      | 204           |                  |                             |
      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource      |                                                                             | 200           |                  | AWSGlueValidDataSource      |
      |                  |       |       | Put  | settings/analyzers/AWSCollectorDataSource | ida/amazonCollectorPayloads/DataSource/AmazonCollectorDataSourceConfig.json | 204           |                  |                             |
      |                  |       |       | Get  | settings/analyzers/AWSCollectorDataSource |                                                                             | 200           |                  | AWSCollectorValidDataSource |


  @sanity @positive @MLP-16092 @IDA-10.3
  Scenario:SC1#MLP-16092:SC1#Run the AWSGlueCataloger
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                  | response code | response message | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonCollectorPayloads/PluginConfiguration/AWSGlueConfigSC1.json | 204           |                  |                                                         |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                       | 200           |                  | AmazonGlueCatalog1                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AmazonGlueCatalog1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                       | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AmazonGlueCatalog1')].status |


  @sanity @positive @MLP-16092 @webtest @IDA-10.3
  Scenario:SC1#MLP_16092_Verify Last cataloged At,file name attributes are collected after running AWSGlueCataloger and Last collected At attribute is collected after running AWSCollector
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user enters the search text "PythonTestJob1" and clicks on search
    And user performs "item click" on "PythonTestJob1" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | Domain=amazonaws.com;Region=us-east-1; |
      | AWSGlue                                |
      | PythonTestJob1                         |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
      | Last catalogued at | Lifecycle   |
      | Location           | Description |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue          | widgetName  |
      | File name         | PythonTestJob1         | Description |
      | Comments          | aws glue qa automation | Description |


  @sanity @positive @MLP-16092 @IDA-10.3
  Scenario:SC1#MLP-16092:SC1#Set and Run the AWSCollector with dryRun as false.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                                                       | response code | response message | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/AWSCollector                                | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigSC1.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/AWSCollector                                |                                                                            | 200           |                  | AWSCollectorConfigSC1                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorConfigSC1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/*  |                                                                            | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorConfigSC1')].status |

  @sanity @positive @MLP-16092 @webtest @IDA-10.3
  Scenario:SC1#MLP_16092_Verify after AWS Collector plugin Run Successfull
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagCollector" and clicks on search
    And user performs "facet selection" in "SC1TagCollector" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user enters the search text "PythonTestJob1" and clicks on search
    And user performs "item click" on "PythonTestJob1" item from search results
    And user "verify displayed" item "PythonTestJob1" under "content" widget
    And user "click" item "PythonTestJob1" under "content" widget
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last collected at | Lifecycle  |
    And user enters the search text "SC1TagCollector" and clicks on search
    And user performs "facet selection" in "SC1TagCollector" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ScalaTestJob1" item from search results
    And user "verify displayed" item "ScalaTestJob1" under "content" widget
    And user "click" item "ScalaTestJob1" under "content" widget
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last collected at | Lifecycle  |

  #6754453#
  @sanity @positive @MLP-16092 @webtest @IDA-10.3
  Scenario:SC2#MLP_16092_Verify AWSGlueCollector plugin collects the file content(Python,Scala) as part of Operation(Has_Data Section).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagCollector" and clicks on search
    And user performs "facet selection" in "SC1TagCollector" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user enters the search text "PythonTestJob1" and clicks on search
    And user performs "item click" on "PythonTestJob1" item from search results
    Then user performs click and verify in new window
      | Table | value          | Action               | RetainPrevwindow | indexSwitch |
      | Data  | PythonTestJob1 | click and switch tab | No               |             |
    Then the "Data" metadata of item "PythonTestJob1" should be as expected
    And user enters the search text "SC1TagCollector" and clicks on search
    And user performs "facet selection" in "SC1TagCollector" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user enters the search text "ScalaTestJob1" and clicks on search
    And user performs "item click" on "ScalaTestJob1" item from search results
    Then user performs click and verify in new window
      | Table | value         | Action               | RetainPrevwindow | indexSwitch |
      | Data  | ScalaTestJob1 | click and switch tab | No               |             |
    Then the "Data" metadata of item "ScalaTestJob1" should be as expected
    And user clicks on logout button

  @sanity @positive @MLP-16092 @webtest @IDA-10.3
  Scenario:SC3#Verify the technology tags/explicit tags/Business Application tags got assigned to analysis item collected by AWSCollector
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagCollector" and clicks on search
    And user performs "facet selection" in "SC1TagCollector" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/AWSCollector/AWSCollectorConfig%"
    Then user "verify presence" of following "Tag List" in Item View Page
      | Amazon Glue     |
      | SC1TagCollector |
      | AWSCOLLECTOR_BA |
    And user clicks on logout button

    #6754453#
  @sanity @positive @MLP-16092 @webtest @IDA-10.3
  Scenario:SC4#MLP_16092_Verify log entries/log enhancements(processed Items widget and Processed count) check for AWSCollector plugin logs.
    Then Analysis log "collector/AWSCollector/AWSCollectorConfigSC1%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:AWSCollector, Plugin Type:collector, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:bd23f07beac5, Plugin Configuration name:AWSCollectorConfigSC1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0071 | AWSCollector | Plugin Version |
      | INFO | 2020-06-26 11:48:16.506 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: ---  2020-06-26 11:48:16.506 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: name: "AWSCollectorConfigSC1"  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: pluginVersion: "LATEST"  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: label:  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: : ""  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: catalogName: "Default"  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: eventClass: null  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: eventCondition: null  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: nodeCondition: null  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: maxWorkSize: 100  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: tags:  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: - "SC1TagCollector"  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: pluginType: "collector"  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: dataSource: "AWSCollectorValidDataSource"  2020-06-26 11:48:16.507 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: credential: "ValidGlueCredentials"  2020-06-26 11:48:16.508 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: businessApplicationName: "AWSCOLLECTOR_BA"  2020-06-26 11:48:16.508 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: dryRun: false  2020-06-26 11:48:16.508 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: schedule: null  2020-06-26 11:48:16.508 INFO  - ANALYSIS-0073: Plugin AWSCollector Configuration: filter: null | ANALYSIS-0073 | AWSCollector |                |
      | INFO | Plugin AWSCollector Start Time:2020-04-20 10:43:08.300, End Time:2020-04-20 10:43:18.234, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0072 | AWSCollector |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0020 |              |                |

  @sanity @positive
  Scenario:SC#1-user deletes the SC1 item from database using dynamic id stored in json
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | MultipleIDDelete | Default | AWSGlue                                         | Service  |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/AmazonGlueCatalog1/% | Analysis |       |       |
      | MultipleIDDelete | Default | collector/AWSCollector/AWSCollectorConfigSC1/%  | Analysis |       |       |

  @AWSCollector
  Scenario Outline:SC5#MLP-16092:SC3#Set and Run the AWSGlueCataloger and Collector with dry run as true.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | body                                                                              | response code | response message | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonCollectorPayloads/PluginConfiguration/AWSGlueConfigDryRunTrue.json      | 204           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                                   | 200           |                  | AmazonGlueCatalog1                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AmazonGlueCatalog1')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                                   | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AmazonGlueCatalog1')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSCollector                                    | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigDryRunTrue.json | 204           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSCollector                                    |                                                                                   | 200           |                  | AWSCollectorConfigSC5                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*     |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorConfigSC5')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/*      |                                                                                   | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*     |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorConfigSC5')].status |

  @sanity @positive @MLP-16092 @webtest @IDA-10.3
  Scenario:SC5#MLP_16092_Verify after AWS Collector plugin Run Successfull with dry run as true/processed count:0 check
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSCollectorConfigSC5" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/AWSCollector/AWSCollectorConfigSC5%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "collector/AWSCollector/AWSCollectorConfigSC5%" should display below info/error/warning
      | type | logValue                                                                                | logCode       | pluginName   | removableText |
      | INFO | Plugin AWSCollector running on dry run mode                                             | ANALYSIS-0069 | AWSCollector |               |
      | INFO | Plugin AWSCollector processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | AWSCollector |               |

  @sanity @positive
  Scenario:SC#5-user deletes the SC1 item from database using dynamic id stored in json
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | MultipleIDDelete | Default | AWSGlue                                         | Service  |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/AmazonGlueCatalog1/% | Analysis |       |       |
      | MultipleIDDelete | Default | collector/AWSCollector/AWSCollectorConfigSC5/%  | Analysis |       |       |


     ##6878391##
  @MLP-16092 @webtest @positive @regression @IDA-10.3
  Scenario: SC6# Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in AWSCollector
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
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | AWSCollector |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"

  @MLP-16092 @webtest @positive @regression @IDA-10.3
  Scenario: SC7# Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in AWSCollectorDatasource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | AWSCollectorDataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"

  @MLP-16092 @webtest @positive @regression @IDA-10.3
  Scenario: SC8#-Verify captions and tool tip text in AWSCollector
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
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | AWSCollector |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Credential*          |
      | Data Source*         |
      | Business Application |

  @MLP-16092 @webtest @positive @regression @IDA-10.3
  Scenario: SC9#-Verify captions and tool tip text in AWSCollectorDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | AWSCollectorDataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source Type* |
      | Name*             |
      | Label             |
      | Region*           |
      | Credential*       |
      | Node              |


  @MLP-16092 @webtest @positive @regression @IDA-10.3
  Scenario:SC#10_Verify whether the background of the panel is displayed in green when connection is successful in AWSCollectorDataSource LocalNode
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute                         |
      | Data Source Type | AWSCollectorDataSource            |
      | Region           | US East (N. Virginia) [us-east-1] |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute               |
      | Name      | AWSCollector_DataSource |
      | Label     | AWSCollector_DataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute            |
      | Credential | ValidGlueCredentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


  @MLP-16092 @webtest @positive @regression @IDA-10.3
  Scenario:SC#11_Verify whether the background of the panel is displayed in red when connection is unsuccessful in AWSGlueCollector when invalid / empty credential is used in Local Node
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
      | fieldName   | attribute                   |
      | Type        | Collector                   |
      | Plugin      | AWSCollector                |
      | Data Source | AWSCollectorValidDataSource |
      | Credential  | InvalidGlueCredentials      |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Name      | AWSCollector |
      | Label     | AWSCollector |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "No connection with data source - AmazonS3 connection was failed" is "displayed" in "Add Manage Configuration Sources Page"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute            |
      | Credential | EmptyGlueCredentials |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "No connection with data source - Required attribute Secret key is blank" is "displayed" in "Add Manage Configuration Sources Page"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"


    ##6878397##
  @MLP-15788 @webtest
  Scenario: SC12#-Verify the AWSCollector does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                        | body                                                                                                   | response code | response message | jsonPath                                                                            |
      | application/json | raw   | false | Put          | settings/analyzers/AWSCollectorDataSource                                  | ida/amazonCollectorPayloads/DataSource/AmazonCollectorInvalidCredentialsDataSourceConfig.json          | 204           |                  |                                                                                     |
      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                                  |                                                                                                        | 200           |                  | AWSCollectorInvalidCredentialsDataSource                                            |
      |                  |       |       | Put          | settings/analyzers/AWSCollector                                            | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigWithInvalidDataSourceCredential.json | 204           |                  |                                                                                     |
      |                  |       |       | Get          | settings/analyzers/AWSCollector                                            |                                                                                                        | 200           |                  | AWSCollectorWithInvalidDataSourceAndCredential                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorInvalidCredentialsDataSource')].status       |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSCollectorDataSource/*  | ida/amazonCollectorPayloads/empty.json                                                                 | 200           |                  |                                                                                     |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorInvalidCredentialsDataSource')].status       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*             |                                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithInvalidDataSourceAndCredential')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/*              | ida/amazonCollectorPayloads/empty.json                                                                 | 200           |                  |                                                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*             |                                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithInvalidDataSourceAndCredential')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagCollectorInvalidDS" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/AWSCollector/AWSCollectorWithInvalidDataSourceAndCredential%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "collector/AWSCollector/AWSCollectorWithInvalidDataSourceAndCredential%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName   | removableText |
      | INFO | Plugin AWSCollector Start Time:2020-03-05 18:44:12.750, End Time:2020-03-05 18:44:18.209, Processed Count:0, Errors:2, Warnings:0 | ANALYSIS-0072 | AWSCollector |               |
    And user clicks on logout button

  @sanity @positive
  Scenario:SC#12-user deletes the SC1 item from database using dynamic id stored in json
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                    | type                | query | param |
      | MultipleIDDelete | Default | AWSGlue                                                                 | Service             |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1;                                  | Cluster             |       |       |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%                                            | Analysis            |       |       |
      | MultipleIDDelete | Default | collector/AWSCollector/AWSCollectorWithInvalidDataSourceAndCredential/% | Analysis            |       |       |
      | MultipleIDDelete | Default | AWSCOLLECTOR_BA                                                         | BusinessApplication |       |       |


#      ##6878395##
#  @MLP-15788 @webtest
#  Scenario: SC29#-Verify the Analysis failed notification event displayed in IDC UI when user gives invalid Secret and Access Key for AWS Glue datasource plugin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                        | body                                                                                          | response code | response message | jsonPath                                                                      |
#      | application/json | raw   | false | Post         | settings/catalogs                                                          | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorInvalidKeyCatalog.json                 | 204           |                  |                                                                               |
#      |                  |       |       | Put          | settings/analyzers/AWSCollectorDataSource                                  | ida/amazonCollectorPayloads/DataSource/AmazonCollectorInvalidCredentialsDataSourceConfig.json | 204           |                  |                                                                               |
#      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                                  |                                                                                               | 200           |                  | AWSCollectorInvalidCredentialsDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorInvalidCredentialsDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSCollectorDataSource/*  | ida/amazonCollectorPayloads/empty.json                                                        | 200           |                  |                                                                               |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorInvalidCredentialsDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CollectorInvalidKeyCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#

#
#    ####
#  @MLP-14874 @webtest
#  Scenario: SC31#-Verify the AWSCollector collects all items when an Invalid Datasource(with wrong Credentials) and Valid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                        | body                                                                                                 | response code | response message | jsonPath                                                                          |
#      | application/json | raw   | false | Post         | settings/catalogs                                                          | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorInvalidKeyCatalog.json                        | 204           |                  |                                                                                   |
#      |                  |       |       | Put          | settings/analyzers/AWSCollector                                            | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigWithValidDataSourceCredential.json | 204           |                  |                                                                                   |
#      |                  |       |       | Get          | settings/analyzers/AWSCollector                                            |                                                                                                      | 200           |                  | AWSCollectorWithValidDataSourceAndCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AWSCollectorDataSource                                  | ida/amazonCollectorPayloads/DataSource/AmazonCollectorInvalidCredentialsDataSourceConfig.json        | 204           |                  |                                                                                   |
#      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                                  |                                                                                                      | 200           |                  | AWSCollectorInvalidCredentialsDataSource                                          |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorInvalidCredentialsDataSource')].status     |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSCollectorDataSource/*  | ida/amazonCollectorPayloads/empty.json                                                               | 200           |                  |                                                                                   |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorInvalidCredentialsDataSource')].status     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*             |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithValidDataSourceAndCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/*              | ida/amazonCollectorPayloads/empty.json                                                               | 200           |                  |                                                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*             |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithValidDataSourceAndCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollector on LocalNode has started" in the notifications tab
#    And "Analysis succeeded!" notification should have content "Analysis AWSCollector on LocalNode has succeeded" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "CollectorInvalidKeyCatalog" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CollectorInvalidKeyCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ####
#  @MLP-15788 @webtest
#  Scenario: SC33#-Verify the AWSCollector does not collect any items when an Datasource(with Empty Credentials) and Empty Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                        | body                                                                                                 | response code | response message | jsonPath                                                                          |
#      | application/json | raw   | false | Post         | settings/catalogs                                                          | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorEmptyCredential.json                          | 204           |                  |                                                                                   |
#      |                  |       |       | Put          | settings/analyzers/AWSCollector                                            | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigWithEmptyDataSourceCredential.json | 204           |                  |                                                                                   |
#      |                  |       |       | Get          | settings/analyzers/AWSCollector                                            |                                                                                                      | 200           |                  | AWSCollectorWithEmptyDataSourceAndCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AWSCollectorDataSource                                  | ida/amazonCollectorPayloads/DataSource/AmazonCollectorEmptyCredentialsDataSourceConfig.json          | 204           |                  |                                                                                   |
#      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                                  |                                                                                                      | 200           |                  | AWSCollectorEmptyCredentialsDataSource                                            |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorEmptyCredentialsDataSource')].status       |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSCollectorDataSource/*  | ida/amazonCollectorPayloads/empty.json                                                               | 200           |                  |                                                                                   |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorEmptyCredentialsDataSource')].status       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*             |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithEmptyDataSourceAndCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/*              | ida/amazonCollectorPayloads/empty.json                                                               | 200           |                  |                                                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*             |                                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithEmptyDataSourceAndCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollector on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollector on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "AWSCollectorEmptyDataSource" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "collector" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "Required attribute secretKey is blank" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/AWSCollectorEmptyDataSource"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ####
#  @MLP-15788 @webtest
#  Scenario: SC32#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started with Empty Credentials in Datasource
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                        | body                                                                                        | response code | response message | jsonPath                                                                    |
#      | application/json | raw   | false | Post         | settings/catalogs                                                          | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorEmptyCredential.json                 | 204           |                  |                                                                             |
#      |                  |       |       | Put          | settings/analyzers/AWSCollectorDataSource                                  | ida/amazonCollectorPayloads/DataSource/AmazonCollectorEmptyCredentialsDataSourceConfig.json | 204           |                  |                                                                             |
#      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                                  |                                                                                             | 200           |                  | AWSCollectorEmptyCredentialsDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                             | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorEmptyCredentialsDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSCollectorDataSource/*  | ida/amazonCollectorPayloads/empty.json                                                      | 200           |                  |                                                                             |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                             | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorEmptyCredentialsDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/AWSCollectorEmptyDataSource"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#      ####
#  @MLP-15788 @webtest
#  Scenario: SC34#-Verify the Analysis failed notification displayed in IDC UI when AWSCollectorDatasource Plugin is Started with No Region(Region will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                        | body                                                                                    | response code | response message | jsonPath                                                                |
#      | application/json | raw   | false | Post         | settings/catalogs                                                          | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorRegionNullCatalog.json           | 204           |                  |                                                                         |
#      |                  |       |       | Put          | settings/analyzers/AWSCollectorDataSource                                  | ida/amazonCollectorPayloads/DataSource/AmazonCollectorDataSourceWithNoRegionConfig.json | 204           |                  |                                                                         |
#      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                                  |                                                                                         | 200           |                  | AWSCollectorDataSourceWithNoRegion                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorDataSourceWithNoRegion')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSCollectorDataSource/*  | ida/amazonCollectorPayloads/empty.json                                                  | 200           |                  |                                                                         |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorDataSourceWithNoRegion')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CollectorNullRegionCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ####
#  @MLP-15788 @webtest
#  Scenario: SC35#-Verify the AWSCollector does not collect any items when an Datasource(with No Region) and Valid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                        | body                                                                                                         | response code | response message | jsonPath                                                                               |
#      | application/json | raw   | false | Post         | settings/catalogs                                                          | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorRegionNullCatalog.json                                | 204           |                  |                                                                                        |
#      |                  |       |       | Put          | settings/analyzers/AWSCollector                                            | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigWithNoRegionDataSourceValidCredential.json | 204           |                  |                                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AWSCollector                                            |                                                                                                              | 200           |                  | AWSCollectorWithNoRegionDataSourceValidCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AWSCollectorDataSource                                  | ida/amazonCollectorPayloads/DataSource/AmazonCollectorDataSourceWithNoRegionConfig.json                      | 204           |                  |                                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                                  |                                                                                                              | 200           |                  | AWSCollectorDataSourceWithNoRegion                                                     |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorDataSourceWithNoRegion')].status                |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSCollectorDataSource/*  | ida/amazonCollectorPayloads/empty.json                                                                       | 200           |                  |                                                                                        |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorDataSourceWithNoRegion')].status                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*             |                                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithNoRegionDataSourceValidCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/*              | ida/amazonCollectorPayloads/empty.json                                                                       | 200           |                  |                                                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/*             |                                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithNoRegionDataSourceValidCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollector on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollector on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "CollectorNullRegionCatalog" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "collector" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "Required attribute Region is blank" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CollectorNullRegionCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ####
#  @MLP-15788 @webtest
#  Scenario: SC36#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started without Credentials in Datasource (Credentials will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                        | body                                                                                          | response code | response message | jsonPath                                                                      |
#      | application/json | raw   | false | Post         | settings/catalogs                                                          | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorCredentialNullCatalog.json             | 204           |                  |                                                                               |
#      |                  |       |       | Put          | settings/analyzers/AWSCollectorDataSource                                  | ida/amazonCollectorPayloads/DataSource/AmazonCollectorDataSourceWithNullCredentialConfig.json | 204           |                  |                                                                               |
#      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                                  |                                                                                               | 200           |                  | AWSCollectorDataSourceWithNullCredential                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorDataSourceWithNullCredential')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSCollectorDataSource/*  | ida/amazonCollectorPayloads/empty.json                                                        | 200           |                  |                                                                               |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSCollectorDataSource/* |                                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorDataSourceWithNullCredential')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollectorDataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CollectorNullCredentialCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#  ##Bug raised MLP-16626##
#  @MLP-14874 @webtest
#  Scenario: SC37#-Verify the AWSCollector does not collect any items when Datasource or Credential value in null in Json
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                                                                             | response code | response message | jsonPath                                                                           |
#      | application/json | raw   | false | Post         | settings/catalogs                                              | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorDataSourceOrCredentialNull.json           | 204           |                  |                                                                                    |
#      |                  |       |       | Put          | settings/analyzers/AWSCollectorDataSource                      | ida/amazonCollectorPayloads/DataSource/AmazonCollectorDataSourceConfigNullDSOrCredential.json    | 204           |                  |                                                                                    |
#      |                  |       |       | Get          | settings/analyzers/AWSCollectorDataSource                      |                                                                                                  | 200           |                  | AWSCollectorValidDSCredentialOrDSNullInPlugin                                      |
#      |                  |       |       | Put          | settings/analyzers/AWSCollector                                | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigWithNullDSValidCredential.json | 204           |                  |                                                                                    |
#      |                  |       |       | Get          | settings/analyzers/AWSCollector                                |                                                                                                  | 200           |                  | AWSCollectorWithNullDataSourceValidCredential                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/* |                                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithNullDataSourceValidCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/*  | ida/amazonCollectorPayloads/empty.json                                                           | 200           |                  |                                                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/* |                                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithNullDataSourceValidCredential')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollector on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollector on LocalNode has failed" in the notifications tab
##    And user select "All" catalog and search "CollectorDSOrCredentialNullCatalog" items at top end
##    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
##     | Analysis |
##    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
##    And user performs "dynamic item click" on "collector" item from search results
##    And user click on Analysis log link in DATA widget section
##    Then user "verify analysis log contains" presence of "Invalid data source configuration name: null" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CollectorDSOrCredentialNullCatalog"
#    Then Status code 204 must be returned
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                            | body                                                                                             | response code | response message | jsonPath                                                                           |
#      |        |       |       | Post         | settings/catalogs                                              | ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorDataSourceOrCredentialNull.json           | 204           |                  |                                                                                    |
#      |        |       |       | Put          | settings/analyzers/AWSCollectorDataSource                      | ida/amazonCollectorPayloads/DataSource/AmazonCollectorDataSourceConfigNullDSOrCredential.json    | 204           |                  |                                                                                    |
#      |        |       |       | Get          | settings/analyzers/AWSCollectorDataSource                      |                                                                                                  | 200           |                  | AWSCollectorValidDSCredentialOrDSNullInPlugin                                      |
#      |        |       |       | Put          | settings/analyzers/AWSCollector                                | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigWithValidDSNullCredential.json | 204           |                  |                                                                                    |
#      |        |       |       | Get          | settings/analyzers/AWSCollector                                |                                                                                                  | 200           |                  | AWSCollectorWithValidDataSourceNullCredential                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/* |                                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithValidDataSourceNullCredential')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/*  | ida/amazonCollectorPayloads/empty.json                                                           | 200           |                  |                                                                                    |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/* |                                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorWithValidDataSourceNullCredential')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSCollector on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSCollector on LocalNode has failed" in the notifications tab
##    And user select "All" catalog and search "CollectorDSOrCredentialNullCatalog" items at top end
##    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
##      | Analysis |
##    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
##    And user performs "dynamic item click" on "cataloger" item from search results
##    And user click on Analysis log link in DATA widget section
##    Then user "verify analysis log contains" presence of "Invalid data source configuration name: AWSGlueValidDataSource" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CollectorDSOrCredentialNullCatalog"
#    Then Status code 204 must be returned
#
#
#  @webtest
#  Scenario: SC39#-Set the AWSGlueDatasource and AWSCollectorDataSource
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                                                     | response code | response message | jsonPath                                 |
#      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource      | ida/amazonCollectorPayloads/DataSource/AmazonGlueDataSourceConfigNodeCondition.json      | 204           |                  |                                          |
#      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource      |                                                                                          | 200           |                  | AWSGlueValidDataSourceNodeCondition      |
#      |                  |       |       | Put  | settings/analyzers/AWSCollectorDataSource | ida/amazonCollectorPayloads/DataSource/AmazonCollectorDataSourceConfigNodeCondition.json | 204           |                  |                                          |
#      |                  |       |       | Get  | settings/analyzers/AWSCollectorDataSource |                                                                                          | 200           |                  | AWSCollectorValidDataSourceNodeCondition |
#
#
#
#    #6754453#
#  @sanity @positive @MLP-16092 @webtest @IDA-10.3
#  Scenario:SC39#MLP_16092_Verify AWSCollector and AWSCollectorDataSource plugins works fine if node condition is given.
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/amazonCollectorPayloads/catalogs/CreateAWSCollectorNodeConditionCatalog.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 204 must be returned
#    And verify created schema "CollectorCatalogNodeCondition" exists in database
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                   | body                                                                            | response code | response message | jsonPath                                                            |
#      |        |       |       | Put          | settings/analyzers/AWSGlueCataloger                                   | ida/amazonCollectorPayloads/PluginConfiguration/AWSGlueConfigNodeCondition.json | 204           |                  |                                                                     |
#      |        |       |       | Get          | settings/analyzers/AWSGlueCataloger                                   |                                                                                 | 200           |                  | AmazonGlueCatalogNodeCondition                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AWSGlueCataloger/* |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonGlueCatalogNodeCondition')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AWSGlueCataloger/*  |                                                                                 | 200           |                  |                                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AWSGlueCataloger/* |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='AmazonGlueCatalogNodeCondition')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "CollectorCatalogNodeCondition" items at top end
#    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "PythonTestJob1" item from search results
#    Then user "verify metadata properties" section has following values
#      | Last catalogued at |
#    Then METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | File name    | PythonTestJob1    |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                               | body                                                                                 | response code | response message | jsonPath                                                             |
#      |        |       |       | Put          | settings/analyzers/AWSCollector                                   | ida/amazonCollectorPayloads/PluginConfiguration/AWSCollectorConfigNodeCondition.json | 204           |                  |                                                                      |
#      |        |       |       | Get          | settings/analyzers/AWSCollector                                   |                                                                                      | 200           |                  | AWSCollectorConfigNodeCondition                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/AWSCollector/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorConfigNodeCondition')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/collector/AWSCollector/*  |                                                                                      | 200           |                  |                                                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/AWSCollector/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AWSCollectorConfigNodeCondition')].status |
#    And user select "All" catalog and search "CollectorCatalogNodeCondition" items at top end
#    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "PythonTestJob1" item from search results
#    And user "verify displayed" item "PythonTestJob1" under "DATA" widget
#    And user "click" item "PythonTestJob1" under "DATA" widget
#    Then user "verify metadata properties" section has following values
#      | Last collected at |
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/CollectorCatalogNodeCondition"
#    Then Status code 204 must be returned

  @MLP-14874 @webtest
  Scenario:SC10#Verify whether the background of the panel is displayed in red when test connection is not successful for AWSCollectorDataSource in LocalNode for disabled/unsupported region
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
      | fieldName        | attribute              |
      | Data Source Type | AWSCollectorDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                   |
      | Name*     | AWSCollectorDataSourceTest3 |
      | Label     | AWSCollectorDataSourceTest3 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                        |
      | Region*     | China (Ningxia) [cn-northwest-1] |
      | Credential* | ValidGlueCredentials             |
      | Node        | LocalNode                        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                              |
      | Region*   | AWS GovCloud (US-East) [us-gov-east-1] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                                   |
      | Region*   | Asia Pacific (Osaka-Local) [ap-northeast-3] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Cannot create enum from ap-northeast-3 value!" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  @sanity @positive @MLP-16092 @IDA-10.3
  Scenario: SC11#MLP_16092:Delete Job in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action    | jobName        |
      | deleteJob | PythonTestJob1 |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName       |
      | deleteJob | ScalaTestJob1 |


  @jdbc
  Scenario Outline: SC11#-Delete the Credentials for AWSGlueDatasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidGlueCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/ValidGlueCredentials   |      | 404           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidGlueCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/InvalidGlueCredentials |      | 404           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyGlueCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/EmptyGlueCredentials   |      | 404           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGlueDataSource        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSCollectorDataSource   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSCollector             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGlueCataloger         |      | 204           |                  |          |

