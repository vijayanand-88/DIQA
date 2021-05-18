@MLP-25699
Feature:Verification of Java Spark Lineage with Teradata and UDB Data Source

  ### Teradata ###
  ############################################# Pre Conditions ##########################################################
  @jdbc @cr-data @precondition @sanity @positive @teradata
  Scenario: SC#1-Create Table in Teradata
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                   | queryField                  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | createSparkSource1          |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | createSparkSource2          |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | createSparkTarget1_1        |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | createSparkTarget1_2        |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | createSparkTarget2          |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord1SparkSource1   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord2SparkSource1   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord3SparkSource1   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord4SparkSource1   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord5SparkSource1   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord1SparkSource2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord2SparkSource2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord3SparkSource2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord4SparkSource2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord5SparkSource2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord1SparkTarget1_1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord2SparkTarget1_1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord3SparkTarget1_1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord4SparkTarget1_1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord5SparkTarget1_1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord1SparkTarget1_2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord2SparkTarget1_2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord3SparkTarget1_2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord4SparkTarget1_2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord5SparkTarget1_2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord1SparkTarget2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord2SparkTarget2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord3SparkTarget2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord4SparkTarget2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeradataQueriesforJavaSpark | insertRecord5SparkTarget2   |

  @sanity @positive @regression @IDA_E2E @teradata
  Scenario Outline: SC#1:Create Business Application tag for Java Spark Lineage test for Teradata Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/teradata/JavaSparkTeradata_BA.json | 200           |                  |          |

  @sanity @positive @regression @teradata
  Scenario Outline: SC#1-Set the Credentials and Datasources for Git and Teradata
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                              | bodyFile                                                                               | path                             | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Git_Credentials                             | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataCredentials.json | $.gitCredentials                 | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/TeradataCredentials                         | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataCredentials.json | $.teradataCredentials            | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                        | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataDataSources.json | $.gitCollectorDataSource_default | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource                          | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataDataSources.json | $.teradataDBDataSource_default   | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataDataSources.json | $.gitCollectorDataSource         | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDBDataSource     | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataDataSources.json | $.teradataDBDataSource           | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |                                                                                        |                                  | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDBDataSource     |                                                                                        |                                  | 200           | TeradataDBDataSource   |          |

  ############################################# Plugin Run ##########################################################
  @javaspark @MLP-25699 @teradata
  Scenario Outline: SC#2-Configurations for Plugins - Git, Teradata DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                                                 | path                  | response code | response message  | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBCataloger/TeradataCataloger | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataPluginConfigs.json | $.teradataDBCataloger | 204           |                   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBCataloger/TeradataCataloger |                                                                                          |                       | 200           | TeradataCataloger |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollector             | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataPluginConfigs.json | $.gitCollector        | 204           |                   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollector             |                                                                                          |                       | 200           | GitCollector      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser/JavaParser                 | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataPluginConfigs.json | $.javaParser          | 204           |                   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser/JavaParser                 |                                                                                          |                       | 200           | JavaParser        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage/JavaSparkLineage     | payloads/ida/javaSparkPayloads/teradata/PluginConfig/javaSparkTeradataPluginConfigs.json | $.javaSparkLineage    | 204           |                   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage/JavaSparkLineage     |                                                                                          |                       | 200           | JavaSparkLineage  |          |

  @javaspark @MLP-25699 @teradata
  Scenario Outline: SC#2-Run the Plugin configurations for Git, Teradata DB Cataloger, Java Parser, Java Linker and JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body           | response code | response message | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector             |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector              | ida/empty.json | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector             |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='TeradataCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeradataCataloger  | ida/empty.json | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCataloger |                | 200           | IDLE             | $.[?(@.configurationName=='TeradataCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                    |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser                     | ida/empty.json | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser                    |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage       |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage        | ida/empty.json | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage       |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status  |

  ####################### API Lineage verification #############################################
  @javaspark @MLP-25699 @regression @positive @teradata
  Scenario Outline:SC#3:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                | asg_scopeid | targetFile                                                                 | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_Teradata_JDBC |             | response/java/javaSpark/javaSparkTeradata/Lineage/Spark_Teradata_JDBC.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadTeradataJDBC  |             | response/java/javaSpark/javaSparkTeradata/Lineage/Spark_Teradata_JDBC.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                     |             | response/java/javaSpark/javaSparkTeradata/Lineage/Spark_Teradata_JDBC.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_TeradataSC1   |             | response/java/javaSpark/javaSparkTeradata/Lineage/Spark_TeradataSC1.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadTeradataSC1   |             | response/java/javaSpark/javaSparkTeradata/Lineage/Spark_TeradataSC1.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                     |             | response/java/javaSpark/javaSparkTeradata/Lineage/Spark_TeradataSC1.json   | $.functionID |

  @javaspark @MLP-25699 @regression @positive @teradata
  Scenario Outline: SC#3:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                | inputFile                                                                  | outputFile                                                                                  |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_Teradata_JDBC | response/java/javaSpark/javaSparkTeradata/Lineage/Spark_Teradata_JDBC.json | response/java/javaSpark/javaSparkTeradata/Lineage/JavaSparkLineageTeradataSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_TeradataSC1   | response/java/javaSpark/javaSparkTeradata/Lineage/Spark_TeradataSC1.json   | response/java/javaSpark/javaSparkTeradata/Lineage/JavaSparkLineageTeradataSourceTarget.json |

  #7165808# #7165809# #7165810# #7165811#
  @javaspark @MLP-25699 @regression @positive @teradata
  Scenario Outline: SC#3:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                        | actual_json                                                                                                   | item                |
      | ida/javaSparkPayloads/teradata/LineageMetadata/expectedJavaSparkLineageTeradata.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTeradata/Lineage/JavaSparkLineageTeradataSourceTarget.json | Spark_Teradata_JDBC |
      | ida/javaSparkPayloads/teradata/LineageMetadata/expectedJavaSparkLineageTeradata.json | Constant.REST_DIR/response/java/javaSpark/javaSparkTeradata/Lineage/JavaSparkLineageTeradataSourceTarget.json | Spark_TeradataSC1   |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-25699 @sanity @positive @teradata
  Scenario: SC#4:UI Lineage verification: - Verify the JavaSparkLineage plugin generates lineage for the java file named 'Spark_Teradata_JDBC.java' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaSparkTeradata" and clicks on search
    And user performs "facet selection" in "tagJavaSparkTeradata" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "doReadTeradataJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                          | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                             | jsonPath       |
      | Lineage Hops | SPARK_SOURCE_SC2.department_name => jdbcDF_td2.department_name | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/teradata/LineageMetadata/javaSparkLineageTeradataMetadata.json | $.LineageHop_1 |
      | Lineage Hops | SPARK_SOURCE_SC2.dept_no => jdbcDF_td2.dept_no                 | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/teradata/LineageMetadata/javaSparkLineageTeradataMetadata.json | $.LineageHop_2 |
      | Lineage Hops | SPARK_SOURCE_SC2.loc_name => jdbcDF_td2.loc_name               | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/teradata/LineageMetadata/javaSparkLineageTeradataMetadata.json | $.LineageHop_3 |
      | Lineage Hops | department_name => SPARK_TARGET_SC2.department_name            | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/teradata/LineageMetadata/javaSparkLineageTeradataMetadata.json | $.LineageHop_4 |
      | Lineage Hops | dept_no => SPARK_TARGET_SC2.dept_no                            | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/teradata/LineageMetadata/javaSparkLineageTeradataMetadata.json | $.LineageHop_5 |
      | Lineage Hops | loc_name => SPARK_TARGET_SC2.loc_name                          | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/teradata/LineageMetadata/javaSparkLineageTeradataMetadata.json | $.LineageHop_6 |

  ###############################TechnologyTagValidation#################################
  @webtest @MLP-25699 @sanity @positive @regression @teradata
  Scenario: SC#5:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                           | fileName               | userTag              |
      | Default     | File       | Metadata Type | test_BA_JavaSparkTeradata,Git,tagJavaSparkTeradata,Java,Spark | Spark_TeradataSC1.java | tagJavaSparkTeradata |
      | Default     | SourceTree | Metadata Type | test_BA_JavaSparkTeradata,tagJavaSparkTeradata,Java,Spark     | Spark_TeradataSC1      | tagJavaSparkTeradata |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkTeradata,tagJavaSparkTeradata,Teradata       | SPARK_TARGET_SC2       | tagJavaSparkTeradata |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkTeradata,tagJavaSparkTeradata,Java,Spark     | jdbcDF_td1             | tagJavaSparkTeradata |
      | Default     | Class      | Metadata Type | test_BA_JavaSparkTeradata,tagJavaSparkTeradata,Java           | Spark_Teradata_JDBC    | tagJavaSparkTeradata |
      | Default     | Function   | Metadata Type | test_BA_JavaSparkTeradata,tagJavaSparkTeradata,Java,Spark     | doReadTeradataJDBC     | tagJavaSparkTeradata |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName            | userTag              |
      | Default     | Class      | Metadata Type | Programming | Spark_Teradata_JDBC | tagJavaSparkTeradata |
      | Default     | Function   | Metadata Type | Programming | doReadTeradataJDBC  | tagJavaSparkTeradata |
      | Default     | SourceTree | Metadata Type | Programming | Spark_Teradata_JDBC | tagJavaSparkTeradata |
    And user enters the search text "tagJavaSparkTeradata" and clicks on search
    And user performs "facet selection" in "tagJavaSparkTeradata" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadTeradataJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                               | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | department_name => SPARK_TARGET_SC2.department_name | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_JavaSparkTeradata,tagJavaSparkTeradata,Java,Spark |
      | item | department_name => SPARK_TARGET_SC2.department_name       |
    And user should be able logoff the IDC

  ############################################# Post Conditions ##########################################################
  @cr-data @postcondition @sanity @positive @teradata
  Scenario: SC#6-Delete required tables in Teradata DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema | Table              | Database  |
      | teradata_db16      | DROP      |        | SPARK_SOURCE_SC1   | collector |
      | teradata_db16      | DROP      |        | SPARK_SOURCE_SC2   | collector |
      | teradata_db16      | DROP      |        | SPARK_TARGET_SC1_1 | collector |
      | teradata_db16      | DROP      |        | SPARK_TARGET_SC1_2 | collector |
      | teradata_db16      | DROP      |        | SPARK_TARGET_SC2   | collector |

  @cr-data @postcondition @sanity @positive @teradata
  Scenario: SC#6:ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type                | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc                     | Cluster             |       |       |
      | SingleItemDelete | Default | automation_repo_java_spark                       | Project             |       |       |
      | SingleItemDelete | Default | test_BA_JavaSparkTeradata                        | BusinessApplication |       |       |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector%             | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/TeradataCataloger% | Analysis            |       |       |
      | MultipleIDDelete | Default | parser/JavaParser/JavaParser%                    | Analysis            |       |       |
      | MultipleIDDelete | Default | lineage/JavaSparkLineage/JavaSparkLineage%       | Analysis            |       |       |

  @cr-data @postcondition @sanity @positive @teradata
  Scenario Outline: SC#6:ConfigDeletion: Delete the Plugin configurations for Git, Teradata DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Git_Credentials                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/TeradataCredentials                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollector                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBDataSource/TeradataDBDataSource     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBCataloger/TeradataCataloger         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser/JavaParser                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage/JavaSparkLineage             |      | 204           |                  |          |


  ### UDB ###
  ############################################# Pre Conditions ##########################################################
  @jdbc @cr-data @precondition @sanity @positive @udb
  Scenario: SC#7-Create Table in UDB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage              | queryField                     |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | createSparkUDBSource1          |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | createSparkUDBSource2          |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | createSparkUDBTarget1_1        |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | createSparkUDBTarget1_2        |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | createSparkUDBTarget2          |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord1SparkUDBSource1   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord2SparkUDBSource1   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord3SparkUDBSource1   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord4SparkUDBSource1   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord1SparkUDBSource2   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord2SparkUDBSource2   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord3SparkUDBSource2   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord4SparkUDBSource2   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord1SparkUDBTarget1_1 |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord2SparkUDBTarget1_1 |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord3SparkUDBTarget1_1 |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord4SparkUDBTarget1_1 |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord1SparkUDBTarget1_2 |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord2SparkUDBTarget1_2 |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord3SparkUDBTarget1_2 |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord4SparkUDBTarget1_2 |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord1SparkUDBTarget2   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord2SparkUDBTarget2   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord3SparkUDBTarget2   |
      | DB2                | EXECUTEQUERY | json/IDA.json | DB2QueriesforJavaSpark | insertRecord4SparkUDBTarget2   |

  @sanity @positive @regression @IDA_E2E @udb
  Scenario Outline: SC#7:Create Business Application tag for Java Spark Lineage test for UDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaSparkPayloads/udb/JavaSparkUDB_BA.json | 200           |                  |          |

  @sanity @positive @regression @udb
  Scenario Outline: SC#7-Set the Credentials and Datasources for Git and UDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                              | bodyFile                                                                     | path                             | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Git_Credentials                             | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBCredentials.json | $.gitCredentials                 | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/UDBCredentials                              | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBCredentials.json | $.udbCredentials                 | 200           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                        | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBDataSources.json | $.gitCollectorDataSource_default | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource                                 | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBDataSources.json | $.udbDataSource_default          | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBDataSources.json | $.gitCollectorDataSource         | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource/UDBDataSource                   | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBDataSources.json | $.udbDataSource                  | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |                                                                              |                                  | 200           | GitCollectorDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/UDBDataSource/UDBDataSource                   |                                                                              |                                  | 200           | UDBDataSource          |          |


  ############################################# Plugin Run ##########################################################
  @javaspark @MLP-25699 @udb
  Scenario Outline: SC#8-Configurations for Plugins - Git, UDB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                  | bodyFile                                                                       | path               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/UDBCataloger/UDBCataloger         | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBPluginConfigs.json | $.udbCataloger     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/UDBCataloger/UDBCataloger         |                                                                                |                    | 200           | UDBCataloger     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollector         | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBPluginConfigs.json | $.gitCollector     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollector         |                                                                                |                    | 200           | GitCollector     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser/JavaParser             | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBPluginConfigs.json | $.javaParser       | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser/JavaParser             |                                                                                |                    | 200           | JavaParser       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaSparkLineage/JavaSparkLineage | payloads/ida/javaSparkPayloads/udb/PluginConfig/javaSparkUDBPluginConfigs.json | $.javaSparkLineage | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaSparkLineage/JavaSparkLineage |                                                                                |                    | 200           | JavaSparkLineage |          |

  @javaspark @MLP-25699 @udb
  Scenario Outline: SC#8-Run the Plugin configurations for Git, UDB Cataloger, Java Parser, Java Linker and JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body           | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector       |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector        | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector       |                | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/UDBCataloger       |                | 200           | IDLE             | $.[?(@.configurationName=='UDBCataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/UDBCataloger        | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/UDBCataloger       |                | 200           | IDLE             | $.[?(@.configurationName=='UDBCataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser              |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser               | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser              |                | 200           | IDLE             | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage  | ida/empty.json | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaSparkLineage/JavaSparkLineage |                | 200           | IDLE             | $.[?(@.configurationName=='JavaSparkLineage')].status |


  ####################### API Lineage verification #############################################
  @javaspark @MLP-25699 @regression @positive @udb
  Scenario Outline:SC#9:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data for UDB
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name           | asg_scopeid | targetFile                                                       | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_UDB_JDBC |             | response/java/javaSpark/javaSparkUDB/Lineage/Spark_UDB_JDBC.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadUDBJDBC  |             | response/java/javaSpark/javaSparkUDB/Lineage/Spark_UDB_JDBC.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                |             | response/java/javaSpark/javaSparkUDB/Lineage/Spark_UDB_JDBC.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Spark_UDB_SC1  |             | response/java/javaSpark/javaSparkUDB/Lineage/Spark_UDB_SC1.json  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadUDBSC1   |             | response/java/javaSpark/javaSparkUDB/Lineage/Spark_UDB_SC1.json  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                |             | response/java/javaSpark/javaSparkUDB/Lineage/Spark_UDB_SC1.json  | $.functionID |

  @javaspark @MLP-25699 @regression @positive @udb
  Scenario Outline: SC#9:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids for UDB
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item           | inputFile                                                        | outputFile                                                                        |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_UDB_JDBC | response/java/javaSpark/javaSparkUDB/Lineage/Spark_UDB_JDBC.json | response/java/javaSpark/javaSparkUDB/Lineage/JavaSparkLineageUDBSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Spark_UDB_SC1  | response/java/javaSpark/javaSparkUDB/Lineage/Spark_UDB_SC1.json  | response/java/javaSpark/javaSparkUDB/Lineage/JavaSparkLineageUDBSourceTarget.json |

  #7165812# #7165813# #7165814# #7165815#
  @javaspark @MLP-25699 @regression @positive @udb
  Scenario Outline: SC#9:API Lineage Hops Final Validation: Lineage Hops Final Validation using API for UDB
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                                                                         | item           |
      | ida/javaSparkPayloads/udb/LineageMetadata/expectedJavaSparkLineageUDB.json | Constant.REST_DIR/response/java/javaSpark/javaSparkUDB/Lineage/JavaSparkLineageUDBSourceTarget.json | Spark_UDB_JDBC |
      | ida/javaSparkPayloads/udb/LineageMetadata/expectedJavaSparkLineageUDB.json | Constant.REST_DIR/response/java/javaSpark/javaSparkUDB/Lineage/JavaSparkLineageUDBSourceTarget.json | Spark_UDB_SC1  |

  ############################################# UI Lineage verification #############################################
  @webtest @MLP-25699 @sanity @positive @udb
  Scenario: SC#10:UI Lineage verification: - Verify the JavaSparkLineage plugin generates lineage for the java file named 'Spark_Teradata_JDBC.java' stored in Git repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaSparkUDB" and clicks on search
    And user performs "facet selection" in "tagJavaSparkUDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "doReadUDBJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                        | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                   | jsonPath       |
      | Lineage Hops | DEPT_HEAD => SPARK_UDB_TARGET2.DEPT_HEAD                     | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/udb/LineageMetadata/javaSparkLineageUDBMetadata.json | $.LineageHop_1 |
      | Lineage Hops | DEPT_ID => SPARK_UDB_TARGET2.DEPT_ID                         | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/udb/LineageMetadata/javaSparkLineageUDBMetadata.json | $.LineageHop_2 |
      | Lineage Hops | DEPT_LOCATION => SPARK_UDB_TARGET2.DEPT_LOCATION             | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/udb/LineageMetadata/javaSparkLineageUDBMetadata.json | $.LineageHop_3 |
      | Lineage Hops | DEPT_NAME => SPARK_UDB_TARGET2.DEPT_NAME                     | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/udb/LineageMetadata/javaSparkLineageUDBMetadata.json | $.LineageHop_4 |
      | Lineage Hops | SPARK_UDB_SOURCE2.DEPT_HEAD => jdbcDF_udb2.DEPT_HEAD         | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/udb/LineageMetadata/javaSparkLineageUDBMetadata.json | $.LineageHop_5 |
      | Lineage Hops | SPARK_UDB_SOURCE2.DEPT_ID => jdbcDF_udb2.DEPT_ID             | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/udb/LineageMetadata/javaSparkLineageUDBMetadata.json | $.LineageHop_6 |
      | Lineage Hops | SPARK_UDB_SOURCE2.DEPT_LOCATION => jdbcDF_udb2.DEPT_LOCATION | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/udb/LineageMetadata/javaSparkLineageUDBMetadata.json | $.LineageHop_7 |
      | Lineage Hops | SPARK_UDB_SOURCE2.DEPT_NAME => jdbcDF_udb2.DEPT_NAME         | click and verify lineagehops | Yes              | 0           | ida/javaSparkPayloads/udb/LineageMetadata/javaSparkLineageUDBMetadata.json | $.LineageHop_8 |

  ###############################TechnologyTagValidation#################################
  @webtest @MLP-25699 @sanity @positive @regression @udb
  Scenario: SC#11:Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                 | fileName           | userTag         |
      | Default     | File       | Metadata Type | test_BA_JavaSparkUDB,Git,tagJavaSparkUDB,Java,Spark | Spark_UDB_SC1.java | tagJavaSparkUDB |
      | Default     | SourceTree | Metadata Type | test_BA_JavaSparkUDB,tagJavaSparkUDB,Java,Spark     | Spark_UDB_SC1      | tagJavaSparkUDB |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkUDB,tagJavaSparkUDB,DB2            | SPARK_UDB_TARGET2  | tagJavaSparkUDB |
      | Default     | Table      | Metadata Type | test_BA_JavaSparkUDB,tagJavaSparkUDB,Java,Spark     | jdbcDF_udb2        | tagJavaSparkUDB |
      | Default     | Class      | Metadata Type | test_BA_JavaSparkUDB,tagJavaSparkUDB,Java           | Spark_UDB_JDBC     | tagJavaSparkUDB |
      | Default     | Function   | Metadata Type | test_BA_JavaSparkUDB,tagJavaSparkUDB,Java,Spark     | doReadUDBJDBC      | tagJavaSparkUDB |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName       | userTag         |
      | Default     | Class      | Metadata Type | Programming | Spark_UDB_JDBC | tagJavaSparkUDB |
      | Default     | Function   | Metadata Type | Programming | doReadUDBJDBC  | tagJavaSparkUDB |
      | Default     | SourceTree | Metadata Type | Programming | Spark_UDB_JDBC | tagJavaSparkUDB |
    And user enters the search text "tagJavaSparkUDB" and clicks on search
    And user performs "facet selection" in "tagJavaSparkUDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "doReadUDBJDBC" item from search results
    Then user performs click and verify in new window
      | Table        | value                                | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | DEPT_ID => SPARK_UDB_TARGET2.DEPT_ID | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | test_BA_JavaSparkUDB,tagJavaSparkUDB,Java,Spark |
      | item | DEPT_ID => SPARK_UDB_TARGET2.DEPT_ID            |
    And user should be able logoff the IDC

  ############################################# Post Conditions ##########################################################
  @cr-data @postcondition @sanity @positive @udb
  Scenario: SC#12-Delete required tables in UDB DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema   | Table                  | Database |
      | DB2                | DROP      | UDBTEST1 | SPARK_UDB_SOURCE1      | UDBTEST1 |
      | DB2                | DROP      | UDBTEST1 | SPARK_UDB_SOURCE2      | UDBTEST1 |
      | DB2                | DROP      | UDBTEST1 | SPARK_UDB_TARGET_SC1_1 | UDBTEST1 |
      | DB2                | DROP      | UDBTEST1 | SPARK_UDB_TARGET_SC1_2 | UDBTEST1 |
      | DB2                | DROP      | UDBTEST1 | SPARK_UDB_TARGET2      | UDBTEST1 |

  @cr-data @postcondition @sanity @positive @udb
  Scenario: SC#12:ItemDeletion- User deletes the collected item from database using dynamic id stored in json - UDB
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type                | query | param |
      | SingleItemDelete | Default | gechcae-col1.asg.com                       | Cluster             |       |       |
      | SingleItemDelete | Default | automation_repo_java_spark                 | Project             |       |       |
      | SingleItemDelete | Default | test_BA_JavaSparkUDB                       | BusinessApplication |       |       |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector%       | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/UDBCataloger%       | Analysis            |       |       |
      | MultipleIDDelete | Default | parser/JavaParser/JavaParser%              | Analysis            |       |       |
      | MultipleIDDelete | Default | lineage/JavaSparkLineage/JavaSparkLineage% | Analysis            |       |       |

  @cr-data @postcondition @sanity @positive @udb
  Scenario Outline: SC#12:ConfigDeletion: Delete the Plugin configurations for Git, UDB DB Cataloger, Java Parser and Java Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Git_Credentials                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/UDBCredentials                              |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollector                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/UDBDataSource/UDBDataSource                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/UDBCataloger/UDBCataloger                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser/JavaParser                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaSparkLineage/JavaSparkLineage             |      | 204           |                  |          |
