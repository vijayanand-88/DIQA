@MLP-29632:
Feature: MLP-29632: Validation of Business Lineage plugin

  @MLP-29632 @regression
  Scenario: SC1 -Copy the file from local to the user path
    Given user connects to the SFTP server for below parameters
      | sftpAction  | remoteDir                                                   |
      | copytoLocal | ida/PythonSparkPayloads/MLP-8130                            |
      | copytoLocal | ida/PythonSparkPayloads/pythonSparkLineage_8130_sourceFiles |


  @MLP-29632 @regression
  Scenario: SC1 - Run the spark commands in local machine
    And user connects to the sftp server or local Machine and runs commands
      | command      | Filename                       | Env   |
      | Spark2_Local | SnowFlake_to_SnowFlake_jdbc.py | Local |


  @MLP-29632 @regression
  Scenario:SC1 Add valid Credentials for Git and Snowflake plugins
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                                        | body                                                                     | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/credentials/GitSparkCredentials   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/GitSparkCredentials.json   | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/GitSparkCredentials   |                                                                          | 200           |                  |          |
      |                  |       |       | Put  | settings/credentials/SnowFlake_Credentials | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Snowflake_credentials.json | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/SnowFlake_Credentials |                                                                          | 200           |                  |          |


  @MP-29632 @regression
  Scenario Outline: SC1 - Run the Plugin configurations for Git , HdfsCataloger , ParquetAnalyzer , BigDataAnalyzer , SnowflakeJDBCCataloger, PythonParser and PythonSparkLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | body                                                                                   | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                  | ida\hbasePayloads\DataSource\license_DS.json                                           | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                         | ida/PythonSparkPayloads/MLP-8130_PluginConfig/GitSparkDataSource.json                  | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                                         |                                                                                        | 200           | GitSpark_SnowflakeDS         |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                                   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Git_Pyspark.json                         | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                                   |                                                                                        | 200           | GitCollector_Snowflake       |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_Snowflake               |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='GitCollector_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector_Snowflake                | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Git_Pyspark_empty.json                   | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector_Snowflake               |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='GitCollector_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                          | ida/PythonSparkPayloads/MLP-8130_PluginConfig/SnowflakeDS.json                         | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                          |                                                                                        | 200           | SnowFlakeDS                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                           | ida/PythonSparkPayloads/MLP-8130_PluginConfig/SnowflakeCatalogerConfig_for_Python.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                           |                                                                                        | 200           | SnowflakeJDBCCataloger_Spark |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger_Spark |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='SnowflakeJDBCCataloger_Spark')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger_Spark  | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Snowflake_Pyspark_empty.json             | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger_Spark |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='SnowflakeJDBCCataloger_Spark')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonParser                                                                   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Parser_Pyspark.json                      | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonParser                                                                   |                                                                                        | 200           | PythonParser_Snowflake       |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Snowflake                  |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='PythonParser_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser_Snowflake                   | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Parser_Pyspark_empty.json                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser_Snowflake                  |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='PythonParser_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonSparkLineage                                                             | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Py_Spark_Pyspark.json                    | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonSparkLineage                                                             |                                                                                        | 200           | SparkLineage_Snowflake       |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/*                                |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='SparkLineage_Snowflake')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSparkLineage/*                                 | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Py_Spark_Pyspark.json                    | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSparkLineage/*                                |                                                                                        | 200           | IDLE                         | $.[?(@.configurationName=='SparkLineage_Snowflake')].status       |


  @MLP-29632 @regression
  Scenario Outline: SC#1:MLP-29632:Create a business application
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_29632\BusinessApplication.json  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_29632\BusinessApplication2.json | 200           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:SC1:Store the item ID to a file
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type  | name          | asg_scopeid | targetFile                            | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Table | SF_To_SF_jdbc |             | payloads\idc\MLP_29632\AssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC1:Assigning BA to first item
    And user update the json file "idc/MLP_29632/AssignTag.json" file for following values
      | jsonPath             | jsonValues  |
      | $.assignedTags..name | BLineageBA1 |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29632/AssignTag.json | 204           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:SC1:Store the item ID to file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type  | name              | asg_scopeid | targetFile                            | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Table | FINANCE_DUPLICATE |             | payloads\idc\MLP_29632\AssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC1:Assigning BA to second item
    And user update the json file "idc/MLP_29632/AssignTag.json" file for following values
      | jsonPath             | jsonValues  |
      | $.assignedTags..name | BLineageBA2 |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29632/AssignTag.json | 204           |                  |          |

##7264194#
  @MLP-29632 @regression
  Scenario:SC1#MLP-29632 Verify business lineage links are created between tables (lineage should exists between tables) after running business lineage plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body                                     | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/BusinessLineage                                                | idc/MLP_29632/BusinessLineageConfig.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/BusinessLineage/TestBusinessLineage  |                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
    And Analysis log "lineage/BusinessLineage/TestBusinessLineage%" should display below info/error/warning
      | type | logValue                                                 | logCode       | pluginName | removableText |
      | INFO | Plugin started                                           | ANALYSIS-0019 |            |               |
      | INFO | Plugin completed                                         | ANALYSIS-0020 |            |               |
      | INFO | Generated 1 link(s) for business application BLineageBA1 |               |            |               |
      | INFO | Generated 0 link(s) for business application BLineageBA2 |               |            |               |


  @MLP-29632 @regression
  Scenario:SC1#MLP-29632 Verify Business lineage widget
    And Verify the metadata properties of the item types via api call
      | widgetName            | filePath                          | jsonPath                               | Action                 | query   | BusinessApplicationName | TabName |
      | Business Lineage To   | idc/MLP_29632/expectedValues.json | $..SC1_BLineageBA1.BusinessLineageTo   | verify widget contains | BAQuery | BLineageBA1             | Lineage |
      | Business Lineage From | idc/MLP_29632/expectedValues.json | $..SC1_BLineageBA2.BusinessLineageFrom | verify widget contains | BAQuery | BLineageBA2             | Lineage |

  @MLP-29632 @regression
  Scenario:SC#1:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | MultipleIDDelete | Default | lineage/BusinessLineage/TestBusinessLineage% | Analysis |       |       |


  @MLP-29632 @regression
  Scenario Outline: SC#2:MLP-29632:Create a business application
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_29632\BusinessApplication3.json | 200           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:SC2:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type  | name    | asg_scopeid | targetFile                            | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Table | FINANCE | TESTSCHEMA  | payloads\idc\MLP_29632\AssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC2:Assigning BA to first item
    And user update the json file "idc/MLP_29632/AssignTag.json" file for following values
      | jsonPath             | jsonValues  |
      | $.assignedTags..name | BLineageBA3 |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29632/AssignTag.json | 204           |                  |          |



#7264198#7264199#
  @MLP-29632 @regression
  Scenario:SC2#MLP-29632 Verify multiple business lineage links are created between tables (lineage should exists between tables) after running business lineage plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body                                     | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/BusinessLineage                                                | idc/MLP_29632/BusinessLineageConfig.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/BusinessLineage/TestBusinessLineage  |                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |

  @MLP-29632 @regression
  Scenario:SC2#MLP-29632 Verify Business lineage widget
    And Verify the metadata properties of the item types via api call
      | widgetName            | filePath                          | jsonPath                               | Action                 | query   | BusinessApplicationName | TabName |
      | Business Lineage To   | idc/MLP_29632/expectedValues.json | $..SC2_BLineageBA3.BusinessLineageTo   | verify widget contains | BAQuery | BLineageBA3             | Lineage |
      | Business Lineage From | idc/MLP_29632/expectedValues.json | $..SC2_BLineageBA1.BusinessLineageFrom | verify widget contains | BAQuery | BLineageBA1             | Lineage |
      | Business Lineage To   | idc/MLP_29632/expectedValues.json | $..SC2_BLineageBA1.BusinessLineageTo   | verify widget contains | BAQuery | BLineageBA1             | Lineage |
      | Business Lineage From | idc/MLP_29632/expectedValues.json | $..SC2_BLineageBA2.BusinessLineageFrom | verify widget contains | BAQuery | BLineageBA2             | Lineage |


  @MLP-29632 @regression
  Scenario Outline:MLP-25437:SC#3:UnAssigning BA Tags to tables
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    And user update the json file "idc/MLP_29632/UnAssignTag.json" file for following values
      | jsonPath             | jsonValues  |
      | $.assignedTags..name | BLineageBA2 |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                           | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29632/UnAssignTag.json | 204           |                  |          |
    Examples:
      | database      | retrive          | catalog | type  | name              | asg_scopeid | targetFile                              | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Table | FINANCE_DUPLICATE | TESTSCHEMA  | payloads\idc\MLP_29632\UnAssignTag.json | $..itemIds..id |


#7264201#
  @MLP-29632 @regression
  Scenario:SC3#MLP-29632 Verify whether Business Lineage links are deleted only from respective tables and doesn't affect the Business Lineage link created to other tables
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body                                     | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/BusinessLineage                                                | idc/MLP_29632/BusinessLineageConfig.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/BusinessLineage/TestBusinessLineage  |                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
    And Analysis log "lineage/BusinessLineage/TestBusinessLineage%" should display below info/error/warning
      | type | logValue                                                        | logCode       | pluginName | removableText |
      | INFO | Plugin started                                                  | ANALYSIS-0019 |            |               |
      | INFO | Plugin completed                                                | ANALYSIS-0020 |            |               |
      | INFO | Deleted 1 obsolete link(s) for business application BLineageBA1 |               |            |               |
      | INFO | Generated 1 link(s) for business application BLineageBA3        |               |            |               |
      | INFO | Generated 0 link(s) for business application BLineageBA1        |               |            |               |
      | INFO | Generated 0 link(s) for business application BLineageBA2        |               |            |               |

  @MLP-29632 @regression
  Scenario:SC3#MLP-29632 Verify Business lineage widget
    And Verify the metadata properties of the item types via api call
      | widgetName            | filePath                          | jsonPath                               | Action                 | query   | BusinessApplicationName | TabName |
      | Business Lineage From | idc/MLP_29632/expectedValues.json | $..SC3_BLineageBA1.BusinessLineageFrom | verify widget contains | BAQuery | BLineageBA1             | Lineage |
      | Business Lineage To   | idc/MLP_29632/expectedValues.json | $..SC3_BLineageBA3.BusinessLineageTo   | verify widget contains | BAQuery | BLineageBA3             | Lineage |

  @MLP-29632 @regression
  Scenario:SC#3:Delete cataloger and Analyzer analysis and tables
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type                | query | param |
      | MultipleIDDelete | Default | lineage/BusinessLineage/TestBusinessLineage% | Analysis            |       |       |
      | SingleItemDelete | Default | BLineageBA1                                  | BusinessApplication |       |       |
      | SingleItemDelete | Default | BLineageBA2                                  | BusinessApplication |       |       |
      | SingleItemDelete | Default | BLineageBA3                                  | BusinessApplication |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/%             | Analysis            |       |       |
      | SingleItemDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster             |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                           | Project             |       |       |
      | MultipleIDDelete | Default | parser/PythonParser/%                        | Analysis            |       |       |
      | MultipleIDDelete | Default | lineage/PythonSparkLineage/%                 | Analysis            |       |       |
      | MultipleIDDelete | Default | collector/GitCollector/%                     | Analysis            |       |       |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/BusinessLineage    |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/PythonSparkLineage |      | 204           |                  |          |

  @MLP-29632 @regression @webtest
  Scenario:SC#4_Verify if mandatory fields are left blank it throws proper error message in BusinessLineage Plugin
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Lineage         |
      | Plugin    | BusinessLineage |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @MLP-29632 @regression
  Scenario Outline:SC#5_Add valid Credentials for Snowflake, S3, Csv, Avro, Parquet, Json
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                               | body                                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/AWS_Amazon_Credentials       | ida/AmazonRedshiftPostProcessorPayloads/Amazons3Credentials.json    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Spec_ValidJSONCredentials    | ida/s3JsonPayloads/Credentials/awsJSONS3ValidCredentials.json       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Spec_AWS_CSV_Credentials     | ida/s3CSVPayloads/credentials/awsCredentials.json                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Spec_ValidParquetCredentials | ida/s3ParquetPayloads/Credentials/awsParquetS3ValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Spec_ValidAVROCredentials    | ida/s3AvroPayloads/Credentials/avroS3ValidCredentials.json          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/OrcS3_ValidJSONCredentials   | ida/SnowFlakeLinkerPayloads/orcS3ValidCredentials.json              | 200           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:SC#5_Pre-Condition_Run the SnowflakeCataloger, File Cataloger (orc) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                              | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                      | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                   | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig_ORC.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                   | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                          | ida/SnowFlakeLinkerPayloads/AmazonOrcS3ValidDataSourceConfig.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                          |                                                                   | 200           | OrcS3DataSource        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger                                                           | ida/SnowFlakeLinkerPayloads/sc1OrcS3Cataloger.json                | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                           |                                                                   | 200           | OrcS3Cataloger         |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger               |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='OrcS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger                | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger               |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='OrcS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                   | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/SnowflakeDBLinker            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/SnowflakeDBLinker             | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/SnowflakeDBLinker            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |


  @MLP-29632 @regression
  Scenario Outline: SC#5:MLP-29632:Create a business application
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_29632\BusinessApplication.json  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_29632\BusinessApplication2.json | 200           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:SC5:Store the item ID to file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type  | name                         | asg_scopeid         | targetFile                            | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Table | OrcExternalTableSingleFolder | TEST_SNOWSchemaAuto | payloads\idc\MLP_29632\AssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC5:Assigning BA to first item
    And user update the json file "idc/MLP_29632/AssignTag.json" file for following values
      | jsonPath             | jsonValues  |
      | $.assignedTags..name | BLineageBA1 |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29632/AssignTag.json | 204           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:SC5:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type      | name                   | asg_scopeid | targetFile                            | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Directory | ORCFilesinSingleFolder | QA          | payloads\idc\MLP_29632\AssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC5:Assigning BA to second item
    And user update the json file "idc/MLP_29632/AssignTag.json" file for following values
      | jsonPath             | jsonValues  |
      | $.assignedTags..name | BLineageBA2 |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29632/AssignTag.json | 204           |                  |          |


#7264206#
  @MLP-29632 @regression
  Scenario:SC5#MLP-29632 Verify business lineage links are created between tables (lineage should exists between tables) after running business lineage plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body                                     | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/BusinessLineage                                                | idc/MLP_29632/BusinessLineageConfig.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/BusinessLineage/TestBusinessLineage  |                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
    And Analysis log "lineage/BusinessLineage/TestBusinessLineage%" should display below info/error/warning
      | type | logValue                                                 | logCode       | pluginName | removableText |
      | INFO | Plugin started                                           | ANALYSIS-0019 |            |               |
      | INFO | Plugin completed                                         | ANALYSIS-0020 |            |               |
      | INFO | Generated 1 link(s) for business application BLineageBA1 |               |            |               |
      | INFO | Generated 0 link(s) for business application BLineageBA2 |               |            |               |

  @MLP-29632 @regression
  Scenario:SC5#MLP-29632 Verify Business lineage widget
    And Verify the metadata properties of the item types via api call
      | widgetName            | filePath                          | jsonPath                               | Action                 | query   | BusinessApplicationName | TabName |
      | Business Lineage To   | idc/MLP_29632/expectedValues.json | $..SC4_BLineageBA1.BusinessLineageTo   | verify widget contains | BAQuery | BLineageBA1             | Lineage |
      | Business Lineage From | idc/MLP_29632/expectedValues.json | $..SC4_BLineageBA2.BusinessLineageFrom | verify widget contains | BAQuery | BLineageBA2             | Lineage |

  @MLP-29632 @regression
  Scenario:SC#5:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type                | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/%                   | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/%             | Analysis            |       |       |
      | MultipleIDDelete | Default | linker/SnowflakeDBLinker/%                   | Analysis            |       |       |
      | SingleItemDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster             |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                        | Cluster             |       |       |
      | SingleItemDelete | Default | BLineageBA1                                  | BusinessApplication |       |       |
      | SingleItemDelete | Default | BLineageBA2                                  | BusinessApplication |       |       |
      | SingleItemDelete | Default | amazonaws.com                                | Cluster             |       |       |
      | SingleItemDelete | Default | lineage/BusinessLineage/TestBusinessLineage% | Analysis            |       |       |

  @MLP-29632 @regression
  Scenario Outline:SC#6_Pre-Condition2:Run the SnowflakeCataloger, s3 cataloger and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                      | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                              | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                           | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig_ORC.json             | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                           | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/SnowFlakeLinkerPayloads/AmazonS3DataSourceConfig.json                 | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                       |                                                                           | 200           | AmazonS3DataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/SnowFlakeLinkerPayloads/AmazonS3Cataloger_Configuration.json          | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                           | 200           | AmazonS3Cataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger         |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger          | ida/SnowFlakeLinkerPayloads/empty.json                                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger         |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_NormalExternalTables_ORC.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                           | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/SnowflakeDBLinker            |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/SnowflakeDBLinker             | ida/SnowFlakeLinkerPayloads/empty.json                                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/SnowflakeDBLinker            |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  @MLP-29632 @regression
  Scenario Outline: SC#6:MLP-29632:Create a business application
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_29632\BusinessApplication.json  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_29632\BusinessApplication2.json | 200           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:SC6:Store the item ID to file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type  | name                         | asg_scopeid         | targetFile                            | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Table | OrcExternalTableSingleFolder | TEST_SNOWSchemaAuto | payloads\idc\MLP_29632\AssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC6:Assigning BA to first item
    And user update the json file "idc/MLP_29632/AssignTag.json" file for following values
      | jsonPath             | jsonValues  |
      | $.assignedTags..name | BLineageBA1 |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29632/AssignTag.json | 204           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:SC6:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive          | catalog | type      | name                   | asg_scopeid | targetFile                            | jsonpath       |
      | APPDBPOSTGRES | ItemIDNodeUpdate | Default | Directory | ORCFilesinSingleFolder | QA          | payloads\idc\MLP_29632\AssignTag.json | $..itemIds..id |

  @MLP-29632 @regression
  Scenario:SC6:Assigning BA to second item
    And user update the json file "idc/MLP_29632/AssignTag.json" file for following values
      | jsonPath             | jsonValues  |
      | $.assignedTags..name | BLineageBA2 |
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | tags/Default/assignments | idc/MLP_29632/AssignTag.json | 204           |                  |          |

#7264207#
  @MLP-29632 @regression
  Scenario:SC6#MLP-29632 Verify business lineage links are created between tables (lineage should exists between tables) after running business lineage plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body                                     | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/BusinessLineage                                                | idc/MLP_29632/BusinessLineageConfig.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/BusinessLineage/TestBusinessLineage  |                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/BusinessLineage/TestBusinessLineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='TestBusinessLineage')].status |
    And Analysis log "lineage/BusinessLineage/TestBusinessLineage%" should display below info/error/warning
      | type | logValue                                                 | logCode       | pluginName | removableText |
      | INFO | Plugin started                                           | ANALYSIS-0019 |            |               |
      | INFO | Plugin completed                                         | ANALYSIS-0020 |            |               |
      | INFO | Generated 1 link(s) for business application BLineageBA1 |               |            |               |
      | INFO | Generated 0 link(s) for business application BLineageBA2 |               |            |               |

  @MLP-29632 @regression
  Scenario:SC6#MLP-29632 Verify Business lineage widget
    And Verify the metadata properties of the item types via api call
      | widgetName            | filePath                          | jsonPath                               | Action                 | query   | BusinessApplicationName | TabName |
      | Business Lineage To   | idc/MLP_29632/expectedValues.json | $..SC5_BLineageBA1.BusinessLineageTo   | verify widget contains | BAQuery | BLineageBA1             | Lineage |
      | Business Lineage From | idc/MLP_29632/expectedValues.json | $..SC5_BLineageBA2.BusinessLineageFrom | verify widget contains | BAQuery | BLineageBA2             | Lineage |

  @MLP-29632 @regression
  Scenario:SC#6:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type                | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/%                   | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/%             | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                | Analysis            |       |       |
      | MultipleIDDelete | Default | linker/SnowflakeDBLinker/%                   | Analysis            |       |       |
      | SingleItemDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster             |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                        | Cluster             |       |       |
      | SingleItemDelete | Default | BLineageBA1                                  | BusinessApplication |       |       |
      | SingleItemDelete | Default | BLineageBA2                                  | BusinessApplication |       |       |
      | SingleItemDelete | Default | amazonaws.com                                | Cluster             |       |       |
      | SingleItemDelete | Default | lineage/BusinessLineage/TestBusinessLineage% | Analysis            |       |       |

  @MLP-29632 @regression
  Scenario Outline:Delete Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                               | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/SnowFlake_Credentials        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_Amazon_Credentials       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spec_ValidJSONCredentials    |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spec_AWS_CSV_Credentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spec_ValidParquetCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spec_ValidAVROCredentials    |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/OrcS3_ValidJSONCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/GitSparkCredentials          |      | 200           |                  |          |

  @MLP-29632 @regression
  Scenario Outline:Delete plugin Configurations and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3DataSource     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3Cataloger      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBDataSource  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBCataloger   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OrcS3DataSource        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OrcS3Cataloger         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBLinker      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/BusinessLineage        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonParser           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |

