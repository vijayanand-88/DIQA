@MLP-11429
Feature: Validation of Java Spark Lineage plugin functionality after running all prerequisite plugins

  ############################################# Pre Conditions ##########################################################
  @cr-data @precondition @sanity @positive
  Scenario: SC#1:Update credentials from config file
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                                                      | username                   | password                   |
      | ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOracleCredentials.json | $.gitCredentials..userName | $.gitCredentials..password |
    And User update the below "oracle12c credentials" in following files using json path
      | filePath                                                                                      | username                      | password                      |
      | ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOracleCredentials.json | $.oracleCredentials..userName | $.oracleCredentials..password |

  @MLP-11429 @sanity @hdfs @regression @positive
  Scenario: SC#1:Copy the file from local to the user path
    Given user connects to the SFTP server for below parameters
      | sftpAction  | remoteDir                      |
      | copytoLocal | ida/javaSparkPayloads/SparkJar |

  @MLP-11429 @sanity @positive @regression @hbase @sftp
  Scenario: SC#1:Run the spark commands in local machine
    And user connects to cmdprompt and runs java spark commands in local
      | command           | Filename                                                                                                             | JarFile                         |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_Alias_Distinct"                                     | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_dropDuplicates_drop_orderBy_repartition"            | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_Except"                                             | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_Intersect"                                          | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_Join_Hint"                                          | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_repartitionByrange_replace_sort_sortwithpartitions" | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_Union"                                              | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_withColumn"                                         | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_withColumnRenamed"                                  | sparkLineage-0.0.2-SNAPSHOT.jar |
      | JavaSpark2_Remote | "com.java.lineage.transformation.transformoracle12c.Spark_Oracle_summary_limit_describe_sample"                      | sparkLineage-0.0.2-SNAPSHOT.jar |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1:Create Business Application tag for Java Spark Lineage test for Oracle Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/transformation/oracle/JavaSparkTransformOracle_BA.json | 200           |                  |          |

  ############################################# Plugin Run ##########################################################
  @javaspark @MLP-11429
  Scenario Outline: SC#2-Configurations for Plugins - Git, Oracle DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                       | bodyFile                                                                                                 | path                     | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Git_Credentials      | payloads/ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOracleCredentials.json   | $.gitCredentials         | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | payloads/ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOracleDataSources.json   | $.gitCollectorDataSource | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource |                                                                                                          |                          | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector           | payloads/ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOraclePluginConfigs.json | $.gitCollector           | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector           |                                                                                                          |                          | 200           | GitCollector           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle_Credentials   | payloads/ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOracleCredentials.json   | $.oracleCredentials      | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource     | payloads/ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOracleDataSources.json   | $.oracleDBDataSource     | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource     |                                                                                                          |                          | 200           | OracleDBDataSource     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBCataloger      | payloads/ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOraclePluginConfigs.json | $.oracleDBCataloger      | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBCataloger      |                                                                                                          |                          | 200           | OracleDBCataloger      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser             | payloads/ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOraclePluginConfigs.json | $.javaParser             | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser             |                                                                                                          |                          | 200           | JavaParser             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage       | payloads/ida/javaSparkPayloads/transformation/oracle/PluginConfig/transformationOraclePluginConfigs.json | $.javaSparkLineage       | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage       |                                                                                                          |                          | 200           | JavaSparkLineage       |          |

  @javaspark @MLP-11429
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

  Scenario Outline: SC#2:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                              | type    | targetFile                                                           | jsonpath                        |
      | APPDBPOSTGRES | Default | javaspark_lineage                                 | Project | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json | $..Project.id                   |
      | APPDBPOSTGRES | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                   |         | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json | $..Oracle_Cluster.id            |
      | APPDBPOSTGRES | Default | test_BA_JavaSparkTransformOracle                  |         | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json | $..has_BA.id                    |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN           |         | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json | $..Git_Analysis.id              |
      | APPDBPOSTGRES | Default | cataloger/OracleDBCataloger/OracleDBCataloger%DYN |         | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json | $..Oracle_Analysis.id           |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN                  |         | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json | $..JParser_Analysis.id          |
      | APPDBPOSTGRES | Default | lineage/JavaSparkLineage/JavaSparkLineage%DYN     |         | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json | $..JavaSparkLineage_Analysis.id |

  ####################### API Lineage verification #############################################
  @javaspark @MLP-11429 @regression @positive
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                                                            | asg_scopeid | targetFile                                                                                                                    | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_withColumnRenamed                                  |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumnRenamed.json                                  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleWithColumnRenamed                                   |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumnRenamed.json                                  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumnRenamed.json                                  | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_Alias_Distinct                                     |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Alias_Distinct.json                                     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleAliasDistinct                                       |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Alias_Distinct.json                                     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Alias_Distinct.json                                     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_dropDuplicates_drop_orderBy_repartition            |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_dropDuplicates_drop_orderBy_repartition.json            |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleDropDuplicates                                      |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_dropDuplicates_drop_orderBy_repartition.json            |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_dropDuplicates_drop_orderBy_repartition.json            | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_Except                                             |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Except.json                                             |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleExcept                                              |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Except.json                                             |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Except.json                                             | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_Intersect                                          |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Intersect.json                                          |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleIntersect                                           |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Intersect.json                                          |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Intersect.json                                          | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_Join_Hint                                          |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Join_Hint.json                                          |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleJoinHint                                            |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Join_Hint.json                                          |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Join_Hint.json                                          | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_repartitionByrange_replace_sort_sortwithpartitions |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_repartitionByrange_replace_sort_sortwithpartitions.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleReplaceSort                                         |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_repartitionByrange_replace_sort_sortwithpartitions.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_repartitionByrange_replace_sort_sortwithpartitions.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_summary_limit_describe_sample                      |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_summary_limit_describe_sample.json                      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleSummaryLimit                                        |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_summary_limit_describe_sample.json                      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_summary_limit_describe_sample.json                      | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_Union                                              |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Union.json                                              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleUnion                                               |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Union.json                                              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Union.json                                              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_withColumn                                         |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn1.json                                        |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleWithColumnSelect                                    |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn1.json                                        |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn1.json                                        | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_withColumn                                         |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn2.json                                        |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleWithColumnSeperate                                  |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn2.json                                        |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn2.json                                        | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Oracle_withColumn                                         |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn3.json                                        |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadOracleWithColumnIntegerated                               |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn3.json                                        |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                                 |             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn3.json                                        | $.functionID |

  @javaspark @MLP-11429 @regression @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                                                            | inputFile                                                                                                                     | outputFile                                                                                                |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_withColumnRenamed                                  | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumnRenamed.json                                  | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_Alias_Distinct                                     | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Alias_Distinct.json                                     | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_dropDuplicates_drop_orderBy_repartition            | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_dropDuplicates_drop_orderBy_repartition.json            | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_Except                                             | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Except.json                                             | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_Intersect                                          | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Intersect.json                                          | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_Join_Hint                                          | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Join_Hint.json                                          | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_repartitionByrange_replace_sort_sortwithpartitions | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_repartitionByrange_replace_sort_sortwithpartitions.json | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_summary_limit_describe_sample                      | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_summary_limit_describe_sample.json                      | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_Union                                              | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_Union.json                                              | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_withColumn1                                        | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn1.json                                        | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_withColumn2                                        | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn2.json                                        | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Oracle_withColumn3                                        | response/java/javaSpark/javaSparkTransformOracle/Lineage/Spark_Oracle_withColumn3.json                                        | response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json |

  #6694819# #6698451# #6698452# #6698453# #6698463# #6698464# #6698465# #6698466# #6698485# #6698487#
  @javaspark @MLP-11429 @regression @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                            | actual_json                                                                                                                 | item                                                            |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_withColumnRenamed                                  |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_Alias_Distinct                                     |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_dropDuplicates_drop_orderBy_repartition            |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_Except                                             |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_Intersect                                          |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_Join_Hint                                          |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_repartitionByrange_replace_sort_sortwithpartitions |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_summary_limit_describe_sample                      |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_Union                                              |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_withColumn1                                        |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_withColumn2                                        |
      | ida/javaSparkPayloads/transformation/oracle/LineageMetadata/expectedJavaSparkLineageTransformOracle.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTransformOracle/Lineage/JavaSparkLineageTransformOracleSourceTarget.json | Spark_Oracle_withColumn3                                        |


  ###############################TechnologyTagValidation#################################
  @webtest @MLP-11429 @sanity @positive
  Scenario: SC#4:Verify the technology tags got assigned to the Cataloged items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                                         | fileName                    | userTag                     |
      | Default     | File       | Metadata Type | test_BA_JavaSparkTransformOracle,Git,tagJavaSparkTransformOracle,Java,Spark | Spark_Oracle_Join_Hint.java | tagJavaSparkTransformOracle |
      | Default     | SourceTree | Metadata Type | test_BA_JavaSparkTransformOracle,tagJavaSparkTransformOracle,Java,Spark     | Spark_Oracle_Join_Hint      | tagJavaSparkTransformOracle |
