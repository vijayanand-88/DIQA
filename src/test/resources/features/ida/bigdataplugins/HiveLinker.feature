@MLP-26714
Feature:MLP-26714: Testing Hive Linker

  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | linker/HiveLinker/%            | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/%    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%     | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                   | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                        | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                      | Cluster  |       |       |
      | SingleItemDelete | Default | LineageDemo Cluster            | Cluster  |       |       |

  @positve @regression @sanity @MLP-26714 @IDA-1.1.0
  Scenario Outline: Pre-Condition :Set the Credentials, Datasource, Bussiness Application and Cataloger for Hive Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                                    | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveValidCredential   | ida/hivePayloads/Credentials/hiveValidCredentials.json                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveValidCredential   |                                                                         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsDBValidCredential | ida/hdfsPayloads/Credentials/hdfsdbValidCredentials.json                | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsDBValidCredential |                                                                         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\hivePayloads\Bussiness_Application\BussinessApplication_Linker.json | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HiveDataSource          | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json              | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HiveDataSource          |                                                                         | 200           | HiveDataSource_Valid |          |

############################################## Policy Patterns - PII Tagging ##########################################################

  @MLP-26714 @positve @hdfs @regression @sanity
  Scenario Outline:Pre-Condition:Creating a New Sub-Directory directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                 | body                                                                 | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | hivelinkerTest/CSV/tagdetails_allmatch_csv.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true             | ida/hdfsPayloads/TestData/CSV_PIITags/tagdetails_allmatch_csv.csv    | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | hivelinkerTest/AVRO/tagdetails_allmatch_avro.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true          | ida/hdfsPayloads/TestData/Avro_PIITags/tagdetails_allmatch_avro.avro | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | hivelinkerTest/PARQUET/tagdetails_allmatch_parquet.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/parquetPayloads/TestData/tagdetails_allmatch_parquet.parquet     | 201           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | hivelinkerTest1/ExternalFolder?op=MKDIRS&recursive=true&overwrite=true                                                                                                              |                                                                      | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | hivelinkerTest/TextFolder/insert_cycling.txt?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true               | ida/hdfsPayloads/TestData/insert_cycling_cassandra.txt               | 201           |                  |

  Scenario: MLP-26714: Create Hive Database and Table to verify PII Data pattern
    Given user executes the following Query in the Hive JDBC
      | queryEntry                                                         |
      | CreateHiveDatabase4                                                |
      | CreateExternalHiveTableTagdetailsCSV                               |
      | CreateExternalHiveTableTagdetailsPARQUET                           |
      | CreateExternalHiveTableTagdetailsText                              |
      | CreateExternalHiveTableTagdetailsNorecordtables                    |
      | Constant.REST_PAYLOAD/ida/hivePayloads/TestData/TestData_Avro.text |
    And sync the test execution for "15" seconds

  Scenario: Pre-Condition#-MLP_26714_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  Scenario: Pre-Condition#-MLP_26714_Update the Host name respect to the docker in HDFS Cataloger
    And user "update" the json file "ida/hivePayloads/Linker/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                               | jsonValues           | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo" |         |
      | $.configurations..filter..root         | /hivelinkerTest      |         |
      | $.configurations..name                 | SC1_AllFormats       |         |
      | $.configurations..tags[*]              | SC1_AllFormats       |         |
      | $.configurations..filter..tags[*]      | AllFormats           |         |
      | $.configurations..autoStart            | false                | boolean |
      | $.configurations..analyzeCollectedData | false                | boolean |

  Scenario: Pre-Condition#-MLP_26714_Update the node condition and analyzer graph fields for Avro
    And user "update" the json file "ida/hivePayloads/Linker/SC1_new_Avro_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC1_AvroAnalyzer     |         |
      | $.configurations..tags[*]          | SC1_AvroAnalyzer     |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

  Scenario: Pre-Condition#-MLP_26714_Update the node condition and analyzer graph fields for CSV
    And user "update" the json file "ida/hivePayloads/Linker/SC1_new_Csv_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC1_CSVAnalyzer      |         |
      | $.configurations..tags[*]          | SC1_CSVAnalyzer      |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

  Scenario: Pre-Condition#-MLP_26714_Update the node condition and analyzer graph fields for Parquet
    And user "update" the json file "ida/hivePayloads/Linker/ParquetAnalyzerConfiguration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC1_ParquetAnalyzer  |         |
      | $.configurations..tags[*]          | SC1_ParquetAnalyzer  |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

  @positve @regression @sanity  @MLP-26714 @IDA-1.1.0
  Scenario Outline: Pre-Condition#-MLP_26714_set HDFS Cataloger , Hive Cataloger , HDFS File Anlayzer(All 3) and Hive Linker to run in below sequence .
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                              | response code | response message     | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                            | ida\hbasePayloads\DataSource\license_DS.json                      | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveDataSource                                                           | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json        | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                           |                                                                   | 200           | HiveDataSource_Valid |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                           | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json      | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                           |                                                                   | 200           | HDFSDataSource_valid |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                            | ida/hivePayloads/Linker/SC1_new_Hdfs_Cataloger_Configuration.json | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                            |                                                                   | 200           | SC1_AllFormats       |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveCataloger                                                            | ida/hivePayloads/Linker/new_Hive_Cataloger_Configuration.json     | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveCataloger                                                            |                                                                   | 200           | HiveCataloger        |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger            |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger             |                                                                   | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger            |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats           |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_AllFormats')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats            |                                                                   | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats           |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_AllFormats')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvAnalyzer                                                              | ida/hivePayloads/Linker/SC1_new_Csv_Analyzer_Configuration.json   | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvAnalyzer                                                              |                                                                   | 200           | SC1_CSVAnalyzer      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC1_CSVAnalyzer         |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_CSVAnalyzer')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC1_CSVAnalyzer          |                                                                   | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC1_CSVAnalyzer         |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_CSVAnalyzer')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/ParquetAnalyzer                                                          | ida/hivePayloads/Linker/ParquetAnalyzerConfiguration.json         | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/ParquetAnalyzer                                                          |                                                                   | 200           | SC1_ParquetAnalyzer  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/SC1_ParquetAnalyzer |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/SC1_ParquetAnalyzer  |                                                                   | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/SC1_ParquetAnalyzer |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_ParquetAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroAnalyzer                                                             | ida/hivePayloads/Linker/SC1_new_Avro_Analyzer_Configuration.json  | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroAnalyzer                                                             |                                                                   | 200           | SC1_AvroAnalyzer     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer       |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_AvroAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer        |                                                                   | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer       |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_AvroAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveLinker                                                               | ida/hivePayloads/Linker/new_Hive_Linker_Configuration.json        | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveLinker                                                               |                                                                   | 200           | HiveLinker           |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/linker/HiveLinker/HiveLinker                     |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/linker/HiveLinker/HiveLinker                      |                                                                   | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/linker/HiveLinker/HiveLinker                     |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveLinker')].status          |

    #7187767
  @MLP-26714 @GlueLinker @webtest
  Scenario Outline:SC1 Verify the Table to File and column to field Lineage is generated for Hive table to CSV File(Post CSV Analyzer run)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name           | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | tagdetails_csv |             | response/hiveLinker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                             | response code | response message | jsonPath | targetFile                                           |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\hiveLinker\bulkLineage.json | $.lineagePayLoads.tagdetails_csv | 200           |                  | edges    | response\hiveLinker\Actual\ActualLineagehopsCSV.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                               | JsonPath       |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsCSV.json | tagdetails_csv |
    And user sort the json file using the following value
      | fileName                                                               | JsonPath       | value  |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsCSV.json | tagdetails_csv | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag" and clicks on search
    And user performs "facet selection" in "HiveTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tagdetails_csv" item from search results
    Then user performs click and verify in new window
      | Table            | value | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | CSV   | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                                            | item           |
      | Constant.REST_DIR/response/hiveLinker/Expected/ExpectedLineagehopsCSV.json | Constant.REST_DIR/response/hiveLinker/Actual/actualLineagehopsCSV.json | tagdetails_csv |

    #7187768
  @MLP-26714 @GlueLinker @webtest
  Scenario Outline:SC2 Verify the Table to File and column to field Lineage is generated for Hive table to AVRO File Column (Post AVRO Analyzer run)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name            | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | tagdetails_avro |             | response/hiveLinker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                              | response code | response message | jsonPath | targetFile                                            |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\hiveLinker\bulkLineage.json | $.lineagePayLoads.tagdetails_avro | 200           |                  | edges    | response\hiveLinker\Actual\ActualLineagehopsAVRO.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                | JsonPath        |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsAVRO.json | tagdetails_avro |
    And user sort the json file using the following value
      | fileName                                                                | JsonPath        | value  |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsAVRO.json | tagdetails_avro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag" and clicks on search
    And user performs "facet selection" in "HiveTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tagdetails_avro" item from search results
    Then user performs click and verify in new window
      | Table            | value | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | AVRO  | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                                             | item            |
      | Constant.REST_DIR/response/hiveLinker/Expected/ExpectedLineagehopsAVRO.json | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsAVRO.json | tagdetails_avro |

    #7187770
  @MLP-26714 @GlueLinker @webtest
  Scenario Outline:SC3 Verify the Table to File and column to field Lineage is generated for Hive table to PARQUET File Column (Post PARQUET Analyzer run)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name               | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | tagdetails_parquet |             | response/hiveLinker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                 | response code | response message | jsonPath | targetFile                                               |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\hiveLinker\bulkLineage.json | $.lineagePayLoads.tagdetails_parquet | 200           |                  | edges    | response\hiveLinker\Actual\ActualLineagehopsPARQUET.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                   | JsonPath           |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsPARQUET.json | tagdetails_parquet |
    And user sort the json file using the following value
      | fileName                                                                   | JsonPath           | value  |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsPARQUET.json | tagdetails_parquet | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag" and clicks on search
    And user performs "facet selection" in "HiveTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tagdetails_parquet" item from search results
    Then user performs click and verify in new window
      | Table            | value   | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | PARQUET | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                  | actual_json                                                                | item               |
      | Constant.REST_DIR/response/hiveLinker/Expected/ExpectedLineagehopsPARQUET.json | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsPARQUET.json | tagdetails_parquet |

    #7187773
  @MLP-26714 @GlueLinker @webtest
  Scenario Outline:SC4 Verify the Table to Directory Lineage is generated when the Text file is provided
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name            | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | tagdetails_text |             | response/hiveLinker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                              | response code | response message | jsonPath | targetFile                                            |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\hiveLinker\bulkLineage.json | $.lineagePayLoads.tagdetails_text | 200           |                  | edges    | response\hiveLinker\Actual\ActualLineagehopsTEXT.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                | JsonPath        |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsTEXT.json | tagdetails_text |
    And user sort the json file using the following value
      | fileName                                                                | JsonPath        | value  |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsTEXT.json | tagdetails_text | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag" and clicks on search
    And user performs "facet selection" in "HiveTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tagdetails_text" item from search results
    Then user performs click and verify in new window
      | Table            | value      | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | TextFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                                             | item            |
      | Constant.REST_DIR/response/hiveLinker/Expected/ExpectedLineagehopsTEXT.json | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsTEXT.json | tagdetails_text |

  Scenario:Post-Condition1:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | linker/HiveLinker/%            | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/%    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%     | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                   | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                        | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                      | Cluster  |       |       |
      | SingleItemDelete | Default | LineageDemo Cluster            | Cluster  |       |       |

  @positve @regression @sanity  @MLP-26714 @IDA-1.1.0
  Scenario Outline: Pre-Condition#-MLP_26714_set HDFS Cataloger , Hive Cataloger and Hive Linker to run in below sequence .
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                              | response code | response message     | jsonPath                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                  | ida\hbasePayloads\DataSource\license_DS.json                      | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveDataSource                                                 | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json        | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                 |                                                                   | 200           | HiveDataSource_Valid |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                 | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json      | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                 |                                                                   | 200           | HDFSDataSource_valid |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                  | ida/hivePayloads/Linker/SC1_new_Hdfs_Cataloger_Configuration.json | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                  |                                                                   | 200           | SC1_AllFormats       |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveCataloger                                                  | ida/hivePayloads/Linker/new_Hive_Cataloger_Configuration.json     | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveCataloger                                                  |                                                                   | 200           | HiveCataloger        |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger   |                                                                   | 200           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_AllFormats')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats  |                                                                   | 200           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_AllFormats')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveLinker                                                     | ida/hivePayloads/Linker/new_Hive_Linker_Configuration.json        | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveLinker                                                     |                                                                   | 200           | HiveLinker           |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/linker/HiveLinker/HiveLinker           |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveLinker')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/linker/HiveLinker/HiveLinker            |                                                                   | 200           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/linker/HiveLinker/HiveLinker           |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveLinker')].status     |

