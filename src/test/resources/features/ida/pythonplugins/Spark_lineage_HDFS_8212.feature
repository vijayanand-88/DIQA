@MLP-8212
Feature: MLP_8212: Feature to validate the lineage created via  python spark lineage plugin is correct


  @MLP-8212 @positve @hdfs @regression @sanity @IDA-10.1
  Scenario Outline:SC#1:Creating a directory in Ambari Files View and Uploading source files into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                     | body                                                                 | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ?op=MKDIRS&recursive=true&overwrite=true                                                                                                 |                                                                      | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ/spark1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true     | ida/PythonSparkPayloads/MLP-8212/MLP-8212_sourceFiles/spark1.csv     | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ/spark2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true     | ida/PythonSparkPayloads/MLP-8212/MLP-8212_sourceFiles/spark2.csv     | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ/spark3.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true     | ida/PythonSparkPayloads/MLP-8212/MLP-8212_sourceFiles/spark3.csv     | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ/users.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/PythonSparkPayloads/MLP-8212/MLP-8212_sourceFiles/users.parquet  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ/users1.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8212/MLP-8212_sourceFiles/users1.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ/users2.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8212/MLP-8212_sourceFiles/users2.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ/users3.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8212/MLP-8212_sourceFiles/users3.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ/sample.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8212/MLP-8212_sourceFiles/sample.parquet | 201           |                  |


  @MLP-8212 @positve @hdfs @regression @sanity @IDA-10.1
  Scenario Outline:SC#1:Creating a directory in Ambari Files View and Uploading target files into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                      | body                                                                                    | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target?op=MKDIRS&recursive=true&overwrite=true                                                                                                                    |                                                                                         | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target/Names/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/PythonSparkPayloads/MLP-8212/MLP-8212_targetFiles/Names/part-r-00000.parquet        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target/Names2/part-r-00000.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true           | ida/PythonSparkPayloads/MLP-8212/MLP-8212_targetFiles/Names2/part-r-00000.csv           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target/names.csv/part-r-00000.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/PythonSparkPayloads/MLP-8212/MLP-8212_targetFiles/names.csv/part-r-00000.csv        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target/combination1/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8212/MLP-8212_targetFiles/combination1/part-r-00000.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target/combination2/part-r-00000.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true     | ida/PythonSparkPayloads/MLP-8212/MLP-8212_targetFiles/combination2/part-r-00000.csv     | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/target/Negative1/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true    | ida/PythonSparkPayloads/MLP-8212/MLP-8212_targetFiles/Negative1/part-r-00000.parquet    | 201           |                  |


  @MLP-8212 @sanity @hdfs @regression @positive
  Scenario:SC#1:Moving the file from local and Unzip the folder in Ambari
    Given user connects to the SFTP server for below parameters
      | sftpHost        | sftpPort       | sftpUser     | sftpPw       | sftpAction | remoteDir | localDir                                                                  |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8212/MLP-8212_PythonFiles/positiveflow.py     |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8212/MLP-8212_PythonFiles/negativeflow_one.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8212/MLP-8212_PythonFiles/negativeflow_two.py |


