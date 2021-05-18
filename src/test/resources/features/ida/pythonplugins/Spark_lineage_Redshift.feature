@7855
Feature: Feature to validate the lineage created via python spark lineage plugin is correct

#THIS FEATURE CAN BE RUN ONLY IN LOCAL MACHINE NOT IN JENKINS, PRE-CONDITION PLACE "PSEXEC.EXE" FILE IN YOUR SYSTEM32 FOLDER###

  @MLP-7855 @sanity @hdfs @regression @positive
  Scenario:SC#1_Copy the file from local to the Redshift remote path
    Given user connects to the SFTP server for below parameters
      | sftpAction   | remoteDir                                                          | localDir                          |
      | copytoremote | \\\\dechewindock01v\\Users\\Siddharthan.G\\Documents\\SparkFolder\ | ida/PythonSparkPayloads/MLP-7855/ |

  @MLP-7855 @sanity @positive @regression
  Scenario: SC#2_Moving the file from local to the folder in Ambari
    And user connects to the sftp server or local Machine and runs commands
      | command       | RemoteMachineName   | RemoteMachinePath                                | Filename                               | Env   |
      | Spark2_Remote | \\\\dechewindock01v | C:\\Users\\Siddharthan.G\\Documents\\SparkFolder | redshift_jdbc.py                       | Local |
      | Spark2_Remote | \\\\dechewindock01v | C:\\Users\\Siddharthan.G\\Documents\\SparkFolder | Redshift_jdbc_df_multiple_write.py     | Local |
      | Spark2_Remote | \\\\dechewindock01v | C:\\Users\\Siddharthan.G\\Documents\\SparkFolder | redshifttoredshift.py                  | Local |
      | Spark2_Remote | \\\\dechewindock01v | C:\\Users\\Siddharthan.G\\Documents\\SparkFolder | redshifttoredshift_jdbc_select.py      | Local |
      | Spark2_Remote | \\\\dechewindock01v | C:\\Users\\Siddharthan.G\\Documents\\SparkFolder | redshifttoredshift_overwrite.py        | Local |
      | Spark2_Remote | \\\\dechewindock01v | C:\\Users\\Siddharthan.G\\Documents\\SparkFolder | redshifttoredshift_overwrite_select.py | Local |

  @MLP-7855 @sanity @positive @regression
  Scenario:SC#3 Add valid Credentials for Git and Amazon3 plugins
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                                                   | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/credentials/GitSparkCredentials  | ida/PythonSparkPayloads/MLP-7855_PluginConfig/GitSparkCredentials.json | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/GitSparkCredentials  |                                                                        | 200           |                  |          |
      |                  |       |       | Put  | settings/credentials/Redshift_Credentials | ida/PythonSparkPayloads/MLP-7855_PluginConfig/CredentialsSuccess.json  | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/Redshift_Credentials |                                                                        | 200           |                  |          |


  @MLP-7855 @sanity @positive @regression
  Scenario Outline: SC#4_Run the Plugin configurations for Git , Python Parser , AzureSQL DB Cataloger and Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | body                                                                             | response code | response message            | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                  | ida/PythonSparkPayloads/MLP-7855_PluginConfig/GitSparkDataSource.json            | 204           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                  |                                                                                  | 200           | GitSpark_RedshiftDataSource |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                            | ida/PythonSparkPayloads/MLP-7855_PluginConfig/Git_Pyspark.json                   | 204           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                            |                                                                                  | 200           | GitCollector_RedshiftSpark  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/*             |                                                                                  | 200           | IDLE                        | $.[?(@.configurationName=='GitCollector_RedshiftSpark')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/*              | ida/PythonSparkPayloads/MLP-7855_PluginConfig/Git_Pyspark_empty.json             | 200           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/*             |                                                                                  | 200           | IDLE                        | $.[?(@.configurationName=='GitCollector_RedshiftSpark')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                | ida/PythonSparkPayloads/MLP-7855_PluginConfig/AmazonRedshiftDataSource.json      | 204           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                |                                                                                  | 200           | RedshiftDataSource          |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                 | ida/PythonSparkPayloads/MLP-7855_PluginConfig/AmazonRedshiftCataloger.json       | 204           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                 |                                                                                  | 200           | AmazonRedshiftCataloger     |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/* |                                                                                  | 200           | IDLE                        | $.[?(@.configurationName=='AmazonRedshiftCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/*  | ida/PythonSparkPayloads/MLP-7855_PluginConfig/AmazonRedshiftCataloger_empty.json | 200           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/* |                                                                                  | 200           | IDLE                        | $.[?(@.configurationName=='AmazonRedshiftCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonParser                                            | ida/PythonSparkPayloads/MLP-7855_PluginConfig/Parser_Pyspark.json                | 204           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonParser                                            |                                                                                  | 200           | PythonParser                |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/*                |                                                                                  | 200           | IDLE                        | $.[?(@.configurationName=='PythonParser')].status               |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/*                 | ida/PythonSparkPayloads/MLP-7855_PluginConfig/Parser_Pyspark_empty.json          | 200           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/*                |                                                                                  | 200           | IDLE                        | $.[?(@.configurationName=='PythonParser')].status               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonSparkLineage                                      | ida/PythonSparkPayloads/MLP-7855_PluginConfig/Py_Spark_Pyspark.json              | 204           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonSparkLineage                                      |                                                                                  | 200           | SparkLineage                |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/*         |                                                                                  | 200           | IDLE                        | $.[?(@.configurationName=='SparkLineage')].status               |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/*          | ida/PythonSparkPayloads/MLP-7855_PluginConfig/Py_Spark_Pyspark_empty.json        | 200           |                             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/*         |                                                                                  | 200           | IDLE                        | $.[?(@.configurationName=='SparkLineage')].status               |

