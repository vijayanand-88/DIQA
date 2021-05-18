@MLP-10518
Feature:Verification of Java Spark Lineage with HBase Data Source

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
      | ServiceName | ServiceUser | Header   | Query | Param | type | url                    | body                                                                                              | response code | response message | jsonPath |
      | HBase       | hbaseuser   | text/xml |       |       | Post | testemployee/schema    | ida/javaSparkPayloads/hbase/TestData/Hbase_testemployee_CreateTable.xml                           | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | testemployee/row_key/  | ida/javaSparkPayloads/hbase/TestData/Hbase_testemployee_Create_ColumnFamily_and_ColumnValues.xml  | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_emp/schema          | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_emp_CreateTable.xml                                 | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_emp/row_key/        | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_emp_Create_ColumnFamily_and_ColumnValues.xml        | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_emp_filter/schema   | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_emp_filter_CreateTable.xml                          | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_emp_filter/row_key/ | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_emp_filter_Create_ColumnFamily_and_ColumnValues.xml | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_emp_wr1/schema      | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_emp_wr1_CreateTable.xml                             | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_emp_wr1/row_key/    | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_emp_wr1_Create_ColumnFamily_and_ColumnValues.xml    | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_emp_wr2/schema      | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_emp_wr2_CreateTable.xml                             | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_emp_wr2/row_key/    | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_emp_wr2_Create_ColumnFamily_and_ColumnValues.xml    | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | qa_overwrite/schema    | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_overwrite_CreateTable.xml                           | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | qa_overwrite/row_key/  | ida/javaSparkPayloads/hbase/TestData/Hbase_qa_overwrite_Create_ColumnFamily_and_ColumnValues.xml  | 200           |                  |          |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1:Create Business Application tag for Java Spark Lineage test for HBase Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/hbase/JavaSparkHBase_BA.json | 200           |                  |          |

  @MLP-10518 @sanity @positive @regression
  Scenario: SC#1: Configuring HBase data source with relevant Rest URL
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user update json file "ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBaseDataSources.json" file for following values using property loader
      | jsonPath                       | jsonValues          |
      | $.hbaseDataSource.hbaseRestUrl | HbaseRestAPIBaseURL |

  @sanity @positive @regression
  Scenario Outline: SC#1-Set the Credentials and Datasources for Git and HBase
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                              | bodyFile                                                                         | path                             | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Git_Credentials                             | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBaseCredentials.json | $.gitCredentials                 | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/HBaseCredentials                            | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBaseCredentials.json | $.hbaseCredentials               | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                        | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBaseDataSources.json | $.gitCollectorDataSource_default | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseDataSource                               | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBaseDataSources.json | $.hbaseDataSource_default        | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBaseDataSources.json | $.gitCollectorDataSource         | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseDataSource/HBaseDataSource               | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBaseDataSources.json | $.hbaseDataSource                | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |                                                                                  |                                  | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HBaseDataSource/HBaseDataSource               |                                                                                  |                                  | 200           | HBaseDataSource        |          |

  ############################################# Plugin Run ##########################################################
  @javaspark @MLP-10518
  Scenario Outline: SC#2-Configurations for Plugins - Git, HBase Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                  | bodyFile                                                                           | path               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseCataloger/HBaseCataloger     | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBasePluginConfigs.json | $.hbaseCataloger   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HBaseCataloger/HBaseCataloger     |                                                                                    |                    | 200           | HBaseCataloger   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollector         | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBasePluginConfigs.json | $.gitCollector     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollector         |                                                                                    |                    | 200           | GitCollector     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser/JavaParser             | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBasePluginConfigs.json | $.javaParser       | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser/JavaParser             |                                                                                    |                    | 200           | JavaParser       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage/JavaSparkLineage | payloads/ida/javaSparkPayloads/hbase/PluginConfig/javaSparkHBasePluginConfigs.json | $.javaSparkLineage | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage/JavaSparkLineage |                                                                                    |                    | 200           | JavaSparkLineage |          |

  @javaspark @MLP-10518
  Scenario Outline: SC#2-Run the Plugin configurations for Git, HBase Cataloger, Java Parser, Java Linker and JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body           | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector       |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector        | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector       |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger   |                | 200           | IDLE             | $.[?(@.configurationName=='HBaseCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger    | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger   |                | 200           | IDLE             | $.[?(@.configurationName=='HBaseCataloger')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser              |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser               | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser              |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage  | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status |

  ####################### API Lineage verification #############################################
  @javaspark @MLP-10518 @regression @positive
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                      | asg_scopeid | targetFile                                                                    | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Hbase_Filter        |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Filter.json        |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadHbaseFilter         |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Filter.json        |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                           |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Filter.json        | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Hbase_Format_Select |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Format_Select.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadHbaseFormatSelect   |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Format_Select.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                           |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Format_Select.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Hbase_MultipleWrite |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_MultipleWrite.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadHbaseMultipleWrite  |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_MultipleWrite.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                           |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_MultipleWrite.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Hbase_Overwrite     |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Overwrite.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadHbaseOverwrite      |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Overwrite.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                           |             | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Overwrite.json     | $.functionID |

  @javaspark @MLP-10518 @regression @positive
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                      | inputFile                                                                     | outputFile                                                                            |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Hbase_Filter        | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Filter.json        | response/java/javaSpark/javaSparkHBase/Lineage/JavaSparkLineageHBaseSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Hbase_Format_Select | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Format_Select.json | response/java/javaSpark/javaSparkHBase/Lineage/JavaSparkLineageHBaseSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Hbase_MultipleWrite | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_MultipleWrite.json | response/java/javaSpark/javaSparkHBase/Lineage/JavaSparkLineageHBaseSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Hbase_Overwrite     | response/java/javaSpark/javaSparkHBase/Lineage/Spark_Hbase_Overwrite.json     | response/java/javaSpark/javaSparkHBase/Lineage/JavaSparkLineageHBaseSourceTarget.json |

  @javaspark @MLP-10518 @regression @positive
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                  | actual_json                                                                                             | item                      |
      | ida/javaSparkPayloads/hbase/LineageMetadata/expectedJavaSparkLineageHBase.json | Constant.REST_DIR/response/java/javaSpark/javaSparkHBase/Lineage/JavaSparkLineageHBaseSourceTarget.json | Spark_Hbase_Filter        |
      | ida/javaSparkPayloads/hbase/LineageMetadata/expectedJavaSparkLineageHBase.json | Constant.REST_DIR/response/java/javaSpark/javaSparkHBase/Lineage/JavaSparkLineageHBaseSourceTarget.json | Spark_Hbase_Format_Select |
      | ida/javaSparkPayloads/hbase/LineageMetadata/expectedJavaSparkLineageHBase.json | Constant.REST_DIR/response/java/javaSpark/javaSparkHBase/Lineage/JavaSparkLineageHBaseSourceTarget.json | Spark_Hbase_MultipleWrite |
      | ida/javaSparkPayloads/hbase/LineageMetadata/expectedJavaSparkLineageHBase.json | Constant.REST_DIR/response/java/javaSpark/javaSparkHBase/Lineage/JavaSparkLineageHBaseSourceTarget.json | Spark_Hbase_Overwrite     |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-10518 @sanity @positive
  Scenario: SC#4:UI Lineage verification: - Verify the JavaSparkLineage plugin generates lineage for the java file named 'Spark_Hbase_Filter.java' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaSparkHBase" and clicks on search
    And user performs "facet selection" in "tagJavaSparkHBase" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadHbaseFilter" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                                                  | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                       | jsonPath       |
      | Lineage Hops | personal data:city => qa_emp_filter.personal data:city                                 | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_1 |
      | Lineage Hops | personal data:name => qa_emp_filter.personal data:name                                 | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_2 |
      | Lineage Hops | testemployee.personal data:address => jdbcDF_hb4.personal data:address                 | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_3 |
      | Lineage Hops | testemployee.personal data:city => jdbcDF_hb4.personal data:city                       | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_4 |
      | Lineage Hops | testemployee.personal data:name => jdbcDF_hb4.personal data:name                       | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_5 |
      | Lineage Hops | testemployee.professional data:DOJ => jdbcDF_hb4.professional data:DOJ                 | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_6 |
      | Lineage Hops | testemployee.professional data:designation => jdbcDF_hb4.professional data:designation | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_7 |
      | Lineage Hops | testemployee.professional data:hike => jdbcDF_hb4.professional data:hike               | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_8 |
      | Lineage Hops | testemployee.professional data:salary => jdbcDF_hb4.professional data:salary           | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/hbase/LineageMetadata/javaSparkLineageHBaseMetadata.json | $.LineageHop_9 |
    And user should be able logoff the IDC

  @webtest @javaspark @MLP-10518 @regression @negative
  Scenario: SC5: Verify the JavaSparkLineage plugin doesn't generates lineage for the below cases
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName            | windowName   |
      | Default     | Function  | Metadata Type | doReadHbaseNegative | Lineage Hops |
    And user should be able logoff the IDC

  ###############################TechnologyTagValidation#################################
  @webtest @MLP-10518 @sanity @positive @regression
  Scenario: SC#6:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                     | fileName                  | userTag           |
      | Default     | File       | Metadata Type | test_BA_JavaSparkHBase,Git,tagJavaSparkHBase,Java,Spark | Spark_Hbase_Filter.java   | tagJavaSparkHBase |
      | Default     | SourceTree | Metadata Type | test_BA_JavaSparkHBase,tagJavaSparkHBase,Java,Spark     | Spark_Hbase_MultipleWrite | tagJavaSparkHBase |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkHBase,tagJavaSparkHBase,HBase          | qa_emp                    | tagJavaSparkHBase |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkHBase,tagJavaSparkHBase,Java,Spark     | jdbcDF_hb1                | tagJavaSparkHBase |
      | Default     | Class      | Metadata Type | test_BA_JavaSparkHBase,tagJavaSparkHBase,Java           | Spark_Hbase_Overwrite     | tagJavaSparkHBase |
      | Default     | Function   | Metadata Type | test_BA_JavaSparkHBase,tagJavaSparkHBase,Java,Spark     | doReadHbaseFormatSelect   | tagJavaSparkHBase |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName                  | userTag           |
      | Default     | Class      | Metadata Type | Programming | Spark_Hbase_Overwrite     | tagJavaSparkHBase |
      | Default     | Function   | Metadata Type | Programming | doReadHbaseFormatSelect   | tagJavaSparkHBase |
      | Default     | SourceTree | Metadata Type | Programming | Spark_Hbase_MultipleWrite | tagJavaSparkHBase |
    And user enters the search text "doReadHbaseFilter" and clicks on search
    And user performs "facet selection" in "tagJavaSparkHBase" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadHbaseFilter" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                  | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | personal data:city => qa_emp_filter.personal data:city | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_JavaSparkHBase,tagJavaSparkHBase,Java,Spark    |
      | item | personal data:city => qa_emp_filter.personal data:city |
    And user should be able logoff the IDC

###############################################################################################################################################################################
###################### Deleting the catalog , plugins configurations and test data in HBase
######################################################################################################################################################################

  @cr-data @MLP-10518 @sanity @positive @regression
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
  Scenario: SC#7: ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type                | query | param |
      | SingleItemDelete | Default | LocalNode                                  | Cluster             |       |       |
      | SingleItemDelete | Default | automation_repo_java_spark                 | Project             |       |       |
      | SingleItemDelete | Default | test_BA_JavaSparkHBase                     | BusinessApplication |       |       |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector%       | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger%   | Analysis            |       |       |
      | MultipleIDDelete | Default | parser/JavaParser/JavaParser%              | Analysis            |       |       |
      | MultipleIDDelete | Default | lineage/JavaSparkLineage/JavaSparkLineage% | Analysis            |       |       |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#7: ConfigDeletion: Delete the Plugin configurations for Git, HBase Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Git_Credentials                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/HBaseCredentials                            |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollector                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HBaseDataSource/HBaseDataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HBaseCataloger/HBaseCataloger                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser/JavaParser                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage/JavaSparkLineage             |      | 204           |                  |          |
