Feature: Amazon S3 Support API for Java Spark Lineage

  @MLP-8132 @positve @amazon @regression @positive @sanity @IDA-10.1
  Scenario: SC#1_Creating a bucket in Amazon S3 and uploading source files
    Given user "Create" a bucket "asgqatestautomation2" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName           | keyPrefix   | dirPath                                        | recursive |
      | asgqatestautomation2 | Java/Source | ida/JavaSparkPayloads/MLP-10517_s3/Sourcefiles | true      |
      | asgqatestautomation2 | Java/Target | ida/JavaSparkPayloads/MLP-10517_s3/Targetfiles | true      |
    Given user "Create" a bucket "asgqatestautomation6" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName           | keyPrefix   | dirPath                                         | recursive |
      | asgqatestautomation6 | Java/Source | ida/JavaSparkPayloads/MLP-10517_s3/Sourcefiles1 | true      |
      | asgqatestautomation6 | Java/Target | ida/JavaSparkPayloads/MLP-10517_s3/Targetfiles1 | true      |


  @aws @precondition
  Scenario: SC#2_Update AWS credentials with exact values
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                | accessKeyPath | secretKeyPath |
      | /ida/javaSparkPayloads/MLP-10517_s3/S3_Credentials.json | $..accessKey  | $..secretKey  |


  @git @precondition
  Scenario: SC#2_Update Git credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                | username    | password    |
      | /ida/javaSparkPayloads/MLP-10517_s3/GitCredentials.json | $..userName | $..password |


  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#3-create Bussiness Application tag for Java Spark Lineage test for S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/MLP-10517_s3/JavaS3Spark_BA.json | 200           |                  |          |


  # 6657774# 6657925# 6657926# 6657927# 6657928# 6657930# 6657931# 6657932# 6657933# 6657934# 6658434
  @MLP-8132 @positve @amazon @regression @positive @sanity @IDA-10.1
  Scenario Outline: SC#4-Run the Plugin configurations for GitCollector, Amazon S3,Java Parser and Java Spark
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                                    | response code | response message         | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/GitCredentialsJS                                                 | ida/javaSparkPayloads/MLP-10517_s3/GitCredentials.json                  | 200           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJS                    | ida/javaSparkPayloads/MLP-10517_s3/GitCollectorDatasource.json          | 204           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJS                    |                                                                         | 200           | GitCollectorDataSourceJS |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector/GitCollectorJS                                        | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/Git_Config.json        | 204           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector/GitCollectorJS                                        |                                                                         | 200           | GitCollectorJS           |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJS           |                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='GitCollectorJS')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJS            | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json             | 200           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJS           |                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='GitCollectorJS')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/AWS_CredentialsJS                                                | ida/javaSparkPayloads/MLP-10517_s3/S3_Credentials.json                  | 200           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource/AmazonS3DataSourceJS                            | ida/javaSparkPayloads/MLP-10517_s3/S3Datasource.json                    | 204           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource/AmazonS3DataSourceJS                            |                                                                         | 200           | AmazonS3DataSourceJS     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger/AmazonS3CatalogerJS                              | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/AmazonS3.json          | 204           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger/AmazonS3CatalogerJS                              |                                                                         | 200           | AmazonS3CatalogerJS      |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3CatalogerJS |                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='AmazonS3CatalogerJS')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3CatalogerJS  | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json             | 200           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3CatalogerJS |                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='AmazonS3CatalogerJS')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser/JavaParserJS                                            | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/JavaParser_Config.json | 204           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser/JavaParserJS                                            |                                                                         | 200           | JavaParserJS             |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJS                  |                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='JavaParserJS')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParserJS                   | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json             | 200           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJS                  |                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='JavaParserJS')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS                                | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/Java_Spark_Config.json | 204           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS                                |                                                                         | 200           | JavaSparkLineageJS       |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS     |                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='JavaSparkLineageJS')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS      | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json             | 200           |                          |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS     |                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='JavaSparkLineageJS')].status  |

  Scenario Outline: SC#5-Dry run test Java Parser
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | body                                                                          | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS1                            | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/Java_Spark_ConfigDryRun.json | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS1                            |                                                                               | 200           | JavaSparkLineageJS1 |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS1 |                                                                               | 200           | IDLE                | $.[?(@.configurationName=='JavaSparkLineageJS1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS1  | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS1 |                                                                               | 200           | IDLE                | $.[?(@.configurationName=='JavaSparkLineageJS1')].status |


  @webtest @sanity @positive @webtest
  Scenario: SC#5-Verify Dry run for Amazon Glue Lineage plugin
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JavaSparkLineageJS1" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on the items listed contains "JavaSparkLineageJS1"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 23            | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaSparkLineage/JavaSparkLineageJS1/%" should display below info/error/warning
      | type | logValue                                                                                                   | logCode       | pluginName | removableText |
      | INFO | Plugin started                                                                                             | ANALYSIS-0019 |            |               |
      | INFO | ANALYSIS-0069: Plugin JavaSparkLineage running on dry run mode                                             | ANALYSIS-0069 |            |               |
      | INFO | ANALYSIS-0070: Plugin JavaSparkLineage processed 4 items on dry run mode and not written to the repository | ANALYSIS-0070 |            |               |

  @webtest @sanity @positive @webtest
  Scenario: SC#6-Verify Logging enhancements for Java Spark Lineage Plugin
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JavaSparkLineageJS" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on the items listed contains "JavaSparkLineageJS/"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 4             | Description |
      | Number of errors          | 23            | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaSparkLineage/JavaSparkLineageJS/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0019 |                  |                |
      | INFO | ANALYSIS-0071: Plugin Name:JavaSparkLineage, Plugin Type:lineage, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:d47dd4c0b586, Plugin Configuration name:JavaSparkLineageJS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0071 | JavaSparkLineage | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaSparkLineage Configuration: ---  2020-08-19 08:43:33.518 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: name: "JavaSparkLineageJS"  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: pluginVersion: "LATEST"  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: label:  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: : "JavaSparkLineageJS"  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: catalogName: "Default"  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: eventClass: null  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: eventCondition: null  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: nodeCondition: null  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: maxWorkSize: 100  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: tags:  2020-08-19 08:43:33.519 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: - "tagJavaSpS3"  2020-08-19 08:43:33.520 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: pluginType: "lineage"  2020-08-19 08:43:33.520 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: dataSource: null  2020-08-19 08:43:33.520 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: credential: null  2020-08-19 08:43:33.520 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: businessApplicationName: "test_BA_JavaSpS3"  2020-08-19 08:43:33.520 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: dryRun: false  2020-08-19 08:43:33.520 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: schedule: null  2020-08-19 08:43:33.520 INFO  - ANALYSIS-0073: Plugin JavaSparkLineage Configuration: filter: null | ANALYSIS-0073 |                  |                |
      | INFO | ANALYSIS-0072: Plugin JavaSparkLineage Start Time:2020-04-02 08:53:17.447, End Time:2020-04-02 08:53:26.356, Processed Count:4, Errors:23, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0072 | JavaSparkLineage |                |
      | INFO | ANALYSIS-0075: Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:01.291)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0075 |                  |                |

  # 6657774# 6657925# 6657926# 6657927# 6657928# 6657930# 6657931# 6657932# 6657933# 6657934# 6658434
  @MLP-8132 @sanity @positive
  Scenario Outline:SC#7-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                | asg_scopeid | targetFile                                | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | DF_S3_Combinations  |             | response/Lineage/DF_S3_Combinations.json  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | DFS3_positiveflow   |             | response/Lineage/DF_S3_Combinations.json  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                     |             | response/Lineage/DF_S3_Combinations.json  | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | RDD_S3_Combinations |             | response/Lineage/RDD_S3_Combinations.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | RDDS3_positiveflow  |             | response/Lineage/RDD_S3_Combinations.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                     |             | response/Lineage/RDD_S3_Combinations.json | $.functionID |

  # 6657774# 6657925# 6657926# 6657927# 6657928# 6657930# 6657931# 6657932# 6657933# 6657934# 6658434
  @MLP-8132
  Scenario Outline: SC#7-User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                | inputFile                                 | outputFile                                |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DF_S3_Combinations  | response/Lineage/DF_S3_Combinations.json  | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RDD_S3_Combinations | response/Lineage/RDD_S3_Combinations.json | response/Lineage/LineageSourceTarget.json |

  # 6657774# 6657925# 6657926# 6657927# 6657928# 6657930# 6657931# 6657932# 6657933# 6657934# 6658434
  @MLP-8132
  Scenario Outline: SC#7-Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                   | actual_json                                                 | item                |
      | ida/javaSparkPayloads/MLP-10517_s3/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | DF_S3_Combinations  |
      | ida/javaSparkPayloads/MLP-10517_s3/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | RDD_S3_Combinations |

  #641908#
  @webtest @MLP-8132 @sanity @positive
  Scenario: SC#7-Verify Lineage Hops in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user "enter text" in "Item Search in Home Page"
      | fieldName   | actionItem         |
      | Search Area | DF_S3_Combinations |
    And user performs following actions in the header
      | actionType | actionItem    |
      | click      | Search Button |
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DFS3_positiveflow" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                                                                                           | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                  | jsonPath              |
      | Lineage Hops | people.json => userDF3                                                                                                          | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10517_s3/LineageMetadata/UILineageMetadata.json | $.DFS3_positiveflow_1 |
      | Lineage Hops | userDF3 => asgqatestautomation2/Java/Target/DF/peopleTarget/part-00000-06159d7d-9bb4-45f1-8a56-e969ccc8b10f-c000.snappy.parquet | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10517_s3/LineageMetadata/UILineageMetadata.json | $.DFS3_positiveflow_2 |

  #6609798#
  @webtest @MLP-8132 @sanity @positive
  Scenario: SC#8-Verify the technology tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag                                     | fileName | userTag     |
      | Default     | Table | Metadata Type | tagJavaSpS3,Spark,test_BA_JavaSpS3,Java | userDF4  | tagJavaSpS3 |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag         | fileName | userTag     |
      | Default     | Table | Metadata Type | Programming | userDF4  | tagJavaSpS3 |
    And user should be able logoff the IDC

################################################################################################################################################################################
#  ----------------------UI VALIDATIONS--------------------------#
# Password encryption validations are not part of 10.3.0
# 6657774# 6657925# 6657926# 6657927# 6657928# 6657930# 6657931# 6657932# 6657933# 6657934# 6658434
#  @Git @MLP-8132 @positve @regression @sanity @webtest
#  Scenario Outline: SC#5_Verification of Password encryption for Git collector
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "SC1Catalog" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user clicks on git collector link
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | attributeName  | Definition                                         |
#      | actualFilePath | ida/javaSparkPayloads/MLP-10517_s3/Definition.json |
#    Then user verify whether "password encrypted" for below parameters
#      | pluginName   | pluginConfigPassword | passwordFilePath                                   | jsonpath             |
#      | GitCollector | BITBUCKET_PASSWORD   | ida/javaSparkPayloads/MLP-10517_s3/Definition.json | $.repositoryPassword |
#    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    And user makes a REST Call for Get request with url "settings/analyzers/GitCollector" and store value of json path"$..repositoryPassword"
#    Then json object value and temp stored value should be equal for below parameters
#      | filePath                                           | jsonPath             | condition    | argument |
#      | ida/javaSparkPayloads/MLP-10517_s3/Definition.json | $.repositoryPassword | not be equal | tempText |
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                             | body                                                             | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/Git_Config.json | 204           |                  |          |


##########################################################################################################################################################################
#---------------------- DELETING THE BUCKET --------------------------#

  @MLP-8132 @regression @positive
  Scenario:  PostConditions-Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "Java" in bucket "asgqatestautomation2"
    Then user "Delete" a bucket "asgqatestautomation2" in amazon storage service

##########################################################################################################################################################################
#  --------------------- DELETING PLUGIN/COLLECTED DATA --------------------------#

  @regression @sanity
  Scenario Outline: PostConditions-User retrieves the item ids of different items for Git Collector, Java Parser, Java Spark Lineage and Amazon S3 Cataloger in order to Delete the collected data
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                 | type | targetFile                                              | jsonpath                         |
      | APPDBPOSTGRES | Default | automation_repo_java_spark                           |      | response/java/javaSpark/javaSparkS3/actual/itemIds.json | $..GitData.has_Project.id        |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJS/%DYN           |      | response/java/javaSpark/javaSparkS3/actual/itemIds.json | $..GitData.has_Analysis.id       |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJS/%DYN                  |      | response/java/javaSpark/javaSparkS3/actual/itemIds.json | $..JavaData.has_Analysis1.id     |
      | APPDBPOSTGRES | Default | lineage/JavaSparkLineage/JavaSparkLineageJS/%DYN     |      | response/java/javaSpark/javaSparkS3/actual/itemIds.json | $..JavaData.has_Analysis2.id     |
      | APPDBPOSTGRES | Default | lineage/JavaSparkLineage/JavaSparkLineageJS1/%DYN    |      | response/java/javaSpark/javaSparkS3/actual/itemIds.json | $..JavaData.has_Analysis3.id     |
      | APPDBPOSTGRES | Default | asgqatestautomation2                                 |      | response/java/javaSpark/javaSparkS3/actual/itemIds.json | $..AmazonS3Data.has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/AmazonS3Cataloger/AmazonS3CatalogerJS/%DYN |      | response/java/javaSpark/javaSparkS3/actual/itemIds.json | $..AmazonS3Data.has_Analysis.id  |
      | APPDBPOSTGRES | Default | test_BA_JavaSpS3                                     |      | response/java/javaSpark/javaSparkS3/actual/itemIds.json | $..BAData.has_BA.id              |

  @regression @sanity
  Scenario Outline: PostConditions-User deletes the content of different items for for Git Collector, Java Parser, Java Spark Lineage and Amazon S3 Cataloger
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                        | inputFile                                               |
      | items/Default/Default.Project:::dynamic             | 204          | $..GitData.has_Project.id        | response/java/javaSpark/javaSparkS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..GitData.has_Analysis.id       | response/java/javaSpark/javaSparkS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaData.has_Analysis1.id     | response/java/javaSpark/javaSparkS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaData.has_Analysis2.id     | response/java/javaSpark/javaSparkS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaData.has_Analysis3.id     | response/java/javaSpark/javaSparkS3/actual/itemIds.json |
      | items/Default/Default.Directory:::dynamic           | 204          | $..AmazonS3Data.has_Directory.id | response/java/javaSpark/javaSparkS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..AmazonS3Data.has_Analysis.id  | response/java/javaSpark/javaSparkS3/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BAData.has_BA.id              | response/java/javaSpark/javaSparkS3/actual/itemIds.json |

  @MLP-8132 @regression @positive
  Scenario Outline: PostConditions-Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/GitCredentialsJS                              |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJS |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorJS                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser/JavaParserJS                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS1            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_CredentialsJS                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3DataSource/AmazonS3DataSourceJS         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3Cataloger/AmazonS3CatalogerJS           |      | 204           |                  |          |

#######################################################################################################################################################################################
#  --------------------- VALIDATION OF COLUMN LEVEL LINEAGES FOR S3 SPARK LINEAGE--------------------------#

  #7022352#  #7022353#  #7022354#
  @MLP-19894 @positve @amazon @regression @positive @sanity @IDA-1.1.0
  Scenario Outline: SC#9_Run the Plugin configurations for GitCollector, Amazon S3,Java Parser and Java Spark -1
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                 | response code | response message         | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/GitCredentialsJS                                                   | ida/javaSparkPayloads/MLP-10517_s3/GitCredentials.json                               | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJS                      | ida/javaSparkPayloads/MLP-10517_s3/GitCollectorDatasourceWithFields.json             | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJS                      |                                                                                      | 200           | GitCollectorDataSourceJS |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector/GitCollectorJS                                          | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/Git_ConfigWithColumns.json          | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector/GitCollectorJS                                          |                                                                                      | 200           | GitCollectorJS           |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJS             |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='GitCollectorJS')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJS              | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json                          | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJS             |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='GitCollectorJS')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/AWS_CredentialsJS                                                  | ida/javaSparkPayloads/MLP-10517_s3/S3_Credentials.json                               | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3DataSource/CsvS3DataSourceJS                                    | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/CSVS3DatasourceWithColumns.json     | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3DataSource/CsvS3DataSourceJS                                    |                                                                                      | 200           | CsvS3DataSourceJS        |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger/CsvS3CatalogerJS                                      | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/CSVS3WithColumns.json               | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger/CsvS3CatalogerJS                                      |                                                                                      | 200           | CsvS3CatalogerJS         |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3CatalogerJS         |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='CsvS3CatalogerJS')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3CatalogerJS          | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json                          | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3CatalogerJS         |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='CsvS3CatalogerJS')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource/JsonS3DataSourceJS                                  | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/JsonS3DatasourceWithColumns.json    | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3DataSource/JsonS3DataSourceJS                                  |                                                                                      | 200           | JsonS3DataSourceJS       |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3CatalogerJS                                    | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/JsonS3WithColumns.json              | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3CatalogerJS                                    |                                                                                      | 200           | JsonS3CatalogerJS        |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3CatalogerJS       |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='JsonS3CatalogerJS')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3CatalogerJS        | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json                          | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3CatalogerJS       |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='JsonS3CatalogerJS')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3DataSource/AvroS3DataSourceJS                                  | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/AvroS3DatasourceWithColumns.json    | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3DataSource/AvroS3DataSourceJS                                  |                                                                                      | 200           | AvroS3DataSourceJS       |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger/AvroS3CatalogerJS                                    | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/AvroS3WithColumns.json              | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger/AvroS3CatalogerJS                                    |                                                                                      | 200           | AvroS3CatalogerJS        |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3CatalogerJS       |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='AvroS3CatalogerJS')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3CatalogerJS        | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json                          | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3CatalogerJS       |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='AvroS3CatalogerJS')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3DataSource/ParquetS3DataSourceJS                            | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/ParquetS3DatasourceWithColumns.json | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3DataSource/ParquetS3DataSourceJS                            |                                                                                      | 200           | ParquetS3DataSourceJS    |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger/ParquetS3CatalogerJS                              | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/ParquetS3WithColumns.json           | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger/ParquetS3CatalogerJS                              |                                                                                      | 200           | ParquetS3CatalogerJS     |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3CatalogerJS |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='ParquetS3CatalogerJS')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3CatalogerJS  | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json                          | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3CatalogerJS |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='ParquetS3CatalogerJS')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser/JavaParserJS                                              | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/JavaParser_Config.json              | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser/JavaParserJS                                              |                                                                                      | 200           | JavaParserJS             |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJS                    |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='JavaParserJS')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParserJS                     | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json                          | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJS                    |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='JavaParserJS')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS                                  | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/Java_Spark_Config.json              | 204           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS                                  |                                                                                      | 200           | JavaSparkLineageJS       |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS       |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='JavaSparkLineageJS')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS        | ida/javaSparkPayloads/MLP-10517_s3/PluginsConfig/empty.json                          | 200           |                          |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineageJS       |                                                                                      | 200           | IDLE                     | $.[?(@.configurationName=='JavaSparkLineageJS')].status   |


  #7022352#  #7022353#  #7022354#
  @MLP-19894 @sanity @positive
  Scenario Outline:SC#10-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data - Column Level Lineage
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                   | asg_scopeid | targetFile                                   | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | S3_CsvToAvro_Final     |             | response/Lineage/S3_CsvToAvro_Final.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | DFS3_positiveflow2     |             | response/Lineage/S3_CsvToAvro_Final.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                        |             | response/Lineage/S3_CsvToAvro_Final.json     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | S3_CsvToJson_Final     |             | response/Lineage/S3_CsvToJson_Final.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | DFS3_positiveflow1     |             | response/Lineage/S3_CsvToJson_Final.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                        |             | response/Lineage/S3_CsvToJson_Final.json     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | S3_JsonToParquet_Final |             | response/Lineage/S3_JsonToParquet_Final.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | DFS3_positiveflow      |             | response/Lineage/S3_JsonToParquet_Final.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                        |             | response/Lineage/S3_JsonToParquet_Final.json | $.functionID |


  #7022352#  #7022353#  #7022354#
  @MLP-19894
  Scenario Outline: SC#10-User retrieves the  Lineage From and Lineage To data for lineage hop ids - Column Level Lineage
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                   | inputFile                                    | outputFile                                |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | S3_CsvToAvro_Final     | response/Lineage/S3_CsvToAvro_Final.json     | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | S3_CsvToJson_Final     | response/Lineage/S3_CsvToJson_Final.json     | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | S3_JsonToParquet_Final | response/Lineage/S3_JsonToParquet_Final.json | response/Lineage/LineageSourceTarget.json |

  #7022352#  #7022353#  #7022354#
  @MLP-19894
  Scenario Outline: SC#10-Lineage Hops Final Validation using API  - Column Level Lineage
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                   | actual_json                                                 | item                   |
      | ida/javaSparkPayloads/MLP-10517_s3/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | S3_CsvToAvro_Final     |
      | ida/javaSparkPayloads/MLP-10517_s3/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | S3_CsvToJson_Final     |
      | ida/javaSparkPayloads/MLP-10517_s3/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | S3_JsonToParquet_Final |