#  @MLP-8212 @sanity @positive @regression
#  Scenario:SC#1:Configuring and Running the Spark job
#    And user connects to the sftp server or local Machine and runs commands
#      | command | Filename            | TimeInMilliSecs | Env    |
#      | SPARK2  | positiveflow.py     | 50000           | Ambari |
#      | SPARK2  | negativeflow_two.py | 50000           | Ambari |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1: Create Business Application tag for Python Spark Lineage test for MLP_8212
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/PySpark_8212_BA.json | 200           |                  |          |


  @MLP-8212 @regression @positive
  Scenario: SC#: Delete the cluster item: Cluster Demo
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                | type    | query | param |
      | MultipleIDDelete | Default | Cluster Demo        | Cluster |       |       |
      | MultipleIDDelete | Default | Cluster 1           | Cluster |       |       |
      | MultipleIDDelete | Default | LineageDemo Cluster | Cluster |       |       |

  ############################################# Plugin Run ##########################################################
  @pythonspark @MLP-8212
  Scenario Outline: SC#2: Configure Credentials, Data Source for Plugins - Git, HDFSCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                         | bodyFile                                                                                   | path                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitCredentials_8212                                                    | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_Credentials.json | $.GitCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/GitCredentials_8212                                                    |                                                                                            |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/HDFSCredentials_8212                                                   | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_Credentials.json | $.HDFSCredentials                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/HDFSCredentials_8212                                                   |                                                                                            |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/Git_8212_DS                                       | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_DataSources.json | $.GitCollectorDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollectorDataSource/Git_8212_DS                                       |                                                                                            |                                  | 200           | Git_8212_DS      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource/HDFS_8212_DS                                              | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_DataSources.json | $.HdfsDataSource                 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource/HDFS_8212_DS                                              |                                                                                            |                                  | 200           | HDFS_8212_DS     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource_TEST_DEFAULT_CONFIGURATION | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_DataSources.json | $.GitCollectorDataSource_Default | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource/HdfsDataSource_TEST_DEFAULT_CONFIGURATION                 | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_DataSources.json | $.HdfsDataSource_Default         | 204           |                  |          |


  @pythonspark @MLP-8212
  Scenario Outline: SC#2: Configure the Plugins - Git, HDFSCataloger, Python Parser and Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                                                                    | path                 | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollector/GitCollector_8212             | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_PluginConfig.json | $.GitCollector       | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollector/GitCollector_8212             |                                                                                             |                      | 200           | GitCollector_8212       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsCataloger/HdfsCataloger_8212           | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_PluginConfig.json | $.HdfsCataloger      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsCataloger/HdfsCataloger_8212           |                                                                                             |                      | 200           | HdfsCataloger_8212      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CsvAnalyzer/CsvAnalyzer_8212               | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_PluginConfig.json | $.CsvAnalyzer        | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CsvAnalyzer/CsvAnalyzer_8212               |                                                                                             |                      | 200           | CsvAnalyzer_8212        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ParquetAnalyzer/ParquetAnalyzer_8212       | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_PluginConfig.json | $.ParquetAnalyzer    | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ParquetAnalyzer/ParquetAnalyzer_8212       |                                                                                             |                      | 200           | ParquetAnalyzer_8212    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/PythonParser/PythonParser_8212             | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_PluginConfig.json | $.PythonParser       | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/PythonParser/PythonParser_8212             |                                                                                             |                      | 200           | PythonParser_8212       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8212 | payloads/ida/PythonSparkPayloads/MLP-8212/MLP-8212_PluginsConfig/MLP_8212_PluginConfig.json | $.PythonSparkLineage | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8212 |                                                                                             |                      | 200           | PythonSparkLineage_8212 |          |


  @pythonspark @MLP-8212
  Scenario Outline: SC#2: Run Git, HDFSCataloger, CsvAnalyzer, ParquetAnalyzer, Python Parser and Python Spark Lineage Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_8212               |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector_8212')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_8212                |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_8212               |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector_8212')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8212        |          |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger_8212')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8212         |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8212        |          |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger_8212')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/CsvAnalyzer_8212         |          |      | 200           | IDLE             | $.[?(@.configurationName=='CsvAnalyzer_8212')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/CsvAnalyzer_8212          |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/CsvAnalyzer_8212         |          |      | 200           | IDLE             | $.[?(@.configurationName=='CsvAnalyzer_8212')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer_8212 |          |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer_8212')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer_8212  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/ParquetAnalyzer_8212 |          |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer_8212')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_8212                  |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser_8212')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_8212                   |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_8212                  |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser_8212')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8212     |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage_8212')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8212      |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8212     |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage_8212')].status |

  ####################### API Lineage verification #############################################
  @MLP-8212 @sanity @positive
  Scenario Outline: SC#3: API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                     | asg_scopeid | targetFile                                                     | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | positiveflow             |             | response/PythonSparkLineage/MLP-8212_Lineage/positiveflow.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | basic_datasource_example |             | response/PythonSparkLineage/MLP-8212_Lineage/positiveflow.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                          |             | response/PythonSparkLineage/MLP-8212_Lineage/positiveflow.json | $.functionID |


  @MLP-8212 @sanity @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item         | inputFile                                                      | outputFile                                                                 |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | positiveflow | response/PythonSparkLineage/MLP-8212_Lineage/positiveflow.json | response/PythonSparkLineage/MLP-8212_Lineage/positiveflowSourceTarget.json |


  # 6492947# 6492948# 6493372# 64933723# 6493390# 6493391# 6496356# 6496357# 6496358# 6496365# 6496804# 6496805# 6497577# 6497578
  @MLP-8212 @sanity @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                        | actual_json                                                                                  | item         |
      | ida/PythonSparkPayloads/MLP-8212/LineageMetadata/expectedPythonSparkLineage8212.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-8212_Lineage/positiveflowSourceTarget.json | positiveflow |

  
  ############################################# UI Lineage verification #############################################
  @webtest @MLP-8212 @sanity @positive
  Scenario: SC#4: UI Lineage verification: - Verify the PythonSparkLineage plugin generates lineage for the python file named 'filetodir.py' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "basic_datasource_example" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "facet selection" in "PySpark8212" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "basic_datasource_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                         | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                               | jsonPath       |
      | Lineage Hops | spark1.csv._c0 => csvFile._c0 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8212/LineageMetadata/pythonSparkLineage_8212_Metadata.json | $.LineageHop_1 |
      | Lineage Hops | spark1.csv._c1 => csvFile._c1 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8212/LineageMetadata/pythonSparkLineage_8212_Metadata.json | $.LineageHop_2 |
      | Lineage Hops | spark1.csv._c2 => csvFile._c2 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8212/LineageMetadata/pythonSparkLineage_8212_Metadata.json | $.LineageHop_3 |
      | Lineage Hops | csvFile._c0 => names.csv._c0  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8212/LineageMetadata/pythonSparkLineage_8212_Metadata.json | $.LineageHop_4 |
      | Lineage Hops | csvFile._c1 => names.csv._c1  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8212/LineageMetadata/pythonSparkLineage_8212_Metadata.json | $.LineageHop_5 |
    And user should be able logoff the IDC


  @webtest @MLP-8212 @negative
  Scenario: SC#13:Verify the PythonSparkLineage plugin doesn't generates lineage for the below cases
  1. Lineage is not generated for the python file stored in Git repository when source is invalid
  2. Lineage is not generated for the python file stored in Git repository when target is invalid
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName                      | windowName   |
      | Default     | Function  | Metadata Type | basic_datasource_neg2_example | Lineage Hops |
    And user should be able logoff the IDC

  ###############################TechnologyTagValidation#################################
  @webtest @MLP-8212 @sanity @positive @regression
  Scenario: SC#5:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                               | fileName                 | userTag     |
      | Default     | File       | Metadata Type | test_BA_PySpark_8212,Git,PySpark8212,Python,Spark | positiveflow.py          | PySpark8212 |
      | Default     | SourceTree | Metadata Type | test_BA_PySpark_8212,PySpark8212,Python,Spark     | positiveflow             | PySpark8212 |
      | Default     | Table      | Metadata Type | test_BA_PySpark_8212,PySpark8212,Python,Spark     | parquetFile1             | PySpark8212 |
      | Default     | Class      | Metadata Type | test_BA_PySpark_8212,PySpark8212,Python           | positiveflow             | PySpark8212 |
      | Default     | Function   | Metadata Type | test_BA_PySpark_8212,PySpark8212,Python,Spark     | basic_datasource_example | PySpark8212 |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName                 | userTag     |
      | Default     | Class      | Metadata Type | Programming | positiveflow             | PySpark8212 |
      | Default     | Function   | Metadata Type | Programming | basic_datasource_example | PySpark8212 |
      | Default     | SourceTree | Metadata Type | Programming | positiveflow             | PySpark8212 |
    And user enters the search text "PySpark8212" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "PySpark8212" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "basic_datasource_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                        | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | csvFile._c0 => names.csv._c0 | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_PySpark_8212,PySpark8212,Python,Spark |
      | item | csvFile._c0 => names.csv._c0                  |
    And user should be able logoff the IDC
  
  
  ############################################# Post Conditions ##########################################################
  @MLP-8212 @regression @positive
  Scenario: SC#6: Delete the analysis items for plugins: GitCollector, HdfsCataloger, PythonParser, PythonSparkLineage
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector_8212%           | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/HdfsCataloger_8212%         | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/CsvAnalyzer_8212%          | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/ParquetAnalyzer_8212%  | Analysis |       |       |
      | MultipleIDDelete | Default | parser/PythonParser/PythonParser_8212%              | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/PythonSparkLineage_8212% | Analysis |       |       |
      | MultipleIDDelete | Default | pythonanalyzerdemo                                  | Project  |       |       |
      | MultipleIDDelete | Default | Cluster Demo                                        | Cluster  |       |       |


  @MLP-8212 @positve @hdfs @regression @positive @sanity @IDA-10.1
  Scenario Outline: SC#6: Delete the created files in Ambari
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type   | url                                      | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/sourceVJ?op=DELETE&recursive=true |      | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/target?op=DELETE&recursive=true   |      | 200           |                  |


  @MLP-8212 @sanity @hdfs @regression @positive
  Scenario: SC#6: Deleting the file from root folder in Ambari
    Given user connects to the SFTP server for below parameters
      | sftpHost        | sftpPort       | sftpUser     | sftpPw       | sftpAction  | localDir | remoteDir           |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | positiveflow.py     |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | negativeflow_one.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | negativeflow_two.py |

  @MLP-8212 @regression @positive
  Scenario Outline: SC#6: Delete Credentials, Datasource and plugin config for GitCollector, HdfsCataloger, PythonParser, PythonSparkLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                           | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollector_8212             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger/HdfsCataloger_8212           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvAnalyzer/CsvAnalyzer_8212               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetAnalyzer/ParquetAnalyzer_8212       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser/PythonParser_8212             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8212 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/Git_8212_DS         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource/HDFS_8212_DS                |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitCredentials_8212                      |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/HDFSCredentials_8212                     |          |      | 200           |                  |          |

  @MLP-8212 @regression @positive
  Scenario: SC#6: Delete the BusinessApplication item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type                | query | param |
      | MultipleIDDelete | Default | test_BA_PySpark_8212 | BusinessApplication |       |       |
