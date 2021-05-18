@9174
Feature: Feature to validate the lineage created via python spark lineage plugin is correct

    ################################################################################################################################################################################
#  -----------------------Oracle file placing and Spark run-------------------------#

  @MLP-9174 @sanity @hdfs @regression @positive
  Scenario: SC#1-Copy the file from local to the user path
    Given user connects to the SFTP server for below parameters
      | sftpAction  | remoteDir                        |
      | copytoLocal | ida/PythonSparkPayloads/MLP-9174 |


  @MLP-9174 @sanity @positive @regression
  Scenario: SC#2-Run the spark commands in local machine
    And user connects to cmdprompt and runs spark commands in local
      | command      | Filename                                   |
      | Spark2_Local | aliasanddistinct.py                        |
      | Spark2_Local | discribe_samlple_summary_fillna.py         |
      | Spark2_Local | dropduplicate_orderby_drpna_repartition.py |
      | Spark2_Local | dropduplicatesandalias.py                  |
      | Spark2_Local | func_call_as_argument.py                   |
      | Spark2_Local | repartition_replace_sort_sortwith.py       |
      | Spark2_Local | with_column.py                             |
      | Spark2_Local | columnrenamed.py                           |

  @MLP-9174 @sanity @positive @regression
  Scenario: SC#3-Check if the tables are available in ORACLE DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage    | queryField                   |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | UPPERSALARYPEOPLES           |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | TABLES_SUMMARY_DESCRIBE_SAMP |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | DROP_ORDERBY                 |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | UPPERSALARYPEOPLES_DROP      |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | EMPLOYEEUNION1               |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | LASTPARTITION                |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | TABLEPHONEADDED              |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | TABLEPHONEADDEDINCHAIN       |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | TABLEADDEDALONGWITHNAME      |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | EMP_RENAMED                  |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | EMP_RENAMEDSECONDLINE        |
      | oracle12c          | EXECUTEQUERY | json/IDA.json | SparkLineage | EMP_RENAMEDWITHSELECT        |


#    ################################################################################################################################################################################
##  --------------------PLUGIN CONFIGURATIONS----------------------------#
#
  @MLP-9174 @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#4-Precondition:Run the Plugin configurations for Git , Python Parser , Package Linker and Python Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                                      | response code | response message               | jsonPath                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/sparkGit                                                               | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/GitCredentials.json                        | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                   | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/gitDatasourceConfig.json                   | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                             | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/Git_Pyspark.json                           | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                             |                                                                                           | 200           | GitCollector_TransformationAPI |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_TransformationAPI |                                                                                           | 200           | IDLE                           | $.[?(@.configurationName=='GitCollector_TransformationAPI')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_TransformationAPI  | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/Git_Pyspark_empty.json                     | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_TransformationAPI |                                                                                           | 200           | IDLE                           | $.[?(@.configurationName=='GitCollector_TransformationAPI')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/sparkOracle                                                            | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/OracleDBCredentials.json                   | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                                       | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/OracleDBDataSource.json                    | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                        | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/oracleCatalogerConfig_for_PythonSpark.json | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                                        |                                                                                           | 200           | OracleDBCataloger_Spark        |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark   |                                                                                           | 200           | IDLE                           | $.[?(@.configurationName=='OracleDBCataloger_Spark')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark    | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/Oracle_Pyspark_empty.json                  | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger_Spark   |                                                                                           | 200           | IDLE                           | $.[?(@.configurationName=='OracleDBCataloger_Spark')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonParser                                                             | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/Parser_Pyspark.json                        | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonParser                                                             |                                                                                           | 200           | PythonParser_Spark             |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Spark                |                                                                                           | 200           | IDLE                           | $.[?(@.configurationName=='PythonParser_Spark')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_Spark                 | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/Parser_Pyspark_empty.json                  | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Spark                |                                                                                           | 200           | IDLE                           | $.[?(@.configurationName=='PythonParser_Spark')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonSparkLineage                                                       | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/Py_Spark_Pyspark.json                      | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonSparkLineage                                                       |                                                                                           | 200           | PythonSparkLineage_Oracle      |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle        |                                                                                           | 200           | IDLE                           | $.[?(@.configurationName=='PythonSparkLineage_Oracle')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle         | ida/PythonSparkPayloads/MLP-9174_PluginsConfig/Py_Spark_Pyspark_empty.json                | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/PythonSparkLineage_Oracle        |                                                                                           | 200           | IDLE                           | $.[?(@.configurationName=='PythonSparkLineage_Oracle')].status      |