#  @sanity @positive @webtest @edibus
#  Scenario:  SC#11-Verify EDI replication for items collected using Java items and Lineage Hops verification
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | JAVA        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBusJava_S3_Config.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                         | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/EDIBusJava_S3_Config.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaSpark |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaSpark')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJavaSpark  |                                              | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaSpark |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaSpark')].status |
#    And user enters the search text "EDIBusJavaSpark" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "dynamic item click" on "EDIBusJavaSpark" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "tagJavaSpS3" and clicks on search
#    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | JAVA        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | Function                                    |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                        | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=tagJavaSpS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | JAVA        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |
#    And user enters the search text "tagJavaSpS3" and clicks on search
#    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | JAVA        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | SourceTree                                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                        | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=tagJavaSpS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | JAVA        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
#    And user enters the search text "tagJavaSpS3" and clicks on search
#    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | JAVA        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | Class                                       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                        | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=tagJavaSpS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | JAVA        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | LineageHop                                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                        | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=tagJavaSpS3&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                |
#      | AP-DATA      | JAVA        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) |
#    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemName                  | itemType                   | attributeName | attributeValue               |
#      | AP-DATA      | JAVA        | 1.0                | @*emp.csv._c0@*           | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | _c0                          |
#      | AP-DATA      | JAVA        | 1.0                | @*emp.csv._c0@*           | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | Column≫[Table≫userDF3]≫_c0   |
#      | AP-DATA      | JAVA        | 1.0                | @*peopleTarget_DF.three@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Column≫[Table≫userDF3]≫three |
#      | AP-DATA      | JAVA        | 1.0                | @*peopleTarget_DF.three@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | three                        |


