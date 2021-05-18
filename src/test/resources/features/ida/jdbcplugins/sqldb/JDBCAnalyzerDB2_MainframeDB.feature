Feature:Verification of JDBC Analyzer using DB2 Mainframe database and plugin validation

  @jdbc
  Scenario: Catalog creation
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                             | body                                     | response code | response message | jsonPath |
      | application/json |       |       | Post | settings/catalogs               | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                  |          |
      |                  |       |       | Get  | settings/catalogs/DB2%20CATALOG |                                          | 200           | DB2 CATALOG      |          |

  @jdbc
  Scenario: Create a Table with Constraint
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField            |
      | db2mainframe       | EXECUTEQUERY | json/IDA.json | db2QueriesMainframe | createConstraintTable |


  @jdbc
  Scenario: Create Table and insert value for data sampling
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage           | queryField    |
      | db2mainframe       | EXECUTEQUERY | json/IDA.json | db2QueriesMainframe | createTable   |
      | db2mainframe       | EXECUTEQUERY | json/IDA.json | db2QueriesMainframe | insertRecord1 |
      | db2mainframe       | EXECUTEQUERY | json/IDA.json | db2QueriesMainframe | insertRecord2 |
      | db2mainframe       | EXECUTEQUERY | json/IDA.json | db2QueriesMainframe | insertRecord3 |
      | db2mainframe       | EXECUTEQUERY | json/IDA.json | db2QueriesMainframe | insertRecord4 |


  @jdbc
  Scenario: Create JDBC Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body                                                      | response code | response message | jsonPath                                                          |
      | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger                                                            | ida/jdbcAnalyzerPayloads/db2MainframeCatalogerConfig.json | 204           |                  |                                                                   |
      |                  |       |       | Get          | settings/analyzers/UDBCataloger                                                            |                                                           | 200           | DB2Cataloger     |                                                                   |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter |                                                           | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilter')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter  |                                                           | 200           |                  |                                                                   |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter |                                                           | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilter')].status |


#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the Service(DB2 DB) should have the appropriate metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user should be in Subject Area page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "DB2:6209" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField   | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getServiceMD | resultsInMap |
#    Then following "metadata property values" for item "DB2:6209" should match with postgres values stored in "jsonHashMap"
#      | targetSystem |

#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the Database(DB2 DB) should have the appropriate metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user performs "facet selection" in "NA01DC1Q [Database]" attribute under "Parent hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "NA01DC1Q" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField      | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getDatabaseName | resultsInMap |
#    Then following "metadata property values" for item "NA01DC1Q" should match with postgres values stored in "jsonHashMap"
#      | Technical Data |


#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the TableName(DB2 DB) should have the appropriate metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user performs "facet selection" in "QA150A [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "DB2_TAG_DETAILS" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField   | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getTableType | resultsInMap |
#    Then following "metadata property values" for item "DB2_TAG_DETAILS" should match with postgres values stored in "hashMap"
#      | Table Type |


#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the ColumnName(DB2 DB) should have the appropriate metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user performs "facet selection" in "QA150A [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "PROJECTID" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField       | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getColumnDetails | resultsInMap |
#    Then following "metadata property values" for item "PROJECTID" should match with postgres values stored in "jsonHashMap"
#      | Data type |
#      | Length    |

