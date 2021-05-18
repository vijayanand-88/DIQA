@MLP-4630
Feature:Verification of JDBC Analyzer using Oracle 18c RDS database and plugin validation


  @precondition
  Scenario:SC#1_1_Update credential payload json for Oracle18cRDS
    Given User update the below "Oracle18cRDS Readonly credentials" in following files using json path
      | filePath                                                     | username    | password    |
      | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleCredentials.json | $..userName | $..password |


  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC#1_2_Add valid Credentials for Oracle18cRDS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                 | body                                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle18cRDSCredentials        | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleCredentials.json            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle18cRDSCredentials        |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle18cRDSInvalidCredentials | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleInvalidCredentials.json     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle18cRDSInvalidCredentials |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle18cRDSEmptyCredentials   | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleCredentialsEmpty.json       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle18cRDSEmptyCredentials   |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                                  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/businessApplicationCataloger.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                                  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/businessApplicationAnalyzer.json  | 200           |                  |          |


  Scenario Outline:SC#2_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                    | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                | 200           | Oracle18cRDSDS                  |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithSchemaFilter.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                               | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |

  ##6767896##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#2_2_Verify Oracle cataloger scans and collects data if schema name alone is provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettablesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getviewsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | OCPPVIEW           | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.OCPPVIEW           | Description     |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#2_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter% | Analysis |       |       |


  Scenario Outline:SC#3_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                        | 200           | Oracle18cRDSDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                        | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |


  ##6767897##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#3_2_Verify Oracle cataloger scans and collects data if schema name and table name is provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user "widget not present" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | OCPPVIEW           | click and switch tab      | Yes              | 0           |                                                             |                      |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value         | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | TABLE_PRIMARY | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#3_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                    | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |


  Scenario Outline:SC#4_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                             | response code | response message                                  | jsonPath                                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                                      | 204           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                  | 200           | Oracle18cRDSDS                                    |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithMultipleSchemaFilterWithTables.json | 204           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                  | 200           | OracleCatalogerWithMultipleSchemaFilterWithTables |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                  | 200           | IDLE                                              | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemaFilterWithTables')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                                 | 200           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                  | 200           | IDLE                                              | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemaFilterWithTables')].status |


  ##6767901##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#4_2_Verify Oracle cataloger scans and collects data if multiple schema names having tables in it are provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table       | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Constraints | PRIMARY_PK | verify widget contains | No               |             |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | TABLE_PRIMARY      | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.TABLE_PRIMARY      | Description     |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | ORACLE_PERSON_INFO | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | PERSON_ID | click and switch tab | No               |             |          |          |                 |
    And user enters the search text "ORACLE12C_SCHEMA2" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA2 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table   | value       | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath    | metadataSection |
      | Tables  | BASELINES   | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.BASELINES | Description     |
      | Tables  | BASELINES   | click and switch tab      | No               | 0           |                                                             |             |                 |
      | Columns | EMPLOYEE_ID | verify widget contains    | Yes              |             |                                                             |             |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#4_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                           | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                              | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemaFilterWithTables% | Analysis |       |       |


  Scenario Outline:SC#5_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                           | response code | response message                                | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                                    | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                | 200           | Oracle18cRDSDS                                  |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerwithSchemaAndMultipleTableFilter.json | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                | 200           | OracleCatalogerwithSchemaAndMultipleTableFilter |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                | 200           | IDLE                                            | $.[?(@.configurationName=='OracleCatalogerwithSchemaAndMultipleTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                               | 200           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                | 200           | IDLE                                            | $.[?(@.configurationName=='OracleCatalogerwithSchemaAndMultipleTableFilter')].status |


  ##6767899##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#5_2_Verify Oracle cataloger scans and collects data if single schema name with multiple table names are provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table       | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Constraints | PRIMARY_PK | verify widget contains | No               |             |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | TABLE_PRIMARY      | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.TABLE_PRIMARY      | Description     |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | ORACLE_PERSON_INFO | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | PERSON_ID | click and switch tab | No               |             |          |          |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#5_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                         | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerwithSchemaAndMultipleTableFilter% | Analysis |       |       |


  Scenario Outline:SC#6_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                      | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                               | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                           | 200           | Oracle18cRDSDS                             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                           | 200           | OracleCatalogerWithMultipleSchemasInFilter |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |


  ##6767898## ##6204182##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#6_2_Verify Oracle cataloger scans and collects data if multiple schema name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettablesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getviewsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | OCPPVIEW           | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.OCPPVIEW           | Description     |
    And user enters the search text "ORACLE12C_SCHEMA2" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA2 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table   | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables  | BASELINES          | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.BASELINES          | Description     |
      | Tables  | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle18cRDS/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables  | BASELINES          | click and switch tab      | No               |             |                                                             |                      |                 |
      | Columns | EMPLOYEE_ID        | click and switch tab      | No               |             |                                                             |                      |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#6_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                    | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                       | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter% | Analysis |       |       |


  Scenario Outline:SC#7_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                              | response code | response message                                   | jsonPath                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                                       | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                   | 200           | Oracle18cRDSDS                                     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerwithNonExistingSchemaAndTableFilter.json | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                   | 200           | OracleCatalogerwithNonExistingSchemaAndTableFilter |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |


  ##6767902## ##6204212##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#7_2_Verify Oracle cataloger scans and collects data if non existing schema name and table name are provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user "widget not present" on "Constraints" in Item view page
    And user "widget presence" on "has_Index" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getroutinesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table   | value              | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_PERSON_INFO | click and switch tab   | Yes              |             |          |          |                 |
      | Columns | PERSON_ID          | verify widget contains |                  |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | OCPPVIEW | click and switch tab | Yes              |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table   | value                    | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_DIFFDATATYPES     | click and switch tab   | No               |             |          |          |                 |
      | Columns | BLOBCOLUMN               | verify widget contains |                  |             |          |          |                 |
      | Columns | CLOBCOLUMN               | verify widget contains |                  |             |          |          |                 |
      | Columns | NCLOBCOLUMN              | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000023474C00015$$ | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000023474C00016$$ | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000023474C00017$$ | verify widget contains |                  |             |          |          |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle18c_rds | STRUCTURED   | json/IDA.json | Oracle18cRDSQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#7_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                            | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                               | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerwithNonExistingSchemaAndTableFilter% | Analysis |       |       |


  Scenario Outline:SC#8_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                        | 200           | Oracle18cRDSDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithIncorrectCredentials.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                        | 200           | OracleCatalogerWithIncorrectCredentials |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithIncorrectCredentials')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithIncorrectCredentials')].status |


  ##6767905##
  @webtest @jdbc @MLP-6942 @MLP-9602
  Scenario:SC#8_2_Verify the error message when Configuration credentials are incorrect
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials%" should display below info/error/warning
      | type  | logValue                                                                                            | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                                                      | ANALYSIS-0019      |                   |               |
      | ERROR | OracleDB datasource failed : ORA-01017: invalid username/password; logon denied","cleared":false}]} | ANALYSIS-JDBC-0067 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                                                             | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |


  @sanity @positive @regression
  Scenario:SC#8_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials% | Analysis |       |       |


  Scenario Outline:SC#9_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                  | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSourceWithWrongDBinURL.json           | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                       | 200           | Oracle18cRDSDSwrongDB  |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWrongDB.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                       | 200           | OracleCatalogerWrongDB |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='OracleCatalogerWrongDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='OracleCatalogerWrongDB')].status |


  ##6767904##
  @webtest @jdbc @MLP-9602
  Scenario:SC#9_2_Verify OracleDatabaseCataloger does not scans and collects and any data if database passed in URL is incorrect
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWrongDB%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWrongDB%" should display below info/error/warning
      | type  | logValue                                                                                                       | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                                                                 | ANALYSIS-0019      |                   |               |
      | ERROR | OracleDB datasource failed : IO Error: The Network Adapter could not establish the connection","cleared":false | ANALYSIS-JDBC-0067 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                                                                        | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |


  @sanity @positive @regression
  Scenario:SC#9_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWrongDB% | Analysis |       |       |


  Scenario Outline:SC#10_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                    | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSourceWrongHost.json                    | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                         | 200           | Oracle18cRDSDSwrongHost  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWrongHost.json | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                         | 200           | OracleCatalogerWrongHost |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='OracleCatalogerWrongHost')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                        | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='OracleCatalogerWrongHost')].status |


  @webtest @jdbc @MLP-6948
  Scenario:SC#10_2_Verify the error message when Configuration url is incorrect
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWrongHost%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWrongHost%" should display below info/error/warning
      | type  | logValue                                                                                                          | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                                                                    | ANALYSIS-0019      |                   |               |
      | ERROR | OracleDB datasource failed : IO Error: The Network Adapter could not establish the connection","cleared":false}]} | ANALYSIS-JDBC-0067 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                                                                           | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |


  @sanity @positive @regression
  Scenario:SC#10_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWrongHost% | Analysis |       |       |


  Scenario Outline:SC#11_1_Run the Plugin configurations for DataSource and run the Oracle18cRDS Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                        | 200           | Oracle18cRDSDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                        | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleAnalyzerWithMinSampleDataCount.json    | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                        | 200           | OracleAnalyzerWithMinSampleDataCount    |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzerWithMinSampleDataCount')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzerWithMinSampleDataCount')].status    |


  ##6767931##
  @webtest @jdbc @MLP-9605
  Scenario:SC#12_2_Verify OracleDbAnalyzer does data sampling when sampling count is varied.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |


  ##6767933##
  @webtest
  Scenario:SC#12_3_Verify OracleDbAnalyzer does data sampling,data profiling and pattern matching properly when analyzer is run on the cataloged item which has filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute           | widgetName |
      | Last catalogued at          | Lifecycle  |
      | Last analyzed at            | Lifecycle  |
      | Maximum value               | Statistics |
      | Minimum value               | Statistics |
      | Number of unique values     | Statistics |
      | Percentage of unique values | Statistics |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIMESTAMP     | Description |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 4             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EMAIL | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |


  @sanity @positive @regression
  Scenario:SC#12_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                    | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMinSampleDataCount%  | Analysis |       |       |


  @jdbc
  Scenario Outline:SC#15_1_Run the OracleDB Cataloger and Oracle Analyzer with Schema Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                      | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                               | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                           | 200           | Oracle18cRDSDS                             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                           | 200           | OracleCatalogerWithMultipleSchemasInFilter |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleAnalyzerWithSchemaFilter.json             | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                           | 200           | OracleAnalyzerWithSchemaFilter             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleAnalyzerWithSchemaFilter')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleAnalyzerWithSchemaFilter')].status             |


  ##7072909## ##7072910##
  @webtest
  Scenario:SC#15_2_Verify Datasampling for Table and View after running the Oracle Analyzer with SchemaFilter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDADB18C" item from search results
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1  | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |
    And user navigates to the index "0" to perform actions
    And user "navigatesToTab" name "Overview" in item view page
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables | OCPPVIEW | click and switch tab | No               |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GRADE | NAME  | ROLLNO | SCHOOLNAME |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
    And user navigates to the index "1" to perform actions
    And user "navigatesToTab" name "Overview" in item view page
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | No               |             |
      | Tables  | BASELINES         | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW2 | click and switch tab | No               |             |
    And user "widget not present" on "dataSamples" in Item view page


  ##7072911## ##7072912##
  @webtest
  Scenario:SC#15_3_Verify data profiling (decimal, varchar and TimeStamp) for Table and View after running the Oracle Analyzer with SchemaFilter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDADB18C" item from search results
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1  | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | FULL_NAME | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 40            | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Maximum value                 | Lionel Messi  | Statistics  |
      | Minimum length                | 11            | Statistics  |
      | Minimum value                 | Alex Ferguson | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_SALARY | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.9         | Statistics  |
      | Variance                      | 53.56         | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 7.32          | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | No               |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2020-08-06 11:51:42 | Statistics  |
      | Minimum value                 | 2020-08-06 11:51:04 | Statistics  |
      | Number of non null values     | 4                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 4                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | ORACLE_TABLE | click and switch tab | Yes              |             |
      | Columns | DOB          | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | OCPPDSVT | click and switch tab | Yes              |             |          |          |                 |
      | Columns | GRADE    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 5             | Statistics  |
      | Maximum value                 | three         | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | five          | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ROLLNO | click and switch tab | No               |             |          |          |                 |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 150           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 150           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 3333.33       | Statistics  |
      | Minimum value                 | 100           | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 57.74         | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_VIEW | click and switch tab | Yes              |             |          |          |                 |
      | Columns | DOB         | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "2" to perform actions
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | Yes              |             |
      | Tables  | BASELINES         | click and switch tab | Yes              |             |
      | Columns | EMAIL             | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "2" to perform actions
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | Yes              |             |
      | Tables  | ORACLE_VIEW2      | click and switch tab | No               |             |
      | Columns | DOB               | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  @sanity @positive @regression
  Scenario:SC#15_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                    | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                       | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithSchemaFilter%           | Analysis |       |       |


  @jdbc
  Scenario Outline:SC#16_1_Run the OracleDB Cataloger and Oracle Analyzer with Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                  | response code | response message                       | jsonPath                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                           | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                       | 200           | Oracle18cRDSDS                         |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithSchemaFilter.json        | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                       | 200           | OracleCatalogerWithSchemaFilter        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                      | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleAnalyzerWithSchemaAndTableFilter.json | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                       | 200           | OracleAnalyzerWithSchemaAndTableFilter |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleAnalyzerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                      | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleAnalyzerWithSchemaAndTableFilter')].status |


  ##7072917##
  @webtest
  Scenario:SC#16_2_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a Table when OracleDBAnalyzer run with Schema and Table Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDADB18C" item from search results
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1  | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |
    And user navigates to the index "0" to perform actions
    And user "navigatesToTab" name "Overview" in item view page
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | TRIGGERTEST | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | FULL_NAME | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 40            | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Maximum value                 | Lionel Messi  | Statistics  |
      | Minimum length                | 11            | Statistics  |
      | Minimum value                 | Alex Ferguson | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_SALARY | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.9         | Statistics  |
      | Variance                      | 53.56         | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 7.32          | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | No               |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2020-08-06 11:51:42 | Statistics  |
      | Minimum value                 | 2020-08-06 11:51:04 | Statistics  |
      | Number of non null values     | 4                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 4                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | ORACLE_TABLE | click and switch tab | Yes              |             |
      | Columns | DOB          | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | TRIGGERTEST | click and switch tab | No               |             |
      | Columns | IDADDRESS   | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  ##7072919##
  @webtest
  Scenario:SC#16_3_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a View when OracleDBAnalyzer run with Schema and Table Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDADB18C" item from search results
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1 | click and switch tab | Yes              |             |
      | Tables  | OCPPVIEW          | click and switch tab | Yes              |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GRADE | NAME  | ROLLNO | SCHOOLNAME |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
    And user navigates to the index "0" to perform actions
    And user "navigatesToTab" name "Overview" in item view page
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables | OCPPDSVT | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | OCPPVIEW | click and switch tab | Yes              |             |          |          |                 |
      | Columns | GRADE    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 5             | Statistics  |
      | Maximum value                 | three         | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | five          | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ROLLNO | click and switch tab | No               |             |          |          |                 |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 150           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 150           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 3333.33       | Statistics  |
      | Minimum value                 | 100           | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 57.74         | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_VIEW | click and switch tab | Yes              |             |          |          |                 |
      | Columns | DOB         | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | OCPPDSVT | click and switch tab | No               |             |
      | Columns | GRADE    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  @sanity @positive @regression
  Scenario:SC#16_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                     | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter%          | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithSchemaAndTableFilter% | Analysis |       |       |


  @jdbc
  Scenario Outline:SC#17_1_Run the OracleDB Cataloger and Oracle Analyzer with Multiple Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                          | response code | response message                               | jsonPath                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                                   | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                               | 200           | Oracle18cRDSDS                                 |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json     | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                               | 200           | OracleCatalogerWithMultipleSchemasInFilter     |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleAnalyzerWithMultipleSchemaAndTableFilter.json | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                               | 200           | OracleAnalyzerWithMultipleSchemaAndTableFilter |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithMultipleSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithMultipleSchemaAndTableFilter')].status |


  ##7072918##
  @webtest
  Scenario:SC#17_2_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a Table when OracleDBAnalyzer run with Multiple Schema and Table Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDADB18C" item from search results
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1  | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |
    And user navigates to the index "0" to perform actions
    And user "navigatesToTab" name "Overview" in item view page
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | TRIGGERTEST | click and switch tab | No               |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TABLE2     | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | DOB                   | DOB2                  | ID  | NAME       |
      | 2005-10-20 00:00:00.0 | 2005-05-01 06:14:00.0 | 200 | Test Name2 |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | BASELINES | click and switch tab | No               |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1  | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | FULL_NAME | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 40            | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Maximum value                 | Lionel Messi  | Statistics  |
      | Minimum length                | 11            | Statistics  |
      | Minimum value                 | Alex Ferguson | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_SALARY | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.9         | Statistics  |
      | Variance                      | 53.56         | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 7.32          | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | No               |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2020-08-06 11:51:42 | Statistics  |
      | Minimum value                 | 2020-08-06 11:51:04 | Statistics  |
      | Number of non null values     | 4                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 4                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | ORACLE_TABLE | click and switch tab | Yes              |             |
      | Columns | DOB          | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | TRIGGERTEST | click and switch tab | No               |             |
      | Columns | IDADDRESS   | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "2" to perform actions
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TABLE2     | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | NAME  | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 10            | Statistics  |
      | Maximum value                 | Test Name2    | Statistics  |
      | Minimum length                | 10            | Statistics  |
      | Minimum value                 | Test Name2    | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ID    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 200           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 200           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 0             | Statistics  |
      | Minimum value                 | 200           | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 0             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB   | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | BASELINES | click and switch tab | No               |             |
      | Columns | GENDER    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  ##7072920##
  @webtest
  Scenario:SC#17_3_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a View when OracleDBAnalyzer run with Multiple Schema and Table Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDADB18C" item from search results
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1 | click and switch tab | Yes              |             |
      | Tables  | OCPPVIEW          | click and switch tab | Yes              |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GRADE | NAME  | ROLLNO | SCHOOLNAME |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables | OCPPDSVT | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | Yes              |             |
      | Tables  | ORACLE_VIEW2      | click and switch tab | Yes              |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | DOB                   | DOB2                  | ID  | NAME       |
      | 2005-10-20 00:00:00.0 | 2005-05-01 06:14:00.0 | 200 | Test Name2 |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW3 | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1 | click and switch tab | Yes              |             |
      | Tables  | ORACLE_VIEW       | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | NAME  | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 10            | Statistics  |
      | Maximum value                 | Test Name2    | Statistics  |
      | Minimum length                | 10            | Statistics  |
      | Minimum value                 | Test Name2    | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ID    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 200           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 200           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 0             | Statistics  |
      | Minimum value                 | 200           | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 0             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB   | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | OCPPDSVT | click and switch tab | No               |             |
      | Columns | GRADE    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "2" to perform actions
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | Yes              |             |
      | Tables  | ORACLE_VIEW2      | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | NAME  | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 10            | Statistics  |
      | Maximum value                 | Test Name2    | Statistics  |
      | Minimum length                | 10            | Statistics  |
      | Minimum value                 | Test Name2    | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ID    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 200           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 200           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 0             | Statistics  |
      | Minimum value                 | 200           | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 0             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB   | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "2" to perform actions
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | No               |             |
      | Tables  | ORACLE_VIEW3      | click and switch tab | No               |             |
      | Columns | EMAIL             | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  @webtest @positive
  Scenario:SC#17_4_Verify the Logging enhancement in OracleDB Cataloger and Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "facet selection" in "Orc18cRDSCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:OracleDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0, Node Name:AWS Node, Host Name:d46f16605777, Plugin Configuration name:OracleCatalogerWithMultipleSchemasInFilter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0071 | OracleDBCataloger | Plugin Version |
      | INFO | Plugin OracleDBCataloger Configuration: --- 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: name: "OracleCatalogerWithMultipleSchemasInFilter" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginVersion: "LATEST" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: label: 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: : "" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: catalogName: "Default" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: eventClass: null 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: eventCondition: null 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: nodeCondition: "name==\"AWS Node\"" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: maxWorkSize: 100 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tags: 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - "Orc18cRDSCataloger" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginType: "cataloger" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: dataSource: "Oracle18cRDSDS" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: credential: "Oracle18cRDSCredentials" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: businessApplicationName: null 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: dryRun: false 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: schedule: null 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: filter: null 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginName: "OracleDBCataloger" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: schemas: 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - schema: "ORACLE12C_SCHEMA1" 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tables: [] 2020-10-15 14:39:19.915 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - schema: "ORACLE12C_SCHEMA2" 2020-10-15 14:39:19.916 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tables: [] 2020-10-15 14:39:19.916 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: arguments: [] 2020-10-15 14:39:19.916 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: type: "Cataloger" 2020-10-15 14:39:19.916 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: properties: [] | ANALYSIS-0073 | OracleDBCataloger |                |
      | INFO | Plugin OracleDBCataloger Start Time:2020-08-12 13:17:01.623, End Time:2020-08-12 13:18:53.366, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0072 | OracleDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:54.600)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0020 |                   |                |
    And user enters the search text "Orc18cRDSAnalyzer" and clicks on search
    And user performs "facet selection" in "Orc18cRDSAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:OracleDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0, Node Name:AWS Node, Host Name:d46f16605777, Plugin Configuration name:OracleAnalyzerWithMultipleSchemaAndTableFilter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0071 | OracleDBAnalyzer | Plugin Version |
      | INFO | Plugin OracleDBAnalyzer Configuration: --- 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: name: "OracleAnalyzerWithMultipleSchemaAndTableFilter" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginVersion: "LATEST" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: label: 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: : "" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: catalogName: "Default" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventClass: null 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventCondition: null 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: nodeCondition: "name==\"AWS Node\"" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: maxWorkSize: 100 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tags: 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - "Orc18cRDSAnalyzer" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginType: "dataanalyzer" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dataSource: null 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: credential: null 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: businessApplicationName: null 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dryRun: false 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schedule: null 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: filter: null 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: histogramBuckets: 100 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: database: "IDADB18C" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginName: "OracleDBAnalyzer" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: sampleDataCount: 25 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schemas: 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "ORACLE12C_SCHEMA1" 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables: 2020-10-15 14:40:01.790 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TAG_DETAILS" 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TABLE" 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "OCPPVIEW" 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_VIEW" 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "ORACLE12C_SCHEMA2" 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables: 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TABLE2" 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_VIEW2" 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: type: "Dataanalyzer" 2020-10-15 14:40:01.791 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | OracleDBAnalyzer |                |
      | INFO | Plugin OracleDBAnalyzer Start Time:2020-08-12 13:19:52.934, End Time:2020-08-12 13:20:06.018, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0072 | OracleDBAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:00.264)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0020 |                  |                |


  @webtest @positive
  Scenario:SC#17_5_Verify the OracleDB Analyzer Plugin Processed Items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSAnalyzer" and clicks on search
    And user performs "facet selection" in "Orc18cRDSAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | ORACLE:1521                                       |


  @sanity @positive @regression
  Scenario:SC#17_6_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                          | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                             | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter%       | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter% | Analysis |       |       |


  ##7072921##
  @jdbc
  Scenario Outline:SC#18_1_Run the OracleDB Cataloger and Oracle Analyzer with Non Existing Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                              | response code | response message                                   | jsonPath                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                                       | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                                   | 200           | Oracle18cRDSDS                                     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithSchemaAndTableAndViewFilter.json     | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                                   | 200           | OracleCatalogerWithSchemaAndTableAndViewFilter     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleAnalyzerWithnNonExistingSchemaAndTableFilter.json | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                                   | 200           | OracleAnalyzerWithnNonExistingSchemaAndTableFilter |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleAnalyzerWithnNonExistingSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleAnalyzerWithnNonExistingSchemaAndTableFilter')].status |


  ##7072921##
  @webtest
  Scenario:SC#18_2_verify data sampling and data profiling (varchar, decimal and Timestamp) for Table and View When Non Existing schema and Table name provided in OracleDBAnalyzer Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDADB18C" item from search results
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1 | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TABLE      | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget not present" on "dataSamples" in Item view page
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget not present" on "dataSamples" in Item view page
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  @sanity @positive @regression
  Scenario:SC#18_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                              | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableAndViewFilter%       | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithnNonExistingSchemaAndTableFilter% | Analysis |       |       |


  ##7072923##
  @jdbc
  Scenario Outline:SC#19_1_Run the OracleDB Cataloger and Oracle Analyzer With Incorrect Database Name in OracleDBAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                          | response code | response message                               | jsonPath                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle18cRDS/OracleDataSource.json                                                   | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                               | 200           | Oracle18cRDSDS                                 |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleCatalogerWithSchemaAndTableAndViewFilter.json | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                               | 200           | OracleCatalogerWithSchemaAndTableAndViewFilter |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/OracleAnalyzerWithIncorrectDatabaseName.json        | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                               | 200           | OracleAnalyzerWithIncorrectDatabaseName        |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithIncorrectDatabaseName')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle18cRDS/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithIncorrectDatabaseName')].status        |


  ##7072923##
  @webtest
  Scenario:SC#19_2_verify data sampling and data profiling are not done for Table and View When Incorrect Database Name is provided in the OracleDBAnalyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc18cRDSCataloger" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDADB18C" item from search results
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1 | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TABLE      | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget not present" on "dataSamples" in Item view page
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget not present" on "dataSamples" in Item view page
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  @sanity @positive @regression
  Scenario:SC#19_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                        | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableAndViewFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithIncorrectDatabaseName%      | Analysis |       |       |