################################################################################################################################################################################
#  ----------------------Tag Validation--------------------------#
###Bug-ID-21772
  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC#5-Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TransformationAPI" and clicks on search
    And user performs "facet selection" in "TransformationAPI" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                                | fileName            | userTag           |
      | Default     | File     | Metadata Type | Git,TransformationAPI,Python,Spark | aliasanddistinct.py | TransformationAPI |
      | Default     | Table    | Metadata Type | Oracle,TransformationAPI           | TESTTABLE2          | TransformationAPI |
      | Default     | Class    | Metadata Type | Python,TransformationAPI           | aliasanddistinct    | TransformationAPI |
      | Default     | Function | Metadata Type | Python,Spark,TransformationAPI     | alias_distinct      | TransformationAPI |
      | Default     | Project  | Metadata Type | Git,TransformationAPI              | pythonanalyzerdemo  | TransformationAPI |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName         | userTag           |
      | Default     | Class      | Metadata Type | Programming | aliasanddistinct | TransformationAPI |
      | Default     | Function   | Metadata Type | Programming | alias_distinct   | TransformationAPI |
      | Default     | SourceTree | Metadata Type | Programming | aliasanddistinct | TransformationAPI |
    And user enters the search text "TransformationAPI" and clicks on search
    And user performs "facet selection" in "TransformationAPI" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "alias_distinct" item from search results
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | TransformationAPI,Python,Spark |
      | item | alias_distinct                 |
    Then user performs click and verify in new window
      | Table        | value                                                    | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | EMPLOYEE_DETAILS.COMMISSION_PCT => jdbcDF.COMMISSION_PCT | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | SnowFlake_Spark,Python,Spark                             |
      | item | EMPLOYEE_DETAILS.COMMISSION_PCT => jdbcDF.COMMISSION_PCT |


    ################################################################################################################################################################################
#  ----------------------Source tree validation--------------------------#

  @webtest @MLP-8130 @sanity @positive @regression
  Scenario: SC#6-Check if the count from the collector plugin and SourceTree count matches
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TransformationAPI" and clicks on search
    And user performs "facet selection" in "TransformationAPI" attribute under "Tags" facets in Item Search results page
    And user selects the "SourceTree" from the Type
    And verify the count of search list and the Expected count "8" matches


       ################################################################################################################################################################################