#7187772
  @MLP-26714 @GlueLinker @webtest
  Scenario Outline:SC5 Verify the Table to Directory is generated for Hive table to CSV File(Post CSV Analyzer run)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name           | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | tagdetails_csv |             | response/hiveLinker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                             | response code | response message | jsonPath | targetFile                                            |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\hiveLinker\bulkLineage.json | $.lineagePayLoads.tagdetails_csv | 200           |                  | edges    | response\hiveLinker\Actual\ActualLineagehopsCSV1.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                | JsonPath       |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsCSV1.json | tagdetails_csv |
    And user sort the json file using the following value
      | fileName                                                                | JsonPath       | value  |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsCSV1.json | tagdetails_csv | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag" and clicks on search
    And user performs "facet selection" in "HiveTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tagdetails_csv" item from search results
    Then user performs click and verify in new window
      | Table            | value | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | CSV   | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                                             | item           |
      | Constant.REST_DIR/response/hiveLinker/Expected/ExpectedLineagehopsCSV1.json | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsCSV1.json | tagdetails_csv |

    #7187772
  @MLP-26714 @GlueLinker @webtest
  Scenario Outline:SC6 Verify the Table to Directory is generated for Hive table to AVRO File Column (Post AVRO Analyzer run)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name            | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | tagdetails_avro |             | response/hiveLinker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                              | response code | response message | jsonPath | targetFile                                             |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\hiveLinker\bulkLineage.json | $.lineagePayLoads.tagdetails_avro | 200           |                  | edges    | response\hiveLinker\Actual\ActualLineagehopsAVRO1.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                 | JsonPath        |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsAVRO1.json | tagdetails_avro |
    And user sort the json file using the following value
      | fileName                                                                 | JsonPath        | value  |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsAVRO1.json | tagdetails_avro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag" and clicks on search
    And user performs "facet selection" in "HiveTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tagdetails_avro" item from search results
    Then user performs click and verify in new window
      | Table            | value | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | AVRO  | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                | actual_json                                                              | item            |
      | Constant.REST_DIR/response/hiveLinker/Expected/ExpectedLineagehopsAVRO1.json | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsAVRO1.json | tagdetails_avro |

    #7187772
  @MLP-26714 @GlueLinker @webtest
  Scenario Outline:SC7 Verify the Table to Directory is generated for Hive table to PARQUET File Column (Post PARQUET Analyzer run)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name               | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | tagdetails_parquet |             | response/hiveLinker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                 | response code | response message | jsonPath | targetFile                                                |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\hiveLinker\bulkLineage.json | $.lineagePayLoads.tagdetails_parquet | 200           |                  | edges    | response\hiveLinker\Actual\ActualLineagehopsPARQUET1.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                    | JsonPath           |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsPARQUET1.json | tagdetails_parquet |
    And user sort the json file using the following value
      | fileName                                                                    | JsonPath           | value  |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsPARQUET1.json | tagdetails_parquet | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag" and clicks on search
    And user performs "facet selection" in "HiveTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tagdetails_parquet" item from search results
    Then user performs click and verify in new window
      | Table            | value   | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | PARQUET | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                   | actual_json                                                                 | item               |
      | Constant.REST_DIR/response/hiveLinker/Expected/ExpectedLineagehopsPARQUET1.json | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsPARQUET1.json | tagdetails_parquet |

  Scenario:Post-Condition2:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | linker/HiveLinker/%            | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/%    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%     | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                   | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                        | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                      | Cluster  |       |       |
      | SingleItemDelete | Default | LineageDemo Cluster            | Cluster  |       |       |

  Scenario: Pre-Condition#-MLP_26714_Update Entire location in HDFS cataloger for No data table lineage
    And user "update" the json file "ida/hivePayloads/Linker/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                               | jsonValues                                          | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"                                |         |
      | $.configurations..filter..root         | /apps/hive/warehouse/hivelinkerdb.db/norecordtables |         |
      | $.configurations..name                 | SC1_AllFormats                                      |         |
      | $.configurations..tags[*]              | SC1_AllFormats                                      |         |
      | $.configurations..filter..tags[*]      | AllFormats                                          |         |
      | $.configurations..autoStart            | false                                               | boolean |
      | $.configurations..analyzeCollectedData | false                                               | boolean |

  @positve @regression @sanity  @MLP-26714 @IDA-1.1.0
  Scenario Outline: Pre-Condition#-MLP_26714_set HDFS Cataloger , Hive Cataloger and Hive Linker to run in below sequence for No data table Lineage.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                              | response code | response message     | jsonPath                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                  | ida\hbasePayloads\DataSource\license_DS.json                      | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveDataSource                                                 | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json        | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                 |                                                                   | 200           | HiveDataSource_Valid |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                 | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json      | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                 |                                                                   | 200           | HDFSDataSource_valid |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                  | ida/hivePayloads/Linker/SC1_new_Hdfs_Cataloger_Configuration.json | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                  |                                                                   | 200           | SC1_AllFormats       |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveCataloger                                                  | ida/hivePayloads/Linker/new_Hive_Cataloger_Configuration.json     | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveCataloger                                                  |                                                                   | 200           | HiveCataloger        |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger   |                                                                   | 200           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_AllFormats')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats  |                                                                   | 200           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_AllFormats |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SC1_AllFormats')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveLinker                                                     | ida/hivePayloads/Linker/new_Hive_Linker_Configuration.json        | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveLinker                                                     |                                                                   | 200           | HiveLinker           |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/linker/HiveLinker/HiveLinker           |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveLinker')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/linker/HiveLinker/HiveLinker            |                                                                   | 200           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/linker/HiveLinker/HiveLinker           |                                                                   | 200           | IDLE                 | $.[?(@.configurationName=='HiveLinker')].status     |

    #7187771
  @MLP-26714 @GlueLinker @webtest
  Scenario Outline:SC8 Verify if the Table to Directory lineage is generated along with External Location for the Hive table to Directory if the file analyzers is not run .
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name           | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | norecordtables |             | response/hiveLinker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                             | response code | response message | jsonPath | targetFile                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\hiveLinker\bulkLineage.json | $.lineagePayLoads.norecordtables | 200           |                  | edges    | response\hiveLinker\Actual\ActualLineagehopsnorecordtables.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                          | JsonPath       |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsnorecordtables.json | norecordtables |
    And user sort the json file using the following value
      | fileName                                                                          | JsonPath       | value  |
      | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsnorecordtables.json | norecordtables | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag" and clicks on search
    And user performs "facet selection" in "HiveTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "norecordtables" item from search results
    Then user performs click and verify in new window
      | Table            | value          | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | norecordtables | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                         | actual_json                                                                       | item           |
      | Constant.REST_DIR/response/hiveLinker/Expected/ExpectedLineagehopsnorecordtables.json | Constant.REST_DIR/response/hiveLinker/Actual/ActualLineagehopsnorecordtables.json | norecordtables |

    ##################################################Logging Enhancement##########################################################

    #7187774
  @sanity @positive @MLP-26714 @webtest @IDA-1.1.0
  Scenario:SC9#Verify log entries/log enhancements(processed Items widget and Processed count) check for HiveLinker plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ExplicitTag" and clicks on search
    And user performs "facet selection" in "ExplicitTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/HiveLinker/HiveLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Cluster Demo |
      | HIVE         |
    And Analysis log "linker/HiveLinker/HiveLinker%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0019 |            |                |
      | INFO | ANALYSIS-0071: Plugin Name:HiveLinker, Plugin Type:linker, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:HiveLinker                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0071 | HiveLinker | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin HiveLinker Configuration: ---  2020-09-03 19:42:27.074 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: name: "HiveLinker"  2020-09-03 19:42:27.074 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: pluginVersion: "LATEST"  2020-09-03 19:42:27.074 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: label:  2020-09-03 19:42:27.074 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: : ""  2020-09-03 19:42:27.074 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: catalogName: "Default"  2020-09-03 19:42:27.074 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: eventClass: null  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: eventCondition: null  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: maxWorkSize: 100  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: tags:  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: - "ExplicitTag"  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: pluginType: "linker"  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: dataSource: null  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: credential: null  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: businessApplicationName: "Hive_LINKER_BA"  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: dryRun: false  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: schedule: null  2020-09-03 19:42:27.075 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: filter: null  2020-09-03 19:42:27.076 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: pluginName: "HiveLinker"  2020-09-03 19:42:27.076 INFO  - ANALYSIS-0073: Plugin HiveLinker Configuration: type: "Linker" | ANALYSIS-0073 | HiveLinker |                |
      | INFO | Plugin HiveLinker Start Time:2020-08-10 19:40:34.556, End Time:2020-08-10 19:44:55.548, Processed Count:2, Errors:0, Warnings:5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0072 | HiveLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0020 |            |                |

    ############################################Technology tag#######################################################################

  #7187774
  @positve @regression @sanity  @PIITag
  Scenario:Commoncase#MLP_26714_Verify Technology tag , Explicit tag , Bussiness Application tag and File Filter tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | DatabaseName | TableName/Filename | Column     | Tags                            | Query                    | Action         |
      | Cluster Demo | HIVE        | hivelinkerdb | norecordtables     |            | ExplicitTag,Hive,Hive_LINKER_BA | TableQuerywithoutSchema  | TagAssigned    |
      | Cluster Demo | HIVE        | hivelinkerdb | norecordtables     | rollnumber | ExplicitTag,Hive,Hive_LINKER_BA | ColumnQuerywithoutSchema | TagAssigned    |
      | Cluster Demo | HIVE        | hivelinkerdb |                    |            | ExplicitTag                     | DatabaseQuery            | TagNotAssigned |
      | Cluster Demo | HIVE        |              |                    |            | ExplicitTag                     | ServiceQuery             | TagNotAssigned |
      | Cluster Demo |             |              |                    |            | ExplicitTag                     | ClusterQuery             | TagNotAssigned |

  Scenario:Post-Condition3:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | linker/HiveLinker/%            | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/%    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%     | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                   | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                        | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                      | Cluster  |       |       |
      | SingleItemDelete | Default | LineageDemo Cluster            | Cluster  |       |       |

    ###################################################Dry Run #################################################################

  #7187774
  Scenario: Pre-Condition#-MLP_26714_Update Entire location in HDFS cataloger for Dry Run
    And user "update" the json file "ida/hivePayloads/Linker/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                               | jsonValues                                          | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"                                |         |
      | $.configurations..filter..root         | /apps/hive/warehouse/hivelinkerdb.db/norecordtables |         |
      | $.configurations..name                 | forDryRun                                           |         |
      | $.configurations..tags[*]              | forDryRun                                           |         |
      | $.configurations..filter..tags[*]      | forDryRun                                           |         |
      | $.configurations..autoStart            | false                                               | boolean |
      | $.configurations..analyzeCollectedData | false                                               | boolean |

  @positve @regression @sanity  @MLP-26714 @IDA-1.1.0
  Scenario Outline: Pre-Condition#-MLP_26714_set HDFS Cataloger , Hive Cataloger and Hive Linker to run in below sequence for Hive Linker Dry Run.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                               | response code | response message     | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                 | ida\hbasePayloads\DataSource\license_DS.json                       | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveDataSource                                                | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json         | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                |                                                                    | 200           | HiveDataSource_Valid |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json       | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                |                                                                    | 200           | HDFSDataSource_valid |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                 | ida/hivePayloads/Linker/SC1_new_Hdfs_Cataloger_Configuration.json  | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                 |                                                                    | 200           | forDryRun            |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/Linker/new_Hive_Cataloger_Configuration.json      | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveCataloger                                                 |                                                                    | 200           | HiveCataloger        |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  |                                                                    | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/forDryRun     |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='forDryRun')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/forDryRun      |                                                                    | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/forDryRun     |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='forDryRun')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveLinker                                                    | ida/hivePayloads/Linker/new_Hive_Linker_Dry_Run_Configuration.json | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveLinker                                                    |                                                                    | 200           | HiveLinker           |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/linker/HiveLinker/HiveLinker          |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='HiveLinker')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/linker/HiveLinker/HiveLinker           |                                                                    | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/linker/HiveLinker/HiveLinker          |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='HiveLinker')].status    |

    #7187774
  #Bug-24578
  @sanity @positive @MLP-26714 @webtest @IDA-1.1.0
  Scenario:SC10#Verify log entries/log enhancements(processed Items widget and Processed count) check for HiveLinker plugin in Dryn Run mode.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ExplicitTag" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service  |
      | Cluster  |
      | Database |
      | Table    |
      | Column   |
    And user enters the search text "HiveLinker" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/HiveLinker/HiveLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    And Analysis log "linker/HiveLinker/HiveLinker%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | logCode       | pluginName | removableText  |
      | INFO | Plugin HiveLinker running on dry run mode                                                                                       | ANALYSIS-0069 | HiveLinker |               |
      | INFO | Plugin HiveLinker processed 2 items on dry run mode and not written to the repository                                           | ANALYSIS-0070 | HiveLinker |               |
      | INFO | Plugin HiveLinker Start Time:2020-08-04 19:06:26.536, End Time:2020-08-04 19:06:26.804, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | HiveLinker |               |

  Scenario:Post-Condition4:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HiveCataloger/%      | Analysis |       |       |
      | MultipleIDDelete | Default | linker/HiveLinker/%            | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/%    | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/%     | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/ParquetAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | monitor/HdfsMonitor/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                   | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                        | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                      | Cluster  |       |       |
      | SingleItemDelete | Default | LineageDemo Cluster            | Cluster  |       |       |

        #################### Deleting the credentials , Data Source , Bussiness Application , Hive tables and HDFS files######################

  @positve @regression @sanity  @MLP-26714 @IDA-1.1.0
  Scenario Outline:SC11:MLP-26714:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsDBValidCredential |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveValidCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveDataSource          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveLinker        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvAnalyzer             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroAnalyzer            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetAnalyzer         |      | 204           |                  |          |

  @positve @regression @sanity  @MLP-26714 @IDA-1.1.0
  Scenario:SC11:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type                | query | param |
      | SingleItemDelete | Default | Hive_LINKER_BA | BusinessApplication |       |       |

  Scenario:SC11Deleting the created database/table in hive view
    And user executes the following Query in the Hive JDBC
      | queryEntry                                      |
      | DropExternalHiveTableTagdetails_CSV             |
      | DropExternalHiveTableTagdetails_AVRO            |
      | DropExternalHiveTableTagdetails_PARQUET         |
      | DropExternalHiveTableTagdetails_Norecordtables  |
      | DropExternalHiveTableTagdetails_tagdetails_text |
      | DropHiveDatabase_hivelinkerdb                   |

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC11:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                       | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /hivelinkerTest?op=DELETE&recursive=true |      | 200           | true             |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /hivelinkerTest1?op=DELETE&recursive=true |      | 200           | true             |

