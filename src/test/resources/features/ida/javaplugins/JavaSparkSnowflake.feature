@MLP-10516
Feature:Verification of Java Spark Lineage with Snowflake Data Source

  ############################################# Pre Conditions ##########################################################
  @cr-data @precondition @sanity @positive
  Scenario: SC#1:Update credentials from config file
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                                   | username    | password    |
      | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/gitCredentials.json | $..userName | $..password |
    And User update the below "snowflake credentials" in following files using json path
      | filePath                                                                         | username    | password    |
      | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/snowflakeCredentials.json | $..userName | $..password |

  @cr-data @precondition @sanity @positive
  Scenario: SC#1:Create Spark Source data in SNOWFLAKE DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                    | queryField    |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createSchema  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable1  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord1 |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createTable2  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | createRecord2 |

#  @MLP-10516 @positve @hdfs @regression @sanity @IDA-10.1
#  Scenario Outline: SC#2 Creating a directory in Ambari Files View and Uploading source files into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                              | body                                                        | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source?op=MKDIRS&recursive=true&overwrite=true                                                                                                    |                                                             | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/spark.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/javaSparkPayloads/MLP-10516_snowflake/spark.csv         | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/userdata1.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/javaSparkPayloads/MLP-10516_snowflake/userdata1.parquet | 201           |                  |
#
#  @MLP-10516 @sanity @hdfs @regression @positive
#  Scenario:SC#3 Moving the file from local to the folder in Ambari
#    Given user connects to the SFTP server for below parameters
#      | sftpHost        | sftpPort       | sftpUser     | sftpPw       | sftpAction | remoteDir | localDir                                                                |
#      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/javaSparkPayloads/MLP-10516_snowflake/Spark_CsvToSnowflake.java     |
#      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/javaSparkPayloads/MLP-10516_snowflake/Spark_ParquetToSnowflake.java |
#      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/javaSparkPayloads/MLP-10516_snowflake/Spark_SnowflakeToParquet.java |
#
#
#  @MLP-10516 @sanity @positive @regression @hbase @sftp
#  Scenario: SC#4 Configuring and Running Spark Commands
#    And user connects to the sftp server or local Machine and runs commands
#      | command | Filename                      | Env    |
#      | SPARK2  | Spark_CsvToSnowflake.java     | ambari |
#      | SPARK2  | Spark_ParquetToSnowflake.java | ambari |
#      | SPARK2  | Spark_SnowflakeToParquet.java | ambari |

  @cr-data @precondition @sanity @positive
  Scenario: SC#1:Copy the file from local to the user path
    Given user connects to the SFTP server for below parameters
      | sftpAction  | remoteDir                      |
      | copytoLocal | ida/javaSparkPayloads/SparkJar |

  @cr-data @precondition @sanity @positive
  Scenario: SC#1:Run the spark commands in local machine for Snowflake
    And user connects to cmdprompt and runs java spark commands in local
      | command           | Filename                                                    | JarFile                         |
      | JavaSpark2_Remote | "com.java.lineage.snowflake.Spark_Snowflake_Format_Select"  | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.snowflake.Spark_Snowflake_JDBC"           | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.snowflake.Spark_Snowflake_Multiple_Write" | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.snowflake.Spark_Snowflake_Overwrite"      | sparkLineage-0.0.2-SNAPSHOT.jar |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1:Create Business Application tag for Java Spark Lineage test for Snowflake Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                 | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/MLP-10516_snowflake/JavaSparkSnowflake_BA.json | 200           |                  |          |

  ############################################# Plugin Run ##########################################################
  @javaspark @MLP-10516
  Scenario Outline: SC#2:Configurations for Plugins - Git, Snowflake DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | body                                                                               | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentials       | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/gitCredentials.json         | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource      | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/GitCollectorDataSource.json | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource      |                                                                                    | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector                | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/GitCollector.json           | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector                |                                                                                    | 200           | GitCollector           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/SnowflakeValidCredentials | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/snowflakeCredentials.json   | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource       | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/SnowflakeDBDataSource.json  | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBDataSource       |                                                                                    | 200           | SnowflakeDataSource    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBCataloger        | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/SnowflakeCataloger.json     | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBCataloger        |                                                                                    | 200           | SnowflakeDBCataloger   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser                  | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/JavaParser.json             | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser                  |                                                                                    | 200           | JavaParser             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage            | ida/javaSparkPayloads/MLP-10516_snowflake/PluginConfig/JavaSparkLineage.json       | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage            |                                                                                    | 200           | JavaSparkLineage       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HdfsCataloger          | ida/javaSparkPayloads/HdfsCataloger.json                              | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HdfsCataloger          |                                                                       | 200           | javaSparkLineage       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/BigDataAnalyzer        | ida/javaSparkPayloads/BigDataAnalyzer.json                            | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/BigDataAnalyzer        |                                                                       | 200           | javaSparkLineage       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ParquetAnalyzer        | ida/javaSparkPayloads/ParquetAnalyzer.json                            | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/ParquetAnalyzer        |                                                                       | 200           | javaSparkLineage       |          |

  @javaspark @MLP-10516
  Scenario Outline: SC#2:Run the Plugin configurations for Git, Snowflake DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body           | response code | response message | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                 |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                  | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                 |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                        |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser                         | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                        |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage           |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage            | ida/empty.json | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage           |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status     |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                   |                                             | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                    | ida/javaSparkPayloads/JavaSparkLineage.json | 200           |                  |                                                             |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HdfsCataloger/HdfsCataloger                   |                                             | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status          |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer            |                                             | 200           | IDLE             | $.[?(@.configurationName=='BigDataAnalyzer')].status        |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/BigDataAnalyzer/ParquetAnalyzer            |                                             | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status        |

  Scenario Outline: SC#2:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                    | type    | targetFile                                                     | jsonpath                        |
      | APPDBPOSTGRES | Default | automation_repo_java_spark                              | Project | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json | $..Project.id                   |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com            |         | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json | $..Snowflake_Cluster.id         |
      | APPDBPOSTGRES | Default | test_BA_JavaSparkSnowflake                              |         | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json | $..has_BA.id                    |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN                 |         | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json | $..Git_Analysis.id              |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%DYN |         | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json | $..Snowflake_Analysis.id        |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN                        |         | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json | $..JParser_Analysis.id          |
      | APPDBPOSTGRES | Default | lineage/JavaSparkLineage/JavaSparkLineage%DYN           |         | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json | $..JavaSparkLineage_Analysis.id |

  ############################################# API Lineage verification #############################################

  @javaspark @MLP-10516 @regression @positive
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                           | asg_scopeid | targetFile                                                                             | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Snowflake_JDBC           |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_JDBC.json           |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadSnowflakeJDBC            |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_JDBC.json           |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_JDBC.json           | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Snowflake_Format_Select  |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Format_Select.json  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadSnowflakeFormat          |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Format_Select.json  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Format_Select.json  | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Snowflake_Multiple_Write |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Multiple_Write.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadSnowflakeMultipleWrite   |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Multiple_Write.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Multiple_Write.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Snowflake_Overwrite      |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Overwrite.json      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadSnowflakeOverwrite       |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Overwrite.json      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Overwrite.json      | $.functionID |

  @javaspark @MLP-10516 @regression @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                           | inputFile                                                                              | outputFile                                                                                    |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Snowflake_Format_Select  | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Format_Select.json  | response/java/javaSpark/javaSparkSnowflake/Lineage/JavaSparkLineageSnowflakeSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Snowflake_JDBC           | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_JDBC.json           | response/java/javaSpark/javaSparkSnowflake/Lineage/JavaSparkLineageSnowflakeSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Snowflake_Multiple_Write | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Multiple_Write.json | response/java/javaSpark/javaSparkSnowflake/Lineage/JavaSparkLineageSnowflakeSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Snowflake_Overwrite      | response/java/javaSpark/javaSparkSnowflake/Lineage/Spark_Snowflake_Overwrite.json      | response/java/javaSpark/javaSparkSnowflake/Lineage/JavaSparkLineageSnowflakeSourceTarget.json |

  #6638644# #6638645# #6638646# #6638647#
  @javaspark @MLP-10516 @regression @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                    | actual_json                                                                                                     | item                           |
      | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/expectedJavaSparkLineageSnowflake.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSnowflake/Lineage/JavaSparkLineageSnowflakeSourceTarget.json | Spark_Snowflake_Format_Select  |
      | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/expectedJavaSparkLineageSnowflake.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSnowflake/Lineage/JavaSparkLineageSnowflakeSourceTarget.json | Spark_Snowflake_JDBC           |
      | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/expectedJavaSparkLineageSnowflake.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSnowflake/Lineage/JavaSparkLineageSnowflakeSourceTarget.json | Spark_Snowflake_Multiple_Write |
      | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/expectedJavaSparkLineageSnowflake.json | Constant.REST_DIR/response/java/javaSpark/javaSparkSnowflake/Lineage/JavaSparkLineageSnowflakeSourceTarget.json | Spark_Snowflake_Overwrite      |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-10516 @sanity @positive
  Scenario: SC#4:UI Lineage verification: - Verify the JavaSparkLineage plugin generates lineage for the java file named 'Spark_Snowflake_JDBC.java' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaSparkSnowflake" and clicks on search
    And user performs "facet selection" in "tagJavaSparkSnowflake" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "doReadSnowflakeJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                               | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                                         | jsonPath        |
      | Lineage Hops | EMPLOYEE_DATA.EMAIL => jdbcDF_sf2.EMAIL             | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_1  |
      | Lineage Hops | EMPLOYEE_DATA.EMPLOYEE_ID => jdbcDF_sf2.EMPLOYEE_ID | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_2  |
      | Lineage Hops | EMPLOYEE_DATA.FIRST_NAME => jdbcDF_sf2.FIRST_NAME   | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_3  |
      | Lineage Hops | EMPLOYEE_DATA.LAST_NAME => jdbcDF_sf2.LAST_NAME     | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_4  |
      | Lineage Hops | EMPLOYEE_DATA.PHONENUMBER => jdbcDF_sf2.PHONENUMBER | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_5  |
      | Lineage Hops | EMAIL => WRITEQA_EMPLOYEE_DATA.EMAIL                | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_6  |
      | Lineage Hops | EMPLOYEE_ID => WRITEQA_EMPLOYEE_DATA.EMPLOYEE_ID    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_7  |
      | Lineage Hops | FIRST_NAME => WRITEQA_EMPLOYEE_DATA.FIRST_NAME      | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_8  |
      | Lineage Hops | LAST_NAME => WRITEQA_EMPLOYEE_DATA.LAST_NAME        | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_9  |
      | Lineage Hops | PHONENUMBER => WRITEQA_EMPLOYEE_DATA.PHONENUMBER    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/MLP-10516_snowflake/LineageMetadata/javaSparkLineageSnowflakeMetadata.json | $.LineageHop_10 |

  #6902516# #6902517#
  @webtest @MLP-16271 @sanity @positive @regression
  Scenario: SC#5:Verify the highlighted line of source code which is responsible for data propogation in Lineage Hops - Copy and transform mode - format api
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaSparkSnowflake" and clicks on search
    And user performs "facet selection" in "tagJavaSparkSnowflake" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "doReadSnowflakeFormat" item from search results
    Then user performs click and verify in new window
      | Table        | value                                   | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | ADULT_PEOPLE_TEST.age => jdbcDF_sf1.age | click and switch tab | Yes              | 1           |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | ADULT_PEOPLE_TEST.age => jdbcDF_sf1.age                                      |
      | attributeName  | locations                                                                    |
      | actualFilePath | ida/javaSparkPayloads/MLP-10516_snowflake/TestData/actualLocations1Data.json |
    Then file content in "ida/javaSparkPayloads/MLP-10516_snowflake/TestData/expectedLocations1Data.json" should be same as the content in "ida/javaSparkPayloads/MLP-10516_snowflake/TestData/actualLocations1Data.json"
    And user switches to the browser window of index "0"
    Then user performs click and verify in new window
      | Table        | value                         | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | age => QA_JAVA_ADULT_TEST.age | click and switch tab | Yes              | 1           |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | age => QA_JAVA_ADULT_TEST.age                                                |
      | attributeName  | locations                                                                    |
      | actualFilePath | ida/javaSparkPayloads/MLP-10516_snowflake/TestData/actualLocations2Data.json |
    Then file content in "ida/javaSparkPayloads/MLP-10516_snowflake/TestData/expectedLocations2Data.json" should be same as the content in "ida/javaSparkPayloads/MLP-10516_snowflake/TestData/actualLocations2Data.json"
    And user switches to the browser window of index "0"
    And user should be able logoff the IDC

  #6902518# #6902519#
  @webtest @MLP-16271 @sanity @positive @regression
  Scenario: SC#6:Verify the highlighted line of source code which is responsible for data propogation in Lineage Hops - Copy and transform mode - jdbc api
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaSparkSnowflake" and clicks on search
    And user performs "facet selection" in "tagJavaSparkSnowflake" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "doReadSnowflakeJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                             | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | EMPLOYEE_DATA.FIRST_NAME => jdbcDF_sf2.FIRST_NAME | click and switch tab | Yes              | 1           |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | EMPLOYEE_DATA.FIRST_NAME => jdbcDF_sf2.FIRST_NAME                            |
      | attributeName  | locations                                                                    |
      | actualFilePath | ida/javaSparkPayloads/MLP-10516_snowflake/TestData/actualLocations3Data.json |
    Then file content in "ida/javaSparkPayloads/MLP-10516_snowflake/TestData/expectedLocations3Data.json" should be same as the content in "ida/javaSparkPayloads/MLP-10516_snowflake/TestData/actualLocations3Data.json"
    And user switches to the browser window of index "0"
    Then user performs click and verify in new window
      | Table        | value                                          | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | FIRST_NAME => WRITEQA_EMPLOYEE_DATA.FIRST_NAME | click and switch tab | Yes              | 1           |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | FIRST_NAME => WRITEQA_EMPLOYEE_DATA.FIRST_NAME                               |
      | attributeName  | locations                                                                    |
      | actualFilePath | ida/javaSparkPayloads/MLP-10516_snowflake/TestData/actualLocations4Data.json |
    Then file content in "ida/javaSparkPayloads/MLP-10516_snowflake/TestData/expectedLocations4Data.json" should be same as the content in "ida/javaSparkPayloads/MLP-10516_snowflake/TestData/actualLocations4Data.json"
    And user switches to the browser window of index "0"
    And user should be able logoff the IDC

  ###############################TechnologyTagValidation#################################

  @webtest @MLP-10516 @sanity @positive @regression
  Scenario: SC#7:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaSparkSnowflake" and clicks on search
    And user performs "facet selection" in "tagJavaSparkSnowflake" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                             | fileName                  | userTag               |
      | Default     | File       | Metadata Type | test_BA_JavaSparkSnowflake,Git,tagJavaSparkSnowflake,Java,Spark | Spark_Snowflake_JDBC.java | tagJavaSparkSnowflake |
      | Default     | SourceTree | Metadata Type | test_BA_JavaSparkSnowflake,tagJavaSparkSnowflake,Java,Spark     | Spark_Snowflake_JDBC      | tagJavaSparkSnowflake |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkSnowflake,tagJavaSparkSnowflake,Snowflake      | EMPLOYEE_DATA             | tagJavaSparkSnowflake |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkSnowflake,tagJavaSparkSnowflake,Java,Spark     | jdbcDF_sf2                | tagJavaSparkSnowflake |
      | Default     | Class      | Metadata Type | test_BA_JavaSparkSnowflake,tagJavaSparkSnowflake,Java           | Spark_Snowflake_JDBC      | tagJavaSparkSnowflake |
      | Default     | Function   | Metadata Type | test_BA_JavaSparkSnowflake,tagJavaSparkSnowflake,Java,Spark     | doReadSnowflakeJDBC       | tagJavaSparkSnowflake |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName             | userTag               |
      | Default     | Class      | Metadata Type | Programming | Spark_Snowflake_JDBC | tagJavaSparkSnowflake |
      | Default     | Function   | Metadata Type | Programming | doReadSnowflakeJDBC  | tagJavaSparkSnowflake |
      | Default     | SourceTree | Metadata Type | Programming | Spark_Snowflake_JDBC | tagJavaSparkSnowflake |
    And user enters the search text "tagJavaSparkSnowflake" and clicks on search
    And user performs "facet selection" in "tagJavaSparkSnowflake" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadSnowflakeJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                             | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | EMPLOYEE_DATA.FIRST_NAME => jdbcDF_sf2.FIRST_NAME | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_JavaSparkSnowflake,tagJavaSparkSnowflake,Java,Spark |
      | item | EMPLOYEE_DATA.FIRST_NAME => jdbcDF_sf2.FIRST_NAME           |
    And user should be able logoff the IDC

  ############################################# Post Conditions ##########################################################
  @cr-data @postcondition @sanity @positive
  Scenario: SC#8:Delete Spark Source data and Spark Target data in SNOWFLAKE DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                    | queryField   |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | SNOWFLAKEQueriesforJavaSpark | deleteSchema |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#8:ItemDeletion- User deletes the collected item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                       | inputFile                                                      |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                   | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Snowflake_Cluster.id         | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                    | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id              | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Snowflake_Analysis.id        | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id          | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaSparkLineage_Analysis.id | response/java/javaSpark/javaSparkSnowflake/actual/itemIds.json |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#8:ConfigDeletion: Delete the Plugin configurations for Git, Snowflake DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                            | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBCataloger        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBDataSource       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentials       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/SnowflakeValidCredentials |      | 200           |                  |          |