#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the TableName(DB2 DB) should have the appropriate Constraint metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user performs "facet selection" in "QA150A [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Constraint" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "CKP" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField             | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getItemConstraintValue | resultsInMap |
#    Then postgres database query result stored in "linkedhashset" should have following values listed
#      | constraintType |
#      | PRIMARY_KEY    |
#    And user clicks on close button in the item full view page
#    And user performs "item click" on "PROJCONST" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getItemConstraintValue1 | resultsInMap |
#    Then postgres database query result stored in "linkedhashset" should have following values listed
#      | constraintType |
#      | FOREIGN_KEY    |


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC cataloger scans and collects data if schema name alone is provided in filters(DB2 DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "QA150A [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getTableList | name       | returnstringlist | resultsInList |
    And user "verifies" the Item search result "list" value with Postgres DB


  @webtest @jdbc @MLP-5641
  Scenario: Verify the DB2 Table should not have constraints window if the table is not having any constraints.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                     | response code | response message                     | jsonPath                                                                  | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                      |                                                                           | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                    |                                          | 200           | DB2CatalogerWithSchemaAndTableFilter |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter  |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    Then user verify "catalog not contains" any "Constriant" attribute under "Type" facets


  @jdbc
  Scenario: Create JDBC Analyzer Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body                                            | response code | response message | jsonPath                                         |
      | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer                                              | ida/jdbcAnalyzerPayloads/db2AnalyzerConfig.json | 204           |                  |                                                  |
      |                  |       |       | Get          | settings/analyzers/UDBAnalyzer                                              |                                                 | 200           | DB2Analyzer      |                                                  |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer |                                                 | 200           | IDLE             | $.[?(@.configurationName=='DB2Analyzer')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer  |                                                 | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer |                                                 | 200           | IDLE             | $.[?(@.configurationName=='DB2Analyzer')].status |


  @webtest @jdbc @MLP-5358
  Scenario: Verify the Column with datatype timestamp in DB2 DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "DB2DB_LOCALTIME" item from search results
    Then user "verify metadata properties" section has following values
      | Last analyzed at |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getdataTypeTimestampDetails | resultsInMap |
    Then following "metadata property values" for item "DB2_TAG_DETAILS" should match with postgres values stored in "hashMap"
      | Data Type | Length | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |


  @webtest @jdbc @MLP-5358
  Scenario: verify the Created Table Name in DB2DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "DB2_TAG_DETAILS" item from search results
    Then user "verify metadata properties" section has following values
      | Last analyzed at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getTableType1 | resultsInMap |
    Then following "metadata property values" for item "DB2_TAG_DETAILS" should match with postgres values stored in "hashMap"
      | Table Type | Number of rows |


  @webtest @jdbc @MLP-5358
  Scenario: Verify the Column with datatype varchar in DB2 DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "TABLE_PRIMARY [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify metadata property values" with following expected parameters for item "FULL_NAME"
      | Data Type | Length | Maximum length | Maximum value | Minimum length | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |
      | VARCHAR   | 40     | 14             | Lionel Messi  | 11             | Alex Ferguson | 4                         | 100                           | 0                     | 4                       | 100                         |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField               | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getColumnAnalyzedDetails | resultsInMap |
    Then following "metadata property values" for item "DB2_TAG_DETAILS" should match with postgres values stored in "hashMap"
      | Data Type | Length | Maximum length | Maximum value | Minimum length | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |


  @webtest @jdbc @MLP-5358
  Scenario: Verify the Column with datatype decimal in DB2 DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "DB2DB_SALARY" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
      | histogram          |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getdataTypeDecimalDetails | resultsInMap |
    Then following "metadata property values" for item "DB2_TAG_DETAILS" should match with postgres values stored in "hashMap"
      | Data Type | Length | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Standard deviation | Percentage of unique values | Variance |


  @webtest @jdbc @MLP-5641
  Scenario: Verify the count of Schema matched UI and DB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getSchemeList | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC cataloger scans and collects data if schema name and table name is provided in filters(DB2 DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getTableList | name       | returnstringlist | resultsInList |
    And user "verifies" the Item search result "list" value with Postgres DB


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC cataloger scans and collects data if multiple schema name alone is provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                   | body                                     | response code | response message                        | jsonPath                                                                     | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                     | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                         |                                                                              | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                       |                                          | 200           | DB2CatalogerWithMultipleSchemasInFilter |                                                                              |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemasInFilter |                                          | 200           | IDLE                                    | $.[?(@.configurationName=='DB2CatalogerWithMultipleSchemasInFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemasInFilter  |                                          | 200           |                                         |                                                                              |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemasInFilter |                                          | 200           | IDLE                                    | $.[?(@.configurationName=='DB2CatalogerWithMultipleSchemasInFilter')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user should be in Subject Area page
    And user performs "facet selection" in "NA01DC1Q [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getTableList | name       | returnstringlist | resultsInList |
    And user "verifies" the Item search result "list" value with Postgres DB


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC cataloger scans and collects data if single schema name with multiple table names are provided in filters(DB2 DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                        | body                                     | response code | response message                             | jsonPath                                                                          | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                          | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                              |                                                                                   | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                            |                                          | 200           | DB2CatalogerwithSchemaAndMultipleTableFilter |                                                                                   |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithSchemaAndMultipleTableFilter |                                          | 200           | IDLE                                         | $.[?(@.configurationName=='DB2CatalogerwithSchemaAndMultipleTableFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithSchemaAndMultipleTableFilter  |                                          | 200           |                                              |                                                                                   |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithSchemaAndMultipleTableFilter |                                          | 200           | IDLE                                         | $.[?(@.configurationName=='DB2CatalogerwithSchemaAndMultipleTableFilter')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "NA01DC1Q [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "2 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getTableList | name       | returnstringlist | resultsInList |
    And user "verifies" the Item search result "list" value with Postgres DB


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC cataloger scans and collects data if multiple schema names having tables in it are provided in filters(DB2 DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                          | body                                     | response code | response message                               | jsonPath                                                                            | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                            | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                                |                                                                                     | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                              |                                          | 200           | DB2CatalogerWithMultipleSchemaFilterWithTables |                                                                                     |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemaFilterWithTables |                                          | 200           | IDLE                                           | $.[?(@.configurationName=='DB2CatalogerWithMultipleSchemaFilterWithTables')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemaFilterWithTables  |                                          | 200           |                                                |                                                                                     |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemaFilterWithTables |                                          | 200           | IDLE                                           | $.[?(@.configurationName=='DB2CatalogerWithMultipleSchemaFilterWithTables')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "NA01DC1Q [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getTableList | name       | returnstringlist | resultsInList |
    And user "verifies" the Item search result "list" value with Postgres DB


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC cataloger scans and collects data if non existing schema name and table name are provided in filters(DB2 DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                           | body                                     | response code | response message                                | jsonPath                                                                             | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                             | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                                 |                                                                                      | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                               |                                          | 200           | DB2CatalogerwithNonExistingSchemaAndTableFilter |                                                                                      |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithNonExistingSchemaAndTableFilter |                                          | 200           | IDLE                                            | $.[?(@.configurationName=='DB2CatalogerwithNonExistingSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithNonExistingSchemaAndTableFilter  |                                          | 200           |                                                 |                                                                                      |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithNonExistingSchemaAndTableFilter |                                          | 200           | IDLE                                            | $.[?(@.configurationName=='DB2CatalogerwithNonExistingSchemaAndTableFilter')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    Then user verify "catalog not contains" any "Schema" attribute under "Type" facets


  @webtest @jdbc @MLP-6064
  Scenario: Verify the data sampling information in DB2 DB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                     | response code | response message                     | jsonPath                                                                  | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                      |                                                                           | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                    |                                          | 200           | DB2CatalogerWithSchemaAndTableFilter |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter  |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Get             | settings/analyzers/UDBAnalyzer                                                                     |                                          | 200           | DB2Analyzer                          |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                         |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM VIEW MANAGER" list
      | CATALOGS    | SUPPORTED TYPES |
      | DB2 CATALOG | DataSample      |
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "NA01DC1Q [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "DB2_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |


  @webtest @jdbc @MLP-6942
  Scenario: Verify the error message when Configuration credentials are incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                     | response code | response message                     | jsonPath                                                                  | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                      |                                                                           | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                    |                                          | 200           | DB2CatalogerWithIncorrectCredentials |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectCredentials |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithIncorrectCredentials')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectCredentials  |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectCredentials |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithIncorrectCredentials')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "User ID invalid" in Analysis Log of IDC UI


  @webtest @jdbc @MLP-6942
  Scenario: Verify the error message when Configuration url is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                        | body                                     | response code | response message             | jsonPath                                                          | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                          | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                              |                                                                   | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                            |                                          | 200           | DB2CatalogerWithIncorrectURL |                                                                   |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectURL |                                          | 200           | IDLE                         | $.[?(@.configurationName=='DB2CatalogerWithIncorrectURL')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectURL  |                                          | 200           |                              |                                                                   |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectURL |                                          | 200           | IDLE                         | $.[?(@.configurationName=='DB2CatalogerWithIncorrectURL')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "unknown host." in Analysis Log of IDC UI


  @jdbc @webtest @MLP-5359
  Scenario: Verify if Tag is assigned to an Item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                     | response code | response message                     | jsonPath                                                                  | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                      |                                                                           | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                    |                                          | 200           | DB2CatalogerWithSchemaAndTableFilter |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter  |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Get             | settings/analyzers/UDBAnalyzer                                                                     |                                          | 200           | DB2Analyzer                          |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                         |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "State" attribute under "Tags" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName |
      | STATE    |


  @jdbc
  Scenario Outline: : update policy engine with new tag
    Given configure a new REST API for the service "PolicyEngine"
    And user makes a REST Call for Get request with url "policies" and store value of json path"$..[?(@.name=='PII - BusinessGlossary')].id"
    And user makes a REST Call for GET request with url "policies/dynamicID" and save the response in file "rest/payloads/ida/jdbcAnalyzerPayloads/PIIPolicy.json"
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/PIIPolicy.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" file
    And user add new object "values" to file "rest/payloads/ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" with following params using json path "$.actions"
      | jsonNode     | jsonValue                                                 |
      | namePattern  |                                                           |
      | matchEmpty   | false                                                     |
      | typePattern  |                                                           |
      | minimumRatio | 0.7                                                       |
      | matchFull    | true                                                      |
      | dataPattern  | [a-zA-Z0-9]+([a-zA-Z0-9](_\|-\| )[a-zA-Z0-9])*[a-zA-Z0-9] |
      | tags         | Username                                                  |
    And user "add" the json file "ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" file for following values
      | jsonPath       | jsonKey | jsonValues               |
      | $.actions.[11] | id      | structured_data_analysis |
    And endpoint for "<ServiceName>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Header      | Query | Param | type | url                | body                                          | response code | response message |
      | PolicyEngine | multiHeader |       |       | Put  | policies/dynamicID | ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json | 200           |                  |


  @jdbc @webtest @MLP-5359
  Scenario: Verify the newly created Tag is assigned to an Item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                     | response code | response message                     | jsonPath                                                                  | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                      |                                                                           | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                    |                                          | 200           | DB2CatalogerWithSchemaAndTableFilter |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter  |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Get             | settings/analyzers/UDBAnalyzer                                                                     |                                          | 200           | DB2Analyzer                          |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                         |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "Username" attribute under "Tags" facets in Item Search results page
    Then results panel "items count" should be displayed as "2 items were found" in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName    |
      | POSTAL_CODE |
      | STATE       |


  @jdbc
  Scenario Outline: update the policy pattern tag
    Given configure a new REST API for the service "PolicyEngine"
    And user makes a REST Call for Get request with url "policies" and store value of json path"$..[?(@.name=='PII - BusinessGlossary')].id"
    And user "update" the json file "ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" file for following values
      | jsonPath                               | jsonValues                               |
      | $..[?(@.tags=='Username')].dataPattern | (m\|M\|male\|Male\|f\|F\|female\|Female) |
    And endpoint for "<ServiceName>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Header      | Query | Param | type | url                | body                                          | response code | response message |
      | PolicyEngine | multiHeader |       |       | Put  | policies/dynamicID | ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json | 200           |                  |


  @jdbc @webtest @MLP-5359
  Scenario: Verify the updated Tag is assigned to an Item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                     | response code | response message                     | jsonPath                                                                  | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                      |                                                                           | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                    |                                          | 200           | DB2CatalogerWithSchemaAndTableFilter |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter  |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Get             | settings/analyzers/UDBAnalyzer                                                                     |                                          | 200           | DB2Analyzer                          |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                         |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "Username" attribute under "Tags" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName |
      | GENDER   |


  @jdbc
  Scenario Outline: user reset the default policy engine tags
    Given configure a new REST API for the service "PolicyEngine"
    And user makes a REST Call for Get request with url "policies" and store value of json path"$..[?(@.name=='PII - BusinessGlossary')].id"
    And endpoint for "<ServiceName>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Header       | Query | Param | type | url                | body                                    | response code | response message |
      | PolicyEngine | Content-Type |       |       | Put  | policies/dynamicID | ida/jdbcAnalyzerPayloads/PIIPolicy.json | 200           |                  |


  @jdbc @webtest @MLP-5359
  Scenario: Verify the removed Tag is not present after Analyzing
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                     | response code | response message                     | jsonPath                                                                  | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                      |                                                                           | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                    |                                          | 200           | DB2CatalogerWithSchemaAndTableFilter |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter  |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |             |
      |                  |       |       | Get             | settings/analyzers/UDBAnalyzer                                                                     |                                          | 200           | DB2Analyzer                          |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                         |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer                        |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2Analyzer')].status                          |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    Then user verify "catalog not contains" any "Date" attribute under "Tags" facets


  @webtest @jdbc @MLP-6281
  Scenario: Verify the JDBC Cataloger scans and collects data when no filter options are provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                        | body                                     | response code | response message | jsonPath                                          | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                          | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                  |                                                   | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                            |                                          | 200           | DB2Cataloger     |                                                   |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2Cataloger |                                          | 200           | IDLE             | $.[?(@.configurationName=='DB2Cataloger')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2Cataloger  |                                          | 200           |                  |                                                   |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2Cataloger |                                          | 200           | IDLE             | $.[?(@.configurationName=='DB2Cataloger')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "QA150A [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2QueriesMainframe | getTableList | name       | returnstringlist | resultsInList |
    And user "verifies" the Item search result "list" value with Postgres DB


  @jdbc
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                             | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/UDBCataloger |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBAnalyzer  |      | 204           |                  |          |


  @jdbc
  Scenario: Drop Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema | Table           | Database |
      | db2mainframe       | DROP      | QA150A | TABLE_PRIMARY   |          |
      | db2mainframe       | DROP      | QA150A | DB2_TAG_DETAILS |          |

  @jdbc
  Scenario: Delete Catalog
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                             | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/catalogs/DB2%20CATALOG |      | 204           |                  |          |



