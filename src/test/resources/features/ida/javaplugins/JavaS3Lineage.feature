Feature: Validation of Java S3 Lineage plugin functionality after running all prerequisite plugins : MLP-13379

  ############################################# Pre Conditions ##########################################################
  @MLP-13379 @git @aws @precondition
  Scenario: SC#1:UpdateCredentials: Update credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                                     | username    | password    |
      | ida/javaS3LineagePayloads/credentials/javaS3Lineage_gitValidCredentials.json | $..userName | $..password |
    And User update the below "aws credentials" in following files using json path
      | filePath                                                                     | accessKeyPath | secretKeyPath |
      | ida/javaS3LineagePayloads/credentials/javaS3Lineage_awsValidCredentials.json | $..accessKey  | $..secretKey  |

  @MLP-13379 @cr-data @sanity @aws
  Scenario: SC#1:CreateBucket: Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgcoms3primarybucket" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix             | dirPath                            | recursive |
      | asgcoms3primarybucket | JavaFiles/QaTestData  | ida/javaS3LineagePayloads/TestData | true      |
      | asgcoms3primarybucket | JavaFiles/UploadDir   | ida/javaParserPayloads             | true      |
      | asgcoms3primarybucket | JavaFiles/DownloadDir | ida/javaLinkerPayloads             | true      |

  @sanity @positive @regression
  Scenario Outline: SC#1:SetValidCredentials: Set the valid credentials for GitCollector, AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                      | body                                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentials | ida/javaS3LineagePayloads/credentials/javaS3Lineage_gitValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidGitCredentials |                                                                              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_Credentials     | ida/javaS3LineagePayloads/credentials/javaS3Lineage_awsValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/AWS_Credentials     |                                                                              | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline: SC#1:BusinessApplication: Create BusinessApplication tag and run the plugin configuration with this new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_BusinessApplication.json | 200           |                  |          |

  ############################################# PluginRun ##########################################################
  @MLP-13379 @sanity @positive @regression
  Scenario Outline: SC#3_PluginRun: Run the Plugin configurations for Git, Amazon S3 Cataloger, Java Parser, Java IO Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                                           | response code | response message       | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                               | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_AmazonS3DataSource.json | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                               |                                                                                | 200           | AmazonS3DataSource     |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_AmazonS3Cataloger.json  | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                |                                                                                | 200           | AmazonS3Cataloger      |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger  | ida/empty.json                                                                 | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                           | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_git_datasource.json     | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                           |                                                                                | 200           | GitCollectorDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                     | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_git.json                | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                     |                                                                                | 200           | GitCollectorJava       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJava       |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='GitCollectorJava')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJava        | ida/empty.json                                                                 | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJava       |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='GitCollectorJava')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                                       | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_parser.json             | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                                       |                                                                                | 200           | JavaS3Parser           |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaS3Parser                |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='JavaS3Parser')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaS3Parser                 | ida/empty.json                                                                 | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaS3Parser                |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='JavaS3Parser')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaIOLinker                                                     | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_iolinker.json           | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaIOLinker                                                     |                                                                                | 200           | JavaIOLinker           |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker              |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaIOLinker/JavaIOLinker               | ida/empty.json                                                                 | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker              |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status      |

  ############################################# PluginRun - DryRunTrue ##########################################################
  @MLP-13379 @sanity @positive @regression
  Scenario Outline: SC#4:PluginDryRun: Run the Plugin configurations for JavaS3Lineage with dryRun as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                          | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaS3Lineage                                          | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_lineageDryRunTrue.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaS3Lineage                                          |                                                                               | 200           | JavaS3Lineage    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaS3Lineage/JavaS3Lineage |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='JavaS3Lineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaS3Lineage/JavaS3Lineage  | ida/empty.json                                                                | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaS3Lineage/JavaS3Lineage |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='JavaS3Lineage')].status |

  Scenario Outline: SC#4:RetrieveItemID: User retrieves the item ids of analysis of JavaS3Lineage and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                    | type | targetFile                                      | jsonpath                     |
      | APPDBPOSTGRES | Default | lineage/JavaS3Lineage/JavaS3Lineage%DYN |      | response/java/javaS3Lineage/actual/itemIds.json | $..JavaS3Lineage_Analysis.id |

  @MLP-13379 @sanity @positive @webtest
  Scenario: SC#4:UI_Validation: Verify JavaS3Lineage plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaS3LineageDryRunTrue" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaS3Lineage/JavaS3Lineage%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 18            | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaS3Lineage/JavaS3Lineage/%" should display below info/error/warning
      | type | logValue                                     | logCode       | pluginName | removableText |
      | INFO | Plugin JavaS3Lineage running on dry run mode | ANALYSIS-0069 |            |               |

  Scenario Outline: SC#4:ItemDeletion: User deletes the JavaS3Lineage analysis item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                    | inputFile                                       |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JavaS3Lineage_Analysis.id | response/java/javaS3Lineage/actual/itemIds.json |

  ############################################# PluginRun ##########################################################
  @MLP-13379 @sanity @positive @regression
  Scenario Outline: SC#3:PluginRun: Run the Plugin configurations for JavaS3Lineage with dryRun as false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body                                                                | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaS3Lineage                                          | ida/javaS3LineagePayloads/PluginPayloads/javaS3Lineage_lineage.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaS3Lineage                                          |                                                                     | 200           | JavaS3Lineage    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaS3Lineage/JavaS3Lineage |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='JavaS3Lineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaS3Lineage/JavaS3Lineage  | ida/empty.json                                                      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaS3Lineage/JavaS3Lineage |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='JavaS3Lineage')].status |

  Scenario Outline: SC#3:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                              | type    | targetFile                                      | jsonpath                     |
      | APPDBPOSTGRES | Default | javaspark_lineage                                 | Project | response/java/javaS3Lineage/actual/itemIds.json | $..Project.id                |
      | APPDBPOSTGRES | Default | amazonaws.com                                     |         | response/java/javaS3Lineage/actual/itemIds.json | $..AmazonS3_Cluster.id       |
      | APPDBPOSTGRES | Default | test_BA_JavaS3Lineage                             |         | response/java/javaS3Lineage/actual/itemIds.json | $..has_BA.id                 |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJava%DYN       |         | response/java/javaS3Lineage/actual/itemIds.json | $..Git_Analysis.id           |
      | APPDBPOSTGRES | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger%DYN |         | response/java/javaS3Lineage/actual/itemIds.json | $..AmazonS3_Analysis.id      |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaS3Parser%DYN                |         | response/java/javaS3Lineage/actual/itemIds.json | $..JParser_Analysis.id       |
      | APPDBPOSTGRES | Default | linker/JavaIOLinker/JavaIOLinker%DYN              |         | response/java/javaS3Lineage/actual/itemIds.json | $..JIOLinker_Analysis.id     |
      | APPDBPOSTGRES | Default | lineage/JavaS3Lineage/JavaS3Lineage%DYN           |         | response/java/javaS3Lineage/actual/itemIds.json | $..JavaS3Lineage_Analysis.id |

  ############################################# LoggingEnhancements #############################################
  @webtest @MLP-13379
  Scenario: SC#5:LoggingEnhancements: Verify JavaS3Lineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaS3Lineage" and clicks on search
    And user performs "facet selection" in "tagJavaS3Lineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaS3Lineage/JavaS3Lineage%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 9             | Description |
      | Number of errors          | 18            | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaS3Lineage/JavaS3Lineage/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:JavaS3Lineage, Plugin Type:lineage, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:128c8c7a53f5, Plugin Configuration name:JavaS3Lineage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0071 | JavaS3Lineage | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaS3Lineage Configuration: ---  2020-08-14 11:42:07.435 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: name: "JavaS3Lineage"  2020-08-14 11:42:07.435 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: pluginVersion: "LATEST"  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: label:  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: : "JavaS3Lineage"  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: catalogName: "Default"  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: eventClass: null  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: eventCondition: null  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: nodeCondition: "name==\"LocalNode\""  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: maxWorkSize: 100  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: tags:  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: - "tagJavaS3Lineage"  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: pluginType: "lineage"  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: dataSource: null  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: credential: null  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: businessApplicationName: "test_BA_JavaS3Lineage"  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: dryRun: false  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: schedule: null  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: runAfter: []  2020-08-14 11:42:07.436 INFO  - ANALYSIS-0073: Plugin JavaS3Lineage Configuration: filter: null | ANALYSIS-0073 | JavaS3Lineage |                |
      | INFO | Plugin JavaS3Lineage Start Time:2020-04-07 09:41:58.595, End Time:2020-04-07 09:42:02.568, Processed Count:9, Errors:18, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0072 | JavaS3Lineage |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0020 |               |                |

  ############################################# API Lineage verification #############################################
  @MLP-13379 @sanity @positive @regression
  Scenario Outline:SC#6:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                             | asg_scopeid | targetFile                                                                | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | GetS3Object                      |             | response/java/javaS3Lineage/Lineage/GetS3Object.json                      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | getObject                        |             | response/java/javaS3Lineage/Lineage/GetS3Object.json                      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                  |             | response/java/javaS3Lineage/Lineage/GetS3Object.json                      | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | CopyS3Object                     |             | response/java/javaS3Lineage/Lineage/CopyS3Object.json                     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | copyObject                       |             | response/java/javaS3Lineage/Lineage/CopyS3Object.json                     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                  |             | response/java/javaS3Lineage/Lineage/CopyS3Object.json                     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | HandleS3Objects                  |             | response/java/javaS3Lineage/Lineage/HandleS3Objects.json                  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | putObject                        |             | response/java/javaS3Lineage/Lineage/HandleS3Objects.json                  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                  |             | response/java/javaS3Lineage/Lineage/HandleS3Objects.json                  | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | HandleMultipleS3API              |             | response/java/javaS3Lineage/Lineage/HandleMultipleS3API.json              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | handleMultipleAPIs               |             | response/java/javaS3Lineage/Lineage/HandleMultipleS3API.json              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                  |             | response/java/javaS3Lineage/Lineage/HandleMultipleS3API.json              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TransferManagerUploadDirectory   |             | response/java/javaS3Lineage/Lineage/TransferManagerUploadDirectory.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | s3UploadDirectory                |             | response/java/javaS3Lineage/Lineage/TransferManagerUploadDirectory.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                  |             | response/java/javaS3Lineage/Lineage/TransferManagerUploadDirectory.json   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TransferManagerDownloadDirectory |             | response/java/javaS3Lineage/Lineage/TransferManagerDownloadDirectory.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | s3DownloadDirectory              |             | response/java/javaS3Lineage/Lineage/TransferManagerDownloadDirectory.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                  |             | response/java/javaS3Lineage/Lineage/TransferManagerDownloadDirectory.json | $.functionID |

  @MLP-13379 @sanity @positive @regression
  Scenario Outline: SC#6:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                             | inputFile                                                                 | outputFile                                                         |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | GetS3Object                      | response/java/javaS3Lineage/Lineage/GetS3Object.json                      | response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | CopyS3Object                     | response/java/javaS3Lineage/Lineage/CopyS3Object.json                     | response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | HandleS3Objects                  | response/java/javaS3Lineage/Lineage/HandleS3Objects.json                  | response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | HandleMultipleS3API              | response/java/javaS3Lineage/Lineage/HandleMultipleS3API.json              | response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TransferManagerUploadDirectory   | response/java/javaS3Lineage/Lineage/TransferManagerUploadDirectory.json   | response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TransferManagerDownloadDirectory | response/java/javaS3Lineage/Lineage/TransferManagerDownloadDirectory.json | response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json |

  #6762327# #6762328# #6762329# #6763790# #6808343# #6808344#
  @MLP-13379 @sanity @positive @regression
  Scenario Outline: SC#6:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                | actual_json                                                                          | item                             |
      | ida/JavaS3LineagePayloads/LineageMetadata/expectedJavaS3LineageMetadata.json | Constant.REST_DIR/response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json | GetS3Object                      |
      | ida/JavaS3LineagePayloads/LineageMetadata/expectedJavaS3LineageMetadata.json | Constant.REST_DIR/response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json | CopyS3Object                     |
      | ida/JavaS3LineagePayloads/LineageMetadata/expectedJavaS3LineageMetadata.json | Constant.REST_DIR/response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json | HandleS3Objects                  |
      | ida/JavaS3LineagePayloads/LineageMetadata/expectedJavaS3LineageMetadata.json | Constant.REST_DIR/response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json | HandleMultipleS3API              |
      | ida/JavaS3LineagePayloads/LineageMetadata/expectedJavaS3LineageMetadata.json | Constant.REST_DIR/response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json | TransferManagerUploadDirectory   |
      | ida/JavaS3LineagePayloads/LineageMetadata/expectedJavaS3LineageMetadata.json | Constant.REST_DIR/response/java/javaS3Lineage/Lineage/JavaS3LineageSourceTarget.json | TransferManagerDownloadDirectory |

  ############################################# UI Lineage & Relationships verification #############################################
  @webtest @MLP-13379 @sanity @positive
  Scenario: SC#7:UI Lineage verification: - Verify the JavaS3Lineage plugin generates lineage for the java file named 'HandleMultipleS3API.java' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaS3Lineage" and clicks on search
    And user performs "facet selection" in "tagJavaS3Lineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "handleMultipleAPIs" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                                                 | Action                       | RetainPrevwindow | indexSwitch | filePath                                                             | jsonPath       |
      | Lineage Hops | /C:/work_related/Amazon_S3/SampleFile/upload/SampleTestFile.txt => UploadedS3File.txt | click and verify lineagehops | Yes              | 0           | ida/javaS3LineagePayloads/LineageMetadata/javaS3LineageMetadata.json | $.LineageHop_1 |
      | Lineage Hops | SourceFile.txt => CopiedFile.txt                                                      | click and verify lineagehops | Yes              | 0           | ida/javaS3LineagePayloads/LineageMetadata/javaS3LineageMetadata.json | $.LineageHop_2 |

  ##6762311##
  @webtest @MLP-13379
  Scenario: SC#8: Verify the relationships shows properly between the function and service under relationship tab for CreateBucketS3 API
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaS3Lineage" and clicks on search
    And user performs "facet selection" in "tagJavaS3Lineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "createBucket" item from search results
    And user verifies the Relationship of "Function" and Table for the following values in "Default"
      | Function     | uses                  |
      | createBucket | asgcoms3primarybucket |