#      | Default     | Table      | Metadata Type | test_BA_JavaSparkTransformOracle,tagJavaSparkTransformOracle,Oracle         | JOBSA                       | tagJavaSparkTransformOracle |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkTransformOracle,tagJavaSparkTransformOracle,Java,Spark     | df5_hint                    | tagJavaSparkTransformOracle |
      | Default     | Class      | Metadata Type | test_BA_JavaSparkTransformOracle,tagJavaSparkTransformOracle,Java           | Spark_Oracle_Join_Hint      | tagJavaSparkTransformOracle |
      | Default     | Function   | Metadata Type | test_BA_JavaSparkTransformOracle,tagJavaSparkTransformOracle,Java,Spark     | doReadOracleJoinHint        | tagJavaSparkTransformOracle |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName               | userTag                     |
      | Default     | Class      | Metadata Type | Programming | Spark_Oracle_Join_Hint | tagJavaSparkTransformOracle |
      | Default     | Function   | Metadata Type | Programming | doReadOracleJoinHint   | tagJavaSparkTransformOracle |
      | Default     | SourceTree | Metadata Type | Programming | Spark_Oracle_Join_Hint | tagJavaSparkTransformOracle |
    And user enters the search text "tagJavaSparkTransformOracle" and clicks on search
    And user performs "facet selection" in "tagJavaSparkTransformOracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadOracleJoinHint" item from search results
    Then user performs click and verify in new window
      | Table        | value                                       | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | ADDRESS => QAA_JAVA_JOINTABLES_AUTO.ADDRESS | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_JavaSparkTransformOracle,tagJavaSparkTransformOracle,Java,Spark |
      | item | ADDRESS => QAA_JAVA_JOINTABLES_AUTO.ADDRESS                             |
    And user should be able logoff the IDC

  ############################################# Post Conditions ##########################################################
  @cr-data @postcondition @sanity @positive
  Scenario: SC#5:Delete target tables created in Oracle DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                       | queryField    |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable1  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable2  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable3  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable4  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable5  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable6  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable7  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable8  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable9  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable10 |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable11 |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | oracleQueriesJavaTransformation | DeleteTable12 |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#5:ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                       | inputFile                                                            |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                   | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Oracle_Cluster.id            | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                    | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id              | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Oracle_Analysis.id           | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id          | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaSparkLineage_Analysis.id | response/java/javaSpark/javaSparkTransformOracle/actual/itemIds.json |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#5:ConfigDeletion: Delete the Plugin configurations for Git, Snowflake DB Cataloger, Java Parser and Java Spark Lineage
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

