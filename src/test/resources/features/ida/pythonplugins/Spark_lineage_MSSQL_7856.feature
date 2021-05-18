@MLP-7856
Feature: MLP-7856:Feature to validate the lineage created via python spark lineage plugin is correct

  ############################################# Pre Conditions ##########################################################
  @MLP-7856 @sanity @hdfs @regression @positive
  Scenario: SC#1: Copy the file from local to the user path
    Given user connects to the SFTP server for below parameters
      | sftpAction  | remoteDir                        |
      | copytoLocal | ida/PythonSparkPayloads/MLP-7856 |


  @MLP-7856 @sanity @positive @regression
  Scenario: SC#1: Moving the file from local to the folder in Ambari
    And user connects to the sftp server or local Machine and runs commands
      | command      | Filename                          | Env   |
      | Spark2_Local | mssql_format_NoSourceandTarget.py | Local |
      | Spark2_Local | mssql_jdbc.py                     | Local |
      | Spark2_Local | mssql_jdbc_df_multiple_write.py   | Local |
      | Spark2_Local | mssql_overwrite.py                | Local |
      | Spark2_Local | mssql_overwriteandselect.py       | Local |
      | Spark2_Local | mssql_with_select.py              | Local |


  @MLP-7856 @sanity @positive @regression
  Scenario: SC#1: Check if the tables are available in MSSQL DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage    | queryField          |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | titles              |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | jobs                |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | publishers          |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | authors             |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | titleauthor         |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | business_tag        |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | jobs_min            |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | jobs_onlytwocolumns |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | jobs_all            |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | canada_author       |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | authors_toronto     |
      | mssql_old          | EXECUTEQUERY | json/IDA.json | SparkLineage | titleauthor_created |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1: Create Business Application tag for Python Spark Lineage test for MLP_7856
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/PythonSparkPayloads/MLP-7856_PluginConfig/PySpark_7856_BA.json | 200           |                  |          |


  ############################################# Plugin Configure ##########################################################
  @pythonspark @MLP-7856
  Scenario Outline: SC#2: Configure Credentials, Data Source for Plugins - Git, HDFSCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                         | bodyFile                                                                         | path                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitCredentials_7856                                                    | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_Credentials.json | $.GitCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/GitCredentials_7856                                                    |                                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/MSSQLCredentials_7856                                                  | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_Credentials.json | $.MSSQLCredentials               | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/MSSQLCredentials_7856                                                  |                                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/Git_7856_DS                                       | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_DataSources.json | $.GitCollectorDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollectorDataSource/Git_7856_DS                                       |                                                                                  |                                  | 200           | Git_7856_DS      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/SQLServerDBDataSource/MSSQL_7856_DS                                      | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_DataSources.json | $.MSSQLDataSource                | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/SQLServerDBDataSource/MSSQL_7856_DS                                      |                                                                                  |                                  | 200           | MSSQL_7856_DS    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource_TEST_DEFAULT_CONFIGURATION | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_DataSources.json | $.GitCollectorDataSource_Default | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/SQLServerDBDataSource/SQLServerDBDataSource_TEST_DEFAULT_CONFIGURATION   | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_DataSources.json | $.MSSQLDataSource_Default        | 204           |                  |          |

  @pythonspark @MLP-7856
  Scenario Outline: SC#2: Configure the Plugins - Git, SQLServerDBCataloger, Python Parser and Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                                                          | path                 | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollector/GitCollector_7856             | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_PluginConfig.json | $.GitCollector       | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollector/GitCollector_7856             |                                                                                   |                      | 200           | GitCollector_7856       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/SQLServerDBCataloger/MSSQLCataloger_7856   | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_PluginConfig.json | $.MSSQLCataloger     | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/SQLServerDBCataloger/MSSQLCataloger_7856   |                                                                                   |                      | 200           | MSSQLCataloger_7856     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/PythonParser/PythonParser_7856             | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_PluginConfig.json | $.PythonParser       | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/PythonParser/PythonParser_7856             |                                                                                   |                      | 200           | PythonParser_7856       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/PythonSparkLineage/PythonSparkLineage_7856 | payloads/ida/PythonSparkPayloads/MLP-7856_PluginConfig/MLP_7856_PluginConfig.json | $.PythonSparkLineage | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/PythonSparkLineage/PythonSparkLineage_7856 |                                                                                   |                      | 200           | PythonSparkLineage_7856 |          |


  #################################################### Plugin Run #####################################################
  @pythonspark @MLP-7856
  Scenario Outline: SC#2: Run Git, HDFSCataloger, Python Parser and Python Spark Lineage Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_7856           |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector_7856')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_7856            |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_7856           |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector_7856')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/MSSQLCataloger_7856 |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSQLCataloger_7856')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/MSSQLCataloger_7856  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/MSSQLCataloger_7856 |          |      | 200           | IDLE             | $.[?(@.configurationName=='MSSQLCataloger_7856')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_7856              |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser_7856')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_7856               |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_7856              |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser_7856')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_7856 |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage_7856')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_7856  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage_7856 |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage_7856')].status |


  ####################### API Lineage verification #############################################
  @MLP-7856 @sanity @positive
  Scenario Outline: SC#3: API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                          | asg_scopeid | targetFile                                                                     | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | mssql_jdbc                    |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_jdbc.json                   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_mssql_jdbc_api           |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_jdbc.json                   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_jdbc.json                   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | mssql_jdbc_df_multiple_write  |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_jdbc_df_multiple_write.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_mssql_multiple_write     |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_jdbc_df_multiple_write.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_jdbc_df_multiple_write.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | mssql_overwrite               |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_overwrite.json              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_mssql_overwrite          |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_overwrite.json              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_overwrite.json              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | mssql_overwriteandselect      |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_overwriteandselect.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_mssql_overwriteandselect |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_overwriteandselect.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_overwriteandselect.json     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | mssql_with_select             |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_with_select.json            |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_mssql_with_select        |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_with_select.json            |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                               |             | response/PythonSparkLineage/MLP-7856_Lineage/mssql_with_select.json            | $.functionID |

  @MLP-7856 @sanity @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                         | inputFile                                                                      | outputFile                                                                      |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | mssql_jdbc                   | response/PythonSparkLineage/MLP-7856_Lineage/mssql_jdbc.json                   | response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | mssql_jdbc_df_multiple_write | response/PythonSparkLineage/MLP-7856_Lineage/mssql_jdbc_df_multiple_write.json | response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | mssql_overwrite              | response/PythonSparkLineage/MLP-7856_Lineage/mssql_overwrite.json              | response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | mssql_overwriteandselect     | response/PythonSparkLineage/MLP-7856_Lineage/mssql_overwriteandselect.json     | response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | mssql_with_select            | response/PythonSparkLineage/MLP-7856_Lineage/mssql_with_select.json            | response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json |

  @MLP-7856 @sanity @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                        | actual_json                                                                                       | item                         |
      | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/expectedPythonSparkLineage7856.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json | mssql_jdbc                   |
      | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/expectedPythonSparkLineage7856.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json | mssql_jdbc_df_multiple_write |
      | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/expectedPythonSparkLineage7856.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json | mssql_overwrite              |
      | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/expectedPythonSparkLineage7856.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json | mssql_overwriteandselect     |
      | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/expectedPythonSparkLineage7856.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-7856_Lineage/PythonSpark_7856_SourceTarget.json | mssql_with_select            |


  ############################################# UI Lineage verification #############################################
  @webtest @MLP-7856 @sanity @positive
  Scenario: SC#4: UI Lineage verification: - Verify the PythonSparkLineage plugin generates lineage for the python file named 'mssql_with_select.py' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "PySpark7856" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "facet selection" in "PySpark7856" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "jdbc_mssql_with_select" item from search results
    Then user performs click and verify in new window
      | Table        | value                                             | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                               | jsonPath       |
      | Lineage Hops | mssqlDF7.au_id => titleauthor_created.au_id       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/pythonSparkLineage_7856_Metadata.json | $.LineageHop_1 |
      | Lineage Hops | mssqlDF7.au_ord => titleauthor_created.au_ord     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/pythonSparkLineage_7856_Metadata.json | $.LineageHop_2 |
      | Lineage Hops | mssqlDF7.title_id => titleauthor_created.title_id | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/pythonSparkLineage_7856_Metadata.json | $.LineageHop_3 |
      | Lineage Hops | titleauthor.au_id => mssqlDF7.au_id               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/pythonSparkLineage_7856_Metadata.json | $.LineageHop_4 |
      | Lineage Hops | titleauthor.au_ord => mssqlDF7.au_ord             | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/pythonSparkLineage_7856_Metadata.json | $.LineageHop_5 |
      | Lineage Hops | titleauthor.royaltyper => mssqlDF7.royaltyper     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/pythonSparkLineage_7856_Metadata.json | $.LineageHop_6 |
      | Lineage Hops | titleauthor.title_id => mssqlDF7.title_id         | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7856/LineageMetadata/pythonSparkLineage_7856_Metadata.json | $.LineageHop_7 |
    And user should be able logoff the IDC

  @webtest @MLP-7856 @negative
  Scenario: SC#4:Verify the PythonSparkLineage plugin doesn't generates lineage for the below cases
  1. Lineage is not generated for the python file stored in Git repository when source is invalid
  2. Lineage is not generated for the python file stored in Git repository when target is invalid
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName                            | windowName   |
      | Default     | Function  | Metadata Type | jdbc_mssql_format_NoSourceandTarget | Lineage Hops |
    And user should be able logoff the IDC
 
  ###############################TechnologyTagValidation#################################
  @MLP-7856 @sanity @positive @regression
  Scenario: SC#5: Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS

    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName                                   | DatabaseName | SchemaName | TableName/Filename | Column | Tags                                              | Query        | Action         |
      | File        | mssql_with_select.py                          |              |            |                    |        | test_BA_PySpark_7856,Git,PySpark7856,Python,Spark | GenericQuery | TagAssigned    |
      | SourceTree  | mssql_jdbc_NoTarget                           |              |            |                    |        | test_BA_PySpark_7856,PySpark7856,Python,Spark     | GenericQuery | TagAssigned    |
      | Class       | mssql_jdbc_df_multiple_write                  |              |            |                    |        | test_BA_PySpark_7856,PySpark7856,Python           | GenericQuery | TagAssigned    |
      | Function    | jdbc_mssql_format_NoSourceandTarget           |              |            |                    |        | test_BA_PySpark_7856,PySpark7856,Python,Spark     | GenericQuery | TagAssigned    |
      | LineageHop  | titleauthor.royaltyper => mssqlDF7.royaltyper |              |            |                    |        | test_BA_PySpark_7856,PySpark7856,Python,Spark     | GenericQuery | TagAssigned    |
      | File        | mssql_with_select.py                          |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |
      | SourceTree  | mssql_jdbc_NoTarget                           |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |
      | Class       | mssql_jdbc_df_multiple_write                  |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |
      | Function    | jdbc_mssql_format_NoSourceandTarget           |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |
      | LineageHop  | titleauthor.royaltyper => mssqlDF7.royaltyper |              |            |                    |        | Programming                                       | GenericQuery | TagNotAssigned |


  ############################################# Post Conditions ##########################################################
  @MLP-7856 @regression @positive
  Scenario: SC#6: Delete the analysis items for plugins: GitCollector, SQLServerDBCataloger, PythonParser, PythonSparkLineage
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector_7856%           | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/MSSQLCataloger_7856% | Analysis |       |       |
      | MultipleIDDelete | Default | parser/PythonParser/PythonParser_7856%              | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/PythonSparkLineage_7856% | Analysis |       |       |
      | MultipleIDDelete | Default | pythonanalyzerdemo                                  | Project  |       |       |
      | MultipleIDDelete | Default | esbcnprodcap02v.asg.com                             | Cluster  |       |       |

  @MLP-7856 @positve @hdfs @regression @positive @sanity @IDA-10.1
  Scenario: SC#6: Drop the target tables created in MSSQL
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema | Table               | Database |
      | mssql_old          | DROP      | dbo    | business_tag        | pubs     |
      | mssql_old          | DROP      | dbo    | jobs_min            | pubs     |
      | mssql_old          | DROP      | dbo    | jobs_onlytwocolumns | pubs     |
      | mssql_old          | DROP      | dbo    | jobs_all            | pubs     |
      | mssql_old          | DROP      | dbo    | canada_author       | pubs     |
      | mssql_old          | DROP      | dbo    | authors_toronto     | pubs     |
      | mssql_old          | DROP      | dbo    | titleauthor_created | pubs     |

  @MLP-7856 @sanity @hdfs @regression @positive
  Scenario: SC#6: Deleting the entire folder
    Given user connects to the SFTP server for below parameters
      | sftpAction | remoteDir |
      | deleteDir  |           |

  @MLP-7856 @regression @positive
  Scenario Outline: SC#6: Delete Credentials, Datasource and plugin config for GitCollector, HdfsCataloger, PythonParser, PythonSparkLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                           | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollector_7856             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBCataloger/MSSQLCataloger_7856   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser/PythonParser_7856             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSparkLineage/PythonSparkLineage_7856 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/Git_7856_DS         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBDataSource/MSSQL_7856_DS        |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitCredentials_7856                      |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/MSSQLCredentials_7856                    |          |      | 200           |                  |          |

  @MLP-7856 @regression @positive
  Scenario: SC#6: Delete the BusinessApplication item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type                | query | param |
      | MultipleIDDelete | Default | test_BA_PySpark_7856 | BusinessApplication |       |       |
