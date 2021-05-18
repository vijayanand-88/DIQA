Feature: Validation of Java Redshift Lineage plugin functionality after running all prerequisite plugins (Amazon S3 CSV cataloger)

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

  @cr-data @sanity
  Scenario: SC#1:CreateBucket: Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgredshifttest" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName      | keyPrefix               | dirPath                               | recursive |
      | asgredshifttest | javaredshiftlineage/csv | ida/javaRedShiftPayloads/TestData/csv | true      |

  @sanity @positive @regression
  Scenario Outline: SC#1:SetValidCredentials: Set the valid credentials for GitCollector, CsvS3Cataloger, AmazonRedshiftCataloger
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
  @MLP-11924 @sanity @positive @regression
  Scenario Outline: SC#3_PluginRun: Run the Plugin configurations for Git , Amazon S3 Cataloger, CSV S3 Cataloger, Amazon RedShift Cataloger, Java Parser, Java RedShift Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message       | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                 | ida/javaRedShiftPayloads/javaRedshift_git_datasource.json             | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                                 |                                                                       | 200           | GitCollectorDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/javaRedShiftPayloads/javaRedshiftCSV_git.json                     | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                           |                                                                       | 200           | GitCollectorJava       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJava             |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='GitCollectorJava')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJava              | ida/javaRedShiftPayloads/empty.json                                   | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJava             |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='GitCollectorJava')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                     | ida/javaRedShiftPayloads/javaRedshift_awsS3DataSource.json            | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                     |                                                                       | 200           | S3DataSource           |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                      | ida/javaRedShiftPayloads/javaRedshift_AmazonS3Cataloger.json          | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                      |                                                                       | 200           | AmazonS3Cataloger      |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger       |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger        | ida/javaRedShiftPayloads/empty.json                                   | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger       |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3DataSource                                                        | ida/javaRedShiftPayloads/javaRedshift_csvS3DataSource.json            | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3DataSource                                                        |                                                                       | 200           | CsvS3DataSource        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                                         | ida/javaRedShiftPayloads/javaRedshift_csvS3Cataloger.json             | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                                         |                                                                       | 200           | CsvS3Cataloger         |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger             |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='CsvS3Cataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger              | ida/javaRedShiftPayloads/empty.json                                   | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger             |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='CsvS3Cataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/javaRedShiftPayloads/javaRedshift_amazonRedshiftDataSource.json   | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                                       | 200           | RedshiftDataSource     |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/javaRedShiftPayloads/javaRedshift_amazonRedshiftCatalogerCsv.json | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                       | 200           | RedshiftCataloger      |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedshiftCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='RedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedshiftCataloger  | ida/javaRedShiftPayloads/empty.json                                   | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedshiftCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='RedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                                             | ida/javaRedShiftPayloads/javaRedshift_parserCsv.json                  | 204           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                                             |                                                                       | 200           | JavaRSParser           |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaRSParser                      |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='JavaRSParser')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaRSParser                       | ida/javaRedShiftPayloads/empty.json                                   | 200           |                        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaRSParser                      |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='JavaRSParser')].status      |

  ############################################# PluginRun - DryRunTrue ##########################################################
  @MLP-11111 @sanity @positive @regression
  Scenario Outline: SC#4:PluginDryRun: Run the Plugin configurations for JavaRedshiftLineage with dryRun as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                         | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaRedshiftLineage                                                | ida/JavaRedShiftPayloads/javaRedshift_javaredshiftlineageCsv_dryRunTrue.json | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaRedshiftLineage                                                |                                                                              | 200           | JavaRedshiftLineage |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage |                                                                              | 200           | IDLE                | $.[?(@.configurationName=='JavaRedshiftLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage  | ida/javaRedShiftPayloads/empty.json                                          | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage |                                                                              | 200           | IDLE                | $.[?(@.configurationName=='JavaRedshiftLineage')].status |

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
    And user enters the search text "tagRedshiftCsvDryRunTrue" and clicks on search
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
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                              | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaRedshiftLineage                                                | ida/JavaRedShiftPayloads/javaRedshift_javaredshiftlineageCsv.json | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaRedshiftLineage                                                |                                                                   | 200           | JavaRedshiftLineage |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage |                                                                   | 200           | IDLE                | $.[?(@.configurationName=='JavaRedshiftLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage  | ida/javaRedShiftPayloads/empty.json                               | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaRedshiftLineage/JavaRedshiftLineage |                                                                   | 200           | IDLE                | $.[?(@.configurationName=='JavaRedshiftLineage')].status |

  Scenario Outline: SC#3:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type    | targetFile                                            | jsonpath                        |
      | APPDBPOSTGRES | Default | javaspark_lineage                                                | Project | response/java/javaRedshiftLineage/actual/itemIds.json | $..Project.id                   |
      | APPDBPOSTGRES | Default | amazonaws.com                                                    |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..S3_Cluster.id                |
      | APPDBPOSTGRES | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..Redshift_Cluster.id          |
      | APPDBPOSTGRES | Default | test_BA_JavaRedshiftLineage                                      |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..has_BA.id                    |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJava%DYN                      |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..Git_Analysis.id              |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger%DYN                      |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..CsvS3_Analysis.id            |
      | APPDBPOSTGRES | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger%DYN                |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..AmazonS3_Analysis.id         |
      | APPDBPOSTGRES | Default | cataloger/AmazonRedshiftCataloger/RedshiftCataloger%DYN          |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..Redshift_Analysis.id         |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaRSParser%DYN                               |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..JParser_Analysis.id          |
      | APPDBPOSTGRES | Default | lineage/JavaRedshiftLineage/JavaRedshiftLineage%DYN              |         | response/java/javaRedshiftLineage/actual/itemIds.json | $..JRedshiftLineage_Analysis.id |

  ############################################# LoggingEnhancements #############################################
  #7083641#
  @sanity @positive @MLP-11924 @webtest
  Scenario: SC#5 Verify JavaRedshiftLineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "lineage" and clicks on search
    And user performs "facet selection" in "tagRedshiftCsv" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cloud Data" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaRedshiftLineage/JavaRedshiftLineage%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 8             | Description |
      | Number of errors          | 11            | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | fieldToColumnCsv                  |
      | fieldToColumnCsvWithoutHeaders    |
      | fieldToColumnCsv_unOrderedHeaders |
      | twoCopyStatement                  |
      | validCsvDefaultQuote              |
      | validCsvPercentageQuote           |
      | validImageFileDefaultQuote        |
      | validTextFileDefaultQuote         |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaRedshiftLineage/JavaRedshiftLineage/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:JavaRedshiftLineage, Plugin Type:lineage, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:12adcf3b1536, Plugin Configuration name:JavaRedshiftLineage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0071 | JavaRedshiftLineage | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: ---  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: name: "JavaRedshiftLineage"  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: pluginVersion: "LATEST"  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: label:  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: : "JavaRedshiftLineage"  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: catalogName: "Default"  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: eventClass: null  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: eventCondition: null  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: nodeCondition: null  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: maxWorkSize: 100  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: tags:  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: - "tagRedshiftCsv"  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: pluginType: "lineage"  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: dataSource: null  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: credential: null  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: businessApplicationName: "test_BA_JavaRedshiftLineage"  2020-08-14 06:25:14.314 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: dryRun: false  2020-08-14 06:25:14.315 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: schedule: null  2020-08-14 06:25:14.315 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: runAfter: []  2020-08-14 06:25:14.315 INFO  - ANALYSIS-0073: Plugin JavaRedshiftLineage Configuration: filter: null | ANALYSIS-0073 | JavaRedshiftLineage |                |
      | INFO | Plugin JavaRedshiftLineage Start Time:2020-03-19 10:03:53.666, End Time:2020-03-19 10:03:55.848, Processed Count:8, Errors:11, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0072 | JavaRedshiftLineage |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0020 |                     |                |

  ############################################# API Lineage verification #############################################
  @MLP-11924 @sanity @positive
  Scenario Outline:SC6:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                              | asg_scopeid | targetFile                                                                       | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | ValidCsvDefaultQuote              |             | response/java/javaRedshiftLineage/Lineage/ValidCsvDefaultQuote.json              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | validCsvDefaultQuote              |             | response/java/javaRedshiftLineage/Lineage/ValidCsvDefaultQuote.json              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                   |             | response/java/javaRedshiftLineage/Lineage/ValidCsvDefaultQuote.json              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | ValidCsvPercentageQuote           |             | response/java/javaRedshiftLineage/Lineage/ValidCsvPercentageQuote.json           |              |
      | APPDBPOSTGRES | FunctionID | Default |            | validCsvPercentageQuote           |             | response/java/javaRedshiftLineage/Lineage/ValidCsvPercentageQuote.json           |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                   |             | response/java/javaRedshiftLineage/Lineage/ValidCsvPercentageQuote.json           | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | ValidImageFileDefaultQuote        |             | response/java/javaRedshiftLineage/Lineage/ValidImageFileDefaultQuote.json        |              |
      | APPDBPOSTGRES | FunctionID | Default |            | validImageFileDefaultQuote        |             | response/java/javaRedshiftLineage/Lineage/ValidImageFileDefaultQuote.json        |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                   |             | response/java/javaRedshiftLineage/Lineage/ValidImageFileDefaultQuote.json        | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | ValidTextFileDefaultQuote         |             | response/java/javaRedshiftLineage/Lineage/ValidTextFileDefaultQuote.json         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | validTextFileDefaultQuote         |             | response/java/javaRedshiftLineage/Lineage/ValidTextFileDefaultQuote.json         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                   |             | response/java/javaRedshiftLineage/Lineage/ValidTextFileDefaultQuote.json         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FieldToColumnCsv                  |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsv.json                  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fieldToColumnCsv                  |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsv.json                  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                   |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsv.json                  | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FieldToColumnCsv_unOrderedHeaders |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsv_unOrderedHeaders.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fieldToColumnCsv_unOrderedHeaders |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsv_unOrderedHeaders.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                   |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsv_unOrderedHeaders.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FieldToColumnCsvWithoutHeaders    |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsvWithoutHeaders.json    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fieldToColumnCsvWithoutHeaders    |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsvWithoutHeaders.json    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                   |             | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsvWithoutHeaders.json    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TwoCopyStatement                  |             | response/java/javaRedshiftLineage/Lineage/TwoCopyStatement.json                  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | twoCopyStatement                  |             | response/java/javaRedshiftLineage/Lineage/TwoCopyStatement.json                  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                   |             | response/java/javaRedshiftLineage/Lineage/TwoCopyStatement.json                  | $.functionID |

  @MLP-11924 @sanity @positive
  Scenario Outline: SC6:API Lineage From To retrieval: user retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                              | inputFile                                                                        | outputFile                                                                     |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | ValidCsvDefaultQuote              | response/java/javaRedshiftLineage/Lineage/ValidCsvDefaultQuote.json              | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | ValidCsvPercentageQuote           | response/java/javaRedshiftLineage/Lineage/ValidCsvPercentageQuote.json           | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | ValidImageFileDefaultQuote        | response/java/javaRedshiftLineage/Lineage/ValidImageFileDefaultQuote.json        | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | ValidTextFileDefaultQuote         | response/java/javaRedshiftLineage/Lineage/ValidTextFileDefaultQuote.json         | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FieldToColumnCsv                  | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsv.json                  | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FieldToColumnCsv_unOrderedHeaders | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsv_unOrderedHeaders.json | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FieldToColumnCsvWithoutHeaders    | response/java/javaRedshiftLineage/Lineage/FieldToColumnCsvWithoutHeaders.json    | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TwoCopyStatement                  | response/java/javaRedshiftLineage/Lineage/TwoCopyStatement.json                  | response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json |

  #6712969# #6712984# #6712985# #6712986# #6713001#
  @MLP-11924 @sanity @positive
  Scenario Outline: SC6:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                     | actual_json                                                                                      | item                              |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | ValidCsvDefaultQuote              |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | ValidCsvPercentageQuote           |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | ValidImageFileDefaultQuote        |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | ValidTextFileDefaultQuote         |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | FieldToColumnCsv                  |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | FieldToColumnCsv_unOrderedHeaders |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | FieldToColumnCsvWithoutHeaders    |
      | ida/JavaRedShiftPayloads/LineageMetadata/expectedJavaRedshiftLineageMetadata.json | Constant.REST_DIR/response/java/javaRedshiftLineage/Lineage/JavaRedshiftLineageSourceTarget.json | TwoCopyStatement                  |

  ############################################# UI Validation #############################################
  @sanity @positive @MLP-11924 @webtest
  Scenario: SC#7 Verify facet counts appears properly for the items collected by Git, CsvS3Cataloger, AmazonS3Cataloger, AmazonRedshiftCataloger, JavaParser and JavaRedshiftLineage
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftCsv" and clicks on search
    And user performs "facet selection" in "tagRedshiftCsv" attribute under "Tags" facets in Item Search results page
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
      | Directory  | 5     |
      | Analysis   | 6     |
      | SourceTree | 15    |
      | Class      | 15    |
      | Function   | 15    |
      | Field      | 18    |
      | File       | 24    |

  #6712969#
  @webtest @MLP-11924 @sanity @positive
  Scenario: SC#8: UI Lineage verification - Verify the JavaRedshiftLineage plugin generates lineage for the java file 'FieldToColumnCsv' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftCsv" and clicks on search
    And user performs "facet selection" in "tagRedshiftCsv" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fieldToColumnCsv" item from search results
    Then user performs click and verify in new window
      | Table       | value                                                                 | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                  | jsonPath       |
      | Lineage Hops | fieldToColumn_csv_withHeaders.csv => catname => category => catname   | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop_1 |
      | Lineage Hops | fieldToColumn_csv_withHeaders.csv => catid => category => catid       | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop_2 |
      | Lineage Hops | fieldToColumn_csv_withHeaders.csv => catdesc => category => catdesc   | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop_3 |
      | Lineage Hops | fieldToColumn_csv_withHeaders.csv => catgroup => category => catgroup | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop_4 |

    #6712969#
  @webtest @MLP-11924 @sanity @positive
  Scenario: SC#9: UI Lineage verification - Verify the JavaRedshiftLineage plugin generates lineage for the java file 'FieldToColumnCsv_unOrderedHeaders' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftCsv" and clicks on search
    And user performs "facet selection" in "tagRedshiftCsv" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fieldToColumnCsv_unOrderedHeaders" item from search results
    Then user performs click and verify in new window
      | Table       | value                                                                     | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                  | jsonPath        |
      | Lineage Hops | fieldToColumn_csv_unOrderedHeaders.csv => catgroup => category => catname | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop1_1 |
      | Lineage Hops | fieldToColumn_csv_unOrderedHeaders.csv => catid => category => catgroup   | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop1_2 |
      | Lineage Hops | fieldToColumn_csv_unOrderedHeaders.csv => catname => category => catid    | click and verify lineagehops | Yes              | 0           | ida/JavaRedShiftPayloads/LineageMetadata/javaRedshiftLineageMetadata.json | $.LineageHop1_3 |


  #6712895# #67128956# #6712897#
  @webtest @MLP-11924 @negative
  Scenario: SC#10:Verify the JavaRedshiftLineage plugin doesn't generates lineage for the below cases
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

  #6712898# #6712899# #6712900# #6712901#
  @webtest @MLP-11924 @negative
  Scenario: SC#11:Verify the JavaRedshiftLineage plugin doesn't generates lineage for the invalid cases below
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
      | Default     | Function  | Metadata Type | nonExistingCsvFile         | Lineage Hops |
      | Default     | Function  | Metadata Type | selectStatementInsteadCopy | Lineage Hops |
    And user should be able logoff the IDC

  #6979128# #6979136#
  @webtest @MLP-19204 @sanity @positive
  Scenario: SC#: UI Lineage verification - Verify the JavaRedshiftLineage plugin displays exact sequence Number for fields and columns
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagRedshiftCsv" and clicks on search
    And user performs "facet selection" in "tagRedshiftCsv" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "category" item from search results
    Then the following field/column should have the specified sequence number
      | dynamicTable | itemName | sequenceNumber |
      | Columns      | catid    | 1              |
      | Columns      | catgroup | 2              |
      | Columns      | catname  | 3              |
      | Columns      | catdesc  | 4              |
    And user enters the search text "tagRedshiftCsv" and clicks on search
    And user performs "facet selection" in "tagRedshiftCsv" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fieldToColumn_csv_withHeaders.csv" item from search results
    Then the following field/column should have the specified sequence number
      | dynamicTable | itemName | sequenceNumber |
      | Fields       | catid    | 1              |
      | Fields       | catgroup | 2              |
      | Fields       | catname  | 3              |
      | Fields       | catdesc  | 4              |

  ############################################# Technology tags verification #############################################
  #7083641#
  @webtest @MLP-11876 @sanity @positive
  Scenario: SC#12:Verify the technology tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                      | fileName                     | userTag        |
      | Default     | Project    | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Git,Java      | javaspark_lineage            | tagRedshiftCsv |
      | Default     | Table      | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Redshift      | category                     | tagRedshiftCsv |
      | Default     | Schema     | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Redshift      | demo                         | tagRedshiftCsv |
      | Default     | Database   | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Redshift      | world                        | tagRedshiftCsv |
      | Default     | Service    | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Redshift      | AmazonRedshift               | tagRedshiftCsv |
      | Default     | Service    | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Amazon S3,CSV | AmazonS3                     | tagRedshiftCsv |
      | Default     | Cluster    | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Amazon S3,CSV | amazonaws.com                | tagRedshiftCsv |
      | Default     | Namespace  | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Java          | com                          | tagRedshiftCsv |
      | Default     | Column     | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Redshift      | catid                        | tagRedshiftCsv |
      | Default     | Directory  | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Amazon S3,CSV | asgredshifttest              | tagRedshiftCsv |
      | Default     | SourceTree | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Java          | ValidCsvPercentageQuote      | tagRedshiftCsv |
      | Default     | Class      | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Java          | ValidCsvPercentageQuote      | tagRedshiftCsv |
      | Default     | Function   | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Java,Redshift | validCsvPercentageQuote      | tagRedshiftCsv |
      | Default     | Function   | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Java          | invalidDatabase              | tagRedshiftCsv |
      | Default     | Field      | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,CSV           | catdesc                      | tagRedshiftCsv |
      | Default     | File       | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Git,Java      | ValidCsvPercentageQuote.java | tagRedshiftCsv |
      | Default     | File       | Metadata Type | tagRedshiftCsv,test_BA_JavaRedshiftLineage,Amazon S3,CSV | valid_csv_data.csv           | tagRedshiftCsv |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                        | fileName        | userTag        |
      | Default     | File | Metadata Type | Programming,Source Control | InvalidURL.java | tagRedshiftCsv |

  ############################################# EDIBusVerification #############################################
#  #7083641#
#  @sanity @positive @webtest @edibus
#  Scenario: SC#13:EDIBusVerification: Verify EDI replication for items collected using JavaRedshiftLineage
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                      |
#      | AP-DATA      | JAVAREDSHIFT | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                     | body                                                                         | response code | response message | jsonPath                                                |
#      | application/json | raw   | false | Put          | settings/credentials/EDIBusValidCredentialsJR                           | ida/javaRedShiftPayloads/credentials/javaRedshift_aws_edibusCredentails.json | 200           |                  |                                                         |
#      |                  |       |       | Put          | settings/analyzers/EDIBusDataSource                                     | idc/EdiBusPayloads/datasource/EDIBusDS_JavaRedshiftLineage.json              | 204           |                  |                                                         |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/JavaRedshiftLineageConfig.json                            | 204           |                  |                                                         |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaRedshift |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaRedshift')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJavaRedshift  |                                                                              | 200           |                  |                                                         |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaRedshift |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaRedshift')].status |
#    And user enters the search text "EDIBusJavaRedshift" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusJavaRedshift%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | LineageHop                                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                           | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=tagRedshiftCsv&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | query                                                                                |
#      | AP-DATA      | JAVAREDSHIFT | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) |
#    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
#      | databaseName | subjectArea  | subjectAreaVersion | itemName                                           | itemType                   | attributeName | attributeValue                |
#      | AP-DATA      | JAVAREDSHIFT | 1.0                | @*fieldToColumn_csv_withHeaders.csv@ =>@ catdesc@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | catdesc                       |
#      | AP-DATA      | JAVAREDSHIFT | 1.0                | @*fieldToColumn_csv_withHeaders.csv@ =>@ catdesc@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | catdesc                       |
#      | AP-DATA      | JAVAREDSHIFT | 1.0                | @*valid_image_data.jpg@*                           | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | ProxyFor≫category             |
#      | AP-DATA      | JAVAREDSHIFT | 1.0                | @*valid_image_data.jpg@*                           | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | ProxyFor≫valid_image_data.jpg |

  ############################################# Post Conditions ##########################################################
  @aws @cr-data @sanity
  Scenario: SC#14:DeleteBucket: Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "javaredshiftlineage" in bucket "asgredshifttest"
    Then user "Delete" a bucket "asgredshifttest" in amazon storage service

  Scenario Outline: SC#14:ItemDeletion: User deletes the collected item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                       | inputFile                                             |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                   | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..S3_Cluster.id                | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Redshift_Cluster.id          | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                    | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id              | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..CsvS3_Analysis.id            | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..AmazonS3_Analysis.id         | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Redshift_Analysis.id         | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id          | response/java/javaRedshiftLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JRedshiftLineage_Analysis.id | response/java/javaRedshiftLineage/actual/itemIds.json |

  @MLP-11111 @sanity @positive @regression
  Scenario Outline: SC#14:ConfigDeletion: Delete the Plugin configurations for Git , Amazon S3 Cataloger, CSV S3 Cataloger, Amazon RedShift Cataloger, Java Parser, Java RedShift Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentials                  |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusValidCredentialsJR             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_Credentials                      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidRedshiftCredentials             |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBusDataSource/EDIBusDS_JavaRedshift |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBus/EDIBusJavaRedshift              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector                           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3DataSource                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3Cataloger                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CsvS3DataSource                        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CsvS3Cataloger                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftDataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftCataloger                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser                             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaRedshiftLineage                    |      | 204           |                  |          |