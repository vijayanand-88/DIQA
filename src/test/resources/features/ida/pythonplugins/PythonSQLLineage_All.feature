@MLP-25698
Feature: Validation of Python SQL Lineage plugin functionality after running Git, Python parser and Python Lineage plugins

  ############################################# Pre Conditions ##########################################################
  Scenario: SC#1-Create Required tables for Redshift DB Cataloger
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                  | queryField                           |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createUserTeradata                   |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createDatabaseTeradata               |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | grantPermissionsTeradata             |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createTablePassenger                 |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | InsertRecordPassenger1               |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | InsertRecordPassenger2               |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createTablePassengerId               |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createSchemaPostgres                 |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createTablePassengerPostgres         |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | InsertRecordPassenger1Postgres       |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createTablePassengerFetchOnePostgres |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createSchemaSnowflake                |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createTablePassengerSnowflake        |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | InsertRecordPassenger1Snowflake      |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createTablePassengerOracle           |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | InsertRecordPassengerracle           |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | createTablePassengerBkpOracle        |


  @precondition
  Scenario:SC#1-Update Git and Redshift credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                 | username                   | password                   |
      | ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.gitCredentials..userName | $.gitCredentials..password |
    And User update the below "Postgres Credentials" in following files using json path
      | filePath                                                 | username                        | password                        |
      | ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.postgresCredentials..userName | $.postgresCredentials..password |
    And User update the below "Teradata16 credentials" in following files using json path
      | filePath                                                 | username                        | password                        |
      | ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.teradataCredentials..userName | $.teradataCredentials..password |
    And User update the below "snowflake credentials" in following files using json path
      | filePath                                                 | username                         | password                         |
      | ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.snowflakeCredentials..userName | $.snowflakeCredentials..password |
    And User update the below "oracle12c credentials" in following files using json path
      | filePath                                                 | username                      | password                      |
      | ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.oracleCredentials..userName | $.oracleCredentials..password |

  @sanity @positive @regression
  Scenario Outline: SC#1-Set the Credentials and Datasources for Git and Redshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                 | bodyFile                                                          | path                             | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentialsPSA                      | payloads/ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.validEDIBusCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentialsPSA                         | payloads/ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.gitCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidOracleDBCredentialsPSA                    | payloads/ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.oracleCredentials              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidTeradataDBCredentialsPSA                  | payloads/ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.teradataCredentials            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidPostgresDBCredentialsPSA                  | payloads/ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.postgresCredentials            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidSnowflakeDBCredentialsPSA                 | payloads/ida/pySQLLineageAllPayloads/pySQLLineageCredentials.json | $.snowflakeCredentials           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                           | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.gitCollectorDataSource_default | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBDataSource                           | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.postgreDBDataSource_default    | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource                            | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.snowflakeDBDataSource_default  | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource                             | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.teradataDBDataSource_default   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource                               | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.oracleDBDataSource_default     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourcePSA | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.gitCollectorDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSourcePSA | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.postgreDBDataSource            | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource/SnowflakeDBDataSourcePSA   | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.snowflakeDBDataSource          | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDBDataSourcePSA     | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.teradataDBDataSource           | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource/OracleDBDataSourcePSA         | payloads/ida/pySQLLineageAllPayloads/pySQLLineageDataSources.json | $.oracleDBDataSource             | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourcePSA |                                                                   |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSourcePSA |                                                                   |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBDataSource/SnowflakeDBDataSourcePSA   |                                                                   |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDBDataSourcePSA     |                                                                   |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource/OracleDBDataSourcePSA         |                                                                   |                                  | 200           |                  |          |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1-Create Business Application tag for Python SQL Lineage test for Redshift Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/pySQLLineageAllPayloads/pySQLLineageRedshift_BA.json | 200           |                  |          |

  ############################################# PluginRun ##########################################################
  Scenario Outline: SC#2-Configure Catalogers for GitCollector, Python and Redshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                               | bodyFile                                                           | path                        | response code | response message          | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCatalogerPSA | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.postgreDBCataloger        | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCatalogerPSA |                                                                    |                             | 200           | PostgreSQLDBCatalogerPSA  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCatalogerPSA   | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.snowflakeDBCataloger      | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCatalogerPSA   |                                                                    |                             | 200           | SnowflakeDBCatalogerPSA   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBCataloger/TeradataDBCatalogerPSA     | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.teradataDBCatalgoer       | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBCataloger/TeradataDBCatalogerPSA     |                                                                    |                             | 200           | TeradataDBCatalogerPSA    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBCataloger/OracleDBCatalogerPSA         | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.oracleDBCataloger         | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBCataloger/OracleDBCatalogerPSA         |                                                                    |                             | 200           | OracleDBCatalogerPSA      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollectorPSA                   | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.GitCollector              | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollectorPSA                   |                                                                    |                             | 200           | GitCollectorPSA           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonParser/PythonParserPSA                   | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.PythonParser              | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonParser/PythonParserPSA                   |                                                                    |                             | 200           | PythonParserPSA           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonPackageLinker/PythonPackageLinkerPSA     | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.PythonPackageLinker       | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonPackageLinker/PythonPackageLinkerPSA     |                                                                    |                             | 200           | PythonPackageLinkerPSA    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonLinker/PythonLinkerPSA                   | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.PythonLinker              | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonLinker/PythonLinkerPSA                   |                                                                    |                             | 200           | PythonLinkerPSA           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSADryRun     | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.PythonSQLLineageDryRun    | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSADryRun     |                                                                    |                             | 200           | PythonSQLLineagePSADryRun |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSA           | payloads/ida/pySQLLineageAllPayloads/pySQLLineagePluginConifg.json | $.PythonSQLLineageActualRun | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSA           |                                                                    |                             | 200           | PythonSQLLineagePSA       |          |

  @MLP-25698 @sanity @positive @regression
  Scenario Outline: SC#2-Run the Plugin configurations for Redshift Cataloger, Git, Python Parser, Python Linker, PythonPackageLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile | path | response code | response message | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCatalogerPSA |          |      | 200           | IDLE             | $.[?(@.configurationName=='PostgreSQLDBCatalogerPSA')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCatalogerPSA  |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCatalogerPSA |          |      | 200           | IDLE             | $.[?(@.configurationName=='PostgreSQLDBCatalogerPSA')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCatalogerPSA   |          |      | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCatalogerPSA')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCatalogerPSA    |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCatalogerPSA   |          |      | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCatalogerPSA')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataDBCatalogerPSA     |          |      | 200           | IDLE             | $.[?(@.configurationName=='TeradataDBCatalogerPSA')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeradataDBCatalogerPSA      |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataDBCatalogerPSA     |          |      | 200           | IDLE             | $.[?(@.configurationName=='TeradataDBCatalogerPSA')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCatalogerPSA         |          |      | 200           | IDLE             | $.[?(@.configurationName=='OracleDBCatalogerPSA')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCatalogerPSA          |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCatalogerPSA         |          |      | 200           | IDLE             | $.[?(@.configurationName=='OracleDBCatalogerPSA')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorPSA                   |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorPSA')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorPSA                    |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorPSA                   |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorPSA')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParserPSA                      |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParserPSA')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParserPSA                       |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParserPSA                      |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParserPSA')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/PythonPackageLinkerPSA        |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonPackageLinkerPSA')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/PythonPackageLinkerPSA         |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/PythonPackageLinkerPSA        |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonPackageLinkerPSA')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinkerPSA                      |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonLinkerPSA')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/PythonLinker/PythonLinkerPSA                       |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinkerPSA                      |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonLinkerPSA')].status          |

  ############################################# PluginRun - DryRunTrue ##########################################################
  @MLP-25698 @sanity @positive @regression
  Scenario Outline: SC#3-Configure and run the plugin config for PythonSQLLineage with dryRun true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSADryRun |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSQLLineagePSADryRun')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSADryRun  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSADryRun |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSQLLineagePSADryRun')].status |

  #7162945#
  @webtest @MLP-25698 @sanity @positive @regression
  Scenario: SC#3:UI_Validation: Verify PythonSQLLineage plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PythonSQLLineagePSADryRun" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/PythonSQLLineage/PythonSQLLineagePSADryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    Then Analysis log "lineage/PythonSQLLineage/PythonSQLLineagePSADryRun%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName       | removableText |
      | INFO | Plugin PythonSQLLineage running on dry run mode                                             | ANALYSIS-0069 | PythonSQLLineage |               |
      | INFO | Plugin PythonSQLLineage processed 5 items on dry run mode and not written to the repository | ANALYSIS-0070 | PythonSQLLineage |               |

  ############################################# PluginRun - DryRun False ##########################################################
  @MLP-25698 @sanity @positive @regression
  Scenario Outline: SC#4-Configure and run the plugin config for PythonSQLLineage with dryRun false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile | path | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSA |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSQLLineagePSA')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSA  |          |      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/PythonSQLLineage/PythonSQLLineagePSA |          |      | 200           | IDLE             | $.[?(@.configurationName=='PythonSQLLineagePSA')].status |


  ############################################# LoggingEnhancements #############################################
  #7162945#
  @sanity @positive @MLP-25698 @webtest
  Scenario: SC#4 Verify PythonSQLLineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tag_PySQLAll" and clicks on search
    And user performs "facet selection" in "tag_PySQLAll" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/PythonSQLLineage/PythonSQLLineagePSA/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 5             | Description |
      | Number of errors          | 2             | Description |
    Then Analysis log "lineage/PythonSQLLineage/PythonSQLLineagePSA/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:PythonSQLLineage, Plugin Type:lineage, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:d000a317a962, Plugin Configuration name:PythonSQLLineagePSA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | PythonSQLLineage | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin PythonSQLLineage Configuration: name: "PythonSQLLineagePSA"  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: pluginVersion: "LATEST"  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: label:  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: : "PythonSQLLineagePSA"  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: catalogName: "Default"  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: eventClass: null  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: eventCondition: null  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: nodeCondition: "name==\"LocalNode\""  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: maxWorkSize: 100  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: tags:  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: - "tag_PySQLAll"  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: pluginType: "lineage"  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: dataSource: null  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: credential: null  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: businessApplicationName: "test_BA_PySQLAll"  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: dryRun: false  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: schedule: null  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: filter: null  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: pluginName: "PythonSQLLineage"  2020-09-25 11:52:25.019 INFO  - ANALYSIS-0073: Plugin PythonSQLLineage Configuration: type: "Lineage" | ANALYSIS-0073 | PythonSQLLineage |                |
      | INFO | Plugin PythonSQLLineage Start Time:2020-07-23 10:29:47.686, End Time:2020-07-23 10:30:35.873, Processed Count:5, Errors:2, Warnings:9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0072 | PythonSQLLineage |                |
      | INFO | ANALYSIS-0075: Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:02:17.507)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0075 |                  |                |

  ####################### API Lineage verification #############################################
  #7162933# #7162934# #7162935# #7162936# #7162937# #7162938# #7162939# #7162940# #7162941# #7162942# #7162943# #7162944#
  @MLP-25698 @regression @positive
  Scenario Outline:SC#5:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                                     | asg_scopeid | targetFile                                                                          | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | PythonODBCLineageUsingFetchOneAPI        |             | response/python/pythonSQLLineage/all/Lineage/PythonODBCLineageUsingFetchOneAPI.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fetchOneAPI_main                         |             | response/python/pythonSQLLineage/all/Lineage/PythonODBCLineageUsingFetchOneAPI.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/all/Lineage/PythonODBCLineageUsingFetchOneAPI.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | InsertUsingColumnName                    |             | response/python/pythonSQLLineage/all/Lineage/InsertUsingColumnName.json             |              |
      | APPDBPOSTGRES | FunctionID | Default |            | validation_insert_using_col_name         |             | response/python/pythonSQLLineage/all/Lineage/InsertUsingColumnName.json             |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/all/Lineage/InsertUsingColumnName.json             | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | RunQuery                                 |             | response/python/pythonSQLLineage/all/Lineage/RunQuery1.json                         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | create_result_set                        |             | response/python/pythonSQLLineage/all/Lineage/RunQuery1.json                         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/all/Lineage/RunQuery1.json                         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | RunQuery                                 |             | response/python/pythonSQLLineage/all/Lineage/RunQuery2.json                         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | execute_insert_statement_from_result_set |             | response/python/pythonSQLLineage/all/Lineage/RunQuery2.json                         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                          |             | response/python/pythonSQLLineage/all/Lineage/RunQuery2.json                         | $.functionID |


  #7162933# #7162934# #7162935# #7162936# #7162937# #7162938# #7162939# #7162940# #7162941# #7162942# #7162943# #7162944#
  @MLP-25698 @regression @positive
  Scenario Outline: SC#5:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get multiple source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                              | inputFile                                                                           | outputFile                                                                        |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | PythonODBCLineageUsingFetchOneAPI | response/python/pythonSQLLineage/all/Lineage/PythonODBCLineageUsingFetchOneAPI.json | response/python/pythonSQLLineage/all/Lineage/PythonSQLLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertUsingColumnName             | response/python/pythonSQLLineage/all/Lineage/InsertUsingColumnName.json             | response/python/pythonSQLLineage/all/Lineage/PythonSQLLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RunQuery1                         | response/python/pythonSQLLineage/all/Lineage/RunQuery1.json                         | response/python/pythonSQLLineage/all/Lineage/PythonSQLLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RunQuery2                         | response/python/pythonSQLLineage/all/Lineage/RunQuery2.json                         | response/python/pythonSQLLineage/all/Lineage/PythonSQLLineageAllSourceTarget.json |


  #7162933# #7162934# #7162935# #7162936# #7162937# #7162938# #7162939# #7162940# #7162941# #7162942# #7162943# #7162944#
  @MLP-25698 @regression @positive
  Scenario Outline: SC#5:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                 | actual_json                                                                                         | item                              |
      | ida/pySQLLineageAllPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/all/Lineage/PythonSQLLineageAllSourceTarget.json | PythonODBCLineageUsingFetchOneAPI |
      | ida/pySQLLineageAllPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/all/Lineage/PythonSQLLineageAllSourceTarget.json | InsertUsingColumnName             |
      | ida/pySQLLineageAllPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/all/Lineage/PythonSQLLineageAllSourceTarget.json | RunQuery1                         |
      | ida/pySQLLineageAllPayloads/expectedPySQLLineageRedshift.json | Constant.REST_DIR/response/python/pythonSQLLineage/all/Lineage/PythonSQLLineageAllSourceTarget.json | RunQuery2                         |

  #7162944#
  @webtest @MLP-25698 @sanity @positive
  Scenario: SC#6-Verify Lineage Hops in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tag_PySQLAll" and clicks on search
    And user performs "facet selection" in "tag_PySQLAll" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "RunQuery" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                                | Action                       | RetainPrevwindow | indexSwitch | filePath                                                           | jsonPath       |
      | Functions    | create_result_set                                                    | click and switch tab         |                  |             |                                                                    |                |
      | Lineage Hops | passenger.AGE => create_result_set.select_cursor.AGE                 | click and verify lineagehops | Yes              | 0           | ida/pySQLLineageAllPayloads/LineageMetadata/UILineageMetadata.json | $.LineageHop_1 |
      | Lineage Hops | passenger.FARE => create_result_set.select_cursor.FARE               | click and verify lineagehops | Yes              | 0           | ida/pySQLLineageAllPayloads/LineageMetadata/UILineageMetadata.json | $.LineageHop_2 |
      | Lineage Hops | passenger.PASSENGERID => create_result_set.select_cursor.PASSENGERID | click and verify lineagehops | Yes              | 0           | ida/pySQLLineageAllPayloads/LineageMetadata/UILineageMetadata.json | $.LineageHop_3 |
      | Lineage Hops | passenger.TICKET => create_result_set.select_cursor.TICKET           | click and verify lineagehops | Yes              | 0           | ida/pySQLLineageAllPayloads/LineageMetadata/UILineageMetadata.json | $.LineageHop_4 |

  ############################################# Technology tags and Explicit tags verification #############################################
  #7162945#
  @webtest @MLP-25698 @sanity @positive
  Scenario: SC#7-Verify the technology tags, Business and explicit tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                          | fileName                             | userTag                           |
      | Default     | File       | Metadata Type | Git,Python,SQL,tag_PySQLAll,test_BA_PySQLAll | PythonODBCLineageAsFromDirectFile.py | PythonODBCLineageAsFromDirectFile |
      | Default     | SourceTree | Metadata Type | Python,SQL,tag_PySQLAll,test_BA_PySQLAll     | PythonODBCLineageAsFromDirectFile    | PythonODBCLineageAsFromDirectFile |
      | Default     | Function   | Metadata Type | Python,SQL,tag_PySQLAll,test_BA_PySQLAll     | create_result_set                    | create_result_set                 |
      | Default     | Table      | Metadata Type | Python,SQL,tag_PySQLAll,test_BA_PySQLAll     | fetchOneAPI_main.insert_cursor       | fetchOneAPI_main.insert_cursor    |