#    And user should be able logoff the IDC

  ##6762325##
  @webtest @MLP-13379
  Scenario: SC#9: Verify the relationships shows properly between the function and service under relationship tab for DeteleBucketS3 API
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaS3Lineage" and clicks on search
    And user performs "facet selection" in "tagJavaS3Lineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "deleteBucket" item from search results
    And user verifies the Relationship of "Function" and Table for the following values in "Default"
      | Function     | uses                  |
      | deleteBucket | asgcoms3primarybucket |
#    And user should be able logoff the IDC

  ##6763790#
  @webtest @MLP-13379
  Scenario: SC#10: Verify the relationships shows properly between the function and service under relationship tab for Create and Delete S3 APIs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaS3Lineage" and clicks on search
    And user performs "facet selection" in "tagJavaS3Lineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "handleMultipleAPIs" item from search results
    And user verifies the Relationship of "Function" and Table for the following values in "Default"
      | Function           | uses                  |
      | handleMultipleAPIs | asgcoms3primarybucket |
#    And user should be able logoff the IDC

  #6763784# #6763785# #6763786# #6763787# #6763788# #6763789# #6808364# #6811190#
  @webtest @MLP-12480 @negative
  Scenario: SC#11: Verify the JavaS3Lineage plugin doesn't generates lineage for the below cases
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName              | windowName   |
      | Default     | Function  | Metadata Type | copyObjectNE          | Lineage Hops |
      | Default     | Function  | Metadata Type | createBucketNE        | Lineage Hops |
      | Default     | Function  | Metadata Type | deleteBucketNE        | Lineage Hops |
      | Default     | Function  | Metadata Type | deleteObjectNE        | Lineage Hops |
      | Default     | Function  | Metadata Type | getObjectNE           | Lineage Hops |
      | Default     | Function  | Metadata Type | putObjectNE           | Lineage Hops |
      | Default     | Function  | Metadata Type | s3UploadDirectoryNE   | Lineage Hops |
      | Default     | Function  | Metadata Type | s3DownloadDirectoryNE | Lineage Hops |
