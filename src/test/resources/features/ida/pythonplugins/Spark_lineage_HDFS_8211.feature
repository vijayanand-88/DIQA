@MLP-8211
Feature: MLP_8211: Feature to validate the lineage created via python spark lineage plugin is correct

  ############################################# Pre Conditions ##########################################################
  @MLP-8211 @positve @hdfs @regression @sanity @IDA-10.1
  Scenario Outline:SC#1: Creating a directory in Ambari Files View and Uploading source files into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                        | body                                                                               | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1?op=MKDIRS&recursive=true&overwrite=true                                                                                                         |                                                                                    | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/account.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/account.parquet        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/chocolate.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true          | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/chocolate.csv          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/city.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true               | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/city.csv               | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/city1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true              | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/city1.csv              | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/country.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true            | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/country.csv            | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/customer.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true          | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/customer.json          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/emp.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/emp.csv                | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/emp1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true               | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/emp1.csv               | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/emp2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true               | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/emp2.csv               | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/gender.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true             | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/gender.orc             | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/marathon.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true       | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/marathon.parquet       | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/namesAndFavColors.text?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/namesAndFavColors.text | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/people.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true            | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/people.json            | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/rubiks.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/rubiks.parquet         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/shapes.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true             | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/shapes.orc             | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/soccer.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true             | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/soccer.orc             | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/students.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true           | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/students.orc           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/source1/system.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/PythonSparkPayloads/pythonSparkLineage_8211_sourceFiles/system.parquet         | 201           |                  |

  @MLP-8211 @positve @hdfs @regression @sanity @IDA-10.1
  Scenario Outline:SC#1: Creating a directory in Ambari Files View and Uploading target files into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                   | body                                                                                                     | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1?op=MKDIRS&recursive=true&overwrite=true                                                                                                                               |                                                                                                          | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/accountTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true           | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/accountTarget/part-r-00000.parquet           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/chocolatetarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/chocolatetarget/part-r-00000.parquet         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/citytarget/part-r-00000.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                  | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/citytarget/part-r-00000.csv                  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/countrytarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true           | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/countrytarget/part-r-00000.parquet           | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/customerTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true          | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/customerTarget/part-r-00000.parquet          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/empTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true               | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/empTarget/part-r-00000.parquet               | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/genderTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true            | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/genderTarget/part-r-00000.parquet            | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/marathonTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true          | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/marathonTarget/part-r-00000.parquet          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/namesAndFavColorsTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/namesAndFavColorsTarget/part-r-00000.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/namesAndFavColorsTarget1/part-r-00000.txt?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true    | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/namesAndFavColorsTarget1/part-r-00000.txt    | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/peopleTarget/part-r-00000.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true               | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/peopleTarget/part-r-00000.json               | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/rubiksTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true            | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/rubiksTarget/part-r-00000.parquet            | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/shapesTarget/part-r-00000.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/shapesTarget/part-r-00000.orc                | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/shapesTarget1/part-r-00000.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true               | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/shapesTarget1/part-r-00000.orc               | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/soccerTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true            | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/soccerTarget/part-r-00000.parquet            | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/studentsTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true          | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/studentsTarget/part-r-00000.parquet          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | pythonA/automation/load/target1/systemTarget/part-r-00000.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true            | ida/PythonSparkPayloads/pythonSparkLineage_8211_targetFiles/systemTarget/part-r-00000.parquet            | 201           |                  |


  @MLP-8211 @sanity @hdfs @regression @positive
  Scenario: SC#1: Moving the file from local to the folder in Ambari
    Given user connects to the SFTP server for below parameters
      | sftpHost        | sftpPort       | sftpUser     | sftpPw       | sftpAction | remoteDir | localDir                                          |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8211/PositiveFlow1.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8211/PositiveFlow2.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8211/PositiveFlow3.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8211/WrongGitData.py  |

