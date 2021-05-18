@MLP-16306
Feature:Verification of Python Spark Lineage with SQL API

  ############################################# Pre Conditions ##########################################################
  @aws @precondition
  Scenario: SC#1:Update AWS credentials with exact values
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                                                  | accessKeyPath | secretKeyPath |
      | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/pythonSparkLineage_awsCredentials.json | $..accessKey  | $..secretKey  |
    And User update the below "Git Credentials" in following files using json path
      | filePath                                                               | username    | password    |
      | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/gitCredentials.json | $..userName | $..password |
    And User update the below "snowflake credentials" in following files using json path
      | filePath                                                                     | username    | password    |
      | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/snowflakeCredentials.json | $..userName | $..password |

  @cr-data @sanity @aws
  Scenario: SC#1:Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "sqlspark" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName | keyPrefix         | dirPath                                           | recursive |
      | sqlspark   | PySqlSpark/Source | ida/PythonSparkPayloads/MLP-16306_sql/SourceFiles | true      |
      | sqlspark   | PySqlSpark/Target | ida/PythonSparkPayloads/MLP-16306_sql/TargetFiles | true      |

  @jdbc @cr-data @sanity
  Scenario: SC#1:Create Spark Source data in SNOWFLAKE DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField    |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable1  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable2  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable3  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable4  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable5  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable6  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable7  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable8  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable9  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforPythonSpark | createTable10 |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1:Create Business Application tag for Python Spark Lineage test for SQL Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/PythonSparkPayloads/MLP-16306_sql/PythonSparkSQL_BA.json | 200           |                  |          |

  ############################################# Plugin Run ##########################################################
  @pythonspark @MLP-16306 @sanity
  Scenario Outline: SC#2:Configurations for Plugins - Git, JsonS3, Snowflake DB Cataloger, Python Parser and Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                              | body                                                                                       | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentials                         | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/gitCredentials.json                     | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/GitCollectorDataSource.json             | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |                                                                                            | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollector                     | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/GitCollector.json                       | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollector                     |                                                                                            | 200           | PythonSparkSQL         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_Credentials                             | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/pythonSparkLineage_awsCredentials.json  | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JsonS3DataSource/JsonS3DataSource             | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/pythonSparkLineage_awsS3DataSource.json | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JsonS3DataSource/JsonS3DataSource             |                                                                                            | 200           | JsonS3DataSource       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger               | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/pythonSparkLineage_jsonS3Cataloger.json | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger               |                                                                                            | 200           | JsonS3Cataloger        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/SnowflakeValidCredentials                   | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/snowflakeCredentials.json               | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource/SnowflakeDBDataSource   | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/SnowflakeDBDataSource.json              | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBDataSource/SnowflakeDBDataSource   |                                                                                            | 200           | SnowflakeDataSource    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger     | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/SnowflakeCataloger.json                 | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger     |                                                                                            | 200           | SnowflakeDBCataloger   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonParser/PythonParser                     | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/PythonParser.json                       | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonParser/PythonParser                     |                                                                                            | 200           | PythonSparkSQL         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonSparkLineage/PythonSparkLineage         | ida/PythonSparkPayloads/MLP-16306_sql/PluginConfig/PythonSparkLineage.json                 | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonSparkLineage/PythonSparkLineage         |                                                                                            | 200           | PythonSparkSQL         |          |

  @pythonspark @MLP-16306 @sanity
  Scenario Outline: SC#2:Run the Plugin configurations for Git, JsonS3, Snowflake DB Cataloger, Python Parser and Python Spark Lineage
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
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser                    |                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser                     | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser                    |                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage       |                | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage        | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage       |                | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage')].status   |

  Scenario Outline: SC#2:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                    | type    | targetFile                                                     | jsonpath                          |
      | APPDBPOSTGRES | Default | pythonanalyzerdemo                                      | Project | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..Project.id                     |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com            |         | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..Snowflake_Cluster.id           |
      | APPDBPOSTGRES | Default | amazonaws.com                                           |         | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..JsonS3_Cluster.id              |
      | APPDBPOSTGRES | Default | test_BA_PythonSparkSQL                                  |         | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..has_BA.id                      |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN                 |         | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..Git_Analysis.id                |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%DYN |         | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..Snowflake_Analysis.id          |
      | APPDBPOSTGRES | Default | parser/PythonParser/PythonParser%DYN                    |         | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..PParser_Analysis.id            |
      | APPDBPOSTGRES | Default | lineage/PythonSparkLineage/PythonSparkLineage%DYN       |         | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..PythonSparkLineage_Analysis.id |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN           |         | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json | $..JsonS3_Analysis.id             |

  ############################################# API Lineage verification #############################################
  @pythonspark @MLP-16306 @regression @positive
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                                            | asg_scopeid | targetFile                                                                                    | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FiletoFile_TempView                             |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FiletoFile_TempView.json                   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | Json_To_Json_Temp                               |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FiletoFile_TempView.json                   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                 |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FiletoFile_TempView.json                   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FiletoFile_GlobalTempView                       |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FiletoFile_GlobalTempView.json             |              |
      | APPDBPOSTGRES | FunctionID | Default |            | Json_To_Json_GlobalTemp                         |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FiletoFile_GlobalTempView.json             |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                 |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FiletoFile_GlobalTempView.json             | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileToFile_multiple_views                       |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FileToFile_multiple_views.json             |              |
      | APPDBPOSTGRES | FunctionID | Default |            | Json_To_Json_Multiple_views                     |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FileToFile_multiple_views.json             |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                 |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FileToFile_multiple_views.json             | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileToFile_multiple_write                       |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FileToFile_multiple_write.json             |              |
      | APPDBPOSTGRES | FunctionID | Default |            | Json_To_Json_Temp                               |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FileToFile_multiple_write.json             |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                 |             | response/python/pythonSpark/pythonSparkSQL/Lineage/FileToFile_multiple_write.json             | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTable_View                               |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_View.json                     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | Table_To_Table_TempView                         |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_View.json                     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                 |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_View.json                     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTable_GlobalTempView                     |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_GlobalTempView.json           |              |
      | APPDBPOSTGRES | FunctionID | Default |            | Table_To_Table_GlobalTempView                   |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_GlobalTempView.json           |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                 |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_GlobalTempView.json           | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTable_multiple_write_and_views           |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_multiple_write_and_views.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_SFtoSF_multiple_write_multipleTemp_example |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_multiple_write_and_views.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                 |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_multiple_write_and_views.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | TableToTable_SelectAllColumns                   |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_SelectAllColumns.json         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | table_to_table_select                           |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_SelectAllColumns.json         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                 |             | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_SelectAllColumns.json         | $.functionID |

  @pythonspark @MLP-16306 @regression @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                                  | inputFile                                                                                     | outputFile                                                                                |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FiletoFile_TempView                   | response/python/pythonSpark/pythonSparkSQL/Lineage/FiletoFile_TempView.json                   | response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FiletoFile_GlobalTempView             | response/python/pythonSpark/pythonSparkSQL/Lineage/FiletoFile_GlobalTempView.json             | response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileToFile_multiple_views             | response/python/pythonSpark/pythonSparkSQL/Lineage/FileToFile_multiple_views.json             | response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileToFile_multiple_write             | response/python/pythonSpark/pythonSparkSQL/Lineage/FileToFile_multiple_write.json             | response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTable_View                     | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_View.json                     | response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTable_GlobalTempView           | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_GlobalTempView.json           | response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTable_multiple_write_and_views | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_multiple_write_and_views.json | response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | TableToTable_SelectAllColumns         | response/python/pythonSpark/pythonSparkSQL/Lineage/TableToTable_SelectAllColumns.json         | response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json |


  #6892028# #6892031# #6892032# #6892033# #6892034# #6892035# #6892036# #6892037# #6892038# #6892039# #6892040# #6892041# #6892042# #6892043#
  @pythonspark @MLP-16306 @regression @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                            | actual_json                                                                                                 | item                                  |
      | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/expectedPythonSparkLineageSQL.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json | FiletoFile_TempView                   |
      | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/expectedPythonSparkLineageSQL.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json | FiletoFile_GlobalTempView             |
      | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/expectedPythonSparkLineageSQL.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json | FileToFile_multiple_views             |
      | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/expectedPythonSparkLineageSQL.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json | FileToFile_multiple_write             |
      | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/expectedPythonSparkLineageSQL.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json | TableToTable_View                     |
      | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/expectedPythonSparkLineageSQL.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json | TableToTable_GlobalTempView           |
      | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/expectedPythonSparkLineageSQL.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json | TableToTable_multiple_write_and_views |
      | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/expectedPythonSparkLineageSQL.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkSQL/Lineage/PythonSparkLineageSQLSourceTarget.json | TableToTable_SelectAllColumns         |


  ############################################# UI Lineage verification #############################################
  #6892028#
  @webtest @MLP-16306 @sanity @positive
  Scenario: SC#4:UI Lineage verification: - Verify the PythonSparkLineage plugin generates lineage for the python file named 'FileToFileCreateTempView.python' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagPythonSparkSQL" and clicks on search
    And user performs "facet selection" in "tagPythonSparkSQL" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FiletoFile_TempView" item from search results
    Then user performs click and verify in new window
      | Table     | value             | Action               | RetainPrevwindow | indexSwitch |
      | Functions | Json_To_Json_Temp | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table        | value                                            | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                                 | jsonPath       |
      | Lineage Hops | fileToFileTempView.Club => jsonTojson_write.Club | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-16306_sql/LineageMetadata/pythonSparkLineageSQLMetadata.json | $.LineageHop_1 |
    And user should be able logoff the IDC

  ############################################# Post Conditions ##########################################################
  @cr-data @postcondition @sanity @positive
  Scenario Outline: PostConditions:ItemDeletion- User deletes the collected item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                         | inputFile                                                      |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                     | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Snowflake_Cluster.id           | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..JsonS3_Cluster.id              | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                      | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id                | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Snowflake_Analysis.id          | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PParser_Analysis.id            | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PythonSparkLineage_Analysis.id | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JsonS3_Analysis.id             | response/python/pythonSpark/pythonSparkSQL/actual/itemIds.json |

  @MLP-16306 @sanity
  Scenario Outline: PostConditions:Delete the Plugin configurations for Git , JsonS3, Snowflake DB Cataloger, Python Parser and Python Spark Lineage
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
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonParser                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonSparkLineage          |      | 204           |                  |          |


  @aws @cr-data @sanity
  Scenario:PostConditions:Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "PySqlSpark" in bucket "sqlspark"
    Then user "Delete" a bucket "sqlspark" in amazon storage service
