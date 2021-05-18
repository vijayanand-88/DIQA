Feature: To Handle Lineage and dataframe transformations when source and target isnt cataloged


    ################################################################################################################################################################################
#  --------------------PLUGIN CONFIGURATIONS----------------------------#

  @MLP-11603 @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1-Precondition:Run the Plugin configurations for Git , Python Parser , Package Linker and Python Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | body                                                                                       | response code | response message                       | jsonPath                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/sparkGit                                                                       | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/GitCredentials.json                        | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                           | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/gitDatasourceConfig.json                   | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                                     | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/Git_Pyspark.json                           | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                                     |                                                                                            | 200           | GitCollector_SparkAnlayzerImprovements |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_SparkAnlayzerImprovements |                                                                                            | 200           | IDLE                                   | $.[?(@.configurationName=='GitCollector_SparkAnlayzerImprovements')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_SparkAnlayzerImprovements  | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/Git_Pyspark_empty.json                     | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_SparkAnlayzerImprovements |                                                                                            | 200           | IDLE                                   | $.[?(@.configurationName=='GitCollector_SparkAnlayzerImprovements')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/sparkOracle                                                                    | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/OracleDBCredentials.json                   | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                                               | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/OracleDBDataSource.json                    | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                                | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/oracleCatalogerConfig_for_PythonSpark.json | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                                                |                                                                                            | 200           | OracleDBCataloger_Spark                |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark           |                                                                                            | 200           | IDLE                                   | $.[?(@.configurationName=='OracleDBCataloger_Spark')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark            | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/Oracle_Pyspark_empty.json                  | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark           |                                                                                            | 200           | IDLE                                   | $.[?(@.configurationName=='OracleDBCataloger_Spark')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonParser                                                                     | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/Parser_Pyspark.json                        | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonParser                                                                     |                                                                                            | 200           | PythonParser_Spark                     |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Spark                        |                                                                                            | 200           | IDLE                                   | $.[?(@.configurationName=='PythonParser_Spark')].status                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_Spark                         | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/Parser_Pyspark_empty.json                  | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Spark                        |                                                                                            | 200           | IDLE                                   | $.[?(@.configurationName=='PythonParser_Spark')].status                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonSparkLineage                                                               | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/Py_Spark_Pyspark.json                      | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonSparkLineage                                                               |                                                                                            | 200           | PythonSparkLineage_Oracle              |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle                |                                                                                            | 200           | IDLE                                   | $.[?(@.configurationName=='PythonSparkLineage_Oracle')].status              |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle                 | ida/PythonSparkPayloads/MLP-11603_PluginsConfig/Py_Spark_Pyspark_empty.json                | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle                |                                                                                            | 200           | IDLE                                   | $.[?(@.configurationName=='PythonSparkLineage_Oracle')].status              |


    ################################################################################################################################################################################
#  ----------------------Source tree validation--------------------------#

  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC#2-Check if the count from the collector plugin and SourceTree count matches
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PythonSparkAnlayzerImprovements" and clicks on search
    And user performs "facet selection" in "PythonSparkAnlayzerImprovements" attribute under "Tags" facets in Item Search results page
    And user selects the "SourceTree" from the Type
    And verify the count of search list and the Expected count "9" matches


       ################################################################################################################################################################################
#  ----------------------Lineage Hops validation--------------------------#

   #Testcase id - #6705735
  @webtest @MLP-11603 @sanity @positive @regression
  Scenario: SC#3-Verify Lineage Hops in UI for alias_distinct function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PythonSparkAnlayzerImprovements" and clicks on search
    And user performs "facet selection" in "PythonSparkAnlayzerImprovements" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "uninonByName_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                        | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                              | jsonPath |
      | Lineage Hops | PEOPLE.AGE => df17.AGE       | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\uninonByName_example.json | $.AGE    |
      | Lineage Hops | PEOPLE.CITY => df17.CITY     | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\uninonByName_example.json | $.CITY   |
      | Lineage Hops | PEOPLE.HEIGHT => df17.HEIGHT | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\uninonByName_example.json | $.HEIGHT |
      | Lineage Hops | PEOPLE.NAME => df17.NAME     | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\uninonByName_example.json | $.NAME   |


    ################################################################################################################################################################################
#  ----------------------Lineage Source and Targets validation--------------------------#

  @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC#4-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                                      | asg_scopeid | targetFile                                                                                   | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Select_Drop                               |             | response/PythonSparkLineage/MLP-11603_Lineage/select_drop_alias_example.json                 |              |
      | APPDBPOSTGRES | FunctionID | Default |            | select_drop_alias_example                 |             | response/PythonSparkLineage/MLP-11603_Lineage/select_drop_alias_example.json                 |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                           |             | response/PythonSparkLineage/MLP-11603_Lineage/select_drop_alias_example.json                 | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Sort_SortwithPartition                    |             | response/PythonSparkLineage/MLP-11603_Lineage/sort_sortwithpartition_example.json            |              |
      | APPDBPOSTGRES | FunctionID | Default |            | sort_sortwithpartition_example            |             | response/PythonSparkLineage/MLP-11603_Lineage/sort_sortwithpartition_example.json            |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                           |             | response/PythonSparkLineage/MLP-11603_Lineage/sort_sortwithpartition_example.json            | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | NoSourceTarget                            |             | response/PythonSparkLineage/MLP-11603_Lineage/nosourcetarget_example.json                    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | nosourcetarget_example                    |             | response/PythonSparkLineage/MLP-11603_Lineage/nosourcetarget_example.json                    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                           |             | response/PythonSparkLineage/MLP-11603_Lineage/nosourcetarget_example.json                    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | RepartitionByRange                        |             | response/PythonSparkLineage/MLP-11603_Lineage/repartitionByRange_replace_example.json        |              |
      | APPDBPOSTGRES | FunctionID | Default |            | repartitionByRange_replace_example        |             | response/PythonSparkLineage/MLP-11603_Lineage/repartitionByRange_replace_example.json        |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                           |             | response/PythonSparkLineage/MLP-11603_Lineage/repartitionByRange_replace_example.json        | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | DropDuplicates_Dropna_OrderBy             |             | response/PythonSparkLineage/MLP-11603_Lineage/dropDuplicates_dropna_orderBy_repartition.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | dropDuplicates_dropna_orderBy_repartition |             | response/PythonSparkLineage/MLP-11603_Lineage/dropDuplicates_dropna_orderBy_repartition.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                           |             | response/PythonSparkLineage/MLP-11603_Lineage/dropDuplicates_dropna_orderBy_repartition.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | JoinExample                               |             | response/PythonSparkLineage/MLP-11603_Lineage/join_example.json                              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | join_example                              |             | response/PythonSparkLineage/MLP-11603_Lineage/join_example.json                              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                           |             | response/PythonSparkLineage/MLP-11603_Lineage/join_example.json                              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Alias_Distinct                            |             | response/PythonSparkLineage/MLP-11603_Lineage/alias_distnict_example.json                    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | alias_distnict_example                    |             | response/PythonSparkLineage/MLP-11603_Lineage/alias_distnict_example.json                    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                           |             | response/PythonSparkLineage/MLP-11603_Lineage/alias_distnict_example.json                    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | WithColumnRenamed                         |             | response/PythonSparkLineage/MLP-11603_Lineage/withColumnRenamed_example.json                 |              |
      | APPDBPOSTGRES | FunctionID | Default |            | withColumnRenamed_example                 |             | response/PythonSparkLineage/MLP-11603_Lineage/withColumnRenamed_example.json                 |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                           |             | response/PythonSparkLineage/MLP-11603_Lineage/withColumnRenamed_example.json                 | $.functionID |


  @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC#4-user retrieves the Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                                      | inputFile                                                                                    | outputFile                                                                                                  |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | select_drop_alias_example                 | response/PythonSparkLineage/MLP-11603_Lineage/select_drop_alias_example.json                 | response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/select_drop_alias_example.json                 |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | sort_sortwithpartition_example            | response/PythonSparkLineage/MLP-11603_Lineage/sort_sortwithpartition_example.json            | response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/sort_sortwithpartition_example.json            |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | nosourcetarget_example                    | response/PythonSparkLineage/MLP-11603_Lineage/nosourcetarget_example.json                    | response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/nosourcetarget_example.json                    |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | repartitionByRange_replace_example        | response/PythonSparkLineage/MLP-11603_Lineage/repartitionByRange_replace_example.json        | response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/repartitionByRange_replace_example.json        |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | dropDuplicates_dropna_orderBy_repartition | response/PythonSparkLineage/MLP-11603_Lineage/dropDuplicates_dropna_orderBy_repartition.json | response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/dropDuplicates_dropna_orderBy_repartition.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | sort_sortwithpartition_example            | response/PythonSparkLineage/MLP-11603_Lineage/sort_sortwithpartition_example.json            | response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/sort_sortwithpartition_example.json            |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | alias_distnict_example                    | response/PythonSparkLineage/MLP-11603_Lineage/alias_distnict_example.json                    | response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/alias_distnict_example.json                    |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | withColumnRenamed_example                 | response/PythonSparkLineage/MLP-11603_Lineage/withColumnRenamed_example.json                 | response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/withColumnRenamed_example.json                 |


  @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC#4-Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                                      | actual_json                                                                                                                   | item                                      |
      | \ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\ExpectedLineageTargets\select_drop_alias_example.json                 | Constant.REST_DIR/response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/select_drop_alias_example.json                 | select_drop_alias_example                 |
      | \ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\ExpectedLineageTargets\sort_sortwithpartition_example.json            | Constant.REST_DIR/response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/sort_sortwithpartition_example.json            | sort_sortwithpartition_example            |
      | ida/PythonSparkPayloads/MLP-11603/MLP-11603_LineagePayloads/ExpectedLineageTargets/nosourcetarget_example.json                     | Constant.REST_DIR/response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/nosourcetarget_example.json                    | nosourcetarget_example                    |
      | \ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\ExpectedLineageTargets\repartitionByRange_replace_example.json        | Constant.REST_DIR/response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/repartitionByRange_replace_example.json        | repartitionByRange_replace_example        |
      | \ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\ExpectedLineageTargets\dropDuplicates_dropna_orderBy_repartition.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/dropDuplicates_dropna_orderBy_repartition.json | dropDuplicates_dropna_orderBy_repartition |
      | ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\ExpectedLineageTargets\sort_sortwithpartition_example.json             | Constant.REST_DIR/response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/sort_sortwithpartition_example.json            | sort_sortwithpartition_example            |
      | \ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\ExpectedLineageTargets\alias_distnict_example.json                    | Constant.REST_DIR/response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/alias_distnict_example.json                    | alias_distnict_example                    |
      | \ida\PythonSparkPayloads\MLP-11603\MLP-11603_LineagePayloads\ExpectedLineageTargets\withColumnRenamed_example.json                 | Constant.REST_DIR/response/PythonSparkLineage/MLP-11603_Lineage/LineageTargets/withColumnRenamed_example.json                 | withColumnRenamed_example                 |


#############################################################################################################################################################################
####################Deleting the plugins configurations data's from UI
####################################################################################################################################################################
###


  @MLP-10467 @sanity @positive
  Scenario: SC#5-Delete the cluster , projects
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector_SparkAnlayzerImprovements/% | Analysis |       |       |
      | SingleItemDelete | Default | parser/PythonParser/PythonParser_Spark%                         | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger_Spark%            | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/PythonSparkLineage_Oracle%           | Analysis |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                                              | Project  |       |       |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                 | Cluster  |       |       |


  @MLP-7854 @sanity @positive
  Scenario Outline: SC05-Delete catalog and Plugin configurations for Git , Python Parser , Package Linker and Python Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                    | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollector_SparkAnlayzerImprovements |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser/PythonParser_Spark                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBCataloger/OracleDBCataloger_Spark           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSparkLineage/PythonSparkLineage_Oracle        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/sparkGit                                          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBDataSource                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/sparkOracle                                       |      | 200           |                  |          |