#  @MLP-8211 @sanity @positive @regression
#  Scenario: Configuring and Running Spark Commands
#    And user connects to the sftp server or local Machine and runs commands
#      | command | Filename         | TimeInMilliSecs | Env    |
#      | SPARK2  | PositiveFlow1.py | 50000           | Ambari |
#      | SPARK2  | PositiveFlow2.py | 50000           | Ambari |
#      | SPARK2  | PositiveFlow3.py | 50000           | Ambari |
#      | SPARK2  | WrongGitData.py  | 50000           | Ambari |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1: Create Business Application tag for Python Spark Lineage test for MLP_8211
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/PythonSparkPayloads/MLP-8211_PluginConfig/PySpark_8211_BA.json | 200           |                  |          |
    
    
  ############################################# Plugin Configure ##########################################################
  @pythonspark @MLP-8211
  Scenario Outline: SC#2: Configure Credentials, Data Source for Plugins - Git, HDFSCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                         | bodyFile                                                                         | path                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitCredentials_8211                                                    | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_Credentials.json | $.GitCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/GitCredentials_8211                                                    |                                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/HDFSCredentials_8211                                                   | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_Credentials.json | $.HDFSCredentials                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/HDFSCredentials_8211                                                   |                                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/Git_8211_DS                                       | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_DataSources.json | $.GitCollectorDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollectorDataSource/Git_8211_DS                                       |                                                                                  |                                  | 200           | Git_8211_DS      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource/HDFS_8211_DS                                              | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_DataSources.json | $.HdfsDataSource                 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource/HDFS_8211_DS                                              |                                                                                  |                                  | 200           | HDFS_8211_DS     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource_TEST_DEFAULT_CONFIGURATION | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_DataSources.json | $.GitCollectorDataSource_Default | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource/HdfsDataSource_TEST_DEFAULT_CONFIGURATION                 | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_DataSources.json | $.HdfsDataSource_Default         | 204           |                  |          |

  @pythonspark @MLP-8211
  Scenario Outline: SC#2: Configure the Plugins - Git, HDFSCataloger, Python Parser and Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                                                          | path                 | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollector/GitCollector_8211             | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_PluginConfig.json | $.GitCollector       | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollector/GitCollector_8211             |                                                                                   |                      | 200           | GitCollector_8211       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsCataloger/HdfsCataloger_8211           | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_PluginConfig.json | $.HdfsCataloger      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsCataloger/HdfsCataloger_8211           |                                                                                   |                      | 200           | HdfsCataloger_8211      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/PythonParser/PythonParser_8211             | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_PluginConfig.json | $.PythonParser       | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/PythonParser/PythonParser_8211             |                                                                                   |                      | 200           | PythonParser_8211       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8211 | payloads/ida/PythonSparkPayloads/MLP-8211_PluginConfig/MLP_8211_PluginConfig.json | $.PythonSparkLineage | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8211 |                                                                                   |                      | 200           | PythonSparkLineage_8211 |          |

  #################################################### Plugin Run #####################################################
  @pythonspark @MLP-8211
  Scenario Outline: SC#2: Run Git, HDFSCataloger, Python Parser and Python Spark Lineage Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_8211           |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector_8211')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_8211            |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_8211           |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector_8211')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8211    |          |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger_8211')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8211     |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8211    |          |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger_8211')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_8211              |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser_8211')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_8211               |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_8211              |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser_8211')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8211 |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage_8211')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8211  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8211 |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage_8211')].status |
  
  
  ####################### API Lineage verification #############################################
  @MLP-8211 @sanity @positive
  Scenario Outline: SC#3: API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                      | asg_scopeid | targetFile                                                      | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | PositiveFlow1             |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow1.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | basic_datasource_example1 |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow1.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                           |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow1.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | PositiveFlow2             |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow2.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | basic_datasource_example2 |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow2.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                           |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow2.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | PositiveFlow3             |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow3.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | basic_datasource_example3 |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow3.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                           |             | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow3.json | $.functionID |

  @MLP-8211 @sanity @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item          | inputFile                                                       | outputFile                                                                 |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | PositiveFlow1 | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow1.json | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlowSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | PositiveFlow2 | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow2.json | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlowSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | PositiveFlow3 | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlow3.json | response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlowSourceTarget.json |

  #6453837,#6439167,#6453883,#6436058,#6453889,#6441105
  @MLP-8211 @sanity @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                        | actual_json                                                                                  | item          |
      | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/expectedPythonSparkLineage8211.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlowSourceTarget.json | PositiveFlow1 |
      | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/expectedPythonSparkLineage8211.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlowSourceTarget.json | PositiveFlow2 |
      | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/expectedPythonSparkLineage8211.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-8211_Lineage/PositiveFlowSourceTarget.json | PositiveFlow3 |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-8211 @sanity @positive
  Scenario: SC#4: UI Lineage verification: - Verify the PythonSparkLineage plugin generates lineage for the python file named 'PositiveFlow1.py' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "PySpark8211" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "facet selection" in "PySpark8211" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "basic_datasource_example1" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                       | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                               | jsonPath        |
      | Lineage Hops | city.csv => usersDF3                                        | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_1  |
      | Lineage Hops | emp.csv => usersDF                                          | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_2  |
      | Lineage Hops | rubiks.parquet => usersDF6                                  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_3  |
      | Lineage Hops | shapes.orc => usersDF4                                      | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_4  |
      | Lineage Hops | students.orc => usersDF2                                    | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_5  |
      | Lineage Hops | system.parquet => usersDF5                                  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_6  |
      | Lineage Hops | usersDF => /pythonA/automation/load/target1/empTarget       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_7  |
      | Lineage Hops | usersDF2 => /pythonA/automation/load/target1/studentsTarget | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_8  |
      | Lineage Hops | usersDF3 => /pythonA/automation/load/target1/citytarget     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_9  |
      | Lineage Hops | usersDF4 => /pythonA/automation/load/target1/shapesTarget   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_10 |
      | Lineage Hops | usersDF5 => /pythonA/automation/load/target1/systemTarget   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_11 |
      | Lineage Hops | usersDF6 => /pythonA/automation/load/target1/rubiksTarget   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8211/LineageMetadata/pythonSparkLineage_8211_Metadata.json | $.LineageHop_12 |
    And user should be able logoff the IDC

  @webtest @MLP-8211 @negative
  Scenario: SC#4:Verify the PythonSparkLineage plugin doesn't generates lineage for the below cases
  1. Lineage is not generated for the python file stored in Git repository when source is invalid
  2. Lineage is not generated for the python file stored in Git repository when target is invalid
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName                         | windowName   |
      | Default     | Function  | Metadata Type | basic_datasource_exampleWrongGit | Lineage Hops |
    And user should be able logoff the IDC
 
  ###############################TechnologyTagValidation#################################
  @MLP-8211 @sanity @positive @regression
  Scenario: SC#5: Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS

    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName                | DatabaseName | SchemaName | TableName/Filename | Column | Tags                                              | Query        | Action         |
      | File        | PositiveFlow1.py           |              |            |                    |        | test_BA_PySpark_8211,Git,PySpark8211,Python,Spark | GenericQuery | TagAssigned    |
      | SourceTree  | PositiveFlow1              |              |            |                    |        | test_BA_PySpark_8211,PySpark8211,Python,Spark     | GenericQuery | TagAssigned    |
      | Class       | PositiveFlow1              |              |            |                    |        | test_BA_PySpark_8211,PySpark8211,Python           | GenericQuery | TagAssigned    |
      | Function    | basic_datasource_example1  |              |            |                    |        | test_BA_PySpark_8211,PySpark8211,Python,Spark     | GenericQuery | TagAssigned    |
      | LineageHop  | rubiks.parquet => usersDF6 |              |            |                    |        | test_BA_PySpark_8211,PySpark8211,Python,Spark     | GenericQuery | TagAssigned    |
      | File        | PositiveFlow1.py           |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |
      | SourceTree  | PositiveFlow1              |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |
      | Class       | PositiveFlow1              |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |
      | Function    | basic_datasource_example1  |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |
      | LineageHop  | rubiks.parquet => usersDF6 |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |


  ############################################# Post Conditions ##########################################################
  @MLP-8211 @regression @positive
  Scenario: SC#6: Delete the analysis items for plugins: GitCollector, HdfsCataloger, PythonParser, PythonSparkLineage
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector_8211%           | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/HdfsCataloger_8211%         | Analysis |       |       |
      | MultipleIDDelete | Default | parser/PythonParser/PythonParser_8211%              | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/PythonSparkLineage_8211% | Analysis |       |       |
      | MultipleIDDelete | Default | pythonanalyzerdemo                                  | Project  |       |       |
      | MultipleIDDelete | Default | Cluster Demo                                        | Cluster  |       |       |


  @MLP-8211 @positve @hdfs @regression @positive @sanity @IDA-10.1
  Scenario Outline: SC#6: Delete the created files in Ambari
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type   | url                                         | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | pythonA/automation?op=DELETE&recursive=true |      | 200           |                  |


  @MLP-8211 @sanity @hdfs @regression @positive
  Scenario: SC#6: Deleting the file from root folder in Ambari
    Given user connects to the SFTP server for below parameters
      | sftpHost        | sftpPort       | sftpUser     | sftpPw       | sftpAction  | localDir | remoteDir        |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | PositiveFlow1.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | PositiveFlow2.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | PositiveFlow3.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | WrongGitData.py  |

  @MLP-8211 @regression @positive
  Scenario Outline: SC#6: Delete Credentials, Datasource and plugin config for GitCollector, HdfsCataloger, PythonParser, PythonSparkLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                           | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollector_8211             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger/HdfsCataloger_8211           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser/PythonParser_8211             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8211 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/Git_8211_DS         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource/HDFS_8211_DS                |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitCredentials_8211                      |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/HDFSCredentials_8211                     |          |      | 200           |                  |          |

  @MLP-8211 @regression @positive
  Scenario: SC#6: Delete the BusinessApplication item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type                | query | param |
      | MultipleIDDelete | Default | test_BA_PySpark_8211 | BusinessApplication |       |       |