#  ----------------------Lineage Hops validation--------------------------#

   #Testcase id - #6528386,6528387,6528384,6528284,6528283,6528285,6528282,6528383,6528388,6528385,6528286,6528287
  @webtest @MLP-9174 @sanity @positive @regression
  Scenario: SC#7-Verify Lineage Hops in UI for alias_distinct function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TransformationAPI" and clicks on search
    And user performs "facet selection" in "TransformationAPI" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "alias_distinct" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                    | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                      | jsonPath         |
      | Lineage Hops | EMPLOYEE_DETAILS.EMPLOYEE_ID => jdbcDF.EMPLOYEE_ID       | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.EMPLOYEE_ID    |
      | Lineage Hops | EMPLOYEE_DETAILS.FIRST_NAME => jdbcDF.FIRST_NAME         | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.FIRST_NAME     |
      | Lineage Hops | EMPLOYEE_DETAILS.LAST_NAME => jdbcDF.LAST_NAME           | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.LAST_NAME      |
      | Lineage Hops | EMPLOYEE_DETAILS.EMAIL => jdbcDF.EMAIL                   | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.EMAIL          |
      | Lineage Hops | EMPLOYEE_DETAILS.PHONE_NUMBER => jdbcDF.PHONE_NUMBER     | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.PHONE_NUMBER   |
      | Lineage Hops | EMPLOYEE_DETAILS.HIRE_DATE => jdbcDF.HIRE_DATE           | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.HIRE_DATE      |
      | Lineage Hops | EMPLOYEE_DETAILS.JOB_ID => jdbcDF.JOB_ID                 | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.JOB_ID         |
      | Lineage Hops | EMPLOYEE_DETAILS.SALARY => jdbcDF.SALARY                 | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.SALARY         |
      | Lineage Hops | EMPLOYEE_DETAILS.COMMISSION_PCT => jdbcDF.COMMISSION_PCT | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.COMMISSION_PCT |
      | Lineage Hops | EMPLOYEE_DETAILS.MANAGER_ID => jdbcDF.MANAGER_ID         | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.MANAGER_ID     |
      | Lineage Hops | EMPLOYEE_DETAILS.DEPARTMENT_ID => jdbcDF.DEPARTMENT_ID   | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.DEPARTMENT_ID  |
      | Lineage Hops | EMPLOYEE_DETAILS.GENDER => jdbcDF.GENDER                 | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.GENDER         |
      | Lineage Hops | EMPLOYEE_DETAILS.SSN => jdbcDF.SSN                       | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.SSN            |
      | Lineage Hops | jdbcDF.EMPLOYEE_ID => df2_forSelect.EMPLOYEE_ID          | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.EMPLOYEE_ID    |
      | Lineage Hops | jdbcDF.FIRST_NAME => df2_forSelect.FIRST_NAME            | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.FIRST_NAME     |
      | Lineage Hops | jdbcDF.LAST_NAME => df2_forSelect.LAST_NAME              | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.LAST_NAME      |
      | Lineage Hops | jdbcDF.EMAIL => df2_forSelect.EMAIL                      | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.EMAIL          |
      | Lineage Hops | jdbcDF.PHONE_NUMBER => df2_forSelect.PHONE_NUMBER        | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.PHONE_NUMBER   |
      | Lineage Hops | jdbcDF.HIRE_DATE => df2_forSelect.HIRE_DATE              | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.HIRE_DATE      |
      | Lineage Hops | jdbcDF.JOB_ID => df2_forSelect.JOB_ID                    | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.JOB_ID         |
      | Lineage Hops | jdbcDF.SALARY => df2_forSelect.SALARY                    | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.SALARY         |
      | Lineage Hops | jdbcDF.COMMISSION_PCT => df2_forSelect.COMMISSION_PCT    | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.COMMISSION_PCT |
      | Lineage Hops | jdbcDF.MANAGER_ID => df2_forSelect.MANAGER_ID            | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.MANAGER_ID     |
      | Lineage Hops | jdbcDF.DEPARTMENT_ID => df2_forSelect.DEPARTMENT_ID      | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.DEPARTMENT_ID  |
      | Lineage Hops | jdbcDF.GENDER => df2_forSelect.GENDER                    | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.GENDER         |
      | Lineage Hops | jdbcDF.SSN => df2_forSelect.SSN                          | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.SSN            |
      | Lineage Hops | df2_forSelect.JOB_ID => df3.JOB_ID                       | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.JOB_ID         |
      | Lineage Hops | JOB_ID => UPPERSALARYPEOPLES.JOB_ID                      | click and verify lineagehops | Yes              | 0           | ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\alias_distinct.json | $.JOB_ID         |


