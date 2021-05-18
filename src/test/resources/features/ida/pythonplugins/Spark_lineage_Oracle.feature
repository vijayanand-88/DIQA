Feature: Feature to validate the lineage created via python spark lineage plugin is correct

    ################################################################################################################################################################################
#  -----------------------HDFS file placing and Spark run-------------------------#

  @MLP-7854 @sanity @hdfs @regression @positive
  Scenario: SC#1-Copy the file from local to the user path
    Given user connects to the SFTP server for below parameters
      | sftpAction  | remoteDir                                                   |
      | copytoLocal | ida/PythonSparkPayloads/MLP-7854                            |
      | copytoLocal | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles |

#  @MLP-7854 @positve @hdfs @regression @sanity @IDA-10.1
#  Scenario Outline:SC#2-Creating a directory in Ambari Files View and Uploading source files into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                                                                | body                                                                                                                                                             | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                                              |                                                                                                                                                                  | 200           |                  |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                                       |                                                                                                                                                                  | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source/userdata1.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                           | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/userdata1.parquet                                                                                    | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source/hdfs.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                   | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/hdfs.json                                                                                            | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source/spark.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                   | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/spark.csv                                                                                            | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source/TestOrcFile.columnProjection.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                            | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/TestOrcFile.columnProjection.orc                                                                     | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletocsvfile.csv/._SUCCESS.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                    | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletocsvfile.csv/._SUCCESS.crc                                                                    | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletocsvfile.csv/.part-00000-8579da89-0d5a-4e10-9ca2-fcc4e86c1af5-c000.csv.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                    | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletocsvfile.csv/.part-00000-8579da89-0d5a-4e10-9ca2-fcc4e86c1af5-c000.csv.crc                    | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletocsvfile.csv/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                         | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletocsvfile.csv/_SUCCESS                                                                         | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletocsvfile.csv/part-00000-8579da89-0d5a-4e10-9ca2-fcc4e86c1af5-c000.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                         | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletocsvfile.csv/part-00000-8579da89-0d5a-4e10-9ca2-fcc4e86c1af5-c000.csv                         | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletoparquetfile.parquet/._SUCCESS.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                            | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletoparquetfile.parquet/._SUCCESS.crc                                                            | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletoparquetfile.parquet/.part-00000-2f2f66d2-653d-42f7-9b07-9ccd4f2ef14a-c000.snappy.parquet.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletoparquetfile.parquet/.part-00000-2f2f66d2-653d-42f7-9b07-9ccd4f2ef14a-c000.snappy.parquet.crc | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletoparquetfile.parquet/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                 | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletoparquetfile.parquet/_SUCCESS                                                                 | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletoparquetfile.parquet/part-00000-2f2f66d2-653d-42f7-9b07-9ccd4f2ef14a-c000.snappy.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true      | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletoparquetfile.parquet/part-00000-2f2f66d2-653d-42f7-9b07-9ccd4f2ef14a-c000.snappy.parquet      | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletoorc.orc/._SUCCESS.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                        | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletoorc.orc/._SUCCESS.crc                                                                        | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletoorc.orc/.part-00000-72bc3655-ffd8-46bf-8bc8-97a127cb7802-c000.snappy.orc.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                 | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletoorc.orc/.part-00000-72bc3655-ffd8-46bf-8bc8-97a127cb7802-c000.snappy.orc.crc                 | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletoorc.orc/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                             | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletoorc.orc/_SUCCESS                                                                             | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_oracle/oracletoorc.orc/part-00000-72bc3655-ffd8-46bf-8bc8-97a127cb7802-c000.snappy.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                      | ida/PythonSparkPayloads/pythonSparkLineage_7854_sourceFiles/oracletoorc.orc/part-00000-72bc3655-ffd8-46bf-8bc8-97a127cb7802-c000.snappy.orc                      | 201           |                  |


  @MLP-7854 @sanity @positive @regression
  Scenario: SC#3-Run the spark commands in local machine
    And user connects to cmdprompt and runs spark commands in local
      | command      | Filename                          |
      | Spark2_Local | oracletoracle_overwrite_select.py |
      | Spark2_Local | oracletoracle_jdbc_select.py      |
      | Spark2_Local | oracletoracle_jdbc_NoSelect.py    |
#      | Spark2_Local | oracle_to_parquet.py               |
#      | Spark2_Local | parquet_to_oracle.py               |
#      | Spark2_Local | oracle_to_csv.py                   |
#      | Spark2_Local | json_to_oracle_oracle_to_json.py   |
#      | Spark2_Local | CsvtoOracle.py                     |
#      | Spark2_Local | orc_to_oracle_And_oracle_to_orc.py |

  @MLP-7854 @sanity @positive @regression
  Scenario: SC#4-Check if the tables are available in ORACLE DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage    | queryField                  |
