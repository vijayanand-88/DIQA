Feature: Validation of Java Redshift Lineage plugin functionality after running all prerequisite plugins (Amazon S3 JSON cataloger)

  ############################################# Pre Conditions ##########################################################
  @git @aws @amazonredshift @precondition
  Scenario: SC#1:UpdateCredentials:  Update credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                                    | username    | password    |
      | ida/javaRedshiftPayloads/credentials/javaRedshift_git_validCredentials.json | $..userName | $..password |
    And User update the below "aws credentials" in following files using json path
      | filePath                                                                    | accessKeyPath | secretKeyPath |
      | ida/javaRedshiftPayloads/credentials/javaRedshift_aws_validCredentials.json | $..accessKey  | $..secretKey  |
    And User update the below "redshift credentials" in following files using json path
      | filePath                                                                         | username    | password    |
      | ida/javaRedshiftPayloads/credentials/javaRedshift_redshift_validCredentials.json | $..userName | $..password |

  @cr-data @sanity @aws
  Scenario: SC#1:CreateBucket: Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgredshifttest" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName      | keyPrefix                | dirPath                                | recursive |
      | asgredshifttest | javaredshiftlineage/json | ida/javaRedShiftPayloads/TestData/json | true      |

  @sanity @positive @regression
  Scenario Outline: SC#1:SetValidCredentials: Set the valid credentials for GitCollector, JsonS3Cataloger, AmazonRedshiftCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                           | body                                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentials      | ida/javaRedshiftPayloads/credentials/javaRedshift_git_validCredentials.json      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidGitCredentials      |                                                                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_Credentials          | ida/javaRedshiftPayloads/credentials/javaRedshift_aws_validCredentials.json      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/AWS_Credentials          |                                                                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidRedshiftCredentials | ida/javaRedshiftPayloads/credentials/javaRedshift_redshift_validCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidRedshiftCredentials |                                                                                  | 200           |                  |          |

  #7083641#
  @sanity @positive @regression
  Scenario Outline: SC#1:BusinessApplication: Create BusinessApplication tag and run the plugin configuration with this new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaRedshiftPayloads/javaRedshift_BusinessApplication.json | 200           |                  |          |

  ############################################# PluginRun ##########################################################
  @MLP-11111 @sanity @positive @regression
  Scenario Outline: SC#3_PluginRun: Run the Plugin configurations for Git, JsonS3Cataloger, AmazonRedshiftCataloger, JavaParser
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                | response code | response message       | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                 | ida/javaRedShiftPayloads/javaRedshift_git_datasource.json           | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                                 |                                                                     | 200           | GitCollectorDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/javaRedShiftPayloads/javaRedshift_git.json                      | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                           |                                                                     | 200           | GitCollectorJava       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJava             |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='GitCollectorJava')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJava              | ida/javaRedShiftPayloads/empty.json                                 | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJava             |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='GitCollectorJava')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource                                                       | ida/javaRedShiftPayloads/javaRedshift_awsS3DataSource.json          | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3DataSource                                                       |                                                                     | 200           | S3DataSource           |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                                        | ida/javaRedShiftPayloads/javaRedshift_jsonS3Cataloger.json          | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger                                                        |                                                                     | 200           | JsonS3Cataloger        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger           |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JsonS3Cataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger            | ida/javaRedShiftPayloads/empty.json                                 | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger           |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JsonS3Cataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/javaRedShiftPayloads/javaRedshift_amazonRedshiftDataSource.json | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                                     | 200           | RedshiftDataSource     |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/javaRedShiftPayloads/javaRedshift_amazonRedshiftCataloger.json  | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                     | 200           | RedshiftCataloger      |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedshiftCataloger |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='RedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedshiftCataloger  | ida/javaRedShiftPayloads/empty.json                                 | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedshiftCataloger |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='RedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                                             | ida/javaRedShiftPayloads/javaRedshift_parser.json                   | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                                             |                                                                     | 200           | JavaRSParser           |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaRSParser                      |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JavaRSParser')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaRSParser                       | ida/javaRedShiftPayloads/empty.json                                 | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaRSParser                      |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JavaRSParser')].status      |

  ############################################# PluginRun - DryRunTrue ##########################################################
  @MLP-11111 @sanity @positive @regression
  Scenario Outline: SC#4:PluginDryRun: Run the Plugin configurations for JavaRedshiftLineage with dryRun as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                      | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaRedshiftLineage                                                | ida/JavaRedShiftPayloads/javaRedshift_javaredshiftlineage_dryRunTrue.json | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaRedshiftLineage                                                |                                                                           | 200           | JavaRedshiftLineage |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage |                                                                           | 200           | IDLE                | $.[?(@.configurationName=='JavaRedshiftLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage  | ida/javaRedShiftPayloads/empty.json                                       | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage |                                                                           | 200           | IDLE                | $.[?(@.configurationName=='JavaRedshiftLineage')].status |

  Scenario Outline: SC#4:RetrieveItemID: User retrieves the item ids of analysis of RedshiftLineage and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                | type | targetFile                                            | jsonpath                        |
      | APPDBPOSTGRES | Default | lineage/JavaRedshiftLineage/JavaRedshiftLineage%DYN |      | response/java/javaRedshiftLineage/actual/itemIds.json | $..JRedshiftLineage_Analysis.id |

  #7083641#
  @webtest @MLP-11924 @sanity @positive
  Scenario: SC#4:UI_Validation: Verify JavaRedshiftLineage plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagRedshiftJsonDryRunTrue" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaRedshiftLineage/JavaRedshiftLineage%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 11            | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaRedshiftLineage/JavaRedshiftLineage%" should display below info/error/warning
      | type | logValue                                           | logCode       | pluginName | removableText |
      | INFO | Plugin JavaRedshiftLineage running on dry run mode | ANALYSIS-0069 |            |               |

  Scenario Outline: SC#4:ItemDeletion: User deletes the JavaRedshiftLineage analysis item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                       | inputFile                                             |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JRedshiftLineage_Analysis.id | response/java/javaRedshiftLineage/actual/itemIds.json |

  ############################################# PluginRun ##########################################################
  @MLP-11111 @sanity @positive @regression
  Scenario Outline: SC#3:PluginRun: Run the Plugin configurations for JavaRedshiftLineage with dryRun as false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                           | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaRedshiftLineage                                                | ida/JavaRedShiftPayloads/javaRedshift_javaredshiftlineage.json | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaRedshiftLineage                                                |                                                                | 200           | JavaRedshiftLineage |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage |                                                                | 200           | IDLE                | $.[?(@.configurationName=='JavaRedshiftLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage  | ida/javaRedShiftPayloads/empty.json                            | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage |                                                                | 200           | IDLE                | $.[?(@.configurationName=='JavaRedshiftLineage')].status |

  Scenario Outline: SC#3:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type    | targetFile                                            | jsonpath                        |
      | APPDBPOSTGRES | Default | javaspark_lineage                                                | Project | response/java/javaRedshiftLineage/actual/itemIds.json | $..Project.id                   |
      | APPDBPOSTGRES | Default | amazonaws.com                                                    |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..JsonS3_Cluster.id            |
      | APPDBPOSTGRES | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..Redshift_Cluster.id          |
      | APPDBPOSTGRES | Default | test_BA_JavaRedshiftLineage                                      |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..has_BA.id                    |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJava%DYN                      |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..Git_Analysis.id              |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN                    |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..JsonS3_Analysis.id           |
      | APPDBPOSTGRES | Default | cataloger/AmazonRedshiftCataloger/RedshiftCataloger%DYN          |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..Redshift_Analysis.id         |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaRSParser%DYN                               |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..JParser_Analysis.id          |
      | APPDBPOSTGRES | Default | lineage/JavaRedshiftLineage/JavaRedshiftLineage%DYN              |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..JRedshiftLineage_Analysis.id |

  ############################################# LoggingEnhancements #############################################
  #7083641#
  @sanity @positive @MLP-11924 @webtest
  Scenario: SC#5 Verify JavaRedshiftLineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaRedshiftLineage/JavaRedshiftLineage%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 5             | Description |
      | Number of errors          | 11            | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | autoMappingExactMatch   |
      | autoMappingPartialMatch |
      | customMappingJsonArrays |
      | customMappingJsonData   |
      | twoCopyStatement        |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaRedshiftLineage/JavaRedshiftLineage%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:JavaRedshiftLineage, Plugin Type:lineage, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:12adcf3b1536, Plugin Configuration name:JavaRedshiftLineage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0071 | JavaRedshiftLineage | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: ---  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: name: "JavaRedshiftLineage"  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: pluginVersion: "LATEST"  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: label:  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: : "JavaRedshiftLineage"  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: catalogName: "Default"  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: eventClass: null  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: eventCondition: null  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: nodeCondition: "name==\"LocalNode\""  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: maxWorkSize: 100  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: tags:  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: - "tagRedshiftJson"  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: pluginType: "lineage"  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: dataSource: null  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: credential: null  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: businessApplicationName: "test_BA_JavaRedshiftLineage"  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: dryRun: false  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: schedule: null  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: runAfter: []  2020-08-14 09:04:09.445 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: filter: null | ANALYSIS-0073 | JavaRedshiftLineage |                |
      | INFO | Plugin JavaRedshiftLineage Start Time:2020-03-19 10:03:53.666, End Time:2020-03-19 10:03:55.848, Processed Count:5, Errors:11, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0072 | JavaRedshiftLineage |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0020 |                     |                |

  ############################################# API Lineage verification #############################################
  @MLP-11111 @sanity @positive
  Scenario Outline:SC#6:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                    | asg_scopeid | targetFile                                                             | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | AutoMappingExactMatch   |             | response/java/javaRedshiftLineage/Lineage/AutoMappingExactMatch.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | autoMappingExactMatch   |             | response/java/javaRedshiftLineage/Lineage/AutoMappingExactMatch.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                         |             | response/java/javaRedshiftLineage/Lineage/AutoMappingExactMatch.json   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | AutoMappingPartialMatch |             | response/java/javaRedshiftLineage/Lineage/AutoMappingPartialMatch.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | autoMappingPartialMatch |             | response/java/javaRedshiftLineage/Lineage/AutoMappingPartialMatch.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                         |             | response/java/javaRedshiftLineage/Lineage/AutoMappingPartialMatch.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | CustomMappingJsonArrays |             | response/java/javaRedshiftLineage/Lineage/CustomMappingJsonArrays.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | customMappingJsonArrays |             | response/java/javaRedshiftLineage/Lineage/CustomMappingJsonArrays.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                         |             | response/java/javaRedshiftLineage/Lineage/CustomMappingJsonArrays.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | CustomMappingJsonData   |             | response/java/javaRedshiftLineage/Lineage/CustomMappingJsonData.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | customMappingJsonData   |             | response/java/javaRedshiftLineage/Lineage/CustomMappingJsonData.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                         |             | response/java/javaRedshiftLineage/Lineage/CustomMappingJsonData.json   | $.functionID |

  @MLP-11111 @sanity @positive
  Scenario Outline: SC#6:API Lineage From To retrieval: user retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                    | inputFile                                                              | outputFile                                                                     |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoMappingExactMatch   | response/java/javaRedshiftLineage/Lineage/AutoMappingExactMatch.json   | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoMappingPartialMatch | response/java/javaRedshiftLineage/Lineage/AutoMappingPartialMatch.json | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | CustomMappingJsonArrays | response/java/javaRedshiftLineage/Lineage/CustomMappingJsonArrays.json | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | CustomMappingJsonData   | response/java/javaRedshiftLineage/Lineage/CustomMappingJsonData.json   | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |

  #6703344# #6702261# #6703347#
  @MLP-11111 @sanity @positive
  Scenario Outline: SC#6:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                     | actual_json                                                                                      | item                    |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | AutoMappingExactMatch   |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | AutoMappingPartialMatch |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | CustomMappingJsonArrays |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | CustomMappingJsonData   |

  ############################################# UI Validation #############################################
  @sanity @positive @MLP-11924 @webtest
  Scenario: SC#7 Verify facet counts appears properly for the items collected by Git, JsonS3Cataloger, AmazonRedshiftCataloger, JavaParser and JavaRedshiftLineage
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType  | count |
      | Project    | 1     |
      | Table      | 1     |
      | Schema     | 1     |
      | Host       | 1     |
      | Database   | 1     |
      | Service    | 2     |
      | Cluster    | 2     |
      | Namespace  | 3     |
      | Column     | 4     |
      | Analysis   | 5     |
      | Directory  | 5     |
      | SourceTree | 12    |
      | Class      | 12    |
      | Function   | 12    |
      | Field      | 16    |
      | File       | 18    |

