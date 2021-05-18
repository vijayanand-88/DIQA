@MLP-8132
Feature: Amazon S3 Support API for Python Spark Lineage

  # 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @MLP-8132 @positve @amazon @regression @positive @sanity @IDA-10.1
  Scenario: SC#1_Creating a bucket in Amazon S3 and uploading source files
    Given user "Create" a bucket "s3lineage1" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName | keyPrefix      | dirPath                                                     | recursive |
      | s3lineage1 | PySpark/Source | ida/PythonSparkPayloads/pythonSparkLineage_8132_sourceFiles | true      |


# 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @MLP-8132 @positve @amazon @regression @positive @sanity @IDA-10.1
  Scenario: SC#2_Creating a bucket in Amazon S3 and uploading Target files
    Given user performs "multiple upload" in amazon storage service with below parameters
      | bucketName | keyPrefix      | dirPath                                                      | recursive |
      | s3lineage1 | PySpark/Target | ida/PythonSparkPayloads/pythonSparkLineage_8132__targetFiles | true      |


# 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
#  @MLP-8132 @positve @amazon @regression @positive @sanity @IDA-10.2
#  Scenario: SC#3_Creating a catalog for collecting the files
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                | body                                                                    | response code | response message | jsonPath |
#      | application/json |       |       | Post | settings/catalogs                  | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/createCatalogConfig.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/catalogs/S3LineageCatalog |                                                                         | 200           | S3LineageCatalog |          |

  @MLP-17257 @sanity @positive @regression
  Scenario:SC#3 Add valid Credentials for Git and Amazon3 plugins
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                                      | body                                                                    | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/credentials/GitSparkCredentials | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/GitSparkCredentials.json | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/GitSparkCredentials |                                                                         | 200           |                  |          |
      |                  |       |       | Put  | settings/credentials/AmazonS3Credentials | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/awsCredentials.json      | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/AmazonS3Credentials |                                                                         | 200           |                  |          |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC03_1#create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/PythonSparlPayloads/MLP-8132_PluginsConfig/BussinessApplication.json | 200           |                  |          |

  # 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @MLP-8132 @positve @amazon @regression @positive @sanity @IDA-10.1
  Scenario Outline: SC#4_Run the Plugin configurations for GitCollector , Amazon S3 ,Python Parser and Python Spark
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | body                                                                         | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                     | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/GitSparkDataSource.json       | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                     |                                                                              | 200           | GitSparkS3DataSource |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                               | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/GitCatalogerConfig.json       | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                               |                                                                              | 200           | GitCollector_S3Spark |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/*                |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='GitCollector_S3Spark')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/*                 | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/empty.json                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/*                |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='GitCollector_S3Spark')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                         | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/AmazonS3DataSourceconfig.json | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                         |                                                                              | 200           | AmazonS3DataSource   |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                          | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/AmazonS3Config.json           | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                          |                                                                              | 200           | AmazonS3             |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*           |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='AmazonS3')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*            | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/empty.json                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*           |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='AmazonS3')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonParser                                               | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/PythonParserConfig.json       | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonParser                                               |                                                                              | 200           | PythonParser         |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser        |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='PythonParser')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser         | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/empty.json                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser        |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='PythonParser')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonSparkLineage                                         | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/PythonSparkLineageConfig.json | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonSparkLineage                                         |                                                                              | 200           | SparkLineage         |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/SparkLineage |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='SparkLineage')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/SparkLineage  | ida/PythonSparkPayloads/MLP-8132_PluginsConfig/empty.json                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/SparkLineage |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='SparkLineage')].status         |


################################################################################################################################################################################
#  ----------------------UI VALIDATIONS--------------------------#

# 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @webtest @MLP-8132 @sanity @positive @regression
  Scenario: SC#6_Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "S3PythonSparkLineage" and clicks on search
    And user performs "facet selection" in "S3PythonSparkLineage" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                              | fileName               | userTag              |
      | Default     | File      | Metadata Type | Amazon S3,S3PythonSparkLineage,PythonSpark_BA    | students.orc           | S3PythonSparkLineage |
      | Default     | Directory | Metadata Type | Amazon S3,S3PythonSparkLineage,PythonSpark_BA    | studentsTarget.orc     | S3PythonSparkLineage |
      | Default     | Table     | Metadata Type | Python,Spark,S3PythonSparkLineage,PythonSpark_BA | usersDF1               | S3PythonSparkLineage |
      | Default     | Class     | Metadata Type | Python,S3PythonSparkLineage,PythonSpark_BA       | SourceFile             | S3PythonSparkLineage |
      | Default     | Function  | Metadata Type | Python,Spark,S3PythonSparkLineage,PythonSpark_BA | aws_datasource_example | S3PythonSparkLineage |
      | Default     | Project   | Metadata Type | Git,S3PythonSparkLineage,PythonSpark_BA          | pythonanalyzerdemo     | S3PythonSparkLineage |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName               | userTag              |
      | Default     | Class      | Metadata Type | Programming | SourceFile             | S3PythonSparkLineage |
      | Default     | Function   | Metadata Type | Programming | aws_datasource_example | S3PythonSparkLineage |
      | Default     | SourceTree | Metadata Type | Programming | SourceFile             | S3PythonSparkLineage |
    And user enters the search text "S3PythonSparkLineage" and clicks on search
    And user performs "facet selection" in "S3PythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "aws_datasource_example" item from search results
    Then user performs click and verify in new window
      | Table        | value              | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | emp.csv => usersDF | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | S3PythonSparkLineage,Python,Spark,PythonSpark_BA |
      | item | emp.csv => usersDF                               |

# 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @webtest @MLP-8132 @sanity @positive @regression
  Scenario: SC7-Verify logging enhancements
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "S3PythonSparkLineage" and clicks on search
    And user performs "facet selection" in "S3PythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on the items listed contains "lineage/PythonSparkLineage/SparkLineage"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log should display the analysis info for below parameters
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | logCode       | pluginName         | removableText |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0019 |                    |               |
      | INFO | Plugin Name:PythonSparkLineage, Plugin Type:lineage, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:ab7f58d973a9, Plugin Configuration name:SparkLineage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0071 | PythonSparkLineage | Host Name     |
      | INFO | Plugin PythonSparkLineage Configuration: ---2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: name: "SparkLineage"2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: pluginVersion: "LATEST"2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: label:2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: : ""2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: catalogName: "Default"2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: eventClass: null2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: eventCondition: null2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: nodeCondition: null2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: maxWorkSize: 1002020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: tags:2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: - "S3PythonSparkLineage"2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: pluginType: "lineage"2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: dataSource: null2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: credential: null2020-03-25 08:34:33.762 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: businessApplicationName: "PythonSpark_BA"2020-03-25 08:34:33.763 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: dryRun: false2020-03-25 08:34:33.763 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: filter: null2020-03-25 08:34:33.763 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: pluginName: "PythonSparkLineage"2020-03-25 08:34:33.763 INFO - ANALYSIS-0073: Plugin PythonSparkLineage Configuration: type: "Lineage" | ANALYSIS-0073 | PythonSparkLineage |               |
      | INFO | ANALYSIS-0072: Plugin PythonSparkLineage Start Time:2020-03-25 08:34:33.760, End Time:2020-03-25 08:34:39.262, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0072 | PythonSparkLineage |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.502)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0020 |                    |               |

# 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @webtest @MLP-8132 @sanity @positive @regression
  Scenario: SC#7_Check if the count from the collector plugin and SourceTree count matches
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "S3PythonSparkLineage" and clicks on search
    And user performs "facet selection" in "S3PythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user get the count of the search list
    And verify the count of search list and the Expected count "1" matches


  # 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @webtest @MLP-8132 @sanity @positive @regression
  Scenario: SC8-Verify Lineage Hops in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "S3PythonSparkLineage" and clicks on search
    And user performs "facet selection" in "S3PythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "aws_datasource_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                                                                                          | Action                       | RetainPrevwindow | indexSwitch | filePath                                                              | jsonPath          |
      | Lineage Hops | emp.csv => usersDF                                                                                                             | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF         |
      | Lineage Hops | namesAndFavColors.text => usersDF4                                                                                             | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF4        |
      | Lineage Hops | people.json => usersDF1                                                                                                        | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF1        |
      | Lineage Hops | rubiks.parquet => usersDF2                                                                                                     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF2        |
      | Lineage Hops | students.orc => usersDF3                                                                                                       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF3        |
      | Lineage Hops | usersDF => s3lineage1/PySpark/Target/empTarget.csv/part-00000-687e7718-43d4-43a0-99ee-26ec0fca3ded-c000.csv                    | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF_Target  |
      | Lineage Hops | usersDF1 => s3lineage1/PySpark/Target/peopleTarget.json/part-r-00000-0386e26f-6edb-4f4a-9ba2-1afae941d0b4.json                 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF1_Target |
      | Lineage Hops | usersDF2 => s3lineage1/PySpark/Target/rubiksTarget.parquet/part-00000-16afaade-5307-493b-89de-cca04a55c832-c000.snappy.parquet | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF2_Target |
      | Lineage Hops | usersDF3 => s3lineage1/PySpark/Target/studentsTarget.orc/part-00000-2e174405-4498-415a-9016-efca1ee618db-c000.snappy.parquet   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF3_Target |
      | Lineage Hops | usersDF4 => s3lineage1/PySpark/Target/namesAndFavColorsTarget.txt/part-00000-a8a2c43b-0de1-4bbe-9f0e-0b177db8f149-c000.txt     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/lineageMetadata.json | $.usersDF4_Target |


# 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @webtest @MLP-8132 @sanity @positive @regression
  Scenario Outline:SC9-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                   | asg_scopeid | targetFile                                                       | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | SourceFile             |             | response/PythonSparkLineage/MLP-8132_Lineage/LineageHopID's.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | aws_datasource_example |             | response/PythonSparkLineage/MLP-8132_Lineage/LineageHopID's.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                        |             | response/PythonSparkLineage/MLP-8132_Lineage/LineageHopID's.json | $.functionID |


    # 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @webtest @MLP-8132 @sanity @positive @regression
  Scenario Outline: SC10-user retrieves the Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item       | inputFile                                                        | outputFile                                                            |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SourceFile | response/PythonSparkLineage/MLP-8132_Lineage/LineageHopID's.json | response/PythonSparkLineage/MLP-8132_Lineage/LineageSourceTarget.json |

    # 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @webtest @MLP-8132 @sanity @positive @regression
  Scenario Outline: SC11-Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                     | actual_json                                                                             | item       |
      | ida/PythonSparkPayloads/MLP-8132_LineagePayloads/ExpectedLineageSourceTarget.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-8132_Lineage/LineageSourceTarget.json | SourceFile |


##########################################################################################################################################################################
  #---------------------- DELETING THE BUCKET --------------------------#

# 6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @MLP-8132 @regression @positive
  Scenario:  SC#9_MLP-8132:Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "PySpark" in bucket "s3lineage1"
    Then user "Delete" a bucket "s3lineage1" in amazon storage service

    ##########################################################################################################################################################################
  #---------------------- DELETING THE AMAZON CLUSTER FROM POSTGRES DB --------------------------#

  Scenario Outline: sc#10_1 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                             | type      | targetFile                                                | jsonpath                  |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector_S3Spark/%DYN |           | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json | $..has_Analysis.id        |
      | APPDBPOSTGRES | Default | S3PythonSparkLineage                             | Tag       | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json | $..Tag.id                 |
      | APPDBPOSTGRES | Default | PythonSpark_BA                                   |           | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json | $..BusinessApplication.id |
      | APPDBPOSTGRES | Default | s3lineage1                                       | Directory | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json | $..Directory.id           |
      | APPDBPOSTGRES | Default | pythonanalyzerdemo                               | Project   | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json | $..Project.id             |


  Scenario Outline: sc#10_2 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                 | inputFile                                                 |
      | items/Default/Default.has_Analysis:::dynamic        | 204          | $..has_Analysis.id        | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json |
      | items/Default/Default.Tag:::dynamic                 | 204          | $..Tag.id                 | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication.id | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json |
      | items/Default/Default.Directory:::dynamic           | 204          | $..Directory.id           | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id             | response/pythonsparkLineage/MLP-8132_Lineage/itemIds.json |


##########################################################################################################################################################################
#  --------------------- DELETING PLUGIN/CATALOG --------------------------#

 #6597342 #  6597344 # 6597343 # 6597345 # 6597337 # 6597338 # 6597341 # 6597339 # 6597340 # 6597336  # 6597347
  @MLP-8132 @regression @positive
  Scenario: SC#11_Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                      | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollector          |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonS3Cataloger     |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/PythonParser          |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/PythonSparkLineage    |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/GitSparkCredentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/AmazonS3Credentials |      | 200           |                  |          |