##########################################################################################################################################################################
#  --------------------- DELETING PLUGIN/COLLECTED DATA --------------------------#

  @regression @sanity
  Scenario Outline: PostConditions-User retrieves the item ids of different items for Git Collector, Java Parser, Java Spark Lineage and Amazon S3 Cataloger in order to Delete the collected data - Column Level Lineages
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                   | type | targetFile                                               | jsonpath                         |
      | APPDBPOSTGRES | Default | javaspark_lineage                                      |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..GitData.has_Project.id        |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJS/%DYN             |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..GitData.has_Analysis.id       |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJS/%DYN                    |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..JavaData.has_Analysis1.id     |
      | APPDBPOSTGRES | Default | lineage/JavaSparkLineage/JavaSparkLineageJS/%DYN       |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..JavaData.has_Analysis2.id     |
      | APPDBPOSTGRES | Default | asgqatestautomation6                                   |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..AmazonS3Data.has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/ParquetS3Cataloger/ParquetS3CatalogerJS/%DYN |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..AmazonS3Data.has_Analysis1.id |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3CatalogerJS/%DYN       |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..AmazonS3Data.has_Analysis2.id |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CsvS3CatalogerJS/%DYN         |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..AmazonS3Data.has_Analysis3.id |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3CatalogerJS/%DYN       |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..AmazonS3Data.has_Analysis4.id |
