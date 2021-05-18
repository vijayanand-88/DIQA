@MLP-24973
Feature: Validation of Python SQL Lineage plugin functionality after running Git, Python parser and Python Lineage plugins

  ############################################# Pre Conditions ##########################################################
  Scenario: SC#1-Create Required tables for Redshift DB Cataloger
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField                   |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforPySQLLineage | createSchema                 |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforPySQLLineage | createTablePassenger         |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforPySQLLineage | createTablePassendgerBkp     |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforPySQLLineage | createTablePassengerId       |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforPySQLLineage | createTablePassengerAge      |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforPySQLLineage | createTablePassengerFetchone |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforPySQLLineage | InsertRecordPassenger        |


  @precondition
  Scenario: SC#1-Update Git and Redshift credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                      | username                   | password                   |
      | ida/pySQLLineageRedshiftPayloads/pySQLLineageCredentials.json | $.gitCredentials..userName | $.gitCredentials..password |
    And User update the below "redshift credentials" in following files using json path
      | filePath                                                      | username                        | password                        |
      | ida/pySQLLineageRedshiftPayloads/pySQLLineageCredentials.json | $.redshiftCredentials..userName | $.redshiftCredentials..password |

  @sanity @positive @regression
  Scenario Outline: SC#1-Set the Credentials and Datasources for Git and Redshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                     | bodyFile                                                               | path                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentialsPSR                          | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineageCredentials.json | $.validEDIBusCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentialsPSR                             | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineageCredentials.json | $.gitCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidRedshiftDBCredentialsPSR                      | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineageCredentials.json | $.redshiftCredentials            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                               | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineageDataSources.json | $.gitCollectorDataSource_default | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource                             | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineageDataSources.json | $.redshiftDBDataSource_default   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourcePSR     | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineageDataSources.json | $.gitCollectorDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSourcePSR | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineageDataSources.json | $.redshiftDBDataSource           | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourcePSR     |                                                                        |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSourcePSR |                                                                        |                                  | 200           |                  |          |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1-Create Business Application tag for Python SQL Lineage test for Redshift Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/pySQLLineageRedshiftPayloads/pySQLLineageRedshift_BA.json | 200           |                  |          |

  ############################################# PluginRun ##########################################################
  Scenario Outline: SC#2-Configure Catalogers for GitCollector, Python and Redshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                   | bodyFile                                                                | path                        | response code | response message           | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCatalogerPSR | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineagePluginConifg.json | $.RedShiftCataloger         | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCatalogerPSR |                                                                         |                             | 200           | AmazonRedshiftCatalogerPSR |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollectorPSR                       | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineagePluginConifg.json | $.GitCollector              | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollectorPSR                       |                                                                         |                             | 200           | GitCollectorPSR            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonParser/PythonParserPSR                       | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineagePluginConifg.json | $.PythonParser              | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonParser/PythonParserPSR                       |                                                                         |                             | 200           | PythonParserPSR            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonPackageLinker/PythonPackageLinkerPSR         | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineagePluginConifg.json | $.PythonPackageLinker       | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonPackageLinker/PythonPackageLinkerPSR         |                                                                         |                             | 200           | PythonPackageLinkerPSR     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonLinker/PythonLinkerPSR                       | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineagePluginConifg.json | $.PythonLinker              | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonLinker/PythonLinkerPSR                       |                                                                         |                             | 200           | PythonLinkerPSR            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSRDryRun         | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineagePluginConifg.json | $.PythonSQLLineageDryRun    | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSRDryRun         |                                                                         |                             | 200           | PythonSQLLineagePSRDryRun  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSR               | payloads/ida/pySQLLineageRedshiftPayloads/pySQLLineagePluginConifg.json | $.PythonSQLLineageActualRun | 204           |                            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSR               |                                                                         |                             | 200           | PythonSQLLineagePSR        |          |

  @MLP-24973 @sanity @positive @regression
  Scenario Outline: SC#2-Run the Plugin configurations for Redshift Cataloger, Git, Python Parser, Python Linker, PythonPackageLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | bodyFile | path | response code | response message | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCatalogerPSR |          |      | 200           | IDLE             | $.[?(@.configurationName=='AmazonRedshiftCatalogerPSR')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCatalogerPSR  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCatalogerPSR |          |      | 200           | IDLE             | $.[?(@.configurationName=='AmazonRedshiftCatalogerPSR')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorPSR                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorPSR')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorPSR                        |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorPSR                       |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorPSR')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParserPSR                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParserPSR')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParserPSR                           |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParserPSR                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParserPSR')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/PythonPackageLinkerPSR            |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonPackageLinkerPSR')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/PythonPackageLinkerPSR             |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/PythonPackageLinkerPSR            |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonPackageLinkerPSR')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinkerPSR                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonLinkerPSR')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/PythonLinker/PythonLinkerPSR                           |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinkerPSR                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonLinkerPSR')].status            |

  ############################################# PluginRun - DryRunTrue ##########################################################
  @MLP-24973 @sanity @positive @regression
  Scenario Outline: SC#3-Configure and run the plugin config for PythonSQLLineage with dryRun true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSRDryRun |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSQLLineagePSRDryRun')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSRDryRun  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSRDryRun |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSQLLineagePSRDryRun')].status |

  #7146002#
  @webtest @MLP-24973 @sanity @positive @regression
  Scenario: SC#3:UI_Validation: Verify PythonSQLLineage plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PythonSQLLineagePSRDryRun" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/PythonSQLLineage/PythonSQLLineagePSRDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "lineage/PythonSQLLineage/PythonSQLLineagePSRDryRun%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName       | removableText |
      | INFO | Plugin PythonSQLLineage running on dry run mode                                             | ANALYSIS-0069 | PythonSQLLineage |               |
      | INFO | Plugin PythonSQLLineage processed 5 items on dry run mode and not written to the repository | ANALYSIS-0070 | PythonSQLLineage |               |

  ############################################# PluginRun - DryRun False ##########################################################
  @MLP-24973 @sanity @positive @regression
  Scenario Outline: SC#4-Configure and run the plugin config for PythonSQLLineage with dryRun false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile | path | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSR |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSQLLineagePSR')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSR  |          |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSR |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSQLLineagePSR')].status |


  ############################################# LoggingEnhancements #############################################
  #7146002#
  @sanity @positive @MLP-24973 @webtest
  Scenario: SC#4 Verify PythonSQLLineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tag_PySqlRedshift" and clicks on search
    And user performs "facet selection" in "tag_PySqlRedshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/PythonSQLLineage/PythonSQLLineagePSR/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 5             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "lineage/PythonSQLLineage/PythonSQLLineagePSR/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:PythonSQLLineage, Plugin Type:lineage, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:d000a317a962, Plugin Configuration name:PythonSQLLineagePSR                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0071 | PythonSQLLineage | Plugin Version |
      | INFO | 2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: ---  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: name: "PythonSQLLineagePSR"  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: pluginVersion: "LATEST"  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: label:  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: : "PythonSQLLineagePSR"  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: catalogName: "Default"  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: eventClass: null  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: eventCondition: null  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: nodeCondition: "name==\"LocalNode\""  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: maxWorkSize: 100  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: tags:  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: - "tag_PySqlRedshift"  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: pluginType: "lineage"  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: dataSource: null  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: credential: null  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: businessApplicationName: "test_BA_PySQLRedshift"  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: dryRun: false  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: filter: null  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: pluginName: "PythonSQLLineage"  2020-07-24 11:49:14.239 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: type: "Lineage" | ANALYSIS-0073 | PythonSQLLineage |                |
      | INFO | Plugin PythonSQLLineage Start Time:2020-07-23 10:29:47.686, End Time:2020-07-23 10:30:35.873, Processed Count:5, Errors:0, Warnings:104                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0072 | PythonSQLLineage |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:48.187)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0020 |                  |                |

  ####################### API Lineage verification #############################################
  #7143232# #7143233# #7143234# #7143236# #7143237# #7143238# #7143239# #7143240# #7143241# #7143242#
  @MLP-24973 @regression @positive
  Scenario Outline:SC#5:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                                     | asg_scopeid | targetFile                                                                               | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | PythonODBCLineageUsingFetchOneAPI        |             | response/python/pythonSQLLineage/redshift/Lineage/PythonODBCLineageUsingFetchOneAPI.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fetchOneAPI_main                         |             | response/python/pythonSQLLineage/redshift/Lineage/PythonODBCLineageUsingFetchOneAPI.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/redshift/Lineage/PythonODBCLineageUsingFetchOneAPI.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | InsertUsingColumnName                    |             | response/python/pythonSQLLineage/redshift/Lineage/InsertUsingColumnName.json             |              |
      | APPDBPOSTGRES | FunctionID | Default |            | validation_insert_using_col_name         |             | response/python/pythonSQLLineage/redshift/Lineage/InsertUsingColumnName.json             |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/redshift/Lineage/InsertUsingColumnName.json             | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | RunQuery                                 |             | response/python/pythonSQLLineage/redshift/Lineage/RunQuery1.json                         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | create_result_set                        |             | response/python/pythonSQLLineage/redshift/Lineage/RunQuery1.json                         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/redshift/Lineage/RunQuery1.json                         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | RunQuery                                 |             | response/python/pythonSQLLineage/redshift/Lineage/RunQuery2.json                         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | execute_insert_statement_from_result_set |             | response/python/pythonSQLLineage/redshift/Lineage/RunQuery2.json                         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/redshift/Lineage/RunQuery2.json                         | $.functionID |
      | APPDBPOSTGRES | FileID     | Default | File       | PythonODBCLineageAsFromDirectFile.py     |             | response/python/pythonSQLLineage/redshift/Lineage/PythonODBCLineageAsFromDirectFile.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/redshift/Lineage/PythonODBCLineageAsFromDirectFile.json | $.fileID     |




  #7143232# #7143233# #7143234# #7143236# #7143237# #7143238# #7143239# #7143240# #7143241# #7143242#
  @MLP-24973 @regression @positive
  Scenario Outline: SC#5:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get multiple source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                              | inputFile                                                                                | outputFile                                                                                  |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | PythonODBCLineageUsingFetchOneAPI | response/python/pythonSQLLineage/redshift/Lineage/PythonODBCLineageUsingFetchOneAPI.json | response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertUsingColumnName             | response/python/pythonSQLLineage/redshift/Lineage/InsertUsingColumnName.json             | response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RunQuery1                         | response/python/pythonSQLLineage/redshift/Lineage/RunQuery1.json                         | response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RunQuery2                         | response/python/pythonSQLLineage/redshift/Lineage/RunQuery2.json                         | response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | PythonODBCLineageAsFromDirectFile | response/python/pythonSQLLineage/redshift/Lineage/PythonODBCLineageAsFromDirectFile.json | response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json |


  #7143232# #7143233# #7143234# #7143236# #7143237# #7143238# #7143239# #7143240# #7143241# #7143242#
  @MLP-24973 @regression @positive
  Scenario Outline: SC#5:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                      | actual_json                                                                                                   | item                              |
      | ida/pySQLLineageRedshiftPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json | PythonODBCLineageUsingFetchOneAPI |
      | ida/pySQLLineageRedshiftPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json | InsertUsingColumnName             |
      | ida/pySQLLineageRedshiftPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json | RunQuery1                         |
      | ida/pySQLLineageRedshiftPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json | RunQuery2                         |
      | ida/pySQLLineageRedshiftPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/redshift/Lineage/PythonSQLLineageRedshiftSourceTarget.json | PythonODBCLineageAsFromDirectFile |

  #7143237#
  @webtest @MLP-24973 @sanity @positive
  Scenario: SC#6-Verify Lineage Hops in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tag_PySqlRedshift" and clicks on search
    And user performs "facet selection" in "tag_PySqlRedshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "PythonODBCLineageAsFromDirectFile.py" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                                                                            | Action                       | RetainPrevwindow | indexSwitch | filePath                                                                | jsonPath       |
      | Lineage Hops | PythonODBCLineageAsFromDirectFile.py.insert_cursor.age => passenger_age.age                                      | click and verify lineagehops | Yes              | 0           | ida/pySQLLineageRedshiftPayloads/LineageMetadata/UILineageMetadata.json | $.LineageHop_1 |
      | Lineage Hops | PythonODBCLineageAsFromDirectFile.py.select_cursor.age => PythonODBCLineageAsFromDirectFile.py.insert_cursor.age | click and verify lineagehops | Yes              | 0           | ida/pySQLLineageRedshiftPayloads/LineageMetadata/UILineageMetadata.json | $.LineageHop_2 |
      | Lineage Hops | passenger.age => PythonODBCLineageAsFromDirectFile.py.select_cursor.age                                          | click and verify lineagehops | Yes              | 0           | ida/pySQLLineageRedshiftPayloads/LineageMetadata/UILineageMetadata.json | $.LineageHop_3 |

  ############################################# Technology tags and Explicit tags verification #############################################
  #7146002#
  @webtest @MLP-24973 @sanity @positive
  Scenario: SC#7-Verify the technology tags, Business and explicit tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                    | fileName                             | userTag           |
      | Default     | File       | Metadata Type | Git,Python,SQL,tag_PySqlRedshift,test_BA_PySQLRedshift | PythonODBCLineageAsFromDirectFile.py | tag_PySqlRedshift |
      | Default     | SourceTree | Metadata Type | Python,SQL,tag_PySqlRedshift,test_BA_PySQLRedshift     | PythonODBCLineageAsFromDirectFile    | tag_PySqlRedshift |
      | Default     | Function   | Metadata Type | Python,SQL,tag_PySqlRedshift,test_BA_PySQLRedshift     | create_result_set                    | tag_PySqlRedshift |
      | Default     | Table      | Metadata Type | Python,SQL,tag_PySqlRedshift,test_BA_PySQLRedshift     | fetchOneAPI_main.insert_cursor       | tag_PySqlRedshift |


  ############################################# EDIBusVerification #############################################
  #7146002#
  @sanity @positive @webtest @edibus
  Scenario: SC#8:EDIBusVerification: Verify EDI replication for items collected using PythonSQLLineage
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea      | subjectAreaVersion | query                                      |
      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user update json file "idc/EdiBusPayloads/PythonSQLLineageRedshiftEDIConfig.json" file for following values using property loader
      | jsonPath                                           | jsonValues    |
      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body                                                                 | response code | response message | jsonPath                                                     |
      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                          | idc/EdiBusPayloads/datasource/EDIBusDS_PythonSQLLineageRedshift.json | 204           |                  |                                                              |
      |                  |       |       | Put          | settings/analyzers/EDIBus                                                    | idc/EdiBusPayloads/PythonSQLLineageRedshiftEDIConfig.json            | 204           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusPythonSQLRedshift |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusPythonSQLRedshift')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusPythonSQLRedshift  |                                                                      | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusPythonSQLRedshift |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusPythonSQLRedshift')].status |
    And user enters the search text "EDIBusPythonSQLRedshift" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusPythonSQLRedshift%"
    And METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea      | subjectAreaVersion | query                                                                                | itemCount |
      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | (XNAME * *  ~/ TABLE@* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_OOP_VARIABLE )      | 8         |
      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | (XNAME * *  ~/ COLUMN@* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_OOP_VARIABLE )     | 23        |
      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 33        |
    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
      | databaseName | subjectArea      | subjectAreaVersion | itemName                                                                                        | itemType                   | attributeName | attributeValue |
      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | fetchOneAPI_main.insert_cursor.age@*passenger_fetchone.age                                      | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | age            |
      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | fetchOneAPI_main.insert_cursor.age@*passenger_fetchone.age                                      | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | age            |
      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | create_result_set.select_cursor.age@*execute_insert_statement_from_result_set.insert_cursor.age | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | age            |
      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | create_result_set.select_cursor.age@*execute_insert_statement_from_result_set.insert_cursor.age | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | age            |

  ############################################# Post Conditions ##########################################################
  Scenario: PostConditions-Delete required tables in Redshift DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema    | Database | Table              |
      | REDSHIFT           | DROP      | transport | REDSHIFT | passenger          |
      | REDSHIFT           | DROP      | transport | REDSHIFT | passenger_age      |
      | REDSHIFT           | DROP      | transport | REDSHIFT | passenger_bkp      |
      | REDSHIFT           | DROP      | transport | REDSHIFT | passenger_fetchone |
      | REDSHIFT           | DROP      | transport | REDSHIFT | passenger_id       |
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | REDSHIFTQueriesforPySQLLineage | dropSchema |

  Scenario Outline: PostConditions: RetrieveItemIDs- User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type    | targetFile                                                    | jsonpath                                 |
      | APPDBPOSTGRES | Default | javaspark_lineage                                                | Project | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..Project.id                            |
      | APPDBPOSTGRES | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..Redshift_Cluster.id                   |
      | APPDBPOSTGRES | Default | test_BA_PySQLRedshift                                            |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..has_BA.id                             |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorPSR%DYN                       |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..Git_Analysis.id                       |
      | APPDBPOSTGRES | Default | cataloger/AmazonRedshiftCataloger/AmazonRedshiftCatalogerPSR%DYN |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..Redshift_Analysis.id                  |
      | APPDBPOSTGRES | Default | parser/PythonParser/PythonParserPSR%DYN                          |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..PParser_Analysis.id                   |
      | APPDBPOSTGRES | Default | linker/PythonPackageLinker/PythonPackageLinkerPSR%DYN            |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..PPackageLinker_Analysis.id            |
      | APPDBPOSTGRES | Default | linker/PythonLinker/PythonLinkerPSR%DYN                          |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..PLinker_Analysis.id                   |
      | APPDBPOSTGRES | Default | lineage/PythonSQLLineage/PythonSQLLineagePSRDryRun/%DYN          |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..PythonSQLLineageDryRun_Analysis.id    |
      | APPDBPOSTGRES | Default | lineage/PythonSQLLineage/PythonSQLLineagePSR/%DYN                |         | response/python/pythonSQLLineage/redshift/actual/itemIds.json | $..PythonSQLLineageActualRun_Analysis.id |


  @cr-data @postcondition @sanity @positive
  Scenario Outline: PostConditions: ItemDeletion- User deletes the collected item from database using dynamic id stored in json 1
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                                | inputFile                                                     |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                            | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Redshift_Cluster.id                   | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                             | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id                       | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Redshift_Analysis.id                  | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PParser_Analysis.id                   | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PPackageLinker_Analysis.id            | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PLinker_Analysis.id                   | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PythonSQLLineageDryRun_Analysis.id    | response/python/pythonSQLLineage/redshift/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PythonSQLLineageActualRun_Analysis.id | response/python/pythonSQLLineage/redshift/actual/itemIds.json |

  Scenario: PostConditions: Delete all the External Packages with respect to Python SQL Lineage
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type            | query | param |
      | MultipleIDDelete | Default |      | ExternalPackage |       |       |

  @sanity @positive @regression
  Scenario Outline: PostConditions: Delete Configurations the following Plugins for Git, MSSQL Cataloger, Python Parser, Python Linker, PythonSQLLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                     | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentialsPSR                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidRedshiftDBCredentialsPSR                      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusValidCredentialsPSR                          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourcePSR     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorPSR                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBusDataSource/EDIBusDS_PythonSQLRedshift          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSourcePSR |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCatalogerPSR   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonParser/PythonParserPSR                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonLinker/PythonLinkerPSR                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonPackageLinker/PythonPackageLinkerPSR           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSRDryRun           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSR                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBus/EDIBusPythonSQLRedshift                       |      | 204           |                  |          |
