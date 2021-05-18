@MLP-16306
Feature:Verification of Java Spark Lineage with SQL API

  ############################################# Pre Conditions ##########################################################
  @aws @precondition
  Scenario: SC#1:Update AWS credentials with exact values
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                                              | accessKeyPath | secretKeyPath |
      | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/javaSparkLineage_awsCredentials.json | $..accessKey  | $..secretKey  |
    And User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/gitCredentials.json | $..userName | $..password |
    And User update the below "snowflake credentials" in following files using json path
      | filePath                                                                   | username    | password    |
      | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/snowflakeCredentials.json | $..userName | $..password |

  @cr-data @sanity @aws
  Scenario: SC#1:Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgsparktest" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName   | keyPrefix             | dirPath                                         | recursive |
      | asgsparktest | javasqllineage/source | ida/javaSparkPayloads/MLP-16306_sql/SourceFiles | true      |
      | asgsparktest | javasqllineage/target | ida/javaSparkPayloads/MLP-16306_sql/TargetFiles | true      |

  @jdbc @cr-data @sanity
  Scenario: SC#1:Create Spark Source data in SNOWFLAKE DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                    | queryField     |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createSchema   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable1   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord1  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable2   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord2  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable5   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord5  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable6   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord6  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable7   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord7  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable8   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord8  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable9   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord9  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable10  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord10 |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable11  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord11 |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1:Create Business Application tag for Java Spark Lineage test for SQL Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/MLP-16306_sql/JavaSparkSQL_BA.json | 200           |                  |          |

  ############################################# Plugin Run ##########################################################
  @javaspark @MLP-16306 @sanity
  Scenario Outline: SC#2:Configurations for Plugins - Git, JsonS3, Snowflake DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | body                                                                                   | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentials       | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/gitCredentials.json                   | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource      | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/GitCollectorDataSource.json           | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource      |                                                                                        | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector                | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/GitCollector.json                     | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector                |                                                                                        | 200           | JavaSparkSQL           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_Credentials           | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/javaSparkLineage_awsCredentials.json  | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JsonS3DataSource            | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/javaSparkLineage_awsS3DataSource.json | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JsonS3DataSource            |                                                                                        | 200           | S3DataSource           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JsonS3Cataloger             | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/javaSparkLineage_jsonS3Cataloger.json | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JsonS3Cataloger             |                                                                                        | 200           | JsonS3Cataloger        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/SnowflakeValidCredentials | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/snowflakeCredentials.json             | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource       | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/SnowflakeDBDataSource.json            | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBDataSource       |                                                                                        | 200           | SnowflakeDataSource    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBCataloger        | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/SnowflakeCataloger.json               | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBCataloger        |                                                                                        | 200           | SnowflakeDBCataloger   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser                  | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/JavaParser.json                       | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser                  |                                                                                        | 200           | JavaSparkSQL           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage            | ida/javaSparkPayloads/MLP-16306_sql/PluginConfig/JavaSparkLineage.json                 | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage            |                                                                                        | 200           | JavaSparkSQL           |          |

  @javaspark @MLP-16306 @sanity
  Scenario Outline: SC#2:Run the Plugin configurations for Git, JsonS3, Snowflake DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body           | response code | response message | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                 |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                  | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                 |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger           |                | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger            | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger           |                | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                        |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser                         | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                        |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage           |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage            | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage           |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status     |

  Scenario Outline: SC#2:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                    | type    | targetFile                                               | jsonpath                        |
      | APPDBPOSTGRES | Default | javaspark_lineage                                       | Project | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..Project.id                   |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com            |         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..Snowflake_Cluster.id         |
      | APPDBPOSTGRES | Default | amazonaws.com                                           |         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..JsonS3_Cluster.id            |
      | APPDBPOSTGRES | Default | test_BA_JavaSparkSQL                                    |         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..has_BA.id                    |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN                 |         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..Git_Analysis.id              |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%DYN |         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..Snowflake_Analysis.id        |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN                        |         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..JParser_Analysis.id          |
      | APPDBPOSTGRES | Default | lineage/JavaSparkLineage/JavaSparkLineage%DYN           |         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..JavaSparkLineage_Analysis.id |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN           |         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json | $..JsonS3_Analysis.id           |

  ############################################# API Lineage verification #############################################
  @javaspark @MLP-16306 @regression @positive
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                         | asg_scopeid | targetFile                                                                     | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileToFileCreateTempView     |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileCreateTempView.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileToFileTempView           |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileCreateTempView.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileCreateTempView.json     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileToFileCreateGlobalView   |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileCreateGlobalView.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileToFileGlobalView         |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileCreateGlobalView.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileCreateGlobalView.json   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileToFileMultipleViews      |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileMultipleViews.json      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileToFileMultipleView       |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileMultipleViews.json      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileMultipleViews.json      | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileToFileMultipleWrites     |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileMultipleWrites.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileToFileMultipleWrites     |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileMultipleWrites.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileMultipleWrites.json     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileToFileSelectStar         |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileSelectStar.json         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileToFileSelectStar         |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileSelectStar.json         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileSelectStar.json         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTableCreateTempView   |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableCreateTempView.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | tableToTableTempView         |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableCreateTempView.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableCreateTempView.json   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTableCreateGlobalView |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableCreateGlobalView.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | tableToTableGlobalView       |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableCreateGlobalView.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableCreateGlobalView.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTableMultipleViews    |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableMultipleViews.json    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | tableToTableMultipleViews    |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableMultipleViews.json    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableMultipleViews.json    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTableMultipleWrites   |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableMultipleWrites.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | tableToTableMultipleWrites   |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableMultipleWrites.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableMultipleWrites.json   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTableSelectStar       |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableSelectStar.json       |              |
      | APPDBPOSTGRES | FunctionID | Default |            | tableToTableSelectStar       |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableSelectStar.json       |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                              |             | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableSelectStar.json       | $.functionID |

  @javaspark @MLP-16306 @regression @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                         | inputFile                                                                      | outputFile                                                                        |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileToFileCreateTempView     | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileCreateTempView.json     | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileToFileCreateGlobalView   | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileCreateGlobalView.json   | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileToFileMultipleViews      | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileMultipleViews.json      | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileToFileMultipleWrites     | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileMultipleWrites.json     | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileToFileSelectStar         | response/java/javaSpark/javaSparkSQL/Lineage/FileToFileSelectStar.json         | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTableCreateTempView   | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableCreateTempView.json   | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTableCreateGlobalView | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableCreateGlobalView.json | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTableMultipleViews    | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableMultipleViews.json    | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTableMultipleWrites   | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableMultipleWrites.json   | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTableSelectStar       | response/java/javaSpark/javaSparkSQL/Lineage/TableToTableSelectStar.json       | response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json |

  #6892015# #6892016# #6892017# #6892018# #6892019# #6892020# #6892021# #6892022# #6892023# #6892024# #6892025# #6892026# #6892027# #6899958#
  @javaspark @MLP-16306 @regression @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                        | actual_json                                                                                         | item                         |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | FileToFileCreateTempView     |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | FileToFileCreateGlobalView   |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | FileToFileMultipleViews      |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | FileToFileMultipleWrites     |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | FileToFileSelectStar         |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | TableToTableCreateTempView   |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | TableToTableCreateGlobalView |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | TableToTableMultipleViews    |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | TableToTableMultipleWrites   |
      | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/expectedJavaSparkLineageSQL.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSQL/Lineage/JavaSparkLineageSQLSourceTarget.json | TableToTableSelectStar       |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-16306 @sanity @positive
  Scenario: SC#4:UI Lineage verification: - Verify the JavaSparkLineage plugin generates lineage for the java file named 'FileToFileCreateTempView.java' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaSparkSQL" and clicks on search
    And user performs "facet selection" in "tagJavaSparkSQL" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fileToFileTempView" item from search results
    Then user performs click and verify in new window
      | Table        | value                                          | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                             | jsonPath        |
      | Lineage Hops | ADDRESS => customersTarget_01.ADDRESS          | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_1  |
      | Lineage Hops | AGE => customersTarget_01.AGE                  | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_2  |
      | Lineage Hops | ID => customersTarget_01.ID                    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_3  |
      | Lineage Hops | NAME => customersTarget_01.NAME                | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_4  |
      | Lineage Hops | customers.json.ADDRESS => userDF1.ADDRESS      | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_5  |
      | Lineage Hops | customers.json.AGE => userDF1.AGE              | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_6  |
      | Lineage Hops | customers.json.ID => userDF1.ID                | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_7  |
      | Lineage Hops | customers.json.NAME => userDF1.NAME            | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_8  |
      | Lineage Hops | fileToFileTempView.ADDRESS => queryDF1.ADDRESS | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_9  |
      | Lineage Hops | fileToFileTempView.AGE => queryDF1.AGE         | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_10 |
      | Lineage Hops | fileToFileTempView.ID => queryDF1.ID           | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_11 |
      | Lineage Hops | fileToFileTempView.NAME => queryDF1.NAME       | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_12 |
      | Lineage Hops | userDF1.ADDRESS => fileToFileTempView.ADDRESS  | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_13 |
      | Lineage Hops | userDF1.AGE => fileToFileTempView.AGE          | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_14 |
      | Lineage Hops | userDF1.ID => fileToFileTempView.ID            | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_15 |
      | Lineage Hops | userDF1.NAME => fileToFileTempView.NAME        | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-16306_sql/LineageMetadata/javaSparkLineageSQLMetadata.json | $.LineageHop_16 |
    And user should be able logoff the IDC

  ###############################TechnologyTagValidation#################################
  @webtest @MLP-16306 @sanity @positive @regression
  Scenario: SC#5:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaSparkSQL" and clicks on search
    And user performs "facet selection" in "tagJavaSparkSQL" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                 | fileName                  | userTag         |
      | Default     | Project    | Metadata Type | test_BA_JavaSparkSQL,Git,tagJavaSparkSQL,Java       | javaspark_lineage         | tagJavaSparkSQL |
      | Default     | Cluster    | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,JSON           | amazonaws.com             | tagJavaSparkSQL |
      | Default     | Schema     | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,Snowflake      | AUTO                      | tagJavaSparkSQL |
      | Default     | File       | Metadata Type | test_BA_JavaSparkSQL,Git,tagJavaSparkSQL,Java,Spark | FileToFileSelectStar.java | tagJavaSparkSQL |
      | Default     | File       | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,JSON           | customers.json            | tagJavaSparkSQL |
      | Default     | Field      | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,JSON           | ADDRESS                   | tagJavaSparkSQL |
      | Default     | SourceTree | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,Java,Spark     | TableToTableMultipleViews | tagJavaSparkSQL |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,Snowflake      | EMPLOYEE_DATA             | EMPLOYEE_DATA |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,Java,Spark     | queryDF2                  | queryDF2 |
      | Default     | Class      | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,Java           | FileToFileMultipleWrites  | tagJavaSparkSQL |
      | Default     | Function   | Metadata Type | test_BA_JavaSparkSQL,tagJavaSparkSQL,Java,Spark     | fileToFileTempView        | tagJavaSparkSQL |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName                 | userTag         |
      | Default     | Class      | Metadata Type | Programming | FileToFileCreateTempView | tagJavaSparkSQL |
      | Default     | Function   | Metadata Type | Programming | fileToFileTempView       | tagJavaSparkSQL |
      | Default     | SourceTree | Metadata Type | Programming | FileToFileCreateTempView | tagJavaSparkSQL |
    And user enters the search text "tagJavaSparkSQL" and clicks on search
    And user performs "facet selection" in "tagJavaSparkSQL" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fileToFileTempView" item from search results
    Then user performs click and verify in new window
      | Table        | value                                 | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | ADDRESS => customersTarget_01.ADDRESS | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_JavaSparkSQL,tagJavaSparkSQL,Java,Spark |
      | item | ADDRESS => customersTarget_01.ADDRESS           |
    And user should be able logoff the IDC

  ############################################# Post Conditions ##########################################################
  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#6:ItemDeletion- User deletes the collected item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                       | inputFile                                                |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                   | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Snowflake_Cluster.id         | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..JsonS3_Cluster.id            | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                    | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id              | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Snowflake_Analysis.id        | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id          | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaSparkLineage_Analysis.id | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JsonS3_Analysis.id           | response/java/javaSpark/javaSparkSQL/actual/itemIds.json |

  @MLP-16306 @sanity
  Scenario Outline: SC#6:Delete the Plugin configurations for Git , JsonS3, Snowflake DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                            | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentials       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_Credentials           |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JsonS3DataSource            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JsonS3Cataloger             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/SnowflakeValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBDataSource       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBCataloger        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage            |      | 204           |                  |          |

  @jdbc @cr-data @sanity
  Scenario: SC#6: Delete Spark Source data and Spark Target data in SNOWFLAKE DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                    | queryField   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | deleteSchema |

  @aws @cr-data @sanity
  Scenario:SC#6: Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "javasqllineage" in bucket "asgsparktest"
    Then user "Delete" a bucket "asgsparktest" in amazon storage service