#      | APPDBPOSTGRES | Default | bulk/EDIBus/EDIBusJavaSpark/%DYN                       |      | response/java/javaSpark/javaSparkS3/actual/itemIds1.json | $..EDIData.has_EDI.id            |


  @regression @sanity
  Scenario Outline: PostConditions-User deletes the content of different items for for Git Collector, Java Parser, Java Spark Lineage and Amazon S3 Cataloger - Column Level Lineages
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                        | inputFile                                                |
      | items/Default/Default.Project:::dynamic   | 204          | $..GitData.has_Project.id        | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..GitData.has_Analysis.id       | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..JavaData.has_Analysis1.id     | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..JavaData.has_Analysis2.id     | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
      | items/Default/Default.Directory:::dynamic | 204          | $..AmazonS3Data.has_Directory.id | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..AmazonS3Data.has_Analysis1.id | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..AmazonS3Data.has_Analysis2.id | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..AmazonS3Data.has_Analysis3.id | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..AmazonS3Data.has_Analysis4.id | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |
#      | items/Default/Default.Analysis:::dynamic  | 204          | $..EDIData.has_EDI.id            | response/java/javaSpark/javaSparkS3/actual/itemIds1.json |


  @MLP-19894 @regression @positive
  Scenario Outline: PostConditions-Delete Plugin Configuration - Column Level Lineages
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/GitCredentialsJS                              |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJS |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorJS                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser/JavaParserJS                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage/JavaSparkLineageJS             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_CredentialsJS                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CsvS3DataSource/CsvS3DataSourceJS               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CsvS3Cataloger/CsvS3CatalogerJS                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AvroS3DataSource/AvroS3DataSourceJS             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AvroS3Cataloger/AvroS3CatalogerJS               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JsonS3DataSource/JsonS3DataSourceJS             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JsonS3Cataloger/JsonS3CatalogerJS               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/ParquetS3DataSource/ParquetS3DataSourceJS       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/ParquetS3Cataloger/ParquetS3CatalogerJS         |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBus                                          |      | 204           |                  |          |


##########################################################################################################################################################################
#---------------------- DELETING THE BUCKET --------------------------#

  @MLP-19894 @regression @positive
  Scenario:  PostConditions-Delete the bucket in Amazon S3 storage  - Column Level Lineages
    Given user "Delete" objects in amazon directory "Java" in bucket "asgqatestautomation6"
    Then user "Delete" a bucket "asgqatestautomation6" in amazon storage service