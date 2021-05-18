@8130
Feature: Feature to validate the Python Spark Lineage for Snowflake data source

  @MLP-8130 @sanity @snowflake @regression @positive
  Scenario: SC1 - Copy the file from local to the user path
    Given user connects to the SFTP server for below parameters
      | sftpAction  | remoteDir                                                   |
      | copytoLocal | ida/PythonSparkPayloads/MLP-8130                            |
      | copytoLocal | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles |

#  @MLP-8130 @positve @hdfs @regression @sanity @IDA-10.1
#  Scenario Outline:SC#2Creating a directory in Ambari Files View and Uploading source files into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                                                                      | body                                                                                                                                                                | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                                                    |                                                                                                                                                                     | 200           |                  |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                                          |                                                                                                                                                                     | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source/userdata1.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                 | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/userdata1.parquet                                                                                       | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source/hdfs.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                         | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/hdfs.json                                                                                               | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source/spark.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                         | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/spark.csv                                                                                               | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/source/TestOrcFile.columnProjection.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                  | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/TestOrcFile.columnProjection.orc                                                                        | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketoorc.orc/._SUCCESS.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                        | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketoorc.orc/._SUCCESS.crc                                                                        | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketoorc.orc/.part-00000-49135b17-13ce-48e2-8057-9e1d58e635fd-c000.snappy.orc.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                 | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketoorc.orc/.part-00000-49135b17-13ce-48e2-8057-9e1d58e635fd-c000.snappy.orc.crc                 | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketoorc.orc/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                             | ida/PythonSparkPayloads/pythonSparkLineage_813_sourceFiles/SnowFlaketoorc.orc/_SUCCESS                                                                              | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketoorc.orc/part-00000-49135b17-13ce-48e2-8057-9e1d58e635fd-c000.snappy.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                      | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketoorc.orc/part-00000-49135b17-13ce-48e2-8057-9e1d58e635fd-c000.snappy.orc                      | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketoparquetfile.parquet/._SUCCESS.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                            | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketoparquetfile.parquet/._SUCCESS.crc                                                            | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketoparquetfile.parquet/.part-00000-4646e5d4-bae6-4d83-8027-12adaa84f90a-c000.snappy.parquet.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketoparquetfile.parquet/.part-00000-4646e5d4-bae6-4d83-8027-12adaa84f90a-c000.snappy.parquet.crc | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketoparquetfile.parquet/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                 | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketoparquetfile.parquet/_SUCCESS                                                                 | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketoparquetfile.parquet/part-00000-4646e5d4-bae6-4d83-8027-12adaa84f90a-c000.snappy.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true      | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketoparquetfile.parquet/part-00000-4646e5d4-bae6-4d83-8027-12adaa84f90a-c000.snappy.parquet      | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketocsvfile.csv/._SUCCESS.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                    | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketocsvfile.csv/._SUCCESS.crc                                                                    | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketocsvfile.csv/.part-00000-b4a8489d-59d1-4484-8b5a-a6b1163ce42a-c000.csv.crc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                    | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketocsvfile.csv/.part-00000-b4a8489d-59d1-4484-8b5a-a6b1163ce42a-c000.csv.crc                    | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketocsvfile.csv/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                         | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketocsvfile.csv/_SUCCESS                                                                         | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target_Snowflake/SnowFlaketocsvfile.csv/part-00000-b4a8489d-59d1-4484-8b5a-a6b1163ce42a-c000.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                         | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles/SnowFlaketocsvfile.csv/part-00000-b4a8489d-59d1-4484-8b5a-a6b1163ce42a-c000.csv                         | 201           |                  |


  ################################################################################################################################################################################
#  ----------------------Running Python files in spark--------------------------#

  @MLP-8130 @sanity @positive @regression @snowflake
  Scenario: SC3 - Run the spark commands in local machine
    And user connects to the sftp server or local Machine and runs commands
      | command      | Filename                                  | Env   |
#      | Spark2_Local | CsvtoSnowFlake.py                         | Local |
#      | Spark2_Local | orc_to_SnowFlake_to_SnowFlake_to_orc.py   | Local |
#      | Spark2_Local | parquet_to_SnowFlake.py                   | Local |
#      | Spark2_Local | SnowFlake_to_csv.py                       | Local |
#      | Spark2_Local | SnowFlake_to_parquet.py                   | Local |
      | Spark2_Local | SnowFlake_df_multiple_write.py            | Local |
      | Spark2_Local | SnowFlake_to_SnowFlake_jdbc.py            | Local |
      | Spark2_Local | SnowFlake_to_SnowFlake_jdbc_select.py     | Local |
      | Spark2_Local | SnowFlake_to_SnowFlakeoverwrite_select.py | Local |

    ################################################################################################################################################################################
