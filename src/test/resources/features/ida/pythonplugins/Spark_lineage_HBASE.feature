@MLP-10518
Feature:Verification of Python Spark Lineage with HBase Data Source

  @MLP-10518 @sanity @positive @regression
  Scenario: SC#1: Configuring and Running HBase server in Ambari
    Given configure a new REST API for the service "Ambari"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
      | X-Requested-By | ambari                     |
    And supply payload with file name "ida/hbasePayloads/HBASE_Data/HBase_StartServiceComponent.json"
    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/HBASE"
    And sync the test execution for "35" seconds

  @MLP-10518 @sanity @positive @regression @ambari
  Scenario: SC#1: Configuring and Running HBase REST server
    Given user connects to the sftp server and run the "START_HBASE" command

  @cr-data @MLP-10518 @sanity @positive @regression
  Scenario Outline: SC#1: Create tables in HBASE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser | Header   | Query | Param | type | url                    | body                                                                                                | response code | response message | jsonPath |
      | HBase       | hbaseuser   | text/xml |       |       | Post | testemployee/schema    | ida/PythonSparkPayloads/hbase/TestData/Hbase_testemployee_CreateTable.xml                           | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | testemployee/row_key/  | ida/PythonSparkPayloads/hbase/TestData/Hbase_testemployee_Create_ColumnFamily_and_ColumnValues.xml  | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_emp/schema          | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_emp_CreateTable.xml                                 | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_emp/row_key/        | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_emp_Create_ColumnFamily_and_ColumnValues.xml        | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_emp_filter/schema   | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_emp_filter_CreateTable.xml                          | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_emp_filter/row_key/ | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_emp_filter_Create_ColumnFamily_and_ColumnValues.xml | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_emp_wr1/schema      | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_emp_wr1_CreateTable.xml                             | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_emp_wr1/row_key/    | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_emp_wr1_Create_ColumnFamily_and_ColumnValues.xml    | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_emp_wr2/schema      | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_emp_wr2_CreateTable.xml                             | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_emp_wr2/row_key/    | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_emp_wr2_Create_ColumnFamily_and_ColumnValues.xml    | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_overwrite/schema    | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_overwrite_CreateTable.xml                           | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_overwrite/row_key/  | ida/PythonSparkPayloads/hbase/TestData/Hbase_qa_overwrite_Create_ColumnFamily_and_ColumnValues.xml  | 200           |                  |          |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1:Create Business Application tag for Python Spark Lineage test for HBase Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/PythonSparkPayloads/hbase/PythonSparkHBase_BA.json | 200           |                  |          |

  @MLP-10518 @sanity @positive @regression
  Scenario: SC#1: Configuring HBase data source with relevant Rest URL
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user update json file "ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBaseDataSources.json" file for following values using property loader
      | jsonPath                       | jsonValues          |
      | $.hbaseDataSource.hbaseRestUrl | HbaseRestAPIBaseURL |

  @sanity @positive @regression
  Scenario Outline: SC#1-Set the Credentials and Datasources for Git and HBase
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                              | bodyFile                                                                             | path                             | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Git_Credentials                             | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBaseCredentials.json | $.gitCredentials                 | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/HBaseCredentials                            | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBaseCredentials.json | $.hbaseCredentials               | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                        | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBaseDataSources.json | $.gitCollectorDataSource_default | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseDataSource                               | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBaseDataSources.json | $.hbaseDataSource_default        | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBaseDataSources.json | $.gitCollectorDataSource         | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseDataSource/HBaseDataSource               | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBaseDataSources.json | $.hbaseDataSource                | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |                                                                                      |                                  | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HBaseDataSource/HBaseDataSource               |                                                                                      |                                  | 200           | HBaseDataSource        |          |

  ############################################# Plugin Run ##########################################################
  @pythonspark @MLP-10518
  Scenario Outline: SC#2-Configurations for Plugins - Git, HBase Cataloger, Python Parser and Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                                               | path                 | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseCataloger/HBaseCataloger         | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBasePluginConfigs.json | $.hbaseCataloger     | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HBaseCataloger/HBaseCataloger         |                                                                                        |                      | 200           | HBaseCataloger     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollector             | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBasePluginConfigs.json | $.gitCollector       | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollector             |                                                                                        |                      | 200           | GitCollector       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonParser/PythonParser             | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBasePluginConfigs.json | $.pythonParser       | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonParser/PythonParser             |                                                                                        |                      | 200           | PythonParser       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonSparkLineage/PythonSparkLineage | payloads/ida/PythonSparkPayloads/hbase/PluginConfig/pythonSparkHBasePluginConfigs.json | $.pythonSparkLineage | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonSparkLineage/PythonSparkLineage |                                                                                        |                      | 200           | PythonSparkLineage |          |

  @pythonspark @MLP-10518
  Scenario Outline: SC#2-Run the Plugin configurations for Git, HBase Cataloger, Python Parser, Python Linker and PythonJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body           | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector           |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector            | ida/empty.json | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector           |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger       |                | 200           | IDLE             | $.[?(@.configurationName=='HBaseCataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger        | ida/empty.json | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger       |                | 200           | IDLE             | $.[?(@.configurationName=='HBaseCataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser              |                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser               | ida/empty.json | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser              |                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage |                | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage  | ida/empty.json | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/PythonSparkLineage |                | 200           | IDLE             | $.[?(@.configurationName=='PythonSparkLineage')].status |

  ####################### API Lineage verification #############################################
  @pythonspark @MLP-10518 @regression @positive
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                | asg_scopeid | targetFile                                                                    | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_format_select |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_format_select.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | hbase_example       |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_format_select.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                     |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_format_select.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_onetarget     |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_onetarget.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | hbase_example1      |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_onetarget.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                     |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_onetarget.json     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_twotarget     |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_twotarget.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | hbase_example2      |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_twotarget.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                     |             | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_twotarget.json     | $.functionID |

  @pythonspark @MLP-10518 @regression @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                | inputFile                                                                     | outputFile                                                                                    |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_format_select | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_format_select.json | response/python/pythonSpark/pythonSparkHBase/Lineage/PythonSparkLineageHBaseSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_onetarget     | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_onetarget.json     | response/python/pythonSpark/pythonSparkHBase/Lineage/PythonSparkLineageHBaseSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_twotarget     | response/python/pythonSpark/pythonSparkHBase/Lineage/Spark_twotarget.json     | response/python/pythonSpark/pythonSparkHBase/Lineage/PythonSparkLineageHBaseSourceTarget.json |

  #6638476# #6638477# #6638478# #6638479# #6638470#
  @pythonspark @MLP-10518 @regression @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                      | actual_json                                                                                                     | item                |
      | ida/PythonSparkPayloads/hbase/LineageMetadata/expectedPythonSparkLineageHBase.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkHBase/Lineage/PythonSparkLineageHBaseSourceTarget.json | Spark_format_select |
      | ida/PythonSparkPayloads/hbase/LineageMetadata/expectedPythonSparkLineageHBase.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkHBase/Lineage/PythonSparkLineageHBaseSourceTarget.json | Spark_onetarget     |
      | ida/PythonSparkPayloads/hbase/LineageMetadata/expectedPythonSparkLineageHBase.json | Constant.REST_DIR/response/python/pythonSpark/pythonSparkHBase/Lineage/PythonSparkLineageHBaseSourceTarget.json | Spark_twotarget     |


  ############################################# UI Lineage verification #############################################
  @webtest @MLP-10518 @sanity @positive
  Scenario: SC#4:UI Lineage verification: - Verify the PythonSparkLineage plugin generates lineage for the python file named 'Spark_Hbase_Filter.python' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagPythonSparkHBase" and clicks on search
    And user performs "facet selection" in "tagPythonSparkHBase" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hbase_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                                           | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                           | jsonPath       |
      | Lineage Hops | df1.personal data:city => qa_emp.personal data:city                             | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_1 |
      | Lineage Hops | df1.personal data:name => qa_emp.personal data:name                             | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_2 |
      | Lineage Hops | testemployee.personal data:address => df1.personal data:address                 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_3 |
      | Lineage Hops | testemployee.personal data:city => df1.personal data:city                       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_4 |
      | Lineage Hops | testemployee.personal data:name => df1.personal data:name                       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_5 |
      | Lineage Hops | testemployee.professional data:DOJ => df1.professional data:DOJ                 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_6 |
      | Lineage Hops | testemployee.professional data:designation => df1.professional data:designation | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_7 |
      | Lineage Hops | testemployee.professional data:hike => df1.professional data:hike               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_8 |
      | Lineage Hops | testemployee.professional data:salary => df1.professional data:salary           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/hbase/LineageMetadata/pythonSparkLineageHBaseMetadata.json | $.LineageHop_9 |
    And user should be able logoff the IDC

