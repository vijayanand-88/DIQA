@MLP-10513
Feature:Verification of Java Spark Lineage with Oracle Data Source

  ############################################# Pre Conditions ##########################################################
  @cr-data @precondition @sanity @positive
  Scenario: SC#1:Update credentials from config file
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                                | username    | password    |
      | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/gitCredentials.json | $..userName | $..password |
    And User update the below "oracle12c credentials" in following files using json path
      | filePath                                                                   | username    | password    |
      | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/oracleCredentials.json | $..userName | $..password |

  @jdbc @cr-data @precondition @sanity @positive
  Scenario: SC#1-Create Spark Source data in Oracle DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                 | queryField     |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createTable1   |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord1  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord1a |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord1b |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createTable2   |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord2  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord2a |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord2b |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createTable3   |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord3  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord3a |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createTable4   |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord4  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | OracleQueriesforJavaSpark | createRecord4a |

#  @MLP-10513 @positve @hdfs @regression @sanity @IDA-10.1
#  Scenario Outline:  SC#2-Creating a directory in Ambari Files View and Uploading source files into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                    | body                                              | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | java/source?op=MKDIRS&recursive=true&overwrite=true                                                                                                    |                                                   | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | java/source/spark.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/javaSparkPayloads/MLP-10516/spark.csv         | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | java/source/userdata1.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/javaSparkPayloads/MLP-10516/userdata1.parquet | 201           |                  |
#
#  @MLP-10513 @sanity @hdfs @regression @positive
#  Scenario:  SC#2-Moving the file from local to the folder in Ambari
#    Given user connects to the SFTP server for below parameters
#      | sftpHost        | sftpPort       | sftpUser     | sftpPw       | sftpAction | remoteDir | localDir                                                          |
#      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/javaSparkPayloads/MLP-10513_oracle/Spark_CsvToOracle.java     |
#      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/javaSparkPayloads/MLP-10513_oracle/Spark_OracleToParquet.java |
#      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/javaSparkPayloads/MLP-10513_oracle/Spark_ParquetToOracle.java |
#
#
#  @MLP-10513 @sanity @positive @regression @hbase @sftp
#  Scenario: SC#2-Configuring and Running Spark Commands
#    And user connects to the sftp server or local Machine and runs commands
#      | command | Filename                   | Env    |
#      | SPARK2  | Spark_CsvToOracle.java     | ambari |
#      | SPARK2  | Spark_OracleToParquet.java | ambari |
#      | SPARK2  | Spark_ParquetToOracle.java | ambari |

  @MLP-10513 @sanity @hdfs @regression @positive
  Scenario:  SC#1-Copy the file from local to the user path
    Given user connects to the SFTP server for below parameters
      | sftpAction  | remoteDir                      |
      | copytoLocal | ida/javaSparkPayloads/SparkJar |

  @MLP-10513 @sanity @positive @regression
  Scenario: SC#1-Run the spark commands in local machine for Oracle
    And user connects to cmdprompt and runs java spark commands in local
      | command           | Filename                                                 | JarFile                         |
      | JavaSpark2_Remote | "com.java.lineage.oracle12c.Spark_Oracle_Format_Select"  | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.oracle12c.Spark_Oracle_JDBC"           | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.oracle12c.Spark_Oracle_Multiple_Write" | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.oracle12c.Spark_Oracle_Overwrite"      | sparkLineage-0.0.2-SNAPSHOT.jar |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1:Create Business Application tag for Java Spark Lineage test for Oracle Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/MLP-10513_oracle/JavaSparkOracle_BA.json | 200           |                  |          |

  ############################################# Plugin Run ##########################################################
  @javaspark @MLP-10513
  Scenario Outline: SC#2-Configurations for Plugins - Git, Oracle DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                       | body                                                                            | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Git_Credentials      | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/gitCredentials.json         | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/GitCollectorDataSource.json | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource |                                                                                 | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector           | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/GitCollector.json           | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector           |                                                                                 | 200           | GitCollector           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle_Credentials   | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/oracleCredentials.json      | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource     | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/OracleDBDataSource.json     | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource     |                                                                                 | 200           | OracleDBDataSource     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBCataloger      | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/OracleDBCataloger.json      | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBCataloger      |                                                                                 | 200           | OracleDBCataloger      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser             | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/JavaParser.json             | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser             |                                                                                 | 200           | JavaParser             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage       | ida/javaSparkPayloads/MLP-10513_oracle/PluginConfig/JavaSparkLineage.json       | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage       |                                                                                 | 200           | JavaSparkLineage       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HdfsCataloger          | ida/javaSparkPayloads/HdfsCataloger.json                              | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HdfsCataloger          |                                                                       | 200           | javaSparkLineage       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/BigDataAnalyzer        | ida/javaSparkPayloads/BigDataAnalyzer.json                            | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/BigDataAnalyzer        |                                                                       | 200           | javaSparkLineage       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ParquetAnalyzer        | ida/javaSparkPayloads/ParquetAnalyzer.json                            | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/ParquetAnalyzer        |                                                                       | 200           | javaSparkLineage       |          |

  @javaspark @MLP-10513
  Scenario Outline: SC#2-Run the Plugin configurations for Git, Oracle DB Cataloger, Java Parser, Java Linker and JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body           | response code | response message | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector           |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector            | ida/empty.json | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector           |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  | ida/empty.json | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                  |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser                   | ida/empty.json | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                  |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage     |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage      | ida/empty.json | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage     |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status  |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                   |                                             | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                    | ida/javaSparkPayloads/JavaSparkLineage.json | 200           |                  |                                                             |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                   |                                             | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status          |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer            |                                             | 200           | IDLE             | $.[?(@.configurationName=='BigDataAnalyzer')].status        |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/BigDataAnalyzer/ParquetAnalyzer            |                                             | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status        |

  Scenario Outline: SC#2:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                              | type    | targetFile                                                  | jsonpath                        |
      | APPDBPOSTGRES | Default | automation_repo_java_spark                        | Project | response/java/javaSpark/javaSparkOracle/actual/itemIds.json | $..Project.id                   |
      | APPDBPOSTGRES | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                   |         | response/java/javaSpark/javaSparkOracle/actual/itemIds.json | $..Oracle_Cluster.id            |
      | APPDBPOSTGRES | Default | test_BA_JavaSparkOracle                           |         | response/java/javaSpark/javaSparkOracle/actual/itemIds.json | $..has_BA.id                    |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN           |         | response/java/javaSpark/javaSparkOracle/actual/itemIds.json | $..Git_Analysis.id              |
      | APPDBPOSTGRES | Default | cataloger/OracleDBCataloger/OracleDBCataloger%DYN |         | response/java/javaSpark/javaSparkOracle/actual/itemIds.json | $..Oracle_Analysis.id           |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN                  |         | response/java/javaSpark/javaSparkOracle/actual/itemIds.json | $..JParser_Analysis.id          |
      | APPDBPOSTGRES | Default | lineage/JavaSparkLineage/JavaSparkLineage%DYN     |         | response/java/javaSpark/javaSparkOracle/actual/itemIds.json | $..JavaSparkLineage_Analysis.id |

  ####################### API Lineage verification #############################################
  @javaspark @MLP-10513 @regression @positive
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                        | asg_scopeid | targetFile                                                                       | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_JDBC           |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_JDBC.json           |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleJDBC            |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_JDBC.json           |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                             |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_JDBC.json           | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_Format_Select  |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Format_Select.json  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleFormat          |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Format_Select.json  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                             |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Format_Select.json  | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_Multiple_Write |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Multiple_Write.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleMultipleWrite   |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Multiple_Write.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                             |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Multiple_Write.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_Overwrite      |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Overwrite.json      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleOverwrite       |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Overwrite.json      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                             |             | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Overwrite.json      | $.functionID |

  @javaspark @MLP-10513 @regression @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                        | inputFile                                                                        | outputFile                                                                              |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_Format_Select  | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Format_Select.json  | response/java/javaSpark/javaSparkOracle/Lineage/JavaSparkLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_JDBC           | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_JDBC.json           | response/java/javaSpark/javaSparkOracle/Lineage/JavaSparkLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_Multiple_Write | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Multiple_Write.json | response/java/javaSpark/javaSparkOracle/Lineage/JavaSparkLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_Overwrite      | response/java/javaSpark/javaSparkOracle/Lineage/Spark_Oracle_Overwrite.json      | response/java/javaSpark/javaSparkOracle/Lineage/JavaSparkLineageOracleSourceTarget.json |

  #6635224# #6635343# #6635407# #6635409#
  @javaspark @MLP-10513 @regression @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                              | actual_json                                                                                               | item                        |
      | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/expectedJavaSparkLineageOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkOracle/Lineage/JavaSparkLineageOracleSourceTarget.json | Spark_Oracle_Format_Select  |
      | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/expectedJavaSparkLineageOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkOracle/Lineage/JavaSparkLineageOracleSourceTarget.json | Spark_Oracle_JDBC           |
      | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/expectedJavaSparkLineageOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkOracle/Lineage/JavaSparkLineageOracleSourceTarget.json | Spark_Oracle_Multiple_Write |
      | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/expectedJavaSparkLineageOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkOracle/Lineage/JavaSparkLineageOracleSourceTarget.json | Spark_Oracle_Overwrite      |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-10513 @sanity @positive
  Scenario: SC#4:UI Lineage verification: - Verify the JavaSparkLineage plugin generates lineage for the java file named 'Spark_Oracle_JDBC.java' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaSparkOracle" and clicks on search
    And user performs "facet selection" in "tagJavaSparkOracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "doReadOracleJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                         | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                                   | jsonPath       |
      | Lineage Hops | DEPARTMENTA.DEPTBLOCK => jdbcDF_ms2.DEPTBLOCK | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/javaSparkLineageOracleMetadata.json | $.LineageHop_1 |
      | Lineage Hops | DEPARTMENTA.DEPTID => jdbcDF_ms2.DEPTID       | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/javaSparkLineageOracleMetadata.json | $.LineageHop_2 |
      | Lineage Hops | DEPARTMENTA.DEPTNAME => jdbcDF_ms2.DEPTNAME   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/javaSparkLineageOracleMetadata.json | $.LineageHop_3 |
      | Lineage Hops | DEPTBLOCK => WRITE_QA_DEPARTMENTA.DEPTBLOCK   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/javaSparkLineageOracleMetadata.json | $.LineageHop_4 |
      | Lineage Hops | DEPTID => WRITE_QA_DEPARTMENTA.DEPTID         | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/javaSparkLineageOracleMetadata.json | $.LineageHop_5 |
      | Lineage Hops | DEPTNAME => WRITE_QA_DEPARTMENTA.DEPTNAME     | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10513_oracle/LineageMetadata/javaSparkLineageOracleMetadata.json | $.LineageHop_6 |

  ###############################TechnologyTagValidation#################################
  @webtest @MLP-10513 @sanity @positive @regression
  Scenario: SC#5:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaSparkOracle" and clicks on search
    And user performs "facet selection" in "tagJavaSparkOracle" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                       | fileName               | userTag            |
      | Default     | File       | Metadata Type | test_BA_JavaSparkOracle,Git,tagJavaSparkOracle,Java,Spark | Spark_Oracle_JDBC.java | tagJavaSparkOracle |
      | Default     | SourceTree | Metadata Type | test_BA_JavaSparkOracle,tagJavaSparkOracle,Java,Spark     | Spark_Oracle_JDBC      | tagJavaSparkOracle |