#      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | PARQUETTOORACLE             |
#      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | ORCTOORACLE                 |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | UPPERSALARYPEOPLES_3COLUMNS |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | UPPERSALARYPEOPLES_NOSELECT |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | EMPLOYEE_DETAILS            |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | UPPERSALARYPEOPLES_NOFILTER |
#      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | JSONTOORACLE                |
#      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | CSVTOORACLE                 |


    ################################################################################################################################################################################
#  --------------------PLUGIN CONFIGURATIONS----------------------------#


  @MLP-7854 @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#5-Precondition:Run the Plugin configurations for Git , Python Parser , Package Linker and Python Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                                     | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/sparkGit                                                             | ida\PythonSparkPayloads\MLP-7854_PluginConfig/GitCredentials.json                        | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                 | ida\PythonSparkPayloads\MLP-7854_PluginConfig/gitDatasourceConfig.json                   | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida\PythonSparkPayloads\MLP-7854_PluginConfig/Git_Pyspark.json                           | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                           |                                                                                          | 200           | GitCollector_7854_OracleAPI |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_7854_OracleAPI  |                                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='GitCollector_7854_OracleAPI')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_7854_OracleAPI   | ida\PythonSparkPayloads\MLP-7854_PluginConfig/Git_Pyspark_empty.json                     | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_7854_OracleAPI  |                                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='GitCollector_7854_OracleAPI')].status |
#     | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                                    | ida\PythonSparkPayloads\MLP-7854_PluginConfig/HDFS_Pyspark.json                        | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                                    |                                                                                        | 200           | HdfsCataloger_Snowflake      |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                                  | ida\PythonSparkPayloads\MLP-7854_PluginConfig/ParquetAnalyzer_Pyspark.json             | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                                  |                                                                                        | 200           | ParquetAnalyzer_Snowflake    |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                                                  | ida\PythonSparkPayloads\MLP-7854_PluginConfig/BigDataAnalyzer_Pyspark.json             | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/BigDataAnalyzer                                                                  |                                                                                        | 200           | BigDataAnalyzer_Snowflake    |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/*/HdfsCataloger/HdfsCataloger_Snowflake                  |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='HdfsCataloger_Snowflake')].status      |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/*/HdfsCataloger/HdfsCataloger_Snowflake                   | ida\PythonSparkPayloads\MLP-7854_PluginConfig/HDFS_Pyspark_empty.json                  | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/*/HdfsCataloger/HdfsCataloger_Snowflake                  |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='HdfsCataloger_Snowflake')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/sparkOracle                                                          | ida\PythonSparkPayloads\MLP-7854_PluginConfig/OracleDBCredentials.json                   | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                                     | ida\PythonSparkPayloads\MLP-7854_PluginConfig/OracleDBDataSource.json                    | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                      | ida\PythonSparkPayloads\MLP-7854_PluginConfig/oracleCatalogerConfig_for_PythonSpark.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                                      |                                                                                          | 200           | OracleDBCataloger_Spark     |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark |                                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='OracleDBCataloger_Spark')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark  | ida\PythonSparkPayloads\MLP-7854_PluginConfig/Oracle_Pyspark_empty.json                  | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark |                                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='OracleDBCataloger_Spark')].status     |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer             |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='ParquetAnalyzer_Snowflake')].status    |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer_Snowflake    | ida\PythonSparkPayloads\MLP-7854_PluginConfig/ParquetAnalyzer_Pyspark_empty.json       | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer_Snowflake   |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='ParquetAnalyzer_Snowflake')].status    |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/ParquetAnalyzer_Snowflake   |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='ParquetAnalyzer_Snowflake')].status    |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer_Snowflake    | ida\PythonSparkPayloads\MLP-7854_PluginConfig/BigDataAnalyzer_Pyspark_empty.json       | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer_Snowflake   |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='BigDataAnalyzer_Snowflake')].status    |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer_Snowflake   |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='BigDataAnalyzer_Snowflake')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonParser                                                           | ida\PythonSparkPayloads\MLP-7854_PluginConfig/Parser_Pyspark.json                        | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonParser                                                           |                                                                                          | 200           | PythonParser_Spark          |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Spark              |                                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='PythonParser_Spark')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_Spark               | ida\PythonSparkPayloads\MLP-7854_PluginConfig/Parser_Pyspark_empty.json                  | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Spark              |                                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='PythonParser_Spark')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonSparkLineage                                                     | ida\PythonSparkPayloads\MLP-7854_PluginConfig/Py_Spark_Pyspark.json                      | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonSparkLineage                                                     |                                                                                          | 200           | PythonSparkLineage_Oracle   |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle      |                                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='PythonSparkLineage_Oracle')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle       | ida\PythonSparkPayloads\MLP-7854_PluginConfig/Py_Spark_Pyspark_empty.json                | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle      |                                                                                          | 200           | IDLE                        | $.[?(@.configurationName=='PythonSparkLineage_Oracle')].status   |



    ################################################################################################################################################################################