################################################################################################################################################################################
#  ----------------------UI VALIDATIONS--------------------------#

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario: SC#5_Check if the count from the collector plugin and SourceTree count matches
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user selects the "SourceTree" from the Type
    And user get the count of the search list
    And verify the count of search list and the Expected count "6" matches

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario: SC#6_Verify the technology tags got assigned to all Cataloged items like Function, DF tables and Lineage HOPS
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                                         | fileName                          | userTag                    |
      | Default     | File     | Metadata Type | Git,RedshiftPythonSparkLineage,Python,Spark | redshifttoredshift_jdbc_select.py | RedshiftPythonSparkLineage |
      | Default     | Table    | Metadata Type | Redshift,RedshiftPythonSparkLineage         | employee_underage                 | RedshiftPythonSparkLineage |
      | Default     | Class    | Metadata Type | Python,RedshiftPythonSparkLineage           | Redshift_jdbc_df_multiple_write   | RedshiftPythonSparkLineage |
      | Default     | Function | Metadata Type | Python,Spark,RedshiftPythonSparkLineage     | jdbc_dataset_example              | RedshiftPythonSparkLineage |
      | Default     | Project  | Metadata Type | Git,RedshiftPythonSparkLineage              | pythonanalyzerdemo                | RedshiftPythonSparkLineage |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName                        | userTag                    |
      | Default     | Class      | Metadata Type | Programming | Redshift_jdbc_df_multiple_write | RedshiftPythonSparkLineage |
      | Default     | Function   | Metadata Type | Programming | jdbc_dataset_example            | RedshiftPythonSparkLineage |
      | Default     | SourceTree | Metadata Type | Programming | redshifttoredshift_jdbc_select  | RedshiftPythonSparkLineage |
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_dataset_example" item from search results
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | RedshiftPythonSparkLineage,Python,Spark |
      | item | jdbc_dataset_example                    |
    Then user performs click and verify in new window
      | Table        | value                        | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | address => employee1.address | click and switch tab | No               |             |
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | RedshiftPythonSparkLineage,Python,Spark |
      | item | address => employee1.address            |