#
#    ################################################################################################################################################################################
##  ----------------------Lineage Source and Targets validation--------------------------#
#
  @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC#8-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                                               | asg_scopeid | targetFile                                                                                           | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | aliasanddistinct                                   |             | response/PythonSparkLineage/MLP-9174_Lineage/alias_distinct.json                                     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | alias_distinct                                     |             | response/PythonSparkLineage/MLP-9174_Lineage/alias_distinct.json                                     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/alias_distinct.json                                     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | discribe_samlple_summary_fillna                    |             | response/PythonSparkLineage/MLP-9174_Lineage/summary_limit_describe_sample_fillna.json               |              |
      | APPDBPOSTGRES | FunctionID | Default |            | summary_limit_describe_sample_fillna               |             | response/PythonSparkLineage/MLP-9174_Lineage/summary_limit_describe_sample_fillna.json               |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/summary_limit_describe_sample_fillna.json               | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | dropduplicate_orderby_drpna_repartition            |             | response/PythonSparkLineage/MLP-9174_Lineage/drop_duplicates_dropna_orderBy_repartition.json         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | drop_duplicates_dropna_orderBy_repartition         |             | response/PythonSparkLineage/MLP-9174_Lineage/drop_duplicates_dropna_orderBy_repartition.json         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/drop_duplicates_dropna_orderBy_repartition.json         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | dropduplicatesandalias                             |             | response/PythonSparkLineage/MLP-9174_Lineage/dropDuplicates_select.json                              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | dropDuplicates_select                              |             | response/PythonSparkLineage/MLP-9174_Lineage/dropDuplicates_select.json                              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/dropDuplicates_select.json                              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | func_call_as_argument                              |             | response/PythonSparkLineage/MLP-9174_Lineage/fun_call_arg.json                                       |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fun_call_arg                                       |             | response/PythonSparkLineage/MLP-9174_Lineage/fun_call_arg.json                                       |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/fun_call_arg.json                                       | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | repartition_replace_sort_sortwith                  |             | response/PythonSparkLineage/MLP-9174_Lineage/repartitionByrange_replace_sort_sortwithpartitions.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | repartitionByrange_replace_sort_sortwithpartitions |             | response/PythonSparkLineage/MLP-9174_Lineage/repartitionByrange_replace_sort_sortwithpartitions.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/repartitionByrange_replace_sort_sortwithpartitions.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | with_column                                        |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnfront.json                                    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | withColumnfront                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnfront.json                                    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnfront.json                                    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | with_column                                        |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnback.json                                     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | withColumnback                                     |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnback.json                                     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnback.json                                     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | with_column                                        |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnselect.json                                   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | withColumnselect                                   |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnselect.json                                   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/withColumnselect.json                                   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | columnrenamed                                      |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedfront.json                                 |              |
      | APPDBPOSTGRES | FunctionID | Default |            | columnrenamedfront                                 |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedfront.json                                 |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedfront.json                                 | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | columnrenamed                                      |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedback.json                                  |              |
      | APPDBPOSTGRES | FunctionID | Default |            | columnrenamedback                                  |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedback.json                                  |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedback.json                                  | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | columnrenamed                                      |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedselect.json                                |              |
      | APPDBPOSTGRES | FunctionID | Default |            | columnrenamedselect                                |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedselect.json                                |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                                    |             | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedselect.json                                | $.functionID |


  @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC#8-user retrieves the Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                                               | inputFile                                                                                            | outputFile                                                                                                          |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | alias_distinct                                     | response/PythonSparkLineage/MLP-9174_Lineage/alias_distinct.json                                     | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/alias_distinct.json                                     |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | summary_limit_describe_sample_fillna               | response/PythonSparkLineage/MLP-9174_Lineage/summary_limit_describe_sample_fillna.json               | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/summary_limit_describe_sample_fillna.json               |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | drop_duplicates_dropna_orderBy_repartition         | response/PythonSparkLineage/MLP-9174_Lineage/drop_duplicates_dropna_orderBy_repartition.json         | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/drop_duplicates_dropna_orderBy_repartition.json         |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | dropDuplicates_select                              | response/PythonSparkLineage/MLP-9174_Lineage/dropDuplicates_select.json                              | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/dropDuplicates_select.json                              |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | fun_call_arg                                       | response/PythonSparkLineage/MLP-9174_Lineage/fun_call_arg.json                                       | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/fun_call_arg.json                                       |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | repartitionByrange_replace_sort_sortwithpartitions | response/PythonSparkLineage/MLP-9174_Lineage/repartitionByrange_replace_sort_sortwithpartitions.json | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/repartitionByrange_replace_sort_sortwithpartitions.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | withColumnfront                                    | response/PythonSparkLineage/MLP-9174_Lineage/withColumnfront.json                                    | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/withColumnfront.json                                    |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | withColumnback                                     | response/PythonSparkLineage/MLP-9174_Lineage/withColumnback.json                                     | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/withColumnback.json                                     |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | withColumnselect                                   | response/PythonSparkLineage/MLP-9174_Lineage/withColumnselect.json                                   | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/withColumnselect.json                                   |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | columnrenamedfront                                 | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedfront.json                                 | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/columnrenamedfront.json                                 |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | columnrenamedback                                  | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedback.json                                  | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/columnrenamedback.json                                  |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | columnrenamedselect                                | response/PythonSparkLineage/MLP-9174_Lineage/columnrenamedselect.json                                | response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/columnrenamedselect.json                                |


  @MLP-8130 @sanity @positive @regression
  Scenario Outline: SC#8-Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                                             | actual_json                                                                                                                           | item                                               |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\alias_distinct.json                                     | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/alias_distinct.json                                     | alias_distinct                                     |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\summary_limit_describe_sample_fillna.json               | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/summary_limit_describe_sample_fillna.json               | summary_limit_describe_sample_fillna               |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\drop_duplicates_dropna_orderBy_repartition.json         | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/drop_duplicates_dropna_orderBy_repartition.json         | drop_duplicates_dropna_orderBy_repartition         |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\dropDuplicates_select.json                              | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/dropDuplicates_select.json                              | dropDuplicates_select                              |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\fun_call_arg.json                                       | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/fun_call_arg.json                                       | fun_call_arg                                       |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\repartitionByrange_replace_sort_sortwithpartitions.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/repartitionByrange_replace_sort_sortwithpartitions.json | repartitionByrange_replace_sort_sortwithpartitions |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\withColumnfront.json                                    | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/withColumnfront.json                                    | withColumnfront                                    |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\withColumnback.json                                     | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/withColumnback.json                                     | withColumnback                                     |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\withColumnselect.json                                   | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/withColumnselect.json                                   | withColumnselect                                   |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\columnrenamedfront.json                                 | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/columnrenamedfront.json                                 | columnrenamedfront                                 |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\columnrenamedback.json                                  | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/columnrenamedback.json                                  | columnrenamedback                                  |
      | \ida\PythonSparkPayloads\MLP-9174\MLP-9174_LineagePayloads\ExpectedLineageTargets\columnrenamedselect.json                                | Constant.REST_DIR/response/PythonSparkLineage/MLP-9174_Lineage/LineageTargets/columnrenamedselect.json                                | columnrenamedselect                                |