#  ---------------------Validating Tables in DB--------------------------#

  @MLP-8130 @sanity @positive @regression
  Scenario: SC4 - Check if the tables are available in Snowflake DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage    | queryField                  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SparkLineage | CSVTOSNOWFLAKE              |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SparkLineage | PARQUETTOSNOWFLAKE          |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SparkLineage | STUDENT_TWOCOLUMNS          |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SparkLineage | STUDENT_ONECOLUMN           |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SparkLineage | EMPLOYEE_DATA_GENDER_FILTER |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SparkLineage | FINANCE_DUPLICATE           |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SparkLineage | CUSTOMERS_MANY              |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SparkLineage | NEW_CUSTOMERS               |


    ################################################################################################################################################################################
#  --------------------PLUGIN CONFIGURATIONS----------------------------#


  @MLP-8130 @sanity @positive @regression
  Scenario:SC#5 Add valid Credentials for Git and Snowflake plugins
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                                        | body                                                                     | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/credentials/GitSparkCredentials   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/GitSparkCredentials.json   | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/GitSparkCredentials   |                                                                          | 200           |                  |          |
      |                  |       |       | Put  | settings/credentials/SnowFlake_Credentials | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Snowflake_credentials.json | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/SnowFlake_Credentials |                                                                          | 200           |                  |          |


  @MP-8130 @sanity @positive @regression
  Scenario Outline: SC6 - Run the Plugin configurations for Git , HdfsCataloger , ParquetAnalyzer , BigDataAnalyzer , SnowflakeJDBCCataloger, PythonParser and PythonSparkLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | body                                                                                   | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                         | ida/PythonSparkPayloads/MLP-8130_PluginConfig/GitSparkDataSource.json                  | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                                         |                                                                                        | 200           | GitSpark_SnowflakeDS         |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                                   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Git_Pyspark.json                         | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                                   |                                                                                        | 200           | GitCollector_Snowflake       |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_Snowflake               |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='GitCollector_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_Snowflake                | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Git_Pyspark_empty.json                   | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_Snowflake               |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='GitCollector_Snowflake')].status       |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                                    | ida/PythonSparkPayloads/MLP-8130_PluginConfig/HDFS_Pyspark.json                        | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HdfsCataloger                                                                    |                                                                                        | 200           | HdfsCataloger_Snowflake      |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetAnalyzer                                                                  | ida/PythonSparkPayloads/MLP-8130_PluginConfig/ParquetAnalyzer_Pyspark.json             | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetAnalyzer                                                                  |                                                                                        | 200           | ParquetAnalyzer_Snowflake    |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                                                  | ida/PythonSparkPayloads/MLP-8130_PluginConfig/BigDataAnalyzer_Pyspark.json             | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/BigDataAnalyzer                                                                  |                                                                                        | 200           | BigDataAnalyzer_Snowflake    |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/*/HdfsCataloger/HdfsCataloger_Snowflake                  |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='HdfsCataloger_Snowflake')].status      |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/*/HdfsCataloger/HdfsCataloger_Snowflake                   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/HDFS_Pyspark_empty.json                  | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/*/HdfsCataloger/HdfsCataloger_Snowflake                  |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='HdfsCataloger_Snowflake')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDataSource                                                            | ida/PythonSparkPayloads/MLP-8130_PluginConfig/SnowflakeDS.json                         | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDataSource                                                            |                                                                                        | 200           | SnowFlakeDS                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                           | ida/PythonSparkPayloads/MLP-8130_PluginConfig/SnowflakeCatalogerConfig_for_Python.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                           |                                                                                        | 200           | SnowflakeJDBCCataloger_Spark |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger_Spark |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='SnowflakeJDBCCataloger_Spark')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger_Spark  | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Snowflake_Pyspark_empty.json             | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger_Spark |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='SnowflakeJDBCCataloger_Spark')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer             |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='ParquetAnalyzer_Snowflake')].status    |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer_Snowflake    | ida/PythonSparkPayloads/MLP-8130_PluginConfig/ParquetAnalyzer_Pyspark_empty.json       | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer_Snowflake   |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='ParquetAnalyzer_Snowflake')].status    |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/ParquetAnalyzer_Snowflake   |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='ParquetAnalyzer_Snowflake')].status    |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer_Snowflake    | ida/PythonSparkPayloads/MLP-8130_PluginConfig/BigDataAnalyzer_Pyspark_empty.json       | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer_Snowflake   |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='BigDataAnalyzer_Snowflake')].status    |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer_Snowflake   |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='BigDataAnalyzer_Snowflake')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonParser                                                                   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Parser_Pyspark.json                      | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonParser                                                                   |                                                                                        | 200           | PythonParser_Snowflake       |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Snowflake                  |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='PythonParser_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_Snowflake                   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Parser_Pyspark_empty.json                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Snowflake                  |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='PythonParser_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonSparkLineage                                                             | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Py_Spark_Pyspark.json                    | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonSparkLineage                                                             |                                                                                        | 200           | SparkLineage_Snowflake       |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/*                                |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='SparkLineage_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/*                                 | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Py_Spark_Pyspark.json                    | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/*                                |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='SparkLineage_Snowflake')].status       |

################################################################################################################################################################################
#  ----------------------Tag Validation--------------------------#

  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC8 - Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Spark" and clicks on search
    And user performs "facet selection" in "SnowFlake_Spark" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                              | fileName                 | userTag         |
      | Default     | File     | Metadata Type | Git,SnowFlake_Spark,Python,Spark | parquet to SnowFlake.py  | SnowFlake_Spark |
      | Default     | Table    | Metadata Type | Snowflake,SnowFlake_Spark        | CSVTOSNOWFLAKE           | SnowFlake_Spark |
      | Default     | Class    | Metadata Type | Python,SnowFlake_Spark           | SnowFlake to parquet     | SnowFlake_Spark |
      | Default     | Function | Metadata Type | Python,Spark,SnowFlake_Spark     | jdbc_SFtoSF_JDBC_example | SnowFlake_Spark |
      | Default     | Project  | Metadata Type | Git,SnowFlake_Spark              | pythonanalyzerdemo       | SnowFlake_Spark |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName                             | userTag         |
      | Default     | Class      | Metadata Type | Programming | SnowFlake to parquet                 | SnowFlake_Spark |
      | Default     | Function   | Metadata Type | Programming | jdbc_SFtoSF_JDBC_example             | SnowFlake_Spark |
      | Default     | SourceTree | Metadata Type | Programming | orc to SnowFlake_to_SnowFlake to orc | SnowFlake_Spark |
    And user enters the search text "SnowFlake_Spark" and clicks on search
    And user performs "facet selection" in "SnowFlake_Spark" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_SFtoSF_JDBC_example" item from search results
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | SnowFlake_Spark,Python,Spark |
      | item | jdbc_SFtoSF_JDBC_example     |
    Then user performs click and verify in new window
      | Table        | value                              | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | DEPTID => FINANCE_DUPLICATE.DEPTID | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | SnowFlake_Spark,Python,Spark       |
      | item | DEPTID => FINANCE_DUPLICATE.DEPTID |


    ################################################################################################################################################################################
#  ----------------------Source tree validation--------------------------#

  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC9 - Check if the count from the collector plugin and SourceTree count matches
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Spark" and clicks on search
    And user performs "facet selection" in "SnowFlake_Spark" attribute under "Tags" facets in Item Search results page
    And user selects the "SourceTree" from the Type
    And user get the count of the search list
    And verify the count of search list and the Expected count "9" matches


    ################################################################################################################################################################################
#  ----------------------Lineage Hops validation--------------------------#

   #Testcase id - 6597363, 6597364, 6597365, 6597366, 6597367, 6597368, 6597369, 6597370, 6597371, 6597372, 6597373
  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC10 - Verify Lineage Hops in UI for jdbc_SFtoSF_JDBC_example function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Spark" and clicks on search
    And user performs "facet selection" in "SnowFlake_Spark" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_SFtoSF_JDBC_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                            | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                       | jsonPath       |
      | Lineage Hops | DEPTID => FINANCE_DUPLICATE.DEPTID               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_example.json | $.DEPTID       |
      | Lineage Hops | FINANCE.DEPTID => SF_To_SF_jdbc.DEPTID           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_example.json | $.DEPTID1      |
      | Lineage Hops | FINANCE.PAYROLLDEPT => SF_To_SF_jdbc.PAYROLLDEPT | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_example.json | $.PAYROLLDEPT  |
      | Lineage Hops | FINANCE.PAYROLLID => SF_To_SF_jdbc.PAYROLLID     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_example.json | $.PAYROLLID    |
      | Lineage Hops | FINANCE.SALARY => SF_To_SF_jdbc.SALARY           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_example.json | $.SALARY       |
      | Lineage Hops | PAYROLLDEPT => FINANCE_DUPLICATE.PAYROLLDEPT     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_example.json | $.PAYROLLDEPT1 |
      | Lineage Hops | PAYROLLID => FINANCE_DUPLICATE.PAYROLLID         | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_example.json | $.PAYROLLID1   |
      | Lineage Hops | SALARY => FINANCE_DUPLICATE.SALARY               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_example.json | $.SALARY1      |


  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC11 - Verify Lineage Hops in UI for jdbc_SFtoSF_JDBC_Select_example function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Spark" and clicks on search
    And user performs "facet selection" in "SnowFlake_Spark" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_SFtoSF_JDBC_Select_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                      | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                              | jsonPath  |
      | Lineage Hops | AGE => CUSTOMERS_MANY.AGE                  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_Select_example.json | $.AGE     |
      | Lineage Hops | CUSTOMERS.ADDRESS => SF_to_SF_jdbc.ADDRESS | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_Select_example.json | $.ADDRESS |
      | Lineage Hops | CUSTOMERS.AGE => SF_to_SF_jdbc.AGE         | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_Select_example.json | $.AGE1    |
      | Lineage Hops | CUSTOMERS.ID => SF_to_SF_jdbc.ID           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_Select_example.json | $.ID      |
      | Lineage Hops | CUSTOMERS.NAME => SF_to_SF_jdbc.NAME       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_Select_example.json | $.NAME    |
      | Lineage Hops | ID => CUSTOMERS_MANY.ID                    | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_Select_example.json | $.ID1     |
      | Lineage Hops | NAME => CUSTOMERS_MANY.NAME                | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_JDBC_Select_example.json | $.NAME1   |


  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC12 - Verify Lineage Hops in UI for jdbc_SFtoSF_multiple_write_example function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Spark" and clicks on search
    And user performs "facet selection" in "SnowFlake_Spark" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_SFtoSF_multiple_write_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                      | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                                 | jsonPath         |
      | Lineage Hops | ADDRESS => STUDENT_ONECOLUMN.ADDRESS                       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.ADDRESS        |
      | Lineage Hops | COMMISION_PCT => EMPLOYEE_DATA_GENDER_FILTER.COMMISION_PCT | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.COMMISION_PCT  |
      | Lineage Hops | DEPTID => EMPLOYEE_DATA_GENDER_FILTER.DEPTID               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.DEPTID         |
      | Lineage Hops | EMAIL => EMPLOYEE_DATA_GENDER_FILTER.EMAIL                 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.EMAIL          |
      | Lineage Hops | EMPLOYEE_DATA.COMMISION_PCT => jdbcDF1.COMMISION_PCT       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.COMMISION_PCT1 |
      | Lineage Hops | EMPLOYEE_DATA.DEPTID => jdbcDF1.DEPTID                     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.DEPTID1        |
      | Lineage Hops | EMPLOYEE_DATA.EMAIL => jdbcDF1.EMAIL                       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.EMAIL1         |
      | Lineage Hops | EMPLOYEE_DATA.EMPLOYEE_ID => jdbcDF1.EMPLOYEE_ID           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.EMPLOYEE_ID    |
      | Lineage Hops | EMPLOYEE_DATA.FIRST_NAME => jdbcDF1.FIRST_NAME             | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.FIRST_NAME     |
      | Lineage Hops | EMPLOYEE_DATA.GENDER => jdbcDF1.GENDER                     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.GENDER         |
      | Lineage Hops | EMPLOYEE_DATA.HIREDATE => jdbcDF1.HIREDATE                 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.HIREDATE       |
      | Lineage Hops | EMPLOYEE_DATA.JOBID => jdbcDF1.JOBID                       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.JOBID          |
      | Lineage Hops | EMPLOYEE_DATA.LAST_NAME => jdbcDF1.LAST_NAME               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.LAST_NAME      |
      | Lineage Hops | EMPLOYEE_DATA.MANAGERID => jdbcDF1.MANAGERID               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.MANAGERID      |
      | Lineage Hops | EMPLOYEE_DATA.PHONENUMBER => jdbcDF1.PHONENUMBER           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.PHONENUMBER    |
      | Lineage Hops | EMPLOYEE_DATA.SSN => jdbcDF1.SSN                           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.SSN            |
      | Lineage Hops | EMPLOYEE_ID => EMPLOYEE_DATA_GENDER_FILTER.EMPLOYEE_ID     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.EMPLOYEE_ID1   |
      | Lineage Hops | FIRST_NAME => EMPLOYEE_DATA_GENDER_FILTER.FIRST_NAME       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.FIRST_NAME1    |
      | Lineage Hops | GENDER => EMPLOYEE_DATA_GENDER_FILTER.GENDER               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.GENDER1        |
      | Lineage Hops | HIREDATE => EMPLOYEE_DATA_GENDER_FILTER.HIREDATE           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.HIREDATE1      |
      | Lineage Hops | JOBID => EMPLOYEE_DATA_GENDER_FILTER.JOBID                 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.JOBID1         |
      | Lineage Hops | LAST_NAME => EMPLOYEE_DATA_GENDER_FILTER.LAST_NAME         | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.LAST_NAME1     |
      | Lineage Hops | MANAGERID => EMPLOYEE_DATA_GENDER_FILTER.MANAGERID         | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.MANAGERID1     |
      | Lineage Hops | NAME => STUDENT_TWOCOLUMNS.NAME                            | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.NAME           |
      | Lineage Hops | PHONENUMBER => EMPLOYEE_DATA_GENDER_FILTER.PHONENUMBER     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.PHONENUMBER1   |
      | Lineage Hops | SSN => EMPLOYEE_DATA_GENDER_FILTER.SSN                     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.SSN1           |
      | Lineage Hops | STUDENT.ADDRESS => jdbcDF.ADDRESS                          | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.ADDRESS1       |
      | Lineage Hops | STUDENT.NAME => jdbcDF.NAME                                | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.NAME1          |
      | Lineage Hops | STUDENT.STUDENTID => jdbcDF.STUDENTID                      | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.STUDENTID      |
      | Lineage Hops | STUDENTID => STUDENT_TWOCOLUMNS.STUDENTID                  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_multiple_write_example.json | $.STUDENTID1     |


  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC13 - Verify Lineage Hops in UI for jdbc_SFtoSF_Overwrite_example function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Spark" and clicks on search
    And user performs "facet selection" in "SnowFlake_Spark" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_SFtoSF_Overwrite_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                  | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                            | jsonPath  |
      | Lineage Hops | AGE => NEW_CUSTOMERS.AGE               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_Overwrite_example.json | $.AGE     |
      | Lineage Hops | CUSTOMERS.ADDRESS => SFtoSF_DF.ADDRESS | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_Overwrite_example.json | $.ADDRESS |
      | Lineage Hops | CUSTOMERS.AGE => SFtoSF_DF.AGE         | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_Overwrite_example.json | $.AGE1    |
      | Lineage Hops | CUSTOMERS.ID => SFtoSF_DF.ID           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_Overwrite_example.json | $.ID      |
      | Lineage Hops | CUSTOMERS.NAME => SFtoSF_DF.NAME       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_Overwrite_example.json | $.NAME    |
      | Lineage Hops | ID => NEW_CUSTOMERS.ID                 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_Overwrite_example.json | $.ID1     |
      | Lineage Hops | NAME => NEW_CUSTOMERS.NAME             | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/jdbc_SFtoSF_Overwrite_example.json | $.NAME1   |


    ################################################################################################################################################################################
#  ----------------------Lineage Source and Targets validation--------------------------#


  @webtest @MLP-8130 @sanity @positive @regression
  Scenario Outline:SC14-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                                   | asg_scopeid | targetFile                                                                           | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | SnowFlake_to_SnowFlake_jdbc            |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_JDBC_example.json           |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_SFtoSF_JDBC_example               |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_JDBC_example.json           |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                        |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_JDBC_example.json           | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | SnowFlake_to_SnowFlake_jdbc_select     |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_JDBC_Select_example.json    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_SFtoSF_JDBC_Select_example        |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_JDBC_Select_example.json    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                        |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_JDBC_Select_example.json    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | SnowFlake_df_multiple_write            |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_multiple_write_example.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_SFtoSF_multiple_write_example     |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_multiple_write_example.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                        |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_multiple_write_example.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | SnowFlake_to_SnowFlakeoverwrite_select |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_Overwrite_example.json      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_SFtoSF_Overwrite_example          |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_Overwrite_example.json      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                        |             | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_Overwrite_example.json      | $.functionID |


  @webtest @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC15-user retrieves the Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                                   | inputFile                                                                            | outputFile                                                                                          |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SnowFlake_to_SnowFlake_jdbc            | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_JDBC_example.json           | response/PythonSparkLineage/MLP-8130_Lineage/LineageTargets/jdbc_SFtoSF_JDBC_example.json           |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SnowFlake_to_SnowFlake_jdbc_select     | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_JDBC_Select_example.json    | response/PythonSparkLineage/MLP-8130_Lineage/LineageTargets/jdbc_SFtoSF_JDBC_Select_example.json    |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SnowFlake_df_multiple_write            | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_multiple_write_example.json | response/PythonSparkLineage/MLP-8130_Lineage/LineageTargets/jdbc_SFtoSF_multiple_write_example.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SnowFlake_to_SnowFlakeoverwrite_select | response/PythonSparkLineage/MLP-8130_Lineage/jdbc_SFtoSF_Overwrite_example.json      | response/PythonSparkLineage/MLP-8130_Lineage/LineageTargets/jdbc_SFtoSF_Overwrite_example.json      |


  @webtest @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC16-Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                   | actual_json                                                                                                           | item                                   |
      | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/ExpectedLineageTargets/jdbc_SFtoSF_JDBC_example.json           | Constant.REST_DIR/response/PythonSparkLineage/MLP-8130_Lineage/LineageTargets/jdbc_SFtoSF_JDBC_example.json           | SnowFlake_to_SnowFlake_jdbc            |
      | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/ExpectedLineageTargets/jdbc_SFtoSF_JDBC_Select_example.json    | Constant.REST_DIR/response/PythonSparkLineage/MLP-8130_Lineage/LineageTargets/jdbc_SFtoSF_JDBC_Select_example.json    | SnowFlake_to_SnowFlake_jdbc_select     |
      | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/ExpectedLineageTargets/jdbc_SFtoSF_multiple_write_example.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-8130_Lineage/LineageTargets/jdbc_SFtoSF_multiple_write_example.json | SnowFlake_df_multiple_write            |
      | ida/PythonSparkPayloads/MLP-8130_LineagePayloads/ExpectedLineageTargets/jdbc_SFtoSF_Overwrite_example.json      | Constant.REST_DIR/response/PythonSparkLineage/MLP-8130_Lineage/LineageTargets/jdbc_SFtoSF_Overwrite_example.json      | SnowFlake_to_SnowFlakeoverwrite_select |


    ##########################################################################################################################################################################
  #---------------------- DELETING THE SNOWFLAKE CLUSTER FROM POSTGRES DB --------------------------#

  Scenario Outline: sc#17_1 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                               | type    | targetFile                                                | jsonpath           |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector_Snowflake/%DYN |         | response/pythonsparkLineage/MLP-8130_Lineage/itemIds.json | $..has_Analysis.id |
      | APPDBPOSTGRES | Default | SnowFlake_Spark                                    | Tag     | response/pythonsparkLineage/MLP-8130_Lineage/itemIds.json | $..Tag.id          |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com       | Cluster | response/pythonsparkLineage/MLP-8130_Lineage/itemIds.json | $..Cluster.id      |
      | APPDBPOSTGRES | Default | pythonanalyzerdemo                                 | Project | response/pythonsparkLineage/MLP-8130_Lineage/itemIds.json | $..Project.id      |


  Scenario Outline: sc#17_2 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                                 |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/pythonsparkLineage/MLP-8130_Lineage/itemIds.json |
      | items/Default/Default.Tag:::dynamic          | 204          | $..Tag.id          | response/pythonsparkLineage/MLP-8130_Lineage/itemIds.json |
      | items/Default/Default.Cluster:::dynamic      | 204          | $..Cluster.id      | response/pythonsparkLineage/MLP-8130_Lineage/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id      | response/pythonsparkLineage/MLP-8130_Lineage/itemIds.json |


############################################################################################################################################################################
###################Deleting the plugins configurations
###################################################################################################################################################################

  @MLP-8131 @regression @positive
  Scenario: SC18 - Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollector            |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/SnowflakeDBCataloger    |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/PythonParser            |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/PythonSparkLineage      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/GitSparkCredentials   |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/SnowFlake_Credentials |      | 200           |                  |          |