#6496385,6496381,6496384, #6496382,6496383,6496380, #6496379,6496378,6496376, #6496375,6496377
  @webtest @MLP-7855 @sanity @positive @regression
  Scenario: SC7_Verify Lineage Hops in UI for jdbc_dataset_redshift_example function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_dataset_redshift_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                         | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                            | jsonPath             |
      | Lineage Hops | name => users_created.name    | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_redshift_example.json | $.users_created_name |
      | Lineage Hops | users.email => jdbcDF.email   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_redshift_example.json | $.email              |
      | Lineage Hops | users.gender => jdbcDF.gender | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_redshift_example.json | $.gender             |
      | Lineage Hops | users.id => jdbcDF.id         | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_redshift_example.json | $.id                 |
      | Lineage Hops | users.name => jdbcDF.name     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_redshift_example.json | $.name               |

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario: SC8_Verify Lineage Hops in UI for jdbc_redshift_example function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_redshift_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                         | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                    | jsonPath               |
      | Lineage Hops | city.countrycode => oracleDF.countrycode      | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example.json | $.oracleDF_countrycode |
      | Lineage Hops | city.district => oracleDF.district            | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example.json | $.oracleDF_district    |
      | Lineage Hops | city.id => oracleDF.id                        | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example.json | $.oracleDF_id          |
      | Lineage Hops | city.name => oracleDF.name                    | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example.json | $.oracleDF_name        |
      | Lineage Hops | city.population => oracleDF.population        | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example.json | $.oracleDF_population  |
      | Lineage Hops | countrycode => citywithtwocolumns.countrycode | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example.json | $.countrycode1         |
      | Lineage Hops | name => citywithtwocolumns.name               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example.json | $.name1                |

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario: SC9_Verify Lineage Hops in UI for jdbc_redshift_example1 function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_redshift_example1" item from search results
    Then user performs click and verify in new window
      | Table        | value                                    | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                     | jsonPath    |
      | Lineage Hops | catdesc => category_twocolumns.catdesc   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example1.json | $.catdesc   |
      | Lineage Hops | category.catdesc => jdbcDF.catdesc       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example1.json | $.catdesc1  |
      | Lineage Hops | category.catgroup => jdbcDF.catgroup     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example1.json | $.catgroup  |
      | Lineage Hops | category.catid => jdbcDF.catid           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example1.json | $.catid     |
      | Lineage Hops | category.catname => jdbcDF.catname       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example1.json | $.catname   |
      | Lineage Hops | catgroup => category_twocolumns.catgroup | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example1.json | $.catgroup1 |
      | Lineage Hops | catid => category_twocolumns.catid       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example1.json | $.catid1    |
      | Lineage Hops | catname => category_twocolumns.catname   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_redshift_example1.json | $.catname1  |

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario: SC10_Verify Lineage Hops in UI for jdbc_dataset_example function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_dataset_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                              | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                   | jsonPath   |
      | Lineage Hops | address => employee1.address       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example.json | $.address  |
      | Lineage Hops | empid => employee1.empid           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example.json | $.empid    |
      | Lineage Hops | employee.address => jdbcDF.address | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example.json | $.address1 |
      | Lineage Hops | employee.empid => jdbcDF.empid     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example.json | $.empid1   |
      | Lineage Hops | employee.ename => jdbcDF.ename     | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example.json | $.ename    |
      | Lineage Hops | ename => employee1.ename           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example.json | $.ename1   |

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario: SC11_Verify Lineage Hops in UI for jdbc_dataset_example1 function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "jdbc_dataset_example1" item from search results
    Then user performs click and verify in new window
      | Table        | value                                 | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                    | jsonPath       |
      | Lineage Hops | address => employee_underage.address  | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.address      |
      | Lineage Hops | email => users_onlytwocolumns.email   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.email        |
      | Lineage Hops | empid => employee_underage.empid      | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.empid        |
      | Lineage Hops | employee.address => jdbcDF1.address   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.emp_ad       |
      | Lineage Hops | employee.empid => jdbcDF1.empid       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.emp_id       |
      | Lineage Hops | employee.ename => jdbcDF1.ename       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.emp_name     |
      | Lineage Hops | ename => employee_underage.ename      | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.ename        |
      | Lineage Hops | gender => users_onlytwocolumns.gender | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.gender       |
      | Lineage Hops | name => users_created.name            | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.name         |
      | Lineage Hops | users.email => jdbcDF.email           | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.users_email  |
      | Lineage Hops | users.gender => jdbcDF.gender         | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.users_gender |
      | Lineage Hops | users.id => jdbcDF.id                 | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.users_id     |
      | Lineage Hops | users.name => jdbcDF.name             | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/jdbc_dataset_example1.json | $.users_name   |

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario: SC12_Verify Lineage Hops in UI for redshift_example function
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftPythonSparkLineage" and clicks on search
    And user performs "facet selection" in "RedshiftPythonSparkLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "redshift_example" item from search results
    Then user performs click and verify in new window
      | Table        | value                                   | Action                       | RetainPrevwindow | indexSwitch | filePath                                                               | jsonPath         |
      | Lineage Hops | city.countrycode => df.countrycode      | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.df_countrycode |
      | Lineage Hops | city.district => df.district            | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.df_district    |
      | Lineage Hops | city.id => df.id                        | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.df_id          |
      | Lineage Hops | city.name => df.name                    | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.df_name        |
      | Lineage Hops | city.population => df.population        | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.df_population  |
      | Lineage Hops | countrycode => city_created.countrycode | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.countrycode    |
      | Lineage Hops | district => city_created.district       | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.district       |
      | Lineage Hops | id => city_created.id                   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.id             |
      | Lineage Hops | name => city_created.name               | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.name           |
      | Lineage Hops | population => city_created.population   | click and verify lineagehops | Yes              | 0           | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/redshift_example.json | $.population     |

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario Outline:SC13-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                                | asg_scopeid | targetFile                                                                      | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | redshifttoredshift_overwrite_select |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_redshift_example.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_dataset_redshift_example       |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_redshift_example.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                     |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_redshift_example.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | Redshift_jdbc_df_multiple_write     |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_example1.json         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_dataset_example1               |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_example1.json         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                     |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_example1.json         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | redshifttoredshift_jdbc_select      |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_redshift_example.json         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_redshift_example               |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_redshift_example.json         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                     |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_redshift_example.json         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | redshift_jdbc                       |             | response/PythonSparkLineage/MLP-7855_Lineage/redshift_example.json              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | redshift_example                    |             | response/PythonSparkLineage/MLP-7855_Lineage/redshift_example.json              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                     |             | response/PythonSparkLineage/MLP-7855_Lineage/redshift_example.json              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | redshifttoredshift_overwrite        |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_redshift_example1.json        |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_redshift_example1              |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_redshift_example1.json        |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                     |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_redshift_example1.json        | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | redshifttoredshift                  |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_example.json          |              |
      | APPDBPOSTGRES | FunctionID | Default |            | jdbc_dataset_example                |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_example.json          |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                     |             | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_example.json          | $.functionID |

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario Outline: SC14-user retrieves the Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                                | inputFile                                                                       | outputFile                                                                                            |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | redshifttoredshift_overwrite_select | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_redshift_example.json | response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_dataset_redshift_example_Target.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Redshift_jdbc_df_multiple_write     | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_example1.json         | response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_dataset_example1_Target.json         |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | redshifttoredshift_jdbc_select      | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_redshift_example.json         | response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_redshift_example_Target.json         |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | redshift_jdbc                       | response/PythonSparkLineage/MLP-7855_Lineage/redshift_example.json              | response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/redshift_example_Target.json              |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | redshifttoredshift_overwrite        | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_redshift_example1.json        | response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_redshift_example1_Target.json        |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | redshifttoredshift                  | response/PythonSparkLineage/MLP-7855_Lineage/jdbc_dataset_example.json          | response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_dataset_example_Target.json          |

  @webtest @MLP-7855 @sanity @positive @regression
  Scenario Outline: SC15-Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                     | actual_json                                                                                                             | item                                |
      | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/ExpectedLineageTargets/jdbc_dataset_redshift_example_Target.json | Constant.REST_DIR/response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_dataset_redshift_example_Target.json | redshifttoredshift_overwrite_select |
      | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/ExpectedLineageTargets/jdbc_dataset_example1_Target.json         | Constant.REST_DIR/response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_dataset_example1_Target.json         | Redshift_jdbc_df_multiple_write     |
      | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/ExpectedLineageTargets/jdbc_redshift_example_Target.json         | Constant.REST_DIR/response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_redshift_example_Target.json         | redshifttoredshift_jdbc_select      |
      | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/ExpectedLineageTargets/redshift_example_Target.json              | Constant.REST_DIR/response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/redshift_example_Target.json              | redshift_jdbc                       |
      | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/ExpectedLineageTargets/jdbc_redshift_example1_Target.json        | Constant.REST_DIR/response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_redshift_example1_Target.json        | redshifttoredshift_overwrite        |
      | ida/PythonSparkPayloads/MLP-7855_LineagePayloads/ExpectedLineageTargets/jdbc_dataset_example_Target.json          | Constant.REST_DIR/response/PythonSparkLineage/MLP-7855_Lineage/LineageTargets/jdbc_dataset_example_Target.json          | redshifttoredshift                  |


    ##########################################################################################################################################################################
  #---------------------- DELETING THE AMAZON CLUSTER FROM POSTGRES DB --------------------------#

  Scenario Outline: sc#6_1 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type    | targetFile                                                | jsonpath           |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector_RedshiftSpark/%DYN           |         | response/pythonsparkLineage/MLP-7855_Lineage/itemIds.json | $..has_Analysis.id |
      | APPDBPOSTGRES | Default | RedshiftPythonSparkLineage                                       | Tag     | response/pythonsparkLineage/MLP-7855_Lineage/itemIds.json | $..Tag.id          |
      | APPDBPOSTGRES | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster | response/pythonsparkLineage/MLP-7855_Lineage/itemIds.json | $..Cluster.id      |
      | APPDBPOSTGRES | Default | pythonanalyzerdemo                                               | Project | response/pythonsparkLineage/MLP-7855_Lineage/itemIds.json | $..Project.id      |


  Scenario Outline: sc#6_2 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                                 |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/pythonsparkLineage/MLP-7855_Lineage/itemIds.json |
      | items/Default/Default.Tag:::dynamic          | 204          | $..Tag.id          | response/pythonsparkLineage/MLP-7855_Lineage/itemIds.json |
      | items/Default/Default.Cluster:::dynamic      | 204          | $..Cluster.id      | response/pythonsparkLineage/MLP-7855_Lineage/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id      | response/pythonsparkLineage/MLP-7855_Lineage/itemIds.json |


#############################################################################################################################################################################
####################Deleting the catalog , plugins configurations and Target folders from HDFS
####################################################################################################################################################################
###
#

  @MLP-7855 @regression @positive
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollector            |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/PythonParser            |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/PythonSparkLineage      |      | 204           |                  |          |