#    And user should be able logoff the IDC

  ############################################# Technology tags verification #############################################
  @webtest @MLP-13379 @sanity @positive
  Scenario: SC#12:Tech_tags_Explicit_Tags verification: Verify the technology tags, Business Application, Explicit tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                              | fileName                 | userTag          |
      | Default     | Project    | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Git,Java  | javaspark_lineage        | tagJavaS3Lineage |
      | Default     | Service    | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Amazon S3 | AmazonS3                 | tagJavaS3Lineage |
      | Default     | Cluster    | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Amazon S3 | amazonaws.com            | tagJavaS3Lineage |
      | Default     | Namespace  | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Java      | com                      | tagJavaS3Lineage |
      | Default     | Directory  | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Amazon S3 | asgcoms3primarybucket    | tagJavaS3Lineage |
      | Default     | SourceTree | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Java      | HandleMultipleS3API      | tagJavaS3Lineage |
      | Default     | Class      | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Java      | HandleMultipleS3API      | tagJavaS3Lineage |
      | Default     | Function   | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Java,S3   | handleMultipleAPIs       | tagJavaS3Lineage |
      | Default     | Function   | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Java      | deleteBucketNE           | tagJavaS3Lineage |
      | Default     | File       | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Git,Java  | HandleMultipleS3API.java | tagJavaS3Lineage |
      | Default     | File       | Metadata Type | tagJavaS3Lineage,test_BA_JavaS3Lineage,Amazon S3 | UploadedS3File.txt       | tagJavaS3Lineage |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                        | fileName                 | userTag          |
      | Default     | File | Metadata Type | Programming,Source Control | HandleMultipleS3API.java | tagJavaS3Lineage |