#6702261#
  @webtest @MLP-11111 @sanity @positive
  Scenario: SC#8: UI Lineage verification - Verify the JavaRedshiftLineage plugin generates lineage for the java file stored in Git repository when column mapping is 'auto' (exact match of fields in json with columns in table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "autoMappingExactMatch" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                               | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                  | jsonPath       |
      | Lineage Hops | category_object_auto_exact.json => catname => category => catname   | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop_1 |
      | Lineage Hops | category_object_auto_exact.json => catid => category => catid       | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop_2 |
      | Lineage Hops | category_object_auto_exact.json => catdesc => category => catdesc   | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop_3 |
      | Lineage Hops | category_object_auto_exact.json => catgroup => category => catgroup | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop_4 |


  #6703344#
  @webtest @MLP-11111 @sanity @positive
  Scenario: SC#9:Verify the JavaRedshiftLineage plugin generates lineage for the java file stored in Git repository when json data is loaded using custom column mapping
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CustomMappingJsonData" item from search results
    Then user performs click and verify in new window
      | Table          | value                                  | Action                 | RetainPrevwindow | indexSwitch |
      | Functions      | customMappingJsonData                  | click and switch tab   | No               |             |
      | Lineage Hops   | category_object_paths.json => category | verify widget contains |                  |             |
      | Lineage Hops   | category_object_paths.json => category | click and switch tab   | No               |             |
      | Lineage Source | category_object_paths.json             | verify widget contains |                  |             |
      | Lineage Target | category                               | verify widget contains |                  |             |
    And user should be able logoff the IDC

  #6702261#
  @webtest @MLP-11111 @sanity @positive
  Scenario: SC#10:Verify the JavaRedshiftLineage plugin generates lineage for the java file stored in Git repository when column mapping is 'auto' (exact match of fields in json with columns in table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AutoMappingExactMatch" item from search results
    Then user performs click and verify in new window
      | Table          | value                                                               | Action                 | RetainPrevwindow | indexSwitch |
      | Functions      | autoMappingExactMatch                                               | click and switch tab   | No               |             |
      | Lineage Hops   | category_object_auto_exact.json => catname => category => catname   | verify widget contains |                  |             |
      | Lineage Hops   | category_object_auto_exact.json => catid => category => catid       | verify widget contains |                  |             |
      | Lineage Hops   | category_object_auto_exact.json => catdesc => category => catdesc   | verify widget contains |                  |             |
      | Lineage Hops   | category_object_auto_exact.json => catgroup => category => catgroup | verify widget contains |                  |             |
      | Lineage Hops   | category_object_auto_exact.json => catname => category => catname   | click and switch tab   | No               |             |
      | Lineage Source | catname                                                             | verify widget contains |                  |             |
      | Lineage Target | catname                                                             | verify widget contains |                  |             |
    And user should be able logoff the IDC

  #6703324#
  @webtest @MLP-11111 @sanity @positive
  Scenario: SC#11:Verify the JavaRedshiftLineage plugin generates lineage for the java file stored in Git repository when column mapping is 'auto' (partial match of fields in json with columns in table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AutoMappingPartialMatch" item from search results
    Then user performs click and verify in new window
      | Table          | value                                                               | Action                 | RetainPrevwindow | indexSwitch |
      | Functions      | autoMappingPartialMatch                                             | click and switch tab   | No               |             |
      | Lineage Hops   | category_object_auto_partial.json => catname => category => catname | verify widget contains |                  |             |
      | Lineage Hops   | category_object_auto_partial.json => catid => category => catid     | verify widget contains |                  |             |
      | Lineage Hops   | category_object_auto_partial.json => catdesc => category => catdesc | verify widget contains |                  |             |
      | Lineage Hops   | category_object_auto_partial.json => catname => category => catname | click and switch tab   | No               |             |
      | Lineage Source | catname                                                             | verify widget contains |                  |             |
      | Lineage Target | catname                                                             | verify widget contains |                  |             |
    And user should be able logoff the IDC

  #6703347#
  @webtest @MLP-11111 @sanity @positive
  Scenario: SC#12:(File to Table) Verify the JavaRedshiftLineage plugin generates lineage for the java file stored in Git repository when json arrays is loaded using custom column mapping
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CustomMappingJsonArrays" item from search results
    Then user performs click and verify in new window
      | Table          | value                                | Action                 | RetainPrevwindow | indexSwitch |
      | Functions      | customMappingJsonArrays              | click and switch tab   | No               |             |
      | Lineage Hops   | category_array_data.json => category | verify widget contains |                  |             |
      | Lineage Hops   | category_array_data.json => category | click and switch tab   | No               |             |
      | Lineage Source | category_array_data.json             | verify widget contains |                  |             |
      | Lineage Target | category                             | verify widget contains |                  |             |
    And user should be able logoff the IDC

  #6703350# #6703353# #6703354#
  @webtest @MLP-11111 @negative
  Scenario: SC#13:Verify the JavaRedshiftLineage plugin doesn't generates lineage for the below cases
  1. Lineage is not generated for the java file stored in Git repository when redshift database URL is invalid
  2. Lineage is not generated for the java file stored in Git repository when Oracle database URL is passed as JDBC URL
  3. Lineage is not generated for the java file stored in Git repository when hostname in database URL is invalid
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName         | windowName   |
      | Default     | Function  | Metadata Type | invalidURL       | Lineage Hops |
      | Default     | Function  | Metadata Type | invalidURLFormat | Lineage Hops |
      | Default     | Function  | Metadata Type | invalidHostname  | Lineage Hops |
    And user should be able logoff the IDC

  #6703355# #6703356# #6703358# #6703359#
  @webtest  @MLP-11111 @negative
  Scenario: SC#14:Verify the JavaRedshiftLineage plugin doesn't generates lineage for the invalid cases below
  1. Lineage is not generated for the java file stored in Git repository when database in database URL is invalid
  2. Lineage is not generated for the java file stored in Git repository when table used in copy statement is non-existing
  3. Lineage is not generated for the java file stored in Git repository when json file available in S3 used in copy statement is non-existing
  4. Lineage is not generated for the java file stored in Git repository when select statement is used instead of copy statement
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName                   | windowName   |
      | Default     | Function  | Metadata Type | invalidDatabase            | Lineage Hops |
      | Default     | Function  | Metadata Type | nonExistingTable           | Lineage Hops |
      | Default     | Function  | Metadata Type | nonExistingJsonFile        | Lineage Hops |
      | Default     | Function  | Metadata Type | selectStatementInsteadCopy | Lineage Hops |
    And user should be able logoff the IDC

  #6979138#
  @webtest @MLP-19204 @sanity @positive
  Scenario: SC#: UI Lineage verification - Verify the JavaRedshiftLineage plugin displays exact sequence Number for fields and columns
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "category" item from search results
    Then the following field/column should have the specified sequence number
      | dynamicTable | itemName | sequenceNumber |
      | Columns      | catid    | 1              |
      | Columns      | catgroup | 2              |
      | Columns      | catname  | 3              |
      | Columns      | catdesc  | 4              |
    And user enters the search text "tagRedshiftJson" and clicks on search
    And user performs "facet selection" in "tagRedshiftJson" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "category_object_auto_partial.json" item from search results
    Then the following field/column should have the specified sequence number
      | dynamicTable | itemName      | sequenceNumber |
      | Fields       | catdesc       | 1              |
      | Fields       | catid         | 2              |
      | Fields       | categorygroup | 3              |
      | Fields       | contact       | 4              |
      | Fields       | catname       | 5              |

  ############################################# Technology tags verification #############################################
  #7083641#
  @webtest @MLP-11876 @sanity @positive
  Scenario: SC#15:Tech_tags_Explicit_Tags verification: Verify the technology tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                       | fileName                          | userTag         |
      | Default     | Project    | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Git,Java      | javaspark_lineage                 | tagRedshiftJson |
      | Default     | Table      | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Redshift      | category                          | tagRedshiftJson |
      | Default     | Schema     | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Redshift      | demo                              | tagRedshiftJson |
      | Default     | Database   | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Redshift      | world                             | tagRedshiftJson |
      | Default     | Service    | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Redshift      | AmazonRedshift                    | tagRedshiftJson |
      | Default     | Service    | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,JSON          | AmazonS3                          | tagRedshiftJson |
      | Default     | Cluster    | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,JSON          | amazonaws.com                     | tagRedshiftJson |
      | Default     | Namespace  | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Java          | com                               | tagRedshiftJson |
      | Default     | Column     | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Redshift      | catid                             | tagRedshiftJson |
      | Default     | Directory  | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,JSON          | asgredshifttest                   | tagRedshiftJson |
      | Default     | SourceTree | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Java          | AutoMappingExactMatch             | tagRedshiftJson |
      | Default     | Class      | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Java          | AutoMappingExactMatch             | tagRedshiftJson |
      | Default     | Function   | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Java,Redshift | autoMappingExactMatch             | tagRedshiftJson |
      | Default     | Function   | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Java          | invalidDatabase                   | tagRedshiftJson |
      | Default     | Field      | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,JSON          | contact                           | tagRedshiftJson |
      | Default     | File       | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,Git,Java      | AutoMappingExactMatch.java        | tagRedshiftJson |
      | Default     | File       | Metadata Type | tagRedshiftJson,test_BA_JavaRedshiftLineage,JSON          | category_object_auto_partial.json | tagRedshiftJson |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                        | fileName                   | userTag         |
      | Default     | File | Metadata Type | Programming,Source Control | AutoMappingExactMatch.java | tagRedshiftJson |

  ############################################# Post Conditions ##########################################################
  @aws @cr-data @sanity
  Scenario:SC#16:DeleteBucket: Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "javaredshiftlineage" in bucket "asgredshifttest"
    Then user "Delete" a bucket "asgredshifttest" in amazon storage service

  Scenario Outline: SC#16:ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                       | inputFile                                             |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                   | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..JsonS3_Cluster.id            | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Redshift_Cluster.id          | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                    | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id              | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JsonS3_Analysis.id           | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Redshift_Analysis.id         | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id          | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JRedshiftLineage_Analysis.id | response/java/javaRedshiftLineage/actual/itemIds.json |

  @MLP-11111 @sanity @positive @regression
  Scenario Outline: SC#16:ConfigDeletion: Delete the Plugin configurations for Git, JsonS3Cataloger, AmazonRedshiftCataloger, JavaParser and JavaRedshiftLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                           | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentials      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_Credentials          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidRedshiftCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JsonS3DataSource           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JsonS3Cataloger            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftDataSource   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftCataloger    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaRedshiftLineage        |      | 204           |                  |          |