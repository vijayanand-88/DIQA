Feature: Validation of Java JDBC Lineage plugin functionality after running Git, Java parser and Java Lineage plugins

  ############################################# Pre Conditions ##########################################################
  @jdbc
  Scenario: SC#1-Create Required tables for Oracle DB Cataloger
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                   | queryField    |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable1  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | insertRecord4 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | insertRecord5 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable2  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable3  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable4  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | insertRecord1 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | insertRecord2 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | insertRecord3 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable5  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable6  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable7  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | insertRecord6 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | insertRecord7 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable8  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable9  |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable10 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable11 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable12 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable13 |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | ORACLE12CQueriesforJavaJDBC | createTable14 |

  @git @oracle @precondition
  Scenario: SC#1-Update Git and Oracle credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                             | username                   | password                   |
      | ida/javaJDBCPayloads/javaJDBCLineageCredentials.json | $.gitCredentials..userName | $.gitCredentials..password |
    And User update the below "oracle12c credentials" in following files using json path
      | filePath                                             | username                      | password                      |
      | ida/javaJDBCPayloads/javaJDBCLineageCredentials.json | $.oracleCredentials..userName | $.oracleCredentials..password |

  @sanity @positive @regression
  Scenario Outline: SC#1-Set the Credentials and Datasources for Git and Oracle
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                | bodyFile                                                              | path                     | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentialsJJ                      | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineageCredentials.json | $.validEDIBusCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentialsJJ                         | payloads/ida/javaJDBCPayloads/javaJDBCLineageCredentials.json         | $.gitCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidOracleDBCredentialsJJ                    | payloads/ida/javaJDBCPayloads/javaJDBCLineageCredentials.json         | $.oracleCredentials      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJJ | payloads/ida/javaJDBCPayloads/javaJDBCLineageDataSources.json         | $.gitCollectorDataSource | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource/OracleDBDataSourceJJ         | payloads/ida/javaJDBCPayloads/javaJDBCLineageDataSources.json         | $.oracleDBDataSource     | 204           |                  |          |

  #7083641#
  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1-Create Business Application tag for Java JDBC Lineage test for Oracle Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                        | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaJDBCPayloads/JavaJDBCOracle_BA.json | 200           |                  |          |

  ############################################# PluginRun ##########################################################
  @MLP-13988 @sanity @positive @regression
  Scenario Outline: SC#2-Configure the data source and plugin config for Git, Oracle DB Cataloger, Java Parser, Java Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                | body                                                | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource/OracleDBDataSourceJJ         |                                                     | 200           | OracleDBDataSourceJJ     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJJ |                                                     | 200           | GitCollectorDataSourceJJ |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBCataloger/OracleDBCatalogerJJ           | ida/javaJDBCPayloads/java13988_oracleDBcatalog.json | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBCataloger/OracleDBCatalogerJJ           |                                                     | 200           | OracleDBCatalogerJJ      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollectorJJ                     | ida/javaJDBCPayloads/GitCollector.json              | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollectorJJ                     |                                                     | 200           | GitCollectorJJ           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser/JavaParserJJ                         | ida/javaJDBCPayloads/java13988_parser.json          | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser/JavaParserJJ                         |                                                     | 200           | JavaParserJJ             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaLinker/JavaLinkerJJ                         | ida/javaJDBCPayloads/java13988_linker.json          | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaLinker/JavaLinkerJJ                         |                                                     | 200           | JavaLinkerJJ             |          |

  @MLP-13988 @sanity @positive @regression
  Scenario Outline: SC#2-Run the Plugin configurations for Oracle DB Cataloger, Git, Java Parser, Java Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                            | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCatalogerJJ |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleDBCatalogerJJ')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCatalogerJJ  | ida/javaJDBCPayloads/empty.json | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCatalogerJJ |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleDBCatalogerJJ')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJJ           |                                 | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorJJ')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJJ            | ida/javaJDBCPayloads/empty.json | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJJ           |                                 | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorJJ')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJJ                  |                                 | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJJ')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParserJJ                   | ida/javaJDBCPayloads/empty.json | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJJ                  |                                 | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJJ')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinkerJJ                  |                                 | 200           | IDLE             | $.[?(@.configurationName=='JavaLinkerJJ')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaLinker/JavaLinkerJJ                   | ida/javaJDBCPayloads/empty.json | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinkerJJ                  |                                 | 200           | IDLE             | $.[?(@.configurationName=='JavaLinkerJJ')].status        |

  ############################################# PluginRun - DryRunTrue ##########################################################
  @MLP-13988 @sanity @positive @regression
  Scenario Outline: SC#3-Configure and run the plugin config for JavaJDBCLineage with dryRun true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                       | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJDryRun                            | ida/javaJDBCPayloads/java13988_jdbclineage_dryRunTrue.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJDryRun                            |                                                            | 200           | JavaJDBCLineageJJDryRun |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJDryRun |                                                            | 200           | IDLE                    | $.[?(@.configurationName=='JavaJDBCLineageJJDryRun')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJDryRun  | ida/javaJDBCPayloads/empty.json                            | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJDryRun |                                                            | 200           | IDLE                    | $.[?(@.configurationName=='JavaJDBCLineageJJDryRun')].status |

  Scenario Outline: SC#3-RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                | type | targetFile                                               | jsonpath                       |
      | APPDBPOSTGRES | Default | lineage/JavaJDBCLineage/JavaJDBCLineageJJDryRun%DYN |      | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..JavaJDBCLineage_Analysis.id |

  #7083641#
  @webtest @MLP-13988 @sanity @positive @regression
  Scenario: SC#3:UI_Validation: Verify JavaJDBCLineage plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaJDBCLinOracleDryRun" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaJDBCLineage/JavaJDBCLineageJJDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 3             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaJDBCLineage/JavaJDBCLineageJJDryRun%" should display below info/error/warning
      | type | logValue                                       | logCode       | pluginName | removableText |
      | INFO | Plugin JavaJDBCLineage running on dry run mode | ANALYSIS-0069 |            |               |

  Scenario Outline: SC#3:ItemDeletion: User deletes the JavaJDBCLineage analysis item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                      | inputFile                                                |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JavaJDBCLineage_Analysis.id | response/java/javaJDBCLineage/oracle/actual/itemIds.json |

  @sanity @positive @regression
  Scenario Outline: SC#3-Delete Configurations the following Plugins for JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaJDBCLineage |      | 204           |                  |          |

  ############################################# PluginRun - DryRun False ##########################################################
  @MLP-13988 @sanity @positive @regression
  Scenario Outline: SC#2-Configure and run the plugin config for JavaJDBCLineage with dryRun false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body                                            | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJ                            | ida/javaJDBCPayloads/java13988_jdbclineage.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJ                            |                                                 | 200           | JavaJDBCLineageJJ |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJ |                                                 | 200           | IDLE              | $.[?(@.configurationName=='JavaJDBCLineageJJ')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJ  | ida/javaJDBCPayloads/empty.json                 | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJ |                                                 | 200           | IDLE              | $.[?(@.configurationName=='JavaJDBCLineageJJ')].status |

  Scenario Outline: SC#2-RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                | type    | targetFile                                               | jsonpath                       |
      | APPDBPOSTGRES | Default | javaspark_lineage                                   | Project | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..Project.id                  |
      | APPDBPOSTGRES | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                     |         | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..Oracle_Cluster.id           |
      | APPDBPOSTGRES | Default | test_BA_JavaJDBCOracle                              |         | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..has_BA.id                   |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJJ%DYN           |         | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..Git_Analysis.id             |
      | APPDBPOSTGRES | Default | cataloger/OracleDBCataloger/OracleDBCatalogerJJ%DYN |         | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..Oracle_Analysis.id          |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJJ%DYN                  |         | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..JParser_Analysis.id         |
      | APPDBPOSTGRES | Default | linker/JavaLinker/JavaLinkerJJ%DYN                  |         | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..JLinker_Analysis.id         |
      | APPDBPOSTGRES | Default | lineage/JavaJDBCLineage/JavaJDBCLineageJJ%DYN       |         | response/java/javaJDBCLineage/oracle/actual/itemIds.json | $..JavaJDBCLineage_Analysis.id |

  ############################################# LoggingEnhancements #############################################
  #7083641#
  @sanity @positive @MLP-13988 @webtest
  Scenario: SC#4 Verify JavaJDBCLineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaJDBCLinOracle" and clicks on search
    And user performs "facet selection" in "tagJavaJDBCLinOracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaJDBCLineage/JavaJDBCLineageJJ/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 30            | Description |
      | Number of errors          | 3             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaJDBCLineage/JavaJDBCLineageJJ/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:JavaJDBCLineage, Plugin Type:lineage, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:840f1e9fbae4, Plugin Configuration name:JavaJDBCLineageJJ                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0071 | JavaJDBCLineage | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: ---  2020-08-13 10:17:42.132 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: name: "JavaJDBCLineageJJ"  2020-08-13 10:17:42.132 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: pluginVersion: "LATEST"  2020-08-13 10:17:42.132 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: label:  2020-08-13 10:17:42.132 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: : "JavaJDBCLineageJJ"  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: catalogName: "Default"  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: eventClass: null  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: eventCondition: null  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: nodeCondition: null  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: maxWorkSize: 100  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: tags:  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: - "tagJavaJDBCLinOracle"  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: pluginType: "lineage"  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: dataSource: null  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: credential: null  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: businessApplicationName: "test_BA_JavaJDBCOracle"  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: dryRun: false  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: schedule: null  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: runAfter: []  2020-08-13 10:17:42.133 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: filter: null | ANALYSIS-0073 | JavaJDBCLineage |                |
      | INFO | Plugin JavaJDBCLineage Start Time:2020-05-27 05:59:59.126, End Time:2020-05-27 06:00:25.097, Processed Count:30, Errors:3, Warnings:610                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0072 | JavaJDBCLineage |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0020 |                 |                |