#  ############################################# EDIBusVerification #############################################
#  #7162945#
#  @sanity @positive @webtest @edibus
#  Scenario: SC#8:EDIBusVerification: Verify EDI replication for items collected using PythonSQLLineage
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea      | subjectAreaVersion | query                                      |
#      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/PythonSQLLineageRedshiftEDIConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                          | body                                                                 | response code | response message | jsonPath                                                     |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                          | idc/EdiBusPayloads/datasource/EDIBusDS_PythonSQLLineageRedshift.json | 204           |                  |                                                              |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                                    | idc/EdiBusPayloads/PythonSQLLineageRedshiftEDIConfig.json            | 204           |                  |                                                              |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusPythonSQLRedshift |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusPythonSQLRedshift')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusPythonSQLRedshift  |                                                                      | 200           |                  |                                                              |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusPythonSQLRedshift |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusPythonSQLRedshift')].status |
#    And user enters the search text "EDIBusPythonSQLRedshift" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusPythonSQLRedshift%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea      | subjectAreaVersion | query                                                                                | itemCount |
#      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | (XNAME * *  ~/ TABLE@* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_OOP_VARIABLE )      | 8         |
#      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | (XNAME * *  ~/ COLUMN@* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_OOP_VARIABLE )     | 23        |
#      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 33        |
#    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
#      | databaseName | subjectArea      | subjectAreaVersion | itemName                                                                                        | itemType                   | attributeName | attributeValue |
#      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | fetchOneAPI_main.insert_cursor.age@*passenger_fetchone.age                                      | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | age            |
#      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | fetchOneAPI_main.insert_cursor.age@*passenger_fetchone.age                                      | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | age            |
#      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | create_result_set.select_cursor.age@*execute_insert_statement_from_result_set.insert_cursor.age | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | age            |
#      | AP-DATA      | PYTHONSQLLINEAGE | 1.0                | create_result_set.select_cursor.age@*execute_insert_statement_from_result_set.insert_cursor.age | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | age            |

  ############################################# Post Conditions ##########################################################
  Scenario: PostConditions-Delete required tables in Redshift DB
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                  | queryField                  |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | deleteDatabaseTeradata      |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | dropDatabaseTeradata        |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | deleteUserTeradata          |
      | TERADATA_DB16      | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | dropUserTeradata            |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | dropSchemaPostgres          |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | dropSchemaSnowflake         |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | dropTablePassengerOracle    |
      | ORACLE12C          | EXECUTEQUERY | json/IDA.json | PySQLLineageAllDataSources | dropTablePassengerBkpOracle |

  Scenario Outline: PostConditions: RetrieveItemIDs- User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                          | type    | targetFile                                               | jsonpath                                 |
      | APPDBPOSTGRES | Default | javaspark_lineage                                             | Project | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Project.id                            |
      | APPDBPOSTGRES | Default | decheqaperf01v.asg.com                                        |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Postgres_Cluster.id                   |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com                  |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Snowflake_Cluster.id                  |
      | APPDBPOSTGRES | Default | didtde01v.did.dev.asgint.loc                                  |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Teradata_Cluster.id                   |
      | APPDBPOSTGRES | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                               |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Oracle_Cluster.id                     |
      | APPDBPOSTGRES | Default | test_BA_PySQLAll                                              |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..has_BA.id                             |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorPSA%DYN                    |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Git_Analysis.id                       |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/PostgreSQLDBCatalogerPSA/%DYN |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Postgres_Analysis.id                  |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCatalogerPSA/%DYN   |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Snowflake_Analysis.id                 |
      | APPDBPOSTGRES | Default | cataloger/TeradataDBCataloger/TeradataDBCatalogerPSA/%DYN     |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Teradata_Analysis.id                  |
      | APPDBPOSTGRES | Default | cataloger/OracleDBCataloger/OracleDBCatalogerPSA/%DYN         |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..Oracle_Analysis.id                    |
      | APPDBPOSTGRES | Default | parser/PythonParser/PythonParserPSA%DYN                       |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..PParser_Analysis.id                   |
      | APPDBPOSTGRES | Default | linker/PythonPackageLinker/PythonPackageLinkerPSA%DYN         |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..PPackageLinker_Analysis.id            |
      | APPDBPOSTGRES | Default | linker/PythonLinker/PythonLinkerPSA%DYN                       |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..PLinker_Analysis.id                   |
      | APPDBPOSTGRES | Default | lineage/PythonSQLLineage/PythonSQLLineagePSADryRun/%DYN       |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..PythonSQLLineageDryRun_Analysis.id    |
      | APPDBPOSTGRES | Default | lineage/PythonSQLLineage/PythonSQLLineagePSA/%DYN             |         | response/python/pythonSQLLineage/all/actual/itemIds.json | $..PythonSQLLineageActualRun_Analysis.id |


  @cr-data @postcondition @sanity @positive
  Scenario Outline: PostConditions: ItemDeletion- User deletes the collected item from database using dynamic id stored in json 1
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                                | inputFile                                                |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                            | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Postgres_Cluster.id                   | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Snowflake_Cluster.id                  | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Teradata_Cluster.id                   | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Oracle_Cluster.id                     | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                             | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id                       | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Postgres_Analysis.id                  | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Snowflake_Analysis.id                 | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Teradata_Analysis.id                  | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Oracle_Analysis.id                    | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PParser_Analysis.id                   | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PPackageLinker_Analysis.id            | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PLinker_Analysis.id                   | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PythonSQLLineageDryRun_Analysis.id    | response/python/pythonSQLLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..PythonSQLLineageActualRun_Analysis.id | response/python/pythonSQLLineage/all/actual/itemIds.json |

  Scenario: PostConditions: Delete all the External Packages with respect to Python SQL Lineage
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type            | query | param |
      | MultipleIDDelete | Default |      | ExternalPackage |       |       |

  @sanity @positive @regression
  Scenario Outline: PostConditions: Delete Configurations the following Plugins for Git, MSSQL Cataloger, Python Parser, Python Linker, PythonSQLLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                 | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentialsPSA                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidPostgresDBCredentialsPSA                  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidSnowflakeDBCredentialsPSA                 |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidTeradataDBCredentialsPSA                  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidOracleDBCredentialsPSA                    |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusValidCredentialsPSA                      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourcePSA |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorPSA                     |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBusDataSource/EDIBusDS_PythonSQLAll          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSourcePSA |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBDataSource/SnowflakeDBDataSourcePSA   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBDataSource/TeradataDBDataSourcePSA     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource/OracleDBDataSourcePSA         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCatalogerPSA   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCatalogerPSA     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBCataloger/TeradataDBCatalogerPSA       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger/OracleDBCatalogerPSA           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonParser/PythonParserPSA                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonLinker/PythonLinkerPSA                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonPackageLinker/PythonPackageLinkerPSA       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSADryRun       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PythonSQLLineage/PythonSQLLineagePSA             |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBus/EDIBusPythonSQLAll                       |      | 204           |                  |          |