#  ----------------------Source tree validation--------------------------#

  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC6 - Check if the count from the collector plugin and SourceTree count matches
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "7854_OracleAPI" and clicks on search
    And user performs "facet selection" in "7854_OracleAPI" attribute under "Tags" facets in Item Search results page
    And user selects the "SourceTree" from the Type
    And verify the count of search list and the Expected count "9" matches


       ################################################################################################################################################################################
#  ----------------------Lineage Hops validation--------------------------#
  #Testcase id - #6528386,6528387,6528384,6528284,6528283,6528285,6528282,6528383,6528388,6528385,6528286,6528287
  @webtest @MLP-7854 @sanity @positive @regression
  Scenario: SC7 - Verify Lineage Hops in UI for alias_distinct function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "7854_OracleAPI" and clicks on search
    And user performs "facet selection" in "7854_OracleAPI" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_dataset_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                      | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                            | jsonPath         |
      | Lineage Hops | EMPLOYEE_DETAILS.EMPLOYEE_ID => oracleDF.EMPLOYEE_ID       | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.EMPLOYEE_ID    |
      | Lineage Hops | EMPLOYEE_DETAILS.FIRST_NAME => oracleDF.FIRST_NAME         | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.FIRST_NAME     |
      | Lineage Hops | EMPLOYEE_DETAILS.LAST_NAME => oracleDF.LAST_NAME           | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.LAST_NAME      |
      | Lineage Hops | EMPLOYEE_DETAILS.EMAIL => oracleDF.EMAIL                   | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.EMAIL          |
      | Lineage Hops | EMPLOYEE_DETAILS.PHONE_NUMBER => oracleDF.PHONE_NUMBER     | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.PHONE_NUMBER   |
      | Lineage Hops | EMPLOYEE_DETAILS.HIRE_DATE => oracleDF.HIRE_DATE           | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.HIRE_DATE      |
      | Lineage Hops | EMPLOYEE_DETAILS.JOB_ID => oracleDF.JOB_ID                 | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.JOB_ID         |
      | Lineage Hops | EMPLOYEE_DETAILS.SALARY => oracleDF.SALARY                 | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.SALARY         |
      | Lineage Hops | EMPLOYEE_DETAILS.COMMISSION_PCT => oracleDF.COMMISSION_PCT | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.COMMISSION_PCT |
      | Lineage Hops | EMPLOYEE_DETAILS.MANAGER_ID => oracleDF.MANAGER_ID         | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.MANAGER_ID     |
      | Lineage Hops | EMPLOYEE_DETAILS.DEPARTMENT_ID => oracleDF.DEPARTMENT_ID   | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.DEPARTMENT_ID  |
      | Lineage Hops | EMPLOYEE_DETAILS.GENDER => oracleDF.GENDER                 | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.GENDER         |
      | Lineage Hops | EMPLOYEE_DETAILS.SSN => oracleDF.SSN                       | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.SSN            |
      | Lineage Hops | FIRST_NAME => UPPERSALARYPEOPLES_3COLUMNS.FIRST_NAME       | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.FIRST_NAME     |
      | Lineage Hops | LAST_NAME => UPPERSALARYPEOPLES_3COLUMNS.LAST_NAME         | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.LAST_NAME      |
      | Lineage Hops | EMAIL => UPPERSALARYPEOPLES_3COLUMNS.EMAIL                 | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\jdbc_dataset_example.json | $.EMAIL          |


    ################################################################################################################################################################################