#############################################################################################################################################################################
####################Deleting the plugins configurations data's from UI
####################################################################################################################################################################
###

  @MLP-10467 @sanity @positive
  Scenario: SC#9-Delete the cluster , projects
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector_TransformationAPI/% | Analysis |       |       |
      | SingleItemDelete | Default | parser/PythonParser/PythonParser_Spark%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger_Spark%    | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/PythonSparkLineage_Oracle%   | Analysis |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                                      | Project  |       |       |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                         | Cluster  |       |       |


  Scenario Outline: SC#10-Delete catalog and Plugin configurations for Git , Python Parser , Oracle and Python Spark
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollector_TransformationAPI  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser/PythonParser_Spark              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBCataloger/OracleDBCataloger_Spark    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSparkLineage/PythonSparkLineage_Oracle |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/sparkGit                                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBDataSource                           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/sparkOracle                                |      | 200           |                  |          |


#############################################################################################################################################################################
####################Deleting tables and Delete dir
####################################################################################################################################################################
###


  @jdbc
  Scenario: SC#11-Drop  Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema    | Table                   | Database |
      | oracle12c          | DROP      | COLLECTOR | EMP_RENAMED             | col2     |
      | oracle12c          | DROP      | COLLECTOR | EMP_RENAMEDSECONDLINE   | col2     |
      | oracle12c          | DROP      | COLLECTOR | EMP_RENAMEDWITHSELECT   | col2     |
      | oracle12c          | DROP      | COLLECTOR | TABLEPHONEADDED         | col2     |
      | oracle12c          | DROP      | COLLECTOR | TABLEPHONEADDEDINCHAIN  | col2     |
      | oracle12c          | DROP      | COLLECTOR | TABLEADDEDALONGWITHNAME | col2     |
      | oracle12c          | DROP      | COLLECTOR | EMPLOYEEUNION1          | col2     |
      | oracle12c          | DROP      | COLLECTOR | UPPERSALARYPEOPLES      | col2     |
      | oracle12c          | DROP      | COLLECTOR | UPPERSALARYPEOPLES_DROP | col2     |
      | oracle12c          | DROP      | COLLECTOR | DROP_ORDERBY            | col2     |
      | oracle12c          | DROP      | COLLECTOR | LASTPARTITION           | col2     |


  Scenario: SC#12-Deleting the entire folder
    Given user connects to the SFTP server for below parameters
      | sftpAction | remoteDir |
      | deleteDir  |           |
