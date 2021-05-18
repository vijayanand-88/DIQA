Feature: Feature to validate the lineage created via  Java spark lineage plugin is correct

  ############################################# Pre Conditions ##########################################################
  # 6644896 to # 6644899# 6644900 to # 6644911 #6653074 to #6653079
  @MLP-10515 @positve @hdfs @regression @sanity @IDA-10.1
  Scenario Outline: SC#1:Creating a directory in Ambari Files View and Uploading source files into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                                                           | body                                                                     | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                                 |                                                                          | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/city.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                       | ida/javaSparkPayloads/hdfs/Sourcefiles/city.csv                          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/spark.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                      | ida/javaSparkPayloads/hdfs/Sourcefiles/spark.csv                         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/commands.txt?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                   | ida/javaSparkPayloads/hdfs/Sourcefiles/commands.txt                      | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/hdfs1.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                     | ida/javaSparkPayloads/hdfs/Sourcefiles/hdfs1.json                        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/students.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                   | ida/javaSparkPayloads/hdfs/Sourcefiles/students.orc                      | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/users.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                  | ida/javaSparkPayloads/hdfs/Sourcefiles/users.parquet                     | 201           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/country?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                         |                                                                          | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/system?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                          |                                                                          | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                     |                                                                          | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/Target?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                                 |                                                                          | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/cityTarget/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                | ida/javaSparkPayloads/hdfs/Targetfiles/cityTarget/_SUCCESS               | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/cityTarget/part-00000-1b56678e-5686-4f98-b721-f633e8d4a079-c000.snappy.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true     | ida/javaSparkPayloads/hdfs/Targetfiles/cityTarget/part-00000.parquet     | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/studentsTarget/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                            | ida/javaSparkPayloads/hdfs/Targetfiles/studentsTarget/_SUCCESS           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/studentsTarget/part-00000-ffd8423f-bd16-40e2-9cef-a3d8abbf4288-c000.snappy.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/javaSparkPayloads/hdfs/Targetfiles/studentsTarget/part-00000.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/hdfs1Target/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                               | ida/javaSparkPayloads/hdfs/Targetfiles/hdfs1Target/_SUCCESS              | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/hdfs1Target/part-00000-d9ad2e3d-8a7e-465c-8129-e19617a9f70f-c000.snappy.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true    | ida/javaSparkPayloads/hdfs/Targetfiles/hdfs1Target/part-00000.parquet    | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/usersTarget/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                               | ida/javaSparkPayloads/hdfs/Targetfiles/usersTarget/_SUCCESS              | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/usersTarget/part-00000-ec4f9dfb-d6d5-41f4-83c7-5b63e3c6eb02-c000.snappy.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/javaSparkPayloads/hdfs/Targetfiles/usersTarget/part-00000.orc        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/usersTarget1/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                              | ida/javaSparkPayloads/hdfs/Targetfiles/usersTarget1/_SUCCESS             | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/usersTarget1/part-00000-14e3f78f-0b0a-47ea-a9d4-43cc552409c6-c000.snappy.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true   | ida/javaSparkPayloads/hdfs/Targetfiles/usersTarget1/part-00000.parquet   | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/commandsTarget1/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                           | ida/javaSparkPayloads/hdfs/Targetfiles/commandsTarget1/_SUCCESS          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/commandsTarget1/part-00000-3b5d4a2f-93d1-4753-b078-5306d0c3fe82-c000.txt?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true           | ida/javaSparkPayloads/hdfs/Targetfiles/commandsTarget1/part-00000.txt    | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/hdfs1Target_01/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                            | ida/javaSparkPayloads/hdfs/Targetfiles/hdfs1Target_01/_SUCCESS           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/hdfs1Target_01/part-00000-d97be388-5d0f-433d-9702-cac7dbde245b-c000.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true           | ida/javaSparkPayloads/hdfs/Targetfiles/hdfs1Target_01/part-00000.json    | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/sparkTarget/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                               | ida/javaSparkPayloads/hdfs/Targetfiles/sparkTarget/_SUCCESS              | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/source/Load/Target/sparkTarget/part-00000-01ac7a41-5960-47f6-8517-c52b2b6bfb7c-c000.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true               | ida/javaSparkPayloads/hdfs/Targetfiles/sparkTarget/part-00000.csv        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/Target/commandstarget/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                        | ida/javaSparkPayloads/hdfs/Targetfiles/commandstarget/_SUCCESS           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/Target/commandstarget/part-00001?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                      | ida/javaSparkPayloads/hdfs/Targetfiles/commandstarget/part-00001         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/Target/country.csv/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                           | ida/javaSparkPayloads/hdfs/Targetfiles/country.csv/_SUCCESS              | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/Target/country.csv/part-00001?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                         | ida/javaSparkPayloads/hdfs/Targetfiles/country.csv/part-00001            | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/Target/system.parquet/_SUCCESS?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                        | ida/javaSparkPayloads/hdfs/Targetfiles/system.parquet/_SUCCESS           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | user/root/java/Target/system.parquet/part-00001?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                      | ida/javaSparkPayloads/hdfs/Targetfiles/system.parquet/part-00001         | 201           |                  |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1:Create Business Application tag for Java Spark Lineage test for HDFS Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/hdfs/JavaSparkHDFS_BA.json | 200           |                  |          |

  @sanity @positive @regression
  Scenario: SC#1:MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSDataSources.json" file for following values using property loader
      | jsonPath                                           | jsonValues      |
      | $.hdfsDataSource.clusterManager.clusterManagerHost | clusterHostName |

  @sanity @positive @regression
  Scenario Outline: SC#1: Set the Credentials and Datasources for Git and HDFS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                              | bodyFile                                                                       | path                             | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Git_Credentials                             | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSCredentials.json | $.gitCredentials                 | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/HdfsCredentials                             | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSCredentials.json | $.hdfsCredentials                | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                        | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSDataSources.json | $.gitCollectorDataSource_default | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HdfsDataSource                                | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSDataSources.json | $.hdfsDataSource_default         | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSDataSources.json | $.gitCollectorDataSource         | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HdfsDataSource/HdfsDataSource                 | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSDataSources.json | $.hdfsDataSource                 | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |                                                                                |                                  | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HdfsDataSource/HdfsDataSource                 |                                                                                |                                  | 200           | HdfsDataSource         |          |

  ############################################# Plugin Run ##########################################################
  @javaspark @MLP-10515
  Scenario Outline: SC#2-Configurations for Plugins - Git, HDFS Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                  | bodyFile                                                                         | path               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HdfsCataloger/HdfsCataloger       | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSPluginConfigs.json | $.hdfsCataloger    | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HdfsCataloger/HdfsCataloger       |                                                                                  |                    | 200           | HdfsCataloger    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollector         | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSPluginConfigs.json | $.gitCollector     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollector         |                                                                                  |                    | 200           | GitCollector     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser/JavaParser             | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSPluginConfigs.json | $.javaParser       | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser/JavaParser             |                                                                                  |                    | 200           | JavaParser       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage/JavaSparkLineage | payloads/ida/javaSparkPayloads/hdfs/PluginConfig/javaSparkHDFSPluginConfigs.json | $.javaSparkLineage | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage/JavaSparkLineage |                                                                                  |                    | 200           | JavaSparkLineage |          |

  @javaspark @MLP-10515
  Scenario Outline: SC#2-Run the Plugin configurations for Git, HDFS Cataloger, Java Parser, Java Linker and JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body           | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector        |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector         | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector        |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger  | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser               |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser                | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser               |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage  |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage   | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage  |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status |

  ####################### API Lineage verification #############################################
  @javaspark @MLP-10515 @regression @positive
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name             | asg_scopeid | targetFile                                                          | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | DF_Combinations  |             | response/java/javaSpark/javaSparkHDFS/Lineage/DF_Combinations.json  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | DFpositiveflow   |             | response/java/javaSpark/javaSparkHDFS/Lineage/DF_Combinations.json  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                  |             | response/java/javaSpark/javaSparkHDFS/Lineage/DF_Combinations.json  | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | RDD_Combinations |             | response/java/javaSpark/javaSparkHDFS/Lineage/RDD_Combinations.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | RDDpositiveflow  |             | response/java/javaSpark/javaSparkHDFS/Lineage/RDD_Combinations.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                  |             | response/java/javaSpark/javaSparkHDFS/Lineage/RDD_Combinations.json | $.functionID |

  @javaspark @MLP-10515 @regression @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item             | inputFile                                                           | outputFile                                                                          |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DF_Combinations  | response/java/javaSpark/javaSparkHDFS/Lineage/DF_Combinations.json  | response/java/javaSpark/javaSparkHDFS/Lineage/JavaSparkLineageHDFSSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RDD_Combinations | response/java/javaSpark/javaSparkHDFS/Lineage/RDD_Combinations.json | response/java/javaSpark/javaSparkHDFS/Lineage/JavaSparkLineageHDFSSourceTarget.json |

  # 6644896 to # 6644899# 6644900 to # 6644911 #6653074 to #6653079
  @javaspark @MLP-10515 @regression @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                | actual_json                                                                                           | item             |
      | ida/javaSparkPayloads/hdfs/LineageMetadata/expectedJavaSparkLineageHDFS.json | Constant.REST_DIR/response/java/javaSpark/javaSparkHDFS/Lineage/JavaSparkLineageHDFSSourceTarget.json | DF_Combinations  |
      | ida/javaSparkPayloads/hdfs/LineageMetadata/expectedJavaSparkLineageHDFS.json | Constant.REST_DIR/response/java/javaSpark/javaSparkHDFS/Lineage/JavaSparkLineageHDFSSourceTarget.json | RDD_Combinations |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-10515 @sanity @positive
  Scenario: SC#4:UI Lineage verification: - Verify the JavaSparkLineage plugin generates lineage for the java file named 'RDD_Combinations.java' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "RDDpositiveflow" and clicks on search
    And user performs "facet selection" in "tagJavaSparkHDFS" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "RDDpositiveflow" item from search results
    Then user performs click and verify in new window
      | Table        | value                                           | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                     | jsonPath       |
      | Lineage Hops | commands.txt => lines                           | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hdfs/LineageMetadata/javaSparkLineageHDFSMetadata.json | $.LineageHop_1 |
      | Lineage Hops | country => lines1                               | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hdfs/LineageMetadata/javaSparkLineageHDFSMetadata.json | $.LineageHop_2 |
      | Lineage Hops | lines => /user/root/java/Target/commandstarget  | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hdfs/LineageMetadata/javaSparkLineageHDFSMetadata.json | $.LineageHop_3 |
      | Lineage Hops | lines1 => /user/root/java/Target/country.csv    | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hdfs/LineageMetadata/javaSparkLineageHDFSMetadata.json | $.LineageHop_4 |
      | Lineage Hops | lines2 => /user/root/java/Target/system.parquet | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hdfs/LineageMetadata/javaSparkLineageHDFSMetadata.json | $.LineageHop_5 |
      | Lineage Hops | system => lines2                                | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hdfs/LineageMetadata/javaSparkLineageHDFSMetadata.json | $.LineageHop_6 |

  ###############################TechnologyTagValidation#################################
  @webtest @MLP-10515 @sanity @positive @regression
  Scenario: SC#5:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                   | fileName              | userTag          |
      | Default     | File       | Metadata Type | test_BA_JavaSparkHDFS,Git,tagJavaSparkHDFS,Java,Spark | RDD_Combinations.java | tagJavaSparkHDFS |
      | Default     | SourceTree | Metadata Type | test_BA_JavaSparkHDFS,tagJavaSparkHDFS,Java,Spark     | RDD_Combinations      | tagJavaSparkHDFS |
      | Default     | File       | Metadata Type | test_BA_JavaSparkHDFS,tagJavaSparkHDFS,Hadoop Files   | city.csv              | tagJavaSparkHDFS |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkHDFS,tagJavaSparkHDFS,Java,Spark     | lines2                | tagJavaSparkHDFS |
      | Default     | Class      | Metadata Type | test_BA_JavaSparkHDFS,tagJavaSparkHDFS,Java           | RDD_Combinations      | tagJavaSparkHDFS |
      | Default     | Function   | Metadata Type | test_BA_JavaSparkHDFS,tagJavaSparkHDFS,Java,Spark     | RDDpositiveflow       | tagJavaSparkHDFS |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName         | userTag          |
      | Default     | Class      | Metadata Type | Programming | RDD_Combinations | tagJavaSparkHDFS |
      | Default     | Function   | Metadata Type | Programming | RDDpositiveflow  | tagJavaSparkHDFS |
      | Default     | SourceTree | Metadata Type | Programming | RDD_Combinations | tagJavaSparkHDFS |
    And user enters the search text "RDDpositiveflow" and clicks on search
    And user performs "facet selection" in "tagJavaSparkHDFS" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "RDDpositiveflow" item from search results
    Then user performs click and verify in new window
      | Table        | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | commands.txt => lines | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_JavaSparkHDFS,tagJavaSparkHDFS,Java,Spark |
      | item | commands.txt => lines                             |
    And user should be able logoff the IDC

  #6902509# #6902515#
  @webtest @MLP-16271 @sanity @positive @regression
  Scenario:SC#6: Verify the highlighted line of source code which is responsible for data propogation in Lineage Hops - Copy and transform mode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "RDDpositiveflow" and clicks on search
    And user performs "facet selection" in "tagJavaSparkHDFS" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "RDDpositiveflow" item from search results
    Then user performs click and verify in new window
      | Table        | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | commands.txt => lines | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | commands.txt => lines                            |
      | attributeName  | locations                                        |
      | actualFilePath | ida/javaSparkPayloads/hdfs/actualLocations1.json |
    Then file content in "ida/javaSparkPayloads/hdfs/expectedLocations1.json" should be same as the content in "ida/javaSparkPayloads/hdfs/actualLocations1.json"
    And user enters the search text "RDDpositiveflow" and clicks on search
    And user performs "facet selection" in "tagJavaSparkHDFS" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "RDDpositiveflow" item from search results
    Then user performs click and verify in new window
      | Table        | value                                          | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | lines => /user/root/java/Target/commandstarget | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | lines => /user/root/java/Target/commandstarget   |
      | attributeName  | locations                                        |
      | actualFilePath | ida/javaSparkPayloads/hdfs/actualLocations2.json |
    Then file content in "ida/javaSparkPayloads/hdfs/expectedLocations2.json" should be same as the content in "ida/javaSparkPayloads/hdfs/actualLocations2.json"


  ############################################# Post Conditions ##########################################################
  @MLP-10515 @positve @hdfs @regression @positive @sanity @IDA-10.1
  Scenario Outline:SC#7: Delete the created files in Ambari
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type   | url                                      | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | user/root/java/?op=DELETE&recursive=true |      | 200           |                  |

  @cr-data @postcondition @sanity @positive
  Scenario: SC#7:ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type                | query | param |
      | SingleItemDelete | Default | Cluster Demo                               | Cluster             |       |       |
      | SingleItemDelete | Default | automation_repo_java_spark                 | Project             |       |       |
      | SingleItemDelete | Default | test_BA_JavaSparkHDFS                      | BusinessApplication |       |       |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector%       | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/HdfsCataloger%     | Analysis            |       |       |
      | MultipleIDDelete | Default | parser/JavaParser/JavaParser%              | Analysis            |       |       |
      | MultipleIDDelete | Default | lineage/JavaSparkLineage/JavaSparkLineage% | Analysis            |       |       |


  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#8:ConfigDeletion: Delete the Plugin configurations for Git, HDFS Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollector                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HdfsCataloger/HdfsCataloger                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser/JavaParser                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage/JavaSparkLineage             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HdfsDataSource/HdfsDataSource                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Git_Credentials                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/HdfsCredentials                             |      | 200           |                  |          |