########################################################## PII Tags ################################################################################


  @sanity @positive @regression @PIITag
  Scenario Outline:SC#20_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | tags/Default/structures                                                              | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OraclePIITags.json                          | $.PIIConfig      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OracleDBTag.json                            | $.SC33           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


  # 7099421
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#20_2_Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag             |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Email Address | EMAIL     | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Gender        | GENDER    | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IP Address    | IPADDRESS | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSN           | SSN       | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Full Name     | FULL_NAME | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Email Address | EMAIL     | TAGDETAILS_ALLEMPTY |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSN           | SSN       | TAGDETAILS_ALLEMPTY |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IP Address    | IPADDRESS | TAGDETAILS_ALLEMPTY |


    # 7099422
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#21_1_Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag          | fileName  | userTag                                     |
      | Default     | Column | Metadata Type | SSNPII       | SSN       | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | EmailPII     | EMAIL     | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | FullNamePII  | FULL_NAME | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | GenderPII    | GENDER    | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | IPAddressPII | IPADDRESS | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | SSNPII       | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | EmailPII     | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | FullNamePII  | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | GenderPII    | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | IPAddressPII | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |


  @sanity @positive @regression @PIITag
  Scenario:SC#21_2_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%   | Analysis |       |       |


  @sanity @positive @regression @PIITag
  Scenario Outline:SC#22_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OracleDBTag.json                            | $.SC35           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


    #7099423
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#22_2_Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                         | fileName  | userTag                                     |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,EmailPII     | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,GenderPII    | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IPAddressPII | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSNPII       | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,FullNamePII  | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,EmailPII     | EMAIL     | TAGDETAILS_RatioEqualTo05EmptyFalse         |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,GenderPII    | GENDER    | TAGDETAILS_RatioEqualTo05EmptyFalse         |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IPAddressPII | IPADDRESS | TAGDETAILS_RatioEqualTo05EmptyFalse         |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSNPII       | SSN       | TAGDETAILS_RatioEqualTo05EmptyFalse         |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,FullNamePII  | FULL_NAME | TAGDETAILS_RatioEqualTo05EmptyFalse         |


    #7099424
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#23_1_Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag           | fileName  | userTag             |
      | Default     | Column | Metadata Type | SSN           | SSN       | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Email Address | EMAIL     | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Full Name     | FULL_NAME | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Gender        | GENDER    | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | IP Address    | IPADDRESS | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | SSN           | SSN       | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Email Address | EMAIL     | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Full Name     | FULL_NAME | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Gender        | GENDER    | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | IP Address    | IPADDRESS | TAGDETAILS_ALLEMPTY |


  @sanity @positive @regression @PIITag
  Scenario:SC#23_2_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%   | Analysis |       |       |


  @sanity @positive @regression @PIITag
  Scenario Outline:SC#24_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OracleDBTag.json                            | $.SC37    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSCatalogerTagsConfig.json | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSAnalyzerTagsConfig.json  | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


    #7099425
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#24_2_Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.2 - 2 or more rows should have matching column values)- Match Empty is False
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                              |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Email Address | EMAIL     | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Gender        | GENDER    | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSN           | SSN       | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Full Name     | FULL_NAME | TAGDETAILS_Ratiolessthan05EmptyFalse |


  @sanity @positive @regression @PIITag
  Scenario:SC#24_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%   | Analysis |       |       |


  @sanity @positive @regression @PIITag
  Scenario Outline:SC#25_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OracleDBTag.json                            | $.SC38    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSCatalogerTagsConfig.json | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSAnalyzerTagsConfig.json  | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


   #7099426
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#25_2_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag       | fileName  | userTag                                     |
      | Default     | Orc18cRDSAnalyzer | Tags  | SSN       | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Gender    | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Full Name | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                                     |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Email Address | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#26_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OracleDBTag.json                            | $.SC39    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


    #7099427
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#26_2_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is True -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                                     |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Email Address | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSN           | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Full Name     | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |


  @sanity @positive @regression @PIITag
  Scenario:SC#26_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%   | Analysis |       |       |


  @sanity @positive @regression @PIITag
  Scenario Outline:SC#27_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OracleDBTag.json                            | $.SC40    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSCatalogerTagsConfig.json | $.Filter3 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSAnalyzerTagsConfig.json  | $.Filter3 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


   #7099428
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#27_2_Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 1 - all rows should match) - Match Empty is false
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag             |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Email Address | EMAIL     | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Gender        | GENDER    | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IP Address    | IPADDRESS | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSN           | SSN       | TAGDETAILS_ALLMATCH |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Full Name     | FULL_NAME | TAGDETAILS_ALLMATCH |


  @sanity @positive @regression @PIITag
  Scenario:SC#27_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%   | Analysis |       |       |


  @sanity @positive @regression @PIITag
  Scenario Outline:SC#28_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OracleDBTag.json                            | $.SC41    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSCatalogerTagsConfig.json | $.Filter4 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSAnalyzerTagsConfig.json  | $.Filter4 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


  #7099429
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#28_2_Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                             |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Email Address | EMAIL     | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Gender        | GENDER    | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IP Address    | IPADDRESS | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSN           | SSN       | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Full Name     | FULL_NAME | TAGDETAILS_RatioEqualTo05EmptyFalse |


     #7099429
  @sanity @positive @regression @PIITag
  Scenario:SC#28_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%   | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#29_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/policyEngine/OracleDBTag.json                            | $.SC42    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSCatalogerTagsConfig.json | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle18cRDS/pluginConfiguration/Oracle18cRDSAnalyzerTagsConfig.json  | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


     #7099430
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#29_2_Verify Tag is set for the column when namePattern,typePattern,dataPattern and minimumRatio is passed which has a regexp and minimum ratio that matches with the data in column in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                              |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Email Address | EMAIL     | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Gender        | GENDER    | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,SSN           | SSN       | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc18cRDSAnalyzer | Tags  | Orc18cRDSAnalyzer,Oracle,Orc18cRDSCataloger,Oracle18C_RDS_Cat,Oracle18C_RDS_AY,Full Name     | FULL_NAME | TAGDETAILS_Ratiolessthan05EmptyFalse |


  @sanity @positive @regression @PIITag
  Scenario:SC#29_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type                | query | param |
      | SingleItemDelete | Default | idadb18c.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster             |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%    | Analysis            |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%   | Analysis            |       |       |
      | SingleItemDelete | Default | Oracle18C_RDS_Cat                                 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Oracle18C_RDS_AY                                  | BusinessApplication |       |       |


  @jdbc
  Scenario Outline:SC#30_Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle18cRDSCredentials        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle18cRDSInvalidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle18cRDSEmptyCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBAnalyzer                 |      | 204           |                  |          |
