Feature:MLP-12976 Teradata Postprocessor Implementation

  @cr-data
  Scenario Outline: SC#1-Set Credentials for  TeradataDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/TeradataDB_Credentials | ida/jdbcAnalyzerPayloads/TeraDataPostprocessorConfig/TeradataDBCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/TeradataDB_Credentials |                                                                                 | 200           |                  |          |

  @jdbc @cr-data
  Scenario: SC#1-Create TeradataDBCataloger,TeradataDBDataSource and TeradataDBPostProcessor Plugin config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                        | body                                                                                    | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource    | ida/jdbcAnalyzerPayloads/TeraDataPostprocessorConfig/TeradataDBsource.json              | 204           |                  |          |
      |                  |       |       | Put  | settings/analyzers/TeradataDBCataloger     | ida/jdbcAnalyzerPayloads/TeraDataPostprocessorConfig/TeradataDBCatalogerConfig.json     | 204           |                  |          |
      |                  |       |       | Put  | settings/analyzers/TeradataDBPostProcessor | ida/jdbcAnalyzerPayloads/TeraDataPostprocessorConfig/TeradataDBPostprocessorConfig.json | 204           |                  |          |

  @jdbc @cr-data
  Scenario: SC#1-Create Database in TeradataDatabase
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField         |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createDBinTeradata |

  @jdbc @cr-data
  Scenario: SC#1-Create User permission in TeradataDatabase
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField          |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | grantUserPermission |

  @jdbc @cr-data
  Scenario: SC#1-Create Table and insert value for Table to Table(through procedure)
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField              |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtabletotable1     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtotab1   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtotab2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtabletotable2     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProceduretabtotab |

  @jdbc @cr-data
  Scenario: SC#1-Create Table and insert value for View to Table(through procedure)
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField               |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtableViewtotab1    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotab1   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotab2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotab3   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtableViewtotab2    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureViewtotab |

  @jdbc @cr-data
  Scenario: SC#1-Create Table and insert value for Table to Table(through macro function)
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtabletabtofunc1     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtofunc11   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtofunc12   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtabletabtofunc2     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtofunc21   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtofunc22   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createmacrofunctabtofunc  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | Executemacrofunctabtofunc |

  @jdbc @cr-data
  Scenario: SC#1-Create Table and insert value for View to Table(through procedure having dynamic sql)
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                      |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createTableViewtotabdynamic1    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertRecordViewtotabdynamic1   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertRecordViewtotabdynamic2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertRecordViewtotabdynamic3   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createTableViewtotabdynamic2    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertRecordViewtotabdynamic11  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertRecordViewtotabdynamic12  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureViewtotabdynamic |

  @jdbc @cr-data
  Scenario: SC#1-Create Database,Table, Insert records and Procedure fro Multiple Server Same Database name and Same Table name
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                             |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createDBinTeradata                     |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | grantUserPermission                    |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtabletabtofunc1_v15              |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtofunc11_v15            |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtofunc12_v15            |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtabletabtofunc2_v15              |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtofunc21_v15            |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluestabtofunc22_v15            |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureMupServerSameDBSametab  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureMupServerSameDBSametab1 |

  @jdbc @cr-data
  Scenario: SC#1-Create Database,Table, Insert records and Procedure fro Multiple Server Same Database name and Same View name
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                        |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtableViewtotab1_v15         |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotab1_v15        |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotab2_v15        |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotab3_v15        |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtableViewtotab2_v15         |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureMupServerSameView  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureMupServerSameView1 |

  @jdbc @cr-data
  Scenario: SC#1-Create Table and insert value for Table to Table(through procedure having update query without variable)
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createTableforUpdateNovars     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesforUpdateNovars11  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesforUpdateNovars12  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createTableforUpdateNovars1    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesforUpdateNovars21  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesforUpdateNovars22  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureforUpdateNovars |

  @jdbc @cr-data
  Scenario: SC#1-Create Procedure for MergerSql
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureTabtotabMerge |

  @jdbc @cr-data
  Scenario: SC#1-Create Table and insert value for join Index to single table (through procedure)
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                          |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createTableJoinindexSingletable1    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexSingletable11  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexSingletable12  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexSingletable13  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createTableJoinindexSingletable2    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexSingletable21  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexSingletable22  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureJoinIndexSingletable |

  @jdbc @cr-data
  Scenario: SC#1-Create Table and insert value for join Index to multiple table (through procedure)
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                       |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtableJoinIndexMultable     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexMultable11  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexMultable12  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexMultable13  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createtableJoinIndexMultable1    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexMultable21  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexMultable22  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesJoinIndexMultable23  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createJoinIndex                  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureJoinIndexMultable |

  @jdbc @cr-data
  Scenario: SC#1-Create Table and insert value for View to Table using query having select subquery with where conditions
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField                  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createTableViewtotable      |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotable11   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotable12   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotable13   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotable14   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createTableViewtotable1     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotable21   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | insertvaluesViewtotable22   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | createProcedureViewtotable1 |

  @jdbc
  Scenario: SC#2-Run TeradataDBCataloger Plugin config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body                                | response code | response message        | jsonPath                                                     |
      | application/json |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                       |                                     | 200           | TeraDataDBCataloger_V16 |                                                              |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_V16 |                                     | 200           | IDLE                    | $.[?(@.configurationName=='TeraDataDBCataloger_V16')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_V16  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                         |                                                              |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_V16 |                                     | 200           | IDLE                    | $.[?(@.configurationName=='TeraDataDBCataloger_V16')].status |

  @jdbc
  Scenario: SC#3-Run TeradataDBPostProcessor Plugin config with dryRun True
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                       | body                                | response code | response message                | jsonPath                                                             |
      | application/json |       |       | Get          | settings/analyzers/TeradataDBPostProcessor                                                                |                                     | 200           | TeradataPostProcessorDryRunTrue |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/lineage/TeradataDBPostProcessor/TeradataPostProcessorDryRunTrue |                                     | 200           | IDLE                            | $.[?(@.configurationName=='TeradataPostProcessorDryRunTrue')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/lineage/TeradataDBPostProcessor/TeradataPostProcessorDryRunTrue  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                                 |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/lineage/TeradataDBPostProcessor/TeradataPostProcessorDryRunTrue |                                     | 200           | IDLE                            | $.[?(@.configurationName=='TeradataPostProcessorDryRunTrue')].status |

  @webtest @positive
  Scenario: SC#3_Verify the TeradataDBPostprocessor Plugin Processed Items for TeradataDB with dryRun True
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeradataPostProcessorDryRunTrue" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/TeradataDBPostProcessor/TeradataPostProcessorDryRunTrue%"
    Then Analysis log "lineage/TeradataDBPostProcessor/TeradataPostProcessor%" should display below info/error/warning
      | type | logValue                                               | logCode       | pluginName              | removableText |
      | INFO | Plugin TeradataDBPostProcessor running on dry run mode | ANALYSIS-0069 | TeradataDBPostProcessor |               |

  Scenario: SC#3: Delete the analysis item of TeradataDBPostProcessor with dryRun true
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | MultipleIDDelete | Default | lineage/TeradataDBPostProcessor/Tera% | Analysis |       |       |

  @jdbc
  Scenario: SC#4-Run TeradataDBPostProcessor Plugin config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body                                | response code | response message        | jsonPath                                                     |
      | application/json |       |       | Get          | settings/analyzers/TeradataDBPostProcessor                                                        |                                     | 200           | TeradataDBPostProcessor |                                                              |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/lineage/TeradataDBPostProcessor/TeradataDBPostProcessor |                                     | 200           | IDLE                    | $.[?(@.configurationName=='TeradataDBPostProcessor')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/lineage/TeradataDBPostProcessor/TeradataDBPostProcessor  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                         |                                                              |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/lineage/TeradataDBPostProcessor/TeradataDBPostProcessor |                                     | 200           | IDLE                    | $.[?(@.configurationName=='TeradataDBPostProcessor')].status |

  #################################Verify Processed count, items and Logging enhancement for Oracle19cPDB##################################################################

  @webtest @positive
  Scenario: SC#5_Verify the TeradataDBPostprocessor Plugin Processed Items for TeradataDB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataDBPostProcessor" and clicks on search
    And user performs "facet selection" in "SC1TeradataDBPostProcessor" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/TeradataDBPostProcessor/TeradataDBPostProcessor%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | didtde01v.did.dev.asgint.loc |
      | Teradata:6666                |
    Then Analysis log "lineage/TeradataDBPostProcessor/TeradataDBPostProcessor%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | logCode       | pluginName              | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0019 |                         |                |
      | INFO | Plugin Name:TeradataDBPostProcessor, Plugin Type:lineage, Plugin Version:1.1.0, Node Name:InternalNode, Host Name:b1ac712a600e, Plugin Configuration name:TeradataDBPostProcessor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | TeradataDBPostProcessor | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: ---  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: name: "TeradataDBPostProcessor"  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: pluginVersion: "LATEST"  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: label:  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: : ""  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: catalogName: "Default"  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: eventClass: null  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: eventCondition: null  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: nodeCondition: "name==\"InternalNode\""  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: maxWorkSize: 100  2020-10-19 08:11:27.255 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: tags:  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: - "SC1TeradataDBPostProcessor"  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: pluginType: "lineage"  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: dataSource: null  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: credential: null  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: businessApplicationName: null  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: dryRun: false  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: schedule: null  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: filter: null  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: pluginName: "TeradataDBPostProcessor"  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: arguments: []  2020-10-19 08:11:27.256 INFO  - ANALYSIS-0073: Plugin TeradataDBPostProcessor Configuration: type: "Lineage" | ANALYSIS-0073 | TeradataDBPostProcessor |                |
      | INFO | Plugin TeradataDBPostProcessor Start Time:2020-08-14 08:09:47.885, End Time:2020-08-14 08:09:49.752, Processed Count:2, Errors:0, Warnings:1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | TeradataDBPostProcessor |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:14.531)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0020 |                         |                |

  #6739918# #6739917# #6739916# #6739915# #6746078# #6746079# #6754477# #6754482#
  Scenario:SC#6_user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name               | asg_scopeid | targetFile                                                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TAB_TO_TAB1        |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | VIEW_TO_TABLE1     |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TAB_TO_FUNC1       |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | VIEWTOTABLEDYNAMIC |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TAB_TAB_NOVARS1    |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | JOIN_TO_SINGLE     |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | EMP_JOIN_INDEX     |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                          | path                                 | response code | response message | jsonPath | targetFile                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs.json | $.lineagePayLoads.TAB_TO_TAB1        | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs.json | $.lineagePayLoads.VIEW_TO_TABLE1     | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs.json | $.lineagePayLoads.TAB_TO_FUNC1       | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs.json | $.lineagePayLoads.VIEWTOTABLEDYNAMIC | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs.json | $.lineagePayLoads.TAB_TAB_NOVARS1    | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs.json | $.lineagePayLoads.JOIN_TO_SINGLE     | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs.json | $.lineagePayLoads.EMP_JOIN_INDEX     | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                        | JsonPath           |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops.json | TAB_TO_TAB1        |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops.json | VIEW_TO_TABLE1     |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops.json | TAB_TO_FUNC1       |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops.json | VIEWTOTABLEDYNAMIC |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops.json | TAB_TAB_NOVARS1    |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops.json | JOIN_TO_SINGLE     |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops.json | EMP_JOIN_INDEX     |

  Scenario Outline:SC#7_user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                        | actualJson                                                                                      |
      | Constant.REST_DIR/response/TeradataPostProcessor/expectedJsonFiles/expectedTeradataLineageHops.json | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops.json |

  Scenario: SC#7: Delete the items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%   | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/TeradataDBPostProcessor/Tera% | Analysis |       |       |

  @jdbc
  Scenario: SC#8-Run TeradataDBCataloger Plugin config for multiple server scenario
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                       | body                                | response code | response message | jsonPath                                                                  |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_MultiServer1_V16 |                                     | 200           | IDLE             | $.[?(@.configurationName=='TeraDataDBCataloger_MultiServer1_V16')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_MultiServer1_V16  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                  |                                                                           |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_MultiServer1_V16 |                                     | 200           | IDLE             | $.[?(@.configurationName=='TeraDataDBCataloger_MultiServer1_V16')].status |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_MultiServer2_V15 |                                     | 200           | IDLE             | $.[?(@.configurationName=='TeraDataDBCataloger_MultiServer2_V15')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_MultiServer2_V15  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                  |                                                                           |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataDBCataloger_MultiServer2_V15 |                                     | 200           | IDLE             | $.[?(@.configurationName=='TeraDataDBCataloger_MultiServer2_V15')].status |

  @jdbc
  Scenario: SC#9-Run TeradataDBPostProcessor Plugin config for multiple server scenario
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body                                | response code | response message        | jsonPath                                                     |
      | application/json |       |       | Get          | settings/analyzers/TeradataDBPostProcessor                                                        |                                     | 200           | TeradataDBPostProcessor |                                                              |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/lineage/TeradataDBPostProcessor/TeradataDBPostProcessor |                                     | 200           | IDLE                    | $.[?(@.configurationName=='TeradataDBPostProcessor')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/lineage/TeradataDBPostProcessor/TeradataDBPostProcessor  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                         |                                                              |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/lineage/TeradataDBPostProcessor/TeradataDBPostProcessor |                                     | 200           | IDLE                    | $.[?(@.configurationName=='TeradataDBPostProcessor')].status |

  #6746067# #6746068#
  Scenario:SC#10_user get all lineage hops id,s and get the source target value from database for multiple server scenario
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name               | asg_scopeid | targetFile                                                            | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TAB_TO_FUNC1       |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs_SC2.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | VIEW_TO_TABLE1     |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs_SC2.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | TAB_TO_FUNC1_V15   |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs_SC2.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | VIEW_TO_TABLE1_V15 |             | response/TeradataPostProcessor/actualJsonFiles/lineageHopIDs_SC2.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                              | path                                 | response code | response message | jsonPath | targetFile                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs_SC2.json | $.lineagePayLoads.TAB_TO_FUNC1       | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops_SC2.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs_SC2.json | $.lineagePayLoads.VIEW_TO_TABLE1     | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops_SC2.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs_SC2.json | $.lineagePayLoads.TAB_TO_FUNC1_V15   | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops_SC2.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\TeradataPostProcessor\actualJsonFiles\lineageHopIDs_SC2.json | $.lineagePayLoads.VIEW_TO_TABLE1_V15 | 200           |                  | edges    | response\TeradataPostProcessor\actualJsonFiles\actualTeradataLineageHops_SC2.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                            | JsonPath           |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops_SC2.json | TAB_TO_FUNC1       |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops_SC2.json | VIEW_TO_TABLE1     |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops_SC2.json | TAB_TO_FUNC1_V15   |
      | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops_SC2.json | VIEW_TO_TABLE1_V15 |

  Scenario Outline:SC#11_user compares the expected lineage data and actual lineage data for multiple server scenario
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                            | actualJson                                                                                          |
      | Constant.REST_DIR/response/TeradataPostProcessor/expectedJsonFiles/expectedTeradataLineageHops_SC2.json | Constant.REST_DIR/response/TeradataPostProcessor/actualJsonFiles/actualTeradataLineageHops_SC2.json |

  Scenario: SC#11: Delete the items for multiple server scenario
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc          | Cluster  |       |       |
      | SingleItemDelete | Default | 10.33.6.190                           | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%   | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/TeradataDBPostProcessor/Tera% | Analysis |       |       |

  @jdbc
  Scenario: SC#12-Drop Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema | Table        | Database  |
      | teradata_db16      | DROP      |        | Target_Table | collector |

  @jdbc
  Scenario: SC#13-Drop Table ,Values and Database in Teradata
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | dropJoinIndex  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | deleteDatabase |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | dropDatabase   |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | deleteDatabase |
      | teradata           | EXECUTEQUERY | json/IDA.json | TeraDataPostQueries | dropDatabase   |

  @jdbc
  Scenario: SC#14-Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/TeradataDB_Credentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/TeradataDBDataSource     |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/TeradataDBCataloger      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/TeradataDBPostProcessor  |      | 204           |                  |          |
