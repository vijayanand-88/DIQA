@MLP-8890
Feature: MLP_8890: Feature to validate the lineage created via python spark lineage plugin is correct

  ############################################# Pre Conditions ##########################################################
  @MLP-8890 @positve @hdfs @regression @sanity @IDA-10.1
  Scenario Outline: SC#1: Creating a directory in Ambari Files View and Uploading source files into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                    | body                                                              | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ01?op=MKDIRS&recursive=true&overwrite=true                                                                                              |                                                                   | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ02?op=MKDIRS&recursive=true&overwrite=true                                                                                              |                                                                   | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ01/people.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8890/MLP-8890_sourceFiles/people.json | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ01/shapes.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/PythonSparkPayloads/MLP-8890/MLP-8890_sourceFiles/shapes.orc  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/sourceVJ02/people.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8890/MLP-8890_sourceFiles/people.json | 201           |                  |


  @MLP-8890 @positve @hdfs @regression @sanity @IDA-10.1
  Scenario Outline: SC#1: Creating a directory in Ambari Files View and Uploading target files into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                             | body                                                                                  | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/peopleTarget?op=MKDIRS&recursive=true&overwrite=true                                                                                                     |                                                                                       | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/peopleTarget1?op=MKDIRS&recursive=true&overwrite=true                                                                                                    |                                                                                       | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/shapesTarget?op=MKDIRS&recursive=true&overwrite=true                                                                                                     |                                                                                       | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/shapesTarget1?op=MKDIRS&recursive=true&overwrite=true                                                                                                    |                                                                                       | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/studentTarget?op=MKDIRS&recursive=true&overwrite=true                                                                                                    |                                                                                       | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/peopleTarget/part-r-00000.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/PythonSparkPayloads/MLP-8890/MLP-8890_targetFiles/peopleTarget/part-r-00000.json  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/peopleTarget1/part-r-00000.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/PythonSparkPayloads/MLP-8890/MLP-8890_targetFiles/peopleTarget1/part-r-00000.orc  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/shapesTarget/part-r-00000.orc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true   | ida/PythonSparkPayloads/MLP-8890/MLP-8890_targetFiles/shapesTarget/part-r-00000.orc   | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/shapesTarget1/part-r-00000.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8890/MLP-8890_targetFiles/shapesTarget1/part-r-00000.json | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | python/studentTarget/part-r-00000.json?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/PythonSparkPayloads/MLP-8890/MLP-8890_targetFiles/studentTarget/part-r-00000.json | 201           |                  |


  @MLP-8890 @sanity @hdfs @regression @positive
  Scenario: SC#1: Moving the file from local and Unzip the folder in Ambari
    Given user connects to the SFTP server for below parameters
      | sftpHost        | sftpPort       | sftpUser     | sftpPw       | sftpAction | remoteDir | localDir                                                           |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8890/MLP-8890_PythonFiles/filetodir.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | copyFiles  | /root     | ida/PythonSparkPayloads/MLP-8890/MLP-8890_PythonFiles/negative.py  |