#  ----------------------Lineage Source and Targets validation--------------------------#

  @webtest @MLP-8130 @sanity @positive @regression
  Scenario Outline:SC08-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                           | asg_scopeid | targetFile                                                                                            | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | oracletoracle_jdbc_NoSelect    |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_oracle_example1_oracletoracle_jdbc_NoSelect.json    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_oracle_example1           |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_oracle_example1_oracletoracle_jdbc_NoSelect.json    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_oracle_example1_oracletoracle_jdbc_NoSelect.json    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | oracletoracle_jdbc_select      |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_oracle_example1_oracletoracle_jdbc_select.json      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_oracle_example1           |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_oracle_example1_oracletoracle_jdbc_select.json      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_oracle_example1_oracletoracle_jdbc_select.json      | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | oracletoracle_overwrite_select |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_dataset_example_oracletoracle_overwrite_select.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_dataset_example           |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_dataset_example_oracletoracle_overwrite_select.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_dataset_example_oracletoracle_overwrite_select.json | $.functionID |

  @webtest @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC08-user retrieves the Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                                                | inputFile                                                                                             | outputFile                                                                                                           |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | jdbc_oracle_example1_oracletoracle_jdbc_NoSelect    | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_oracle_example1_oracletoracle_jdbc_NoSelect.json    | response/PythonSparkLineage/MLP-7854_Lineage/LineageTargets/jdbc_oracle_example1_oracletoracle_jdbc_NoSelect.json    |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | jdbc_oracle_example1_oracletoracle_jdbc_select      | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_oracle_example1_oracletoracle_jdbc_select.json      | response/PythonSparkLineage/MLP-7854_Lineage/LineageTargets/jdbc_oracle_example1_oracletoracle_jdbc_select.json      |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | jdbc_dataset_example_oracletoracle_overwrite_select | response/PythonSparkLineage/MLP-7854_Lineage/jdbc_dataset_example_oracletoracle_overwrite_select.json | response/PythonSparkLineage/MLP-7854_Lineage/LineageTargets/jdbc_dataset_example_oracletoracle_overwrite_select.json |


  @webtest @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC08-Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                                              | actual_json                                                                                                                            | item                                                |
      | \ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\ExpectedLineageTargets\jdbc_oracle_example1_oracletoracle_jdbc_NoSelect.json    | Constant.REST_DIR/response/PythonSparkLineage/MLP-7854_Lineage/LineageTargets/jdbc_oracle_example1_oracletoracle_jdbc_NoSelect.json    | jdbc_oracle_example1_oracletoracle_jdbc_NoSelect    |
      | \ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\ExpectedLineageTargets\jdbc_oracle_example1_oracletoracle_jdbc_select.json      | Constant.REST_DIR/response/PythonSparkLineage/MLP-7854_Lineage/LineageTargets/jdbc_oracle_example1_oracletoracle_jdbc_select.json      | jdbc_oracle_example1_oracletoracle_jdbc_select      |
      | \ida\PythonSparkPayloads\MLP-7854\MLP-7854_LineagePayloads\ExpectedLineageTargets\jdbc_dataset_example_oracletoracle_overwrite_select.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-7854_Lineage/LineageTargets/jdbc_dataset_example_oracletoracle_overwrite_select.json | jdbc_dataset_example_oracletoracle_overwrite_select |


#############################################################################################################################################################################
####################Deleting the plugins configurations data's from UI
####################################################################################################################################################################
###


  @MLP-10467 @sanity @positive
  Scenario: SC09-Delete the cluster , projects
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector_7854_OracleAPI/%  | Analysis |       |       |
      | SingleItemDelete | Default | parser/PythonParser/PythonParser_Spark%               | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger_Spark%  | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/PythonSparkLineage_Oracle% | Analysis |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                                    | Project  |       |       |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                       | Cluster  |       |       |

  @MLP-7854 @sanity @positive
  Scenario Outline: SC09-Delete catalog and Plugin configurations for Git , Python Parser , Package Linker and Python Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollector_7854_OracleAPI     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser/PythonParser_Spark              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBCataloger/OracleDBCataloger_Spark    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSparkLineage/PythonSparkLineage_Oracle |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/sparkGit                                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBDataSource                           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/sparkOracle                                |      | 200           |                  |          |

#############################################################################################################################################################################
####################Deleting Target folders in local , HDFS and drop the tables in Oracle
####################################################################################################################################################################
###


#  @MLP-7854 @positve @hdfs @regression @positive @sanity @IDA-10.2
#  Scenario Outline: SC10-Scenario Outline: Delete the created files in Ambari
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type   | url                                    | body | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/source?op=DELETE&recursive=true |      | 200           |                  |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/Target?op=DELETE&recursive=true |      | 200           |                  |
#

  @jdbc
  Scenario: SC11-Drop  Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema    | Table                       | Database |
      | oracle12c          | DROP      | COLLECTOR | UPPERSALARYPEOPLES_3COLUMNS | col2     |
#      | oracle12c          | DROP      | COLLECTOR | PARQUETTOORACLE             | col2     |
      | oracle12c          | DROP      | COLLECTOR | UPPERSALARYPEOPLES_NOSELECT | col2     |
      | oracle12c          | DROP      | COLLECTOR | UPPERSALARYPEOPLES_NOFILTER | col2     |


  Scenario: SC12-Deleting the entire folder
    Given user connects to the SFTP server for below parameters
      | sftpAction | remoteDir |
      | deleteDir  |           |