#  ############################################# EDIBusVerification #############################################
#  @sanity @positive @webtest @edibus
#  Scenario: SC#13:EDIBusVerification: Verify EDI replication for items collected using JavaS3Lineage
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "tagJavaS3Lineage" and clicks on search
#    And user performs "facet selection" in "tagJavaS3Lineage" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Technology" attribute under "Tags" facets in Item Search results page
#    And user "verify displayed" for listed "Metadata Type" facet in Search results page
#      | Project    |
#      | Service    |
#      | Cluster    |
#      | Namespace  |
#      | Analysis   |
#      | Directory  |
#      | SourceTree |
#      | Class      |
#      | Function   |
#      | File       |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | JAVAS3      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/JavaS3LineageConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                               | body                                        | response code | response message | jsonPath                                          |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/JavaS3LineageConfig.json | 204           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaS3 |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaS3')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJavaS3  |                                             | 200           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaS3 |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaS3')].status |
#    And user enters the search text "EDIBusJavaS3" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "dynamic item click" on "EDIBusJavaS3" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | LineageHop                                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                             | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=tagJavaS3Lineage&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                |
#      | AP-DATA      | JAVAS3      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) |
#    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemName           | itemType                   | attributeName | attributeValue                    |
#      | AP-DATA      | JAVAS3      | 1.0                | @*SourceFile.txt@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | ProxyFor≫CopiedFile.txt           |
#      | AP-DATA      | JAVAS3      | 1.0                | @*SourceFile.txt@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | ProxyFor≫SourceFile.txt           |
#      | AP-DATA      | JAVAS3      | 1.0                | @*DownloadDir@*    | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | File≫/C:/Java/S3_Lineage_Download |
#      | AP-DATA      | JAVAS3      | 1.0                | @*DownloadDir@*    | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | DownloadDir                       |

  ############################################# Post Conditions ##########################################################
  @aws @MLP-13379 @cr-data @sanity
  Scenario: SC#14:DeleteBucket: Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "JavaFiles" in bucket "asgcoms3primarybucket"
    Then user "Delete" a bucket "asgcoms3primarybucket" in amazon storage service

  ###########ItemDeletion##########
  Scenario Outline: SC#14:ItemDeletion- User deletes the collected item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                    | inputFile                                       |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                | response/java/javaS3Lineage/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..AmazonS3_Cluster.id       | response/java/javaS3Lineage/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                 | response/java/javaS3Lineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id           | response/java/javaS3Lineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..AmazonS3_Analysis.id      | response/java/javaS3Lineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id       | response/java/javaS3Lineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JIOLinker_Analysis.id     | response/java/javaS3Lineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaS3Lineage_Analysis.id | response/java/javaS3Lineage/actual/itemIds.json |

  ###########ConfigDeletion##########
  @MLP-13379 @sanity @positive @regression
  Scenario Outline: SC#14:ConfigDeletion: Delete the Plugin configurations for Git, Amazon S3 Cataloger, Java Parser , Java IO Linker and Java S3 Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                          | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_Credentials         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3DataSource        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3Cataloger         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaIOLinker              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaS3Lineage             |      | 204           |                  |          |