#
  ####################### API Lineage verification #############################################
  @MLP-13988 @regression @positive
  Scenario Outline:SC#5:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive               | catalog | type       | name                                              | asg_scopeid | targetFile                                                                        | jsonpath                |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertFunction1                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_1.json               |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_1.json               |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMP]                         |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_1.json               | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_1.json               | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertFunction1                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_2.json               |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_2.json               |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1]                       |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_2.json               | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_2.json               | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertSubQuery                                    |             | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_1.json                |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_1.json                |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMP, QAEMPID]                |             | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_1.json                | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_1.json                | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertSubQuery                                    |             | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_2.json                |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_2.json                |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP4]                       |             | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_2.json                | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_2.json                | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertFunction3                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_1.json               |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_1.json               |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP3]                       |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_1.json               | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_1.json               | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertFunction3                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_2.json               |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_2.json               |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMP]                         |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_2.json               | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_2.json               | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | CaseSensitivity1                                  |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_1.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_1.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP3]                       |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_1.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_1.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | CaseSensitivity1                                  |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_2.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_2.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[qaempsmall]                    |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_2.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_2.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | CaseSensitivity2                                  |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_1.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_1.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[qasmallsource]                 |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_1.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_1.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | CaseSensitivity2                                  |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_2.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_2.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[qasmalltarget]                |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_2.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_2.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SynonymProg8                                      |             | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_1.json                  |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_1.json                  |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[EMPX]                          |             | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_1.json                  | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_1.json                  | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SynonymProg8                                      |             | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_2.json                  |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_2.json                  |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1]                       |             | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_2.json                  | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_2.json                  | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | AliasProg9                                        |             | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_1.json                    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_1.json                    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[EMPY]                          |             | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_1.json                    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_1.json                    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | AliasProg9                                        |             | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_2.json                    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_2.json                    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1]                       |             | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_2.json                    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_2.json                    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | UpdateProg5                                       |             | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_1.json                   |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_1.json                   |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPUPDATE]                   |             | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_1.json                   | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_1.json                   | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | UpdateProg5                                       |             | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_2.json                   |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_2.json                   |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP5]                       |             | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_2.json                   | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_2.json                   | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DeleteProg6                                       |             | response/java/javaJDBCLineage/oracle/Lineage/DeleteProg6.json                     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/DeleteProg6.json                     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPUPDATE]                   |             | response/java/javaJDBCLineage/oracle/Lineage/DeleteProg6.json                     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/DeleteProg6.json                     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateGetWithDifferentNames                     |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_1.json |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                      |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_1.json |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_STMT_1_[QAEMP]                 |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_1.json | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_1.json | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateGetWithDifferentNames                     |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_2.json |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_2.json |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1]                       |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_2.json | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_2.json | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateGetWithSameNames                          |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_1.json      |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                      |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_1.json      |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_STMT_1_[qasmallsource]         |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_1.json      | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_1.json      | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateGetWithSameNames                          |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_2.json      |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_2.json      |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[qasmalltarget]                |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_2.json      | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_2.json      | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | GetWithConstants                                  |             | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_1.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                      |             | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_1.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_STMT_1_[QAEMP]                 |             | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_1.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_1.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | GetWithConstants                                  |             | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_2.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | write                                             |             | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_2.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | write_SQL_U_PSTMT_1_[QAEMP1]                      |             | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_2.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_2.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetWithDiffFunction                            |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithDiffFunction.json          |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | runRowSet                                         |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithDiffFunction.json          |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | runRowSet_SQL_Q_ROWSET_1_[QAEMP5]                 |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithDiffFunction.json          | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithDiffFunction.json          | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetWithMain                                    |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithMain.json                  |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithMain.json                  |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_ROWSET_1_[QAEMP]                       |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithMain.json                  | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithMain.json                  | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetInsert                                      |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_1.json                  |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_1.json                  |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_ROWSET_1_[QAEMP]                       |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_1.json                  | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_1.json                  | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetInsert                                      |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_2.json                  |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_2.json                  |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1]                       |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_2.json                  | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_2.json                  | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateGetAndSet                                 |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetAndSet.json               |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                      |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetAndSet.json               |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_STMT_1_[QAEMPUPDATE]           |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetAndSet.json               | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetAndSet.json               | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DirectLineageSt                                   |             | response/java/javaJDBCLineage/oracle/Lineage/DirectLineageSt.json                 |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/DirectLineageSt.json                 |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_STMT_1_[QAEMP, QAEMP4, QAEMP1]         |             | response/java/javaJDBCLineage/oracle/Lineage/DirectLineageSt.json                 | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/DirectLineageSt.json                 | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DirectLineagePrep                                 |             | response/java/javaJDBCLineage/oracle/Lineage/DirectLineagePrep.json               |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/DirectLineagePrep.json               |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMPID, QAEMP5]              |             | response/java/javaJDBCLineage/oracle/Lineage/DirectLineagePrep.json               | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/DirectLineagePrep.json               | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DirLineagePrepwithRes                             |             | response/java/javaJDBCLineage/oracle/Lineage/DirLineagePrepwithRes.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/DirLineagePrepwithRes.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[qasmalltarget, qasmallsource] |             | response/java/javaJDBCLineage/oracle/Lineage/DirLineagePrepwithRes.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/DirLineagePrepwithRes.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DirLinWildCard                                    |             | response/java/javaJDBCLineage/oracle/Lineage/DirLinWildCard.json                  |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                              |             | response/java/javaJDBCLineage/oracle/Lineage/DirLinWildCard.json                  |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_STMT_1_[qaempsmall, QAINS]             |             | response/java/javaJDBCLineage/oracle/Lineage/DirLinWildCard.json                  | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                                   |             | response/java/javaJDBCLineage/oracle/Lineage/DirLinWildCard.json                  | $.tableIDinsideFunction |

  @MLP-13988 @regression @positive
  Scenario Outline: SC#5:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get multiple source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                            | inputFile                                                                         | outputFile                                                                          |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertFunction1_1               | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_1.json               | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertFunction1_2               | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction1_2.json               | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertSubQuery_1                | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_1.json                | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertSubQuery_2                | response/java/javaJDBCLineage/oracle/Lineage/InsertSubQuery_2.json                | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertFunction3_1               | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_1.json               | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertFunction3_2               | response/java/javaJDBCLineage/oracle/Lineage/InsertFunction3_2.json               | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | CaseSensitivity1_1              | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_1.json              | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | CaseSensitivity1_2              | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity1_2.json              | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | CaseSensitivity2_1              | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_1.json              | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | CaseSensitivity2_2              | response/java/javaJDBCLineage/oracle/Lineage/CaseSensitivity2_2.json              | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SynonymProg8_1                  | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_1.json                  | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SynonymProg8_2                  | response/java/javaJDBCLineage/oracle/Lineage/SynonymProg8_2.json                  | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AliasProg9_1                    | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_1.json                    | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AliasProg9_2                    | response/java/javaJDBCLineage/oracle/Lineage/AliasProg9_2.json                    | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | UpdateProg5_1                   | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_1.json                   | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | UpdateProg5_2                   | response/java/javaJDBCLineage/oracle/Lineage/UpdateProg5_2.json                   | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DeleteProg6                     | response/java/javaJDBCLineage/oracle/Lineage/DeleteProg6.json                     | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateGetWithDifferentNames_1 | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_1.json | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateGetWithDifferentNames_2 | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithDifferentNames_2.json | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateGetWithSameNames_1      | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_1.json      | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateGetWithSameNames_2      | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetWithSameNames_2.json      | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | GetWithConstants_1              | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_1.json              | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | GetWithConstants_2              | response/java/javaJDBCLineage/oracle/Lineage/GetWithConstants_2.json              | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetWithDiffFunction          | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithDiffFunction.json          | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetWithMain                  | response/java/javaJDBCLineage/oracle/Lineage/RowsetWithMain.json                  | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetInsert_1                  | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_1.json                  | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetInsert_2                  | response/java/javaJDBCLineage/oracle/Lineage/RowsetInsert_2.json                  | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateGetAndSet               | response/java/javaJDBCLineage/oracle/Lineage/SeparateGetAndSet.json               | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DirectLineageSt                 | response/java/javaJDBCLineage/oracle/Lineage/DirectLineageSt.json                 | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DirectLineagePrep               | response/java/javaJDBCLineage/oracle/Lineage/DirectLineagePrep.json               | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DirLineagePrepwithRes           | response/java/javaJDBCLineage/oracle/Lineage/DirLineagePrepwithRes.json           | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DirLinWildCard                  | response/java/javaJDBCLineage/oracle/Lineage/DirLinWildCard.json                  | response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json |

  #6805722# #6805723# #6805724# #6805725# #6805728# #6806460# #6833527# #6833528# #6833530# #6833531#
  #6805726# #6805727# #6805724# #6805725# #6805729# #6805730# #6863355# #6863356# #6866891#
  #6805724# #6805725# #6833528# #6833527# #6833530# #6833532#
  #6805728# #6805723# #6904099# #6904102# #6904100# #6904101# #6904103#
  @MLP-13988 @regression @positive
  Scenario Outline: SC#5:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                           | actual_json                                                                                           | item                            |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | InsertFunction1_1               |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | InsertFunction1_2               |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | InsertSubQuery_1                |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | InsertSubQuery_2                |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | InsertFunction3_1               |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | InsertFunction3_2               |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | CaseSensitivity1_1              |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | CaseSensitivity1_2              |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | CaseSensitivity2_1              |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | CaseSensitivity2_2              |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | SynonymProg8_1                  |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | SynonymProg8_2                  |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | AliasProg9_1                    |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | AliasProg9_2                    |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | UpdateProg5_1                   |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | UpdateProg5_2                   |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | DeleteProg6                     |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | SeparateGetWithDifferentNames_1 |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | SeparateGetWithDifferentNames_2 |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | SeparateGetWithSameNames_1      |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | SeparateGetWithSameNames_2      |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | GetWithConstants_1              |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | GetWithConstants_2              |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | RowsetWithDiffFunction          |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | RowsetWithMain                  |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | RowsetInsert_1                  |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | RowsetInsert_2                  |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | SeparateGetAndSet               |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | DirectLineageSt                 |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | DirectLineagePrep               |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | DirLineagePrepwithRes           |
      | ida/javaJDBCPayloads/expectedJavaJDBCLineageOracle.json | Constant.REST_DIR/response/java/javaJDBCLineage/oracle/Lineage/JavaJDBCLineageOracleSourceTarget.json | DirLinWildCard                  |

  #6805729#
  @webtest @MLP-13988 @sanity @positive
  Scenario: SC#6-Verify the Java JDBC plugin generates lineage for the java file stored in Git repository for a Java JDBC Join from 2 tables
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaJDBCLinOracle" and clicks on search
    And user performs "facet selection" in "tagJavaJDBCLinOracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "GetFromTwoTables" item from search results
    Then user performs click and verify in new window
      | Table        | value                        | Action                 | RetainPrevwindow | indexSwitch |
      | Functions    | main                         | click and switch tab   | No               |             |
      | Tables       | main_SQL_U_PSTMT_1_[QAJOIN3] | click and switch tab   | Yes              |             |
      | Lineage Hops | set_1 => FNAME               | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value          | Action                       | RetainPrevwindow | indexSwitch | filePath                                                  | jsonPath       |
      | Lineage Hops | set_1 => FNAME | click and verify lineagehops | Yes              | 0           | ida/javaJDBCPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_1 |
      | Lineage Hops | set_2 => LNAME | click and verify lineagehops | Yes              | 0           | ida/javaJDBCPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_2 |
      | Lineage Hops | set_3 => ID    | click and verify lineagehops | Yes              | 0           | ida/javaJDBCPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_3 |
      | Lineage Hops | set_4 => AGE   | click and verify lineagehops | Yes              | 0           | ida/javaJDBCPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_4 |
    Then user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table        | value                                           | Action                 | RetainPrevwindow | indexSwitch |
      | Tables       | main_SQL_Q_STMT_1_[QAJOIN1, QAJOIN2]            | click and switch tab   | Yes              |             |
      | Lineage Hops | main_SQL_Q_STMT_1_[QAJOIN1, QAJOIN2] => CONTROL | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value                                           | Action                       | RetainPrevwindow | indexSwitch | filePath                                                  | jsonPath       |
      | Lineage Hops | main_SQL_Q_STMT_1_[QAJOIN1, QAJOIN2] => CONTROL | click and verify lineagehops | Yes              | 0           | ida/javaJDBCPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_5 |


  ############################################# Technology tags verification #############################################
  #7083641#
  @webtest @MLP-13988 @sanity @positive
  Scenario: SC#7-Verify the technology tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                   | fileName                        | userTag              |
      | Default     | Project    | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Git,Java  | javaspark_lineage               | tagJavaJDBCLinOracle |
      | Default     | Schema     | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Oracle    | COLLECTOR                       | tagJavaJDBCLinOracle |
      | Default     | Database   | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Oracle    | ORACLE12                        | tagJavaJDBCLinOracle |
      | Default     | Service    | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Oracle    | ORACLE:1521                     | tagJavaJDBCLinOracle |
      | Default     | Cluster    | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Oracle    | DIDORACLE01V.DID.DEV.ASGINT.LOC | tagJavaJDBCLinOracle |
      | Default     | Namespace  | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Java      | com                             | tagJavaJDBCLinOracle |
      | Default     | Directory  | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Git       | javajdbclineage                 | tagJavaJDBCLinOracle |
      | Default     | SourceTree | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Java      | DirLinWildCard                  | DirLinWildCard       |
      | Default     | Class      | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Java      | DirLinWildCard                  | DirLinWildCard       |
      | Default     | Function   | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Java,JDBC | runRowSet                       | runRowSet            |
      | Default     | File       | Metadata Type | tagJavaJDBCLinOracle,test_BA_JavaJDBCOracle,Git,Java  | DirLinWildCard.java             | DirLinWildCard.java  |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                        | fileName            | userTag             |
      | Default     | File | Metadata Type | Programming,Source Control | DirLinWildCard.java | DirLinWildCard.java |

