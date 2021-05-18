@MLP-24751
Feature: Validation of Java JDBC Lineage plugin functionality after running Git, Java parser and Java Lineage plugins

  ############################################# Pre Conditions ##########################################################
  @jdbc
  Scenario: SC#1-Create Required tables for Redshift DB Cataloger
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                  | queryField    |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createSchema  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable1  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | insertRecord4 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | insertRecord5 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable2  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable3  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable4  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | insertRecord1 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | insertRecord2 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | insertRecord3 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable5  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable6  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable7  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | insertRecord6 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | insertRecord7 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable8  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable9  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable10 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable11 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable12 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable13 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable14 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable15 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable16 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable17 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable18 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable19 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable20 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable21 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable22 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable23 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable24 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable25 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable26 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable27 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable28 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable29 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable30 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | createTable31 |

  @precondition
  Scenario: SC#1-Update Git and Redshift credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                     | username                   | password                   |
      | ida/javaJDBCRedshiftPayloads/javaJDBCLineageCredentials.json | $.gitCredentials..userName | $.gitCredentials..password |
    And User update the below "redshift credentials" in following files using json path
      | filePath                                                     | username                        | password                        |
      | ida/javaJDBCRedshiftPayloads/javaJDBCLineageCredentials.json | $.redshiftCredentials..userName | $.redshiftCredentials..password |

  @sanity @positive @regression
  Scenario Outline: SC#1-Set the Credentials and Datasources for Git and Redshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                     | bodyFile                                                              | path                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentialsJJR                          | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineageCredentials.json | $.validEDIBusCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentialsJJR                             | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineageCredentials.json | $.gitCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidRedshiftDBCredentialsJJR                      | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineageCredentials.json | $.redshiftCredentials            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                               | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineageDataSources.json | $.gitCollectorDataSource_default | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource                             | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineageDataSources.json | $.redshiftDBDataSource_default   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJJR     | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineageDataSources.json | $.gitCollectorDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSourceJJR | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineageDataSources.json | $.redshiftDBDataSource           | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJJR     |                                                                       |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSourceJJR |                                                                       |                                  | 200           |                  |          |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1-Create Business Application tag for Java JDBC Lineage test for Redshift Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaJDBCRedshiftPayloads/JavaJDBCRedshift_BA.json | 200           |                  |          |

  ############################################# PluginRun ##########################################################
  Scenario Outline: SC#2-Configure Catalogers for GitCollector,  Java and Redshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                   | bodyFile                                                               | path                       | response code | response message           | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCatalogerJJR | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineagePluginConifg.json | $.RedShiftCataloger        | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCatalogerJJR |                                                                        |                            | 200           | AmazonRedshiftCatalogerJJR |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollectorJJR                       | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineagePluginConifg.json | $.GitCollector             | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollectorJJR                       |                                                                        |                            | 200           | GitCollectorJJR            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser/JavaParserJJR                           | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineagePluginConifg.json | $.JavaParser               | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser/JavaParserJJR                           |                                                                        |                            | 200           | JavaParserJJR              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaLinker/JavaLinkerJJR                           | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineagePluginConifg.json | $.JavaLinker               | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaLinker/JavaLinkerJJR                           |                                                                        |                            | 200           | JavaLinkerJJR              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaIOLinker/JavaIOLinkerJJR                       | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineagePluginConifg.json | $.JavaIOLinker             | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaIOLinker/JavaIOLinkerJJR                       |                                                                        |                            | 200           | JavaIOLinkerJJR            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJRDryRun           | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineagePluginConifg.json | $.JavaJDBCLineageDryRun    | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJRDryRun           |                                                                        |                            | 200           | JavaJDBCLineageJJRDryRun   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJR                 | payloads/ida/javaJDBCRedshiftPayloads/javaJDBCLineagePluginConifg.json | $.JavaJDBCLineageActualRun | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJR                 |                                                                        |                            | 200           | JavaJDBCLineageJJR         |          |

  @MLP-24751 @sanity @positive @regression
  Scenario Outline: SC#2-Run the Plugin configurations for Redshift Cataloger, Git, Java Parser, Java Linker, JavaIOLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | bodyFile | path | response code | response message | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCatalogerJJR |          |      | 200           | IDLE             | $.[?(@.configurationName=='AmazonRedshiftCatalogerJJR')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCatalogerJJR  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCatalogerJJR |          |      | 200           | IDLE             | $.[?(@.configurationName=='AmazonRedshiftCatalogerJJR')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJJR                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorJJR')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJJR                        |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJJR                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorJJR')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJJR                              |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJJR')].status              |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParserJJR                               |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJJR                              |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJJR')].status              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinkerJJR                              |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaLinkerJJR')].status              |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaLinker/JavaLinkerJJR                               |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinkerJJR                              |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaLinkerJJR')].status              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinkerJJR                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaIOLinkerJJR')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaIOLinker/JavaIOLinkerJJR                           |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinkerJJR                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaIOLinkerJJR')].status            |

  ############################################# PluginRun - DryRunTrue ##########################################################
  @MLP-24751 @sanity @positive @regression
  Scenario Outline: SC#3-Configure and run the plugin config for JavaJDBCLineage with dryRun true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | bodyFile | path | response code | response message | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJRDryRun |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaJDBCLineageJJRDryRun')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJRDryRun  |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJRDryRun |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaJDBCLineageJJRDryRun')].status |

  #7131877#
  @webtest @MLP-24751 @sanity @positive @regression
  Scenario: SC#3:UI_Validation: Verify JavaJDBCLineage plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JavaJDBCLineageJJRDryRun" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaJDBCLineage/JavaJDBCLineageJJRDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    Then Analysis log "lineage/JavaJDBCLineage/JavaJDBCLineageJJRDryRun%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName      | removableText |
      | INFO | Plugin JavaJDBCLineage running on dry run mode                                              | ANALYSIS-0069 | JavaJDBCLineage |               |
      | INFO | Plugin JavaJDBCLineage processed 26 items on dry run mode and not written to the repository | ANALYSIS-0070 | JavaJDBCLineage |               |

  ############################################# PluginRun - DryRun False ##########################################################
  @MLP-24751 @sanity @positive @regression
  Scenario Outline: SC#4-Configure and run the plugin config for JavaJDBCLineage with dryRun false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile | path | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJR |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaJDBCLineageJJR')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJR  |          |      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJR |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaJDBCLineageJJR')].status |


  ############################################# LoggingEnhancements #############################################
  #7131877#
  @sanity @positive @MLP-24751 @webtest
  Scenario: SC#4 Verify JavaJDBCLineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tag_JavaJDBCRedshift" and clicks on search
    And user performs "facet selection" in "tag_JavaJDBCRedshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaJDBCLineage/JavaJDBCLineageJJR%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 26            | Description |
      | Number of errors          | 2             | Description |
    Then Analysis log "lineage/JavaJDBCLineage/JavaJDBCLineageJJR%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:JavaJDBCLineage, Plugin Type:lineage, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:840f1e9fbae4, Plugin Configuration name:JavaJDBCLineageJJR                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | JavaJDBCLineage | Plugin Version |
      | INFO | 2020-07-14 11:34:51.655 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: ---  2020-07-14 11:34:51.655 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: name: "JavaJDBCLineageJJR"  2020-07-14 11:34:51.655 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: pluginVersion: "LATEST"  2020-07-14 11:34:51.655 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: label:  2020-07-14 11:34:51.655 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: : "JavaJDBCLineageJJR"  2020-07-14 11:34:51.655 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: catalogName: "Default"  2020-07-14 11:34:51.655 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: eventClass: null  2020-07-14 11:34:51.655 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: eventCondition: null  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: nodeCondition: "name==\"LocalNode\""  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: maxWorkSize: 100  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: tags:  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: - "tag_JavaJDBCRedshift"  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: pluginType: "lineage"  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: dataSource: null  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: credential: null  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: businessApplicationName: "test_BA_JavaJDBCRedshift"  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: dryRun: false  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: filter: null  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: pluginName: "JavaJDBCLineage"  2020-07-14 11:34:51.656 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: type: "Lineage" | ANALYSIS-0073 | JavaJDBCLineage |                |
      | INFO | Plugin JavaJDBCLineage Start Time:2020-05-27 05:59:59.126, End Time:2020-05-27 06:00:25.097, Processed Count:26, Errors:2, Warnings:890                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0072 | JavaJDBCLineage |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0020 |                 |                |

  ####################### API Lineage verification #############################################
  #7131878# #7131879# #7131880# #7131881# #7131882# #7131883# #7131884# #7131886# #7131888# #7131889# #7131890# #7131892# #7131893# #7131894# #7131895#  #7131896#
  @MLP-24751 @regression @positive
  Scenario Outline:SC#5:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive               | catalog | type       | name                                         | asg_scopeid | targetFile                                                                 | jsonpath                |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertSubQuery                               |             | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_1.json       |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_1.json       |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMP, QAEMPID]           |             | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_1.json       | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_1.json       | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertSubQuery                               |             | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_2.json       |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_2.json       |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP4]                  |             | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_2.json       | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_2.json       | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SynonymProg8                                 |             | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_1.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_1.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[EMPX]                     |             | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_1.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_1.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SynonymProg8                                 |             | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_2.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_2.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1]                  |             | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_2.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_2.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetWithDiffFunction                       |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetWithDiffFunction.json |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | runRowSet                                    |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetWithDiffFunction.json |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | runRowSet_SQL_Q_ROWSET_1_[QAEMP5]            |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetWithDiffFunction.json | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetWithDiffFunction.json | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetInsert                                 |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_1.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_1.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_ROWSET_1_[QAEMP]                  |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_1.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_1.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetInsert                                 |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_2.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_2.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1]                  |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_2.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_2.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateGetAndSet                            |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateGetAndSet.json      |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                 |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateGetAndSet.json      |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_STMT_1_[QAEMPUPDATE]      |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateGetAndSet.json      | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateGetAndSet.json      | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DirectLineagePrep                            |             | response/java/javaJDBCLineage/redshift/Lineage/DirectLineagePrep.json      |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/DirectLineagePrep.json      |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMPID, QAEMP5]         |             | response/java/javaJDBCLineage/redshift/Lineage/DirectLineagePrep.json      | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/DirectLineagePrep.json      | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DirLinWildCard                               |             | response/java/javaJDBCLineage/redshift/Lineage/DirLinWildCard.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/DirLinWildCard.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_STMT_1_[qaempsmall, QAINS]        |             | response/java/javaJDBCLineage/redshift/Lineage/DirLinWildCard.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/DirLinWildCard.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DeletewithConcat                             |             | response/java/javaJDBCLineage/redshift/Lineage/DeletewithConcat_1.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/DeletewithConcat_1.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPUPDATE]              |             | response/java/javaJDBCLineage/redshift/Lineage/DeletewithConcat_1.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/DeletewithConcat_1.json     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle1                                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle1.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle1.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPFILE1]               |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle1.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle1.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle2                                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle2.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle2.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPFILE2]               |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle2.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle2.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle3                                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle3.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle3.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPFILE3]               |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle3.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle3.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle4                                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle4.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle4.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PS_1_[QAEMPFILE4]                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle4.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle4.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle5                                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle5.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle5.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PS_1_[QAEMPFILE5]                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle5.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle5.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle6                                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_1.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_1.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PS_1_[QAEMPFILE6]                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_1.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_1.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle6                                 |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_2.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_2.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPFILE6]               |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_2.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_2.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | GetFromTwoTables                             |             | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_1.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_1.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAJOIN3]                 |             | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_1.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_1.json     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | GetFromTwoTables                             |             | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_2.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_2.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAJOIN1, QAJOIN2]         |             | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_2.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_2.json     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | LambdaExp1                                   |             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp1.json             |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp1.json             |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPLAMBDA1]             |             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp1.json             | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp1.json             | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | LambdaExp2                                   |             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp2.json             |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp2.json             |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PS_1_[QAEMPLAMBDA2]               |             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp2.json             | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp2.json             | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | Literals                                     |             | response/java/javaJDBCLineage/redshift/Lineage/Literals_1.json             |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Literals_1.json             |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V1_STMT_1_[E]                     |             | response/java/javaJDBCLineage/redshift/Lineage/Literals_1.json             | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Literals_1.json             | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | Literals                                     |             | response/java/javaJDBCLineage/redshift/Lineage/Literals_2.json             |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Literals_2.json             |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V2_STMT_1_[QAEMPUPDATE]           |             | response/java/javaJDBCLineage/redshift/Lineage/Literals_2.json             | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Literals_2.json             | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateSourceSQL                            |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_1.json    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_1.json    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_V_1PSTMT_1_[qasmalltarget]        |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_1.json    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_1.json    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateSourceSQL                            |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_2.json    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_2.json    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_V_2PSTMT_1_[QAEMPUPDATE]          |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_2.json    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_2.json    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateSourceSQL                            |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_3.json    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                 |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_3.json    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_V1_STMT_1_[QAEMPID]       |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_3.json    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_3.json    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateSourceSQL                            |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_4.json    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                 |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_4.json    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_V2_STMT_1_[qasmallsource] |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_4.json    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_4.json    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt2                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_1.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_1.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V1_STMT_1_[]                      |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_1.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_1.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt2                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_2.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_2.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V5_STMT_1_[SWITCH1]               |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_2.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_2.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt2                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_3.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_3.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V4_STMT_1_[SWITCH2]               |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_3.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_3.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt2                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_4.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_4.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V3_STMT_1_[SWITCH3]               |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_4.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_4.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt2                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_5.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_5.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V2_STMT_1_[SWITCH4]               |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_5.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_5.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt2                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_6.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_6.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[SWITCHTAR2]              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_6.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch2_6.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt3                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_1.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_1.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V3_STMT_1_[SWITCH1]               |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_1.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_1.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt3                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_2.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_2.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V2_STMT_1_[SWITCH2]               |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_2.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_2.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt3                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_3.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_3.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_V1_STMT_1_[SWITCH3]               |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_3.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_3.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SwitchSt3                                    |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_4.json              |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_4.json              |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[SWITCHTAR3]              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_4.json              | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/Switch3_4.json              | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | UpdatewithConcat                             |             | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_1.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_1.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPUPDATE]              |             | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_1.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_1.json     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | UpdatewithConcat                             |             | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_2.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_2.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP5]                  |             | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_2.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_2.json     | $.tableIDinsideFunction |

  #7131878# #7131879# #7131880# #7131881# #7131882# #7131883# #7131884# #7131886# #7131888# #7131889# #7131890# #7131892# #7131893# #7131894# #7131895#  #7131896#
  @MLP-24751 @regression @positive
  Scenario Outline: SC#5:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get multiple source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                   | inputFile                                                                  | outputFile                                                                              |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertSubQuery_1       | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_1.json       | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertSubQuery_2       | response/java/javaJDBCLineage/redshift/Lineage/InsertSubQuery_2.json       | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SynonymProg8_1         | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_1.json         | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SynonymProg8_2         | response/java/javaJDBCLineage/redshift/Lineage/SynonymProg8_2.json         | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetWithDiffFunction | response/java/javaJDBCLineage/redshift/Lineage/RowsetWithDiffFunction.json | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetInsert_1         | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_1.json         | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetInsert_2         | response/java/javaJDBCLineage/redshift/Lineage/RowsetInsert_2.json         | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateGetAndSet      | response/java/javaJDBCLineage/redshift/Lineage/SeparateGetAndSet.json      | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DirectLineagePrep      | response/java/javaJDBCLineage/redshift/Lineage/DirectLineagePrep.json      | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DirLinWildCard         | response/java/javaJDBCLineage/redshift/Lineage/DirLinWildCard.json         | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DeletewithConcat_1     | response/java/javaJDBCLineage/redshift/Lineage/DeletewithConcat_1.json     | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle1           | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle1.json           | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle2           | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle2.json           | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle3           | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle3.json           | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle4           | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle4.json           | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle5           | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle5.json           | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle6_1         | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_1.json         | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle6_2         | response/java/javaJDBCLineage/redshift/Lineage/FilesHandle6_2.json         | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | GetFromTwoTables_1     | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_1.json     | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | GetFromTwoTables_2     | response/java/javaJDBCLineage/redshift/Lineage/GetFromTwoTables_2.json     | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | LambdaExp1             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp1.json             | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | LambdaExp2             | response/java/javaJDBCLineage/redshift/Lineage/LambdaExp2.json             | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Literals_1             | response/java/javaJDBCLineage/redshift/Lineage/Literals_1.json             | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Literals_2             | response/java/javaJDBCLineage/redshift/Lineage/Literals_2.json             | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateSourceSQL_1    | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_1.json    | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateSourceSQL_2    | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_2.json    | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateSourceSQL_3    | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_3.json    | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateSourceSQL_4    | response/java/javaJDBCLineage/redshift/Lineage/SeparateSourceSQL_4.json    | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch2_1              | response/java/javaJDBCLineage/redshift/Lineage/Switch2_1.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch2_2              | response/java/javaJDBCLineage/redshift/Lineage/Switch2_2.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch2_3              | response/java/javaJDBCLineage/redshift/Lineage/Switch2_3.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch2_4              | response/java/javaJDBCLineage/redshift/Lineage/Switch2_4.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch2_5              | response/java/javaJDBCLineage/redshift/Lineage/Switch2_5.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch2_6              | response/java/javaJDBCLineage/redshift/Lineage/Switch2_6.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch3_1              | response/java/javaJDBCLineage/redshift/Lineage/Switch3_1.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch3_2              | response/java/javaJDBCLineage/redshift/Lineage/Switch3_2.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch3_3              | response/java/javaJDBCLineage/redshift/Lineage/Switch3_3.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | Switch3_4              | response/java/javaJDBCLineage/redshift/Lineage/Switch3_4.json              | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | UpdatewithConcat_1     | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_1.json     | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | UpdatewithConcat_2     | response/java/javaJDBCLineage/redshift/Lineage/UpdatewithConcat_2.json     | response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json |

  #7131878# #7131879# #7131880# #7131881# #7131882# #7131883# #7131884# #7131886# #7131888# #7131889# #7131890# #7131892# #7131893# #7131894# #7131895#  #7131896#
  @MLP-24751 @regression @positive
  Scenario Outline: SC#5:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                     | actual_json                                                                                               | item                   |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | InsertSubQuery_1       |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | InsertSubQuery_2       |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | SynonymProg8_1         |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | SynonymProg8_2         |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | RowsetWithDiffFunction |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | RowsetInsert_1         |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | RowsetInsert_2         |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | SeparateGetAndSet      |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | DirectLineagePrep      |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | DirLinWildCard         |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | DeletewithConcat_1     |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | FilesHandle1           |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | FilesHandle2           |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | FilesHandle3           |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | FilesHandle4           |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | FilesHandle5           |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | FilesHandle6_1         |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | FilesHandle6_2         |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | GetFromTwoTables_1     |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | GetFromTwoTables_2     |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | LambdaExp1             |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | LambdaExp2             |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Literals_1             |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Literals_2             |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | SeparateSourceSQL_1    |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | SeparateSourceSQL_2    |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | SeparateSourceSQL_3    |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | SeparateSourceSQL_4    |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch2_1              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch2_2              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch2_3              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch2_4              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch2_5              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch2_6              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch3_1              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch3_2              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch3_3              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | Switch3_4              |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | UpdatewithConcat_1     |
      | ida/javaJDBCRedshiftPayloads/expectedJavaJDBCLineageRedshift.json | Constant.REST_DIR/response/java/javaJDBCLineage/redshift/Lineage/JavaJDBCLineageRedshiftSourceTarget.json | UpdatewithConcat_2     |

  #7131877#
  @webtest @MLP-24751 @sanity @positive
  Scenario: SC#6-Verify Lineage Hops in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tag_JavaJDBCRedshift" and clicks on search
    And user performs "facet selection" in "tag_JavaJDBCRedshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "GetFromTwoTables" item from search results
    Then user performs click and verify in new window
      | Table        | value                        | Action                 | RetainPrevwindow | indexSwitch |
      | Functions    | main                         | click and switch tab   | No               |             |
      | Tables       | main_SQL_U_PSTMT_1_[QAJOIN3] | click and switch tab   | No               |             |
      | Lineage Hops | set_1 => FNAME               | verify widget contains |                  |             |
    Then user performs click and verify in new window
      | Table        | value          | Action                       | RetainPrevwindow | indexSwitch | filePath                                                          | jsonPath       |
      | Lineage Hops | set_1 => FNAME | click and verify lineagehops | Yes              | 0           | ida/javaJDBCRedshiftPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_1 |
      | Lineage Hops | set_2 => LNAME | click and verify lineagehops | Yes              | 0           | ida/javaJDBCRedshiftPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_2 |
      | Lineage Hops | set_3 => ID    | click and verify lineagehops | Yes              | 0           | ida/javaJDBCRedshiftPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_3 |
      | Lineage Hops | set_4 => AGE   | click and verify lineagehops | Yes              | 0           | ida/javaJDBCRedshiftPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_4 |
    And user enters the search text "main_SQL_Q_STMT_1_[QAJOIN1, QAJOIN2]" and clicks on search
    And user performs "item click" on "main_SQL_Q_STMT_1_[QAJOIN1, QAJOIN2]" item from search results
    Then user performs click and verify in new window
      | Table        | value                                           | Action                       | RetainPrevwindow | indexSwitch | filePath                                                          | jsonPath       |
      | Lineage Hops | main_SQL_Q_STMT_1_[QAJOIN1, QAJOIN2] => CONTROL | click and verify lineagehops | Yes              | 0           | ida/javaJDBCRedshiftPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_5 |

  ############################################# Technology tags and Explicit tags verification #############################################
  #7131877#
  @webtest @MLP-24751 @sanity @positive
  Scenario: SC#7-Verify the technology tags and explicit tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                     | fileName                     | userTag              |
      | Default     | SourceTree | Metadata Type | tag_JavaJDBCRedshift,Java                               | DirLinWildCard               | tag_JavaJDBCRedshift |
      | Default     | Class      | Metadata Type | tag_JavaJDBCRedshift,Java                               | DirLinWildCard               | tag_JavaJDBCRedshift |
      | Default     | Function   | Metadata Type | tag_JavaJDBCRedshift,Java,JDBC,test_BA_JavaJDBCRedshift | runRowSet                    | JDBC                 |
      | Default     | Table      | Metadata Type | tag_JavaJDBCRedshift,Java,JDBC,test_BA_JavaJDBCRedshift | main_SQL_U_PSTMT_1_[QAJOIN3] | JDBC                 |

  ############################################# EDIBusVerification #############################################
  #7131877#
  @sanity @positive @webtest @edibus
  Scenario: SC#8:EDIBusVerification: Verify EDI replication for items collected using JavaJDBCLineage
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea      | subjectAreaVersion | query                                      |
      | AP-DATA      | JAVAJDBCREDSHIFT | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user update json file "idc/EdiBusPayloads/JavaJDBCLineageRedshiftEDIConfig.json" file for following values using property loader
      | jsonPath                                           | jsonValues    |
      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body                                                                | response code | response message | jsonPath                                                    |
      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                         | idc/EdiBusPayloads/datasource/EDIBusDS_JavaJDBCLineageRedshift.json | 204           |                  |                                                             |
      |                  |       |       | Put          | settings/analyzers/EDIBus                                                   | idc/EdiBusPayloads/JavaJDBCLineageRedshiftEDIConfig.json            | 204           |                  |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaJDBCRedshift |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaJDBCRedshift')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJavaJDBCRedshift  |                                                                     | 200           |                  |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaJDBCRedshift |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaJDBCRedshift')].status |
    And user enters the search text "EDIBusJavaJDBCRedshift" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusJavaJDBCRedshift%"
    And METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea      | subjectAreaVersion | query                                                                                | itemCount |
      | AP-DATA      | JAVAJDBCREDSHIFT | 1.0                | (XNAME * *  ~/ TABLE@* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_OOP_VARIABLE )      | 45        |
      | AP-DATA      | JAVAJDBCREDSHIFT | 1.0                | (XNAME * *  ~/ COLUMN@* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_OOP_VARIABLE )     | 85        |
      | AP-DATA      | JAVAJDBCREDSHIFT | 1.0                | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 138       |
    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
      | databaseName | subjectArea      | subjectAreaVersion | itemName                                                       | itemType                   | attributeName | attributeValue                              |
      | AP-DATA      | JAVAJDBCREDSHIFT | 1.0                | @*main_SQL_U_PSTMT_1_[QAJOIN3]@*set_1@*                        | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Table≫main_SQL_U_PSTMT_1_[QAJOIN3]          |
      | AP-DATA      | JAVAJDBCREDSHIFT | 1.0                | @*main_SQL_U_PSTMT_1_[QAJOIN3]@*set_1@*                        | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | fname                                       |
      | AP-DATA      | JAVAJDBCREDSHIFT | 1.0                | @*main_SQL_Q_STMT_1_[QAEMPFILE6]]@*FNAME@*FirstnameLists.txt@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Table≫main_SQL_Q_STMT_1_[QAEMPFILE6]]≫FNAME |
      | AP-DATA      | JAVAJDBCREDSHIFT | 1.0                | @*main_SQL_Q_STMT_1_[QAEMPFILE6]]@*FNAME@*FirstnameLists.txt@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | /C:/FirstnameLists.txt                      |

  ############################################# Post Conditions ##########################################################
  @jdbc
  Scenario: PostConditions-Delete required tables in Redshift DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema | Database | Table           |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaemp           |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAEMP1          |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAEMP3          |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAEMP4          |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAEMP5          |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAEMPID         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAEMPUPDATE     |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAINS           |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAJOIN1         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAJOIN2         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | QAJOIN3         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | "qasmallsource" |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | "qasmalltarget" |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | "qaempsmall"    |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaempfile1      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaempfile2      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaempfile3      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaempfile4      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaempfile5      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaempfile6      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaemplambda1    |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | qaemplambda2    |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switch1         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switch2         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switch3         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switch4         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switch5         |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switchtar1      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switchtar2      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switchtar3      |
      | REDSHIFT           | DROP      | empdb  | REDSHIFT | switchtar4      |
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                  | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforJavaJDBC | dropSchema |

  Scenario Outline: PostConditions: RetrieveItemIDs- User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type    | targetFile                                                 | jsonpath                             |
      | APPDBPOSTGRES | Default | javaspark_lineage                                                | Project | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..Project.id                        |
      | APPDBPOSTGRES | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..Redshift_Cluster.id               |
      | APPDBPOSTGRES | Default | test_BA_JavaJDBCRedshift                                         |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..has_BA.id                         |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJJR%DYN                       |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..Git_Analysis.id                   |
      | APPDBPOSTGRES | Default | cataloger/AmazonRedshiftCataloger/AmazonRedshiftCatalogerJJR%DYN |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..Redshift_Analysis.id              |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJJR%DYN                              |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..JParser_Analysis.id               |
      | APPDBPOSTGRES | Default | linker/JavaLinker/JavaLinkerJJR%DYN                              |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..JLinker_Analysis.id               |
      | APPDBPOSTGRES | Default | linker/JavaIOLinker/JavaIOLinkerJJR%DYN                          |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..JIOLinker_Analysis.id             |
      | APPDBPOSTGRES | Default | lineage/JavaJDBCLineage/JavaJDBCLineageJJR%DYN                   |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..JavaJDBCLineage_Analysis.id       |
      | APPDBPOSTGRES | Default | lineage/JavaJDBCLineage/JavaJDBCLineageJJRDryRun%DYN             |         | response/java/javaJDBCLineage/redshift/actual/itemIds.json | $..JavaJDBCLineageDryRun_Analysis.id |


  @cr-data @postcondition @sanity @positive
  Scenario Outline: PostConditions: ItemDeletion- User deletes the collected item from database using dynamic id stored in json 1
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                            | inputFile                                                  |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                        | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Redshift_Cluster.id               | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                         | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id                   | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Redshift_Analysis.id              | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id               | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JLinker_Analysis.id               | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JIOLinker_Analysis.id             | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaJDBCLineage_Analysis.id       | response/java/javaJDBCLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaJDBCLineageDryRun_Analysis.id | response/java/javaJDBCLineage/redshift/actual/itemIds.json |

  Scenario: PostConditions: Delete all the External Packages with respect to Java JDBC Lineage
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type            | query | param |
      | MultipleIDDelete | Default |      | ExternalPackage |       |       |

  @sanity @positive @regression
  Scenario Outline: PostConditions: Delete Configurations the following Plugins for Git, MSSQL Cataloger, Java Parser, Java Linker, JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                     | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentialsJJR                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidRedshiftDBCredentialsJJR                      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusValidCredentialsJJR                          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJJR     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorJJR                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBusDataSource/EDIBusDS_JavaJDBCRedshift           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSourceJJR |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCatalogerJJR   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser/JavaParserJJR                             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaLinker/JavaLinkerJJR                             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaIOLinker/JavaIOLinkerJJR                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJRDryRun             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJR                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBus/EDIBusJavaJDBCRedshift                        |      | 204           |                  |          |