#  @MLP-8890 @sanity @positive @regression
#  Scenario: SC#1: Configuring and Running Spark job
#    And user connects to the sftp server or local Machine and runs commands
#      | command | Filename     | TimeInMilliSecs | Env    |
#      | SPARK2  | filetodir.py | 50000           | Ambari |


  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1: Create Business Application tag for Python Spark Lineage test for MLP_8890
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/PySpark_8890_BA.json | 200           |                  |          |


  ############################################# Plugin Run ##########################################################
  @pythonspark @MLP-8890
  Scenario Outline: SC#2: Configure Credentials, Data Source for Plugins - Git, HDFSCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                         | bodyFile                                                                                   | path                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitCredentials_8890                                                    | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_Credentials.json | $.GitCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/GitCredentials_8890                                                    |                                                                                            |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/HDFSCredentials_8890                                                   | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_Credentials.json | $.HDFSCredentials                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/HDFSCredentials_8890                                                   |                                                                                            |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/Git_8890_DS                                       | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_DataSources.json | $.GitCollectorDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollectorDataSource/Git_8890_DS                                       |                                                                                            |                                  | 200           | Git_8890_DS      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource/HDFS_8890_DS                                              | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_DataSources.json | $.HdfsDataSource                 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource/HDFS_8890_DS                                              |                                                                                            |                                  | 200           | HDFS_8890_DS     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource_TEST_DEFAULT_CONFIGURATION | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_DataSources.json | $.GitCollectorDataSource_Default | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource/HdfsDataSource_TEST_DEFAULT_CONFIGURATION                 | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_DataSources.json | $.HdfsDataSource_Default         | 204           |                  |          |


  @pythonspark @MLP-8890
  Scenario Outline: SC#2: Configure the Plugins - Git, HDFSCataloger, Python Parser and Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                                                                    | path                 | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollector/GitCollector_8890             | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_PluginConfig.json | $.GitCollector       | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollector/GitCollector_8890             |                                                                                             |                      | 200           | GitCollector_8890       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsCataloger/HdfsCataloger_8890           | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_PluginConfig.json | $.HdfsCataloger      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsCataloger/HdfsCataloger_8890           |                                                                                             |                      | 200           | HdfsCataloger_8890      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/PythonParser/PythonParser_8890             | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_PluginConfig.json | $.PythonParser       | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/PythonParser/PythonParser_8890             |                                                                                             |                      | 200           | PythonParser_8890       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8890 | payloads/ida/PythonSparkPayloads/MLP-8890/MLP-8890_PluginsConfig/MLP_8890_PluginConfig.json | $.PythonSparkLineage | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8890 |                                                                                             |                      | 200           | PythonSparkLineage_8890 |          |


  #################################################### Plugin Run #####################################################
  @pythonspark @MLP-8890
  Scenario Outline: SC#2: Run Git, HDFSCataloger, Python Parser and Python Spark Lineage Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_8890           |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector_8890')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_8890            |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_8890           |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector_8890')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8890    |          |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger_8890')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8890     |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger_8890    |          |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger_8890')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_8890              |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser_8890')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_8890               |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_8890              |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser_8890')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8890 |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage_8890')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8890  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_8890 |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage_8890')].status |


  ####################### API Lineage verification #############################################
  @MLP-8890 @sanity @positive
  Scenario Outline: SC#3: API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                          | asg_scopeid | targetFile                                                  | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | filetodir                     |             | response/PythonSparkLineage/MLP-8890_Lineage/filetodir.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | basic_datasource_testexample1 |             | response/PythonSparkLineage/MLP-8890_Lineage/filetodir.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/PythonSparkLineage/MLP-8890_Lineage/filetodir.json | $.functionID |


  @MLP-8890 @sanity @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item      | inputFile                                                   | outputFile                                                              |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | filetodir | response/PythonSparkLineage/MLP-8890_Lineage/filetodir.json | response/PythonSparkLineage/MLP-8890_Lineage/filetodirSourceTarget.json |


  # 6492947# 6492948# 6493372# 64933723# 6493390# 6493391# 6496356# 6496357# 6496358# 6496365# 6496804# 6496805# 6497577# 6497578
  @MLP-8890 @sanity @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                        | actual_json                                                                               | item      |
      | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/expectedPythonSparkLineage8890.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-8890_Lineage/filetodirSourceTarget.json | filetodir |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-8890 @sanity @positive
  Scenario: SC#4: UI Lineage verification: - Verify the PythonSparkLineage plugin generates lineage for the python file named 'filetodir.py' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "PySpark8890" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "facet selection" in "PySpark8890" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "basic_datasource_testexample1" item from search results
    Then user performs click and verify in new window
      | Table        | value                              | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                               | jsonPath       |
      | Lineage Hops | people.json => peopleDF            | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/pythonSparkLineage_8890_Metadata.json | $.LineageHop_1 |
      | Lineage Hops | peopleDF => /python/peopleTarget   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/pythonSparkLineage_8890_Metadata.json | $.LineageHop_2 |
      | Lineage Hops | peopleDF => /python/peopleTarget1  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/pythonSparkLineage_8890_Metadata.json | $.LineageHop_3 |
      | Lineage Hops | peopleDF1 => /python/shapesTarget  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/pythonSparkLineage_8890_Metadata.json | $.LineageHop_4 |
      | Lineage Hops | peopleDF1 => /python/shapesTarget1 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/pythonSparkLineage_8890_Metadata.json | $.LineageHop_5 |
      | Lineage Hops | peopleDF2 => /python/studentTarget | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/pythonSparkLineage_8890_Metadata.json | $.LineageHop_6 |
      | Lineage Hops | shapes.orc => peopleDF1            | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/pythonSparkLineage_8890_Metadata.json | $.LineageHop_7 |
      | Lineage Hops | shapes.orc => peopleDF2            | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-8890/LineageMetadata/pythonSparkLineage_8890_Metadata.json | $.LineageHop_8 |
    And user should be able logoff the IDC

  ###############################TechnologyTagValidation#################################
  @webtest @MLP-8890 @sanity @positive @regression
  Scenario: SC#5:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                               | fileName                      | userTag     |
      | Default     | File       | Metadata Type | test_BA_PySpark_8890,Git,PySpark8890,Python,Spark | filetodir.py                  | PySpark8890 |
      | Default     | SourceTree | Metadata Type | test_BA_PySpark_8890,PySpark8890,Python,Spark     | filetodir                     | PySpark8890 |
      | Default     | Table      | Metadata Type | test_BA_PySpark_8890,PySpark8890,Python,Spark     | peopleDF2                     | PySpark8890 |
      | Default     | Class      | Metadata Type | test_BA_PySpark_8890,PySpark8890,Python           | filetodir                     | PySpark8890 |
      | Default     | Function   | Metadata Type | test_BA_PySpark_8890,PySpark8890,Python,Spark     | basic_datasource_testexample1 | PySpark8890 |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName                      | userTag     |
      | Default     | Class      | Metadata Type | Programming | filetodir                     | PySpark8890 |
      | Default     | Function   | Metadata Type | Programming | basic_datasource_testexample1 | PySpark8890 |
      | Default     | SourceTree | Metadata Type | Programming | filetodir                     | PySpark8890 |
    And user enters the search text "PySpark8890" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "PySpark8890" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "basic_datasource_testexample1" item from search results
    Then user performs click and verify in new window
      | Table        | value                   | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | people.json => peopleDF | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_PySpark_8890,PySpark8890,Python,Spark |
      | item | people.json => peopleDF                       |
    And user should be able logoff the IDC


  ############################################# Post Conditions ##########################################################
  @MLP-8890 @regression @positive
  Scenario: SC#6: Delete the analysis items for plugins: GitCollector, HdfsCataloger, PythonParser, PythonSparkLineage
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector_8890%           | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/HdfsCataloger_8890%         | Analysis |       |       |
      | MultipleIDDelete | Default | parser/PythonParser/PythonParser_8890%              | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/PythonSparkLineage_8890% | Analysis |       |       |
      | MultipleIDDelete | Default | pythonanalyzerdemo                                  | Project  |       |       |
      | MultipleIDDelete | Default | Cluster Demo                                        | Cluster  |       |       |


  @MLP-8890 @positve @hdfs @regression @positive @sanity @IDA-10.1
  Scenario Outline: SC#6: Delete the created files in Ambari
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type   | url                                           | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/sourceVJ01?op=DELETE&recursive=true    |      | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/sourceVJ02?op=DELETE&recursive=true    |      | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/peopleTarget?op=DELETE&recursive=true  |      | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/peopleTarget1?op=DELETE&recursive=true |      | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/shapesTarget?op=DELETE&recursive=true  |      | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/shapesTarget1?op=DELETE&recursive=true |      | 200           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | python/studentTarget?op=DELETE&recursive=true |      | 200           |                  |


  @MLP-8890 @sanity @hdfs @regression @positive
  Scenario: SC#6: Deleting the file from root folder in Ambari
    Given user connects to the SFTP server for below parameters
      | sftpHost        | sftpPort       | sftpUser     | sftpPw       | sftpAction  | localDir | remoteDir    |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | filetodir.py |
      | clusterHostName | sftpPortNumber | sftpUsername | sftpPassword | deleteFiles | /root    | negative.py  |

  @MLP-8890 @regression @positive
  Scenario Outline: SC#6: Delete Credentials, Datasource and plugin config for GitCollector, HdfsCataloger, PythonParser, PythonSparkLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                           | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollector_8890             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger/HdfsCataloger_8890           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser/PythonParser_8890             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSparkLineage/PythonSparkLineage_8890 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/Git_8890_DS         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource/HDFS_8890_DS                |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitCredentials_8890                      |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/HDFSCredentials_8890                     |          |      | 200           |                  |          |

  @MLP-8890 @regression @positive
  Scenario: SC#6: Delete the BusinessApplication item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type                | query | param |
      | MultipleIDDelete | Default | test_BA_PySpark_8890 | BusinessApplication |       |       |