#      | Default     | Table      | Metadata Type | test_BA_JavaSparkOracle,tagJavaSparkOracle,Oracle         | JOBSA                  | tagJavaSparkOracle |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkOracle,tagJavaSparkOracle,Java,Spark     | jdbcDF_ms2             | tagJavaSparkOracle |
      | Default     | Class      | Metadata Type | test_BA_JavaSparkOracle,tagJavaSparkOracle,Java           | Spark_Oracle_JDBC      | tagJavaSparkOracle |
      | Default     | Function   | Metadata Type | test_BA_JavaSparkOracle,tagJavaSparkOracle,Java,Spark     | doReadOracleJDBC       | tagJavaSparkOracle |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName          | userTag            |
      | Default     | Class      | Metadata Type | Programming | Spark_Oracle_JDBC | tagJavaSparkOracle |
      | Default     | Function   | Metadata Type | Programming | doReadOracleJDBC  | tagJavaSparkOracle |
      | Default     | SourceTree | Metadata Type | Programming | Spark_Oracle_JDBC | tagJavaSparkOracle |
    And user enters the search text "tagJavaSparkOracle" and clicks on search
    And user performs "facet selection" in "tagJavaSparkOracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadOracleJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                         | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | DEPARTMENTA.DEPTBLOCK => jdbcDF_ms2.DEPTBLOCK | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_JavaSparkOracle,tagJavaSparkOracle,Java,Spark |
      | item | DEPARTMENTA.DEPTBLOCK => jdbcDF_ms2.DEPTBLOCK         |
    And user should be able logoff the IDC

  ############################################# Post Conditions ##########################################################
  @cr-data @postcondition @sanity @positive
  Scenario: SC#6-Delete required tables in Oracle DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema    | Database  | Table                         |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | jobsa                         |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | departmenta                   |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | personsa                      |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | customersa                    |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | write_qa_jobsa                |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | write_qa_departmenta          |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | write_qa1_personsa            |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | write_qa2_personsa            |
      | oracle12c          | DROP      | COLLECTOR | ORACLE12C | write_qa_overwrite_customersa |
#      | oracle             | DROP      | COLLECTOR | col2     | publishersa                   |
#      | oracle             | DROP      | COLLECTOR | col2     | qa_parquettomssqla            |
#      | oracle             | DROP      | COLLECTOR | col2     | qa_csvtomssqla                |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#6:ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                       | inputFile                                                   |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                   | response/java/javaSpark/javaSparkOracle/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Oracle_Cluster.id            | response/java/javaSpark/javaSparkOracle/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                    | response/java/javaSpark/javaSparkOracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id              | response/java/javaSpark/javaSparkOracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Oracle_Analysis.id           | response/java/javaSpark/javaSparkOracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id          | response/java/javaSpark/javaSparkOracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaSparkLineage_Analysis.id | response/java/javaSpark/javaSparkOracle/actual/itemIds.json |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#6:ConfigDeletion: Delete the Plugin configurations for Git, Snowflake DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Git_Credentials      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle_Credentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage       |      | 204           |                  |          |