###############################################################################################################################################################################
###################### Deleting the catalog , plugins configurations and test data in HBase
######################################################################################################################################################################

  Scenario Outline: SC#7: Delete tables in HBASE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser | Header   | Query | Param | type   | url                  | body | response code | response message | jsonPath |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | testemployee/schema  |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | qa_emp/schema        |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | qa_emp_filter/schema |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | qa_overwrite/schema  |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | qa_emp_wr1/schema    |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | qa_emp_wr2/schema    |      | 200           |                  |          |


  @cr-data @postcondition @sanity @positive
  Scenario: Post Conditions: ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type                | query | param |
      | SingleItemDelete | Default | LocalNode                                      | Cluster             |       |       |
      | SingleItemDelete | Default | javaspark_lineage                              | Project             |       |       |
      | SingleItemDelete | Default | test_BA_PythonSparkHBase                       | BusinessApplication |       |       |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector%           | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger%       | Analysis            |       |       |
      | MultipleIDDelete | Default | parser/PythonParser/PythonParser%              | Analysis            |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/PythonSparkLineage% | Analysis            |       |       |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: Post Conditions: ConfigDeletion: Delete the Plugin configurations for Git, HBase Cataloger, Python Parser and Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Git_Credentials                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/HBaseCredentials                            |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollector                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HBaseDataSource/HBaseDataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HBaseCataloger/HBaseCataloger                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonParser/PythonParser                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonSparkLineage/PythonSparkLineage         |      | 204           |                  |          |