#  ############################################# EDIBusVerification #############################################
#  #7083641#
#  @sanity @positive @webtest @edibus
#  Scenario: SC#8:EDIBusVerification: Verify EDI replication for items collected using JavaJDBCLineage
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea    | subjectAreaVersion | query                                      |
#      | AP-DATA      | JAVAJDBCORACLE | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/JavaJDBCLineageOracleEDIConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                       | body                                                              | response code | response message | jsonPath                                                  |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                       | idc/EdiBusPayloads/datasource/EDIBusDS_JavaJDBCLineageOracle.json | 204           |                  |                                                           |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/JavaJDBCLineageOracleEDIConfig.json            | 204           |                  |                                                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaJDBCOracle |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaJDBCOracle')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJavaJDBCOracle  |                                                                   | 200           |                  |                                                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaJDBCOracle |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaJDBCOracle')].status |
#    And user enters the search text "EDIBusJavaJDBCOracle" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "dynamic item click" on "EDIBusJavaJDBCOracle" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea    | subjectAreaVersion | query                                                                                | itemCount |
#      | AP-DATA      | JAVAJDBCORACLE | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 148       |

  ############################################# Post Conditions ##########################################################
  @jdbc
  Scenario: SC#9-Delete required tables in Oracle DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema    | Database  | Table           |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAEMP           |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAEMP1          |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAEMP3          |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAEMP4          |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAEMP5          |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAEMPID         |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAEMPUPDATE     |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAINS           |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAJOIN1         |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAJOIN2         |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | QAJOIN3         |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | "qasmallsource" |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | "qasmalltarget" |
      | ORACLE12C          | DROP      | COLLECTOR | ORACLE12C | "qaempsmall"    |

  @cr-data @postcondition @sanity @positive
  Scenario Outline: SC#9:ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                      | inputFile                                                |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                  | response/java/javaJDBCLineage/oracle/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Oracle_Cluster.id           | response/java/javaJDBCLineage/oracle/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                   | response/java/javaJDBCLineage/oracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id             | response/java/javaJDBCLineage/oracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Oracle_Analysis.id          | response/java/javaJDBCLineage/oracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id         | response/java/javaJDBCLineage/oracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JLinker_Analysis.id         | response/java/javaJDBCLineage/oracle/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaJDBCLineage_Analysis.id | response/java/javaJDBCLineage/oracle/actual/itemIds.json |

  Scenario: SC#9:Delete all the External Packages with respect to Java JDBC Lineage
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type            | query | param |
      | MultipleIDDelete | Default |      | ExternalPackage |       |       |

  @sanity @positive @regression
  Scenario Outline: SC#9-Delete Configurations the following Plugins for Git, MSSQL Cataloger, Java Parser, Java Linker, JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentialsJJ      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidOracleDBCredentialsJJ |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusValidCredentialsJJ   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource           |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBusDataSource             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaLinker                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaJDBCLineage              |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBus                       |      | 204           |                  |          |
