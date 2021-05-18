Feature:Verification of Scan UDB Analyzer using DB2 database and plugin validation


  @jdbc
  Scenario: Catalog creation
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                             | body                                     | response code | response message | jsonPath |
      | application/json |       |       | Post | settings/catalogs               | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                  |          |
      |                  |       |       | Get  | settings/catalogs/DB2%20CATALOG |                                          | 200           | DB2 CATALOG      |          |

  @jdbc
  Scenario: Create Table in DB2
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage  | queryField                |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | createConstraintTable     |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | createEmptyTimeStampTable |


  @jdbc
  Scenario: Create Table and insert value for data sampling
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage  | queryField    |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | createTable   |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertRecord1 |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertRecord2 |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertRecord3 |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertRecord4 |


  @jdbc
  Scenario: Create table for Timestamp verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage  | queryField            |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | createTimeStampTable  |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertTimeStampRecord |


  @jdbc
  Scenario: Create JDBC Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body                                             | response code | response message | jsonPath                                                          |
      | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger                                                            | ida/jdbcAnalyzerPayloads/db2CatalogerConfig.json | 204           |                  |                                                                   |
      |                  |       |       | Get          | settings/analyzers/UDBCataloger                                                            |                                                  | 200           | DB2Cataloger     |                                                                   |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter |                                                  | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilter')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter  |                                                  | 200           |                  |                                                                   |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter |                                                  | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilter')].status |


#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the Service(DB2 DB) should have the appropriate metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user should be in Subject Area page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "DB2:50000" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField   | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getServiceMD | resultsInMap |
#    Then following "metadata property values" for item "DB2:50000" should match with postgres values stored in "jsonHashMap"
#      | targetSystem |


#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the Database(DB2 DB) should have the appropriate metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "SAMPLE" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField      | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getDatabaseName | resultsInMap |
#    Then following "metadata property values" for item "SAMPLE" should match with postgres values stored in "jsonHashMap"
#      | Technical Data |


#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the TableName(DB2 DB) should have the appropriate metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user performs "definite facet selection" in "Table" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "TAG_DETAILS" item from search results
#    Then user "verify metadata properties" section has following values
#      | Last catalogued at |
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField   | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getTableType | resultsInMap |
#    Then following "metadata property values" for item "TAG_DETAILS" should match with postgres values stored in "jsonHashMap"
#      | Table Type |


#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the ColumnName(DB2 DB) should have the appropriate metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user performs "facet selection" in "TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "EMAIL" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField       | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getColumnDetails | resultsInMap |
#    Then following "metadata property values" for item "EMAIL" should match with postgres values stored in "jsonHashMap"
#      | Data type |
#      | Length    |

#  @webtest @jdbc @MLP-5641
#  Scenario: Verify the TableName(DB2 DB) should have the appropriate Constraint metadata information in IDC UI and Database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "DB2 CATALOG" from Catalog list
#    And user performs "facet selection" in "TABLE_PRIMARY [Table]" attribute under "Parent hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Constraint" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "CKP" item from search results
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField             | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getItemConstraintValue | resultsInMap |
#    Then following "metadata property values" for item "CKP" should match with postgres values stored in "jsonHashMap"
#      | Constraint Type |


  @webtest @jdbc
  Scenario: Verify the breadcrumb hierarchy appears correctly when ScanUDB cataloger is ran for DB2 Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "POSTAL_CODE" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | gechcae-col1.asg.com |
      | DB2:50000            |
      | SAMPLE               |
      | UDBTEST1             |
      | DB2_TAG_DETAILS      |
      | POSTAL_CODE          |


  @webtest @jdbc
  Scenario: Verify the technology tags got assigned to all DB2 database items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName | name           | facet | Tag                      |
      | DB2 CATALOG | Column         | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Table          | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Analysis       | Type  | DB2,Relational Databases |
      | DB2 CATALOG | Schema         | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Cluster        | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Database       | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Service        | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Constraint     | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Tablespace     | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Index          | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | Bufferpool     | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | User           | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | PartitionGroup | Type  | DB2,RELATIONAL DATABASES |
      | DB2 CATALOG | StorageGroup   | Type  | DB2,RELATIONAL DATABASES |


  @webtest @jdbc
  Scenario: Verify proper error message is shown if mandatory fields are not filled in UDBCataloger plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "UDBCataloger" plugin config list in Plugin Manager page
    And user add button in "UDBCATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | URL                   |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName  | pluginConfigFieldValue |
      | UDB DRIVER BUNDLE NAME |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | USER                  |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | PASSWORD              |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | NAME                                             |
      | errorMessage | Name field should not be empty                   |
      | fieldName    | URL                                              |
      | errorMessage | URL field should not be empty                    |
      | fieldName    | UDB DRIVER BUNDLE NAME                           |
      | errorMessage | UDB Driver Bundle Name field should not be empty |
      | fieldName    | USER                                             |
      | errorMessage | User field should not be empty                   |
      | fieldName    | PASSWORD                                         |
      | errorMessage | Password field should not be empty               |


  @webtest @jdbc
  Scenario: Verify proper error message is shown if mandatory fields are not filled in UDBCAnalyzer plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "UDBAnalyzer" plugin config list in Plugin Manager page
    And user add button in "UDBANALYZER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | NAME                           |
      | errorMessage | Name field should not be empty |

  @webtest @jdbc
  Scenario: Verify the error message when Configuration BundleDriver is incorrect in DB2
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                              | body                                     | response code | response message                   | jsonPath                                                                | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                    |                                                                         | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/catalogs/DB2%20CATALOG                                                                  |                                          | 200           | DB2 CATALOG                        |                                                                         |              |             |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                  |                                          | 200           | DB2CatalogerWithIncorretBundleName |                                                                         |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorretBundleName  |                                          | 200           |                                    |                                                                         |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorretBundleName |                                          | 200           | IDLE                               | $.[?(@.configurationName=='DB2CatalogerWithIncorretBundleName')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Bundle com.ibm.db2 not found" in Analysis Log of IDC UI


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


  @jdbc @webtest @MLP-5359
  Scenario: Verify Tag is assigned to an Item
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "State" attribute under "Tags" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName |
      | STATE    |


  @webtest @jdbc @MLP-5358
  Scenario: verify the Created Table Name in DB2DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "DB2_TAG_DETAILS" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getTableType1 | resultsInMap |
    Then following "metadata property values" for item "DB2_TAG_DETAILS" should match with postgres values stored in "jsonHashMap"
      | Table Type | Number of rows |

  @webtest @jdbc @MLP-5358
  Scenario: Verify the Column with datatype varchar in DB2 DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify metadata property values" with following expected parameters for item "FULL_NAME"
      | Data type | Length | Maximum length | Maximum value | Minimum length | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |
      | VARCHAR   | 40     | 14             | Lionel Messi  | 11             | Alex Ferguson | 4                         | 100                           | 0                     | 4                       | 100                         |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField               | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getColumnAnalyzedDetails | resultsInMap |
    Then following "metadata property values" for item "FULL_NAME" should match with postgres values stored in "jsonHashMap"
      | Data type | Length | Maximum length | Maximum value | Minimum length | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |


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
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getdataTypeDecimalDetails | resultsInMap |
    Then following "metadata property values" for item "DB2DB_SALARY" should match with postgres values stored in "jsonHashMap"
      | Data type | Length | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField                   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getdataTypeBigDecimalDetails | resultsInMap |
    Then following "metadata property values" for item "DB2DB_SALARY" should match with postgres values stored in "hashMapWithBigDecimals"
      | Median | Standard deviation | Variance |

  @webtest @jdbc @MLP-5358
  Scenario: Verify the Column with datatype timestamp in DB2 DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "DB2DB_LOCALTIME" item from search results
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getdataTypeTimestampDetails | resultsInMap |
    Then following "metadata property values" for item "DB2DB_LOCALTIME" should match with postgres values stored in "jsonHashMap"
      | Data type | Length | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |


  @webtest @jdbc @MLP-5641
  Scenario: Verify the count of Schema matched UI and DB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getSchemeList | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC cataloger scans and collects data if schema name alone is provided in filters(DB2 DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                        | body                                     | response code | response message             | jsonPath                                                          | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                          | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                              |                                                                   | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                            |                                          | 200           | DB2CatalogerWithSchemaFilter |                                                                   |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter |                                          | 200           | IDLE                         | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilter')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter  |                                          | 200           |                              |                                                                   |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter |                                          | 200           | IDLE                         | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilter')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "UDBTEST1 [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getTableList | name       | returnstringlist | resultsInList |
    And user "verifies" the Item search result "list" value with Postgres DB


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC cataloger scans and collects data if schema name and table name is provided in filters(DB2 DB)
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
    And user performs "definite facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getTableList | name       | returnstringlist | resultsInList |
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
    And user performs "facet selection" in "SAMPLE [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getTableList | name       | returnstringlist | resultsInList |
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
    And user performs "facet selection" in "SAMPLE [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getTableList | name       | returnstringlist | resultsInList |
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
    And user performs "facet selection" in "SAMPLE [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField   | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getTableList | name       | returnstringlist | resultsInList |
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
    And user performs "facet selection" in "SAMPLE [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Type" facets in Item Search results page
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
    And user "verify analysis log contains" presence of "User ID or Password invalid" in Analysis Log of IDC UI


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


  @jdbc
  Scenario Outline:  Update policy engine with new tag
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
  Scenario Outline: Update the policy pattern tag
    Given configure a new REST API for the service "PolicyEngine"
    And user makes a REST Call for Get request with url "policies" and store value of json path"$..[?(@.name=='PII - BusinessGlossary')].id"
    And user "update" the json file "ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" file for following values
      | jsonPath                               | jsonValues                               |
      | $..[?(@.tags=='Username')].dataPattern | (m\|M\|male\|Male\|f\|F\|female\|Female) |
      | $..[?(@.tags=='Username')].tags        | UsernameUpdated                          |
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
    And user performs "facet selection" in "UsernameUpdated" attribute under "Tags" facets in Item Search results page
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
    Then user verify "catalog not contains" any "UsernameUpdated" attribute under "Tags" facets


  @webtest @jdbc @MLP-6281
  Scenario: Verify JDBC Cataloge scans and displays item when no Filters are provided
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
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "23 items were found" in Item Search results page


  @jdbc @webtest @MLP-7325
  Scenario: Verify the data profiling metadata for string,numeric,date,time,timestamp datatypes metrics does not get calculated for empty table(DB2)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                     | body                                     | response code | response message          | jsonPath                                                       | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                       | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                           |                                                                | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                         |                                          | 200           | DB2CatalogerWithTimeStamp |                                                                |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithTimeStamp |                                          | 200           | IDLE                      | $.[?(@.configurationName=='DB2CatalogerWithTimeStamp')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithTimeStamp  |                                          | 200           |                           |                                                                |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithTimeStamp |                                          | 200           | IDLE                      | $.[?(@.configurationName=='DB2CatalogerWithTimeStamp')].status |              |             |
      |                  |       |       | Get             | settings/analyzers/UDBAnalyzer                                                          |                                          | 200           | DB2Analyzer               |                                                                |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer             |                                          | 200           | IDLE                      | $.[?(@.configurationName=='DB2Analyzer')].status               |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer              |                                          | 200           |                           |                                                                |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/DB2Analyzer             |                                          | 200           | IDLE                      | $.[?(@.configurationName=='DB2Analyzer')].status               |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_EMPTY [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "ID" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    And user "verify metadata properties" section does not have the following values
      | Average | Maximum value | Median | Minimum value |
    And user clicks on close button in the item full view page
    And user performs "item click" on "NAME" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    And user "verify metadata properties" section does not have the following values
      | Maximum length | Maximum value | Minimum length | Minimum value |
    And user clicks on close button in the item full view page
    And user performs "item click" on "DATE1" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    And user "verify metadata properties" section does not have the following values
      | Number of non null values | Maximum value | Number of non null values | Minimum value |
    And user clicks on close button in the item full view page
    And user performs "item click" on "DATE2" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    And user "verify metadata properties" section does not have the following values
      | Number of non null values | Maximum value | Number of non null values | Minimum value |
    And user clicks on close button in the item full view page
    And user performs "item click" on "DATE3" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    And user "verify metadata properties" section does not have the following values
      | Number of non null values | Maximum value | Number of non null values | Minimum value |


  @jdbc @webtest @MLP-7325
  Scenario: Verify the data profiling metadata for date,time,timestamp datatypes and should have the appropriate metadata information in IDC UI and Database(DB2)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "DB2_TABLE [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "ID" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    Then user "verify metadata property values" with following expected parameters for item "ID"
      | Average | Data type | ID                     | Length | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Standard deviation | Number of unique values | Percentage of unique values | Variance |
      | 100     | INTEGER   | DB2 CATALOG.Column:::6 | 4      | 100           | 100    | 100           | 1                         | 100                           | 0                     | 0                  | 1                       | 100                         | 0        |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getDataTypeMDdetails1 | resultsInMap |
    Then following "metadata property values" for item "ID" should match with postgres values stored in "map"
      | Technical Data | topValues |
    And user clicks on close button in the item full view page
    And user performs "item click" on "NAME" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    Then user "verify metadata property values" with following expected parameters for item "NAME"
      | Data type | ID                      | Length | Maximum value | Maximum length | Minimum length | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |
      | VARCHAR   | DB2 CATALOG.Column:::10 | 20     | Test Name     | 9              | 9              | Test Name     | 1                         | 100                           | 0                     | 1                       | 100                         |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getDataTypeMDdetails2 | resultsInMap |
    Then following "metadata property values" for item "NAME" should match with postgres values stored in "map"
      | Technical Data | topValues |
    And user clicks on close button in the item full view page
    And user performs "item click" on "DATE1" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    Then user "verify metadata property values" with following expected parameters for item "DATE1"
      | Data type | ID                     | Length | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |
      | DATE      | DB2 CATALOG.Column:::9 | 4      | 2000-01-01    | 2000-01-01    | 1                         | 100                           | 0                     | 1                       | 100                         |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getDataTypeMDdetails3 | resultsInMap |
    Then following "metadata property values" for item "DATE1" should match with postgres values stored in "map"
      | Technical Data | topValues |
    And user clicks on close button in the item full view page
    And user performs "item click" on "DATE2" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    Then user "verify metadata property values" with following expected parameters for item "DATE2"
      | Data type | ID                     | Length | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |
      | TIME      | DB2 CATALOG.Column:::8 | 3      | 00:00:00      | 00:00:00      | 1                         | 100                           | 0                     | 1                       | 100                         |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getDataTypeMDdetails4 | resultsInMap |
    Then following "metadata property values" for item "DATE2" should match with postgres values stored in "map"
      | Technical Data | topValues |
    And user clicks on close button in the item full view page
    And user performs "item click" on "DATE3" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at |
    Then user "verify metadata property values" with following expected parameters for item "DATE3"
      | Data type | ID                     | Length | Maximum value         | Minimum value         | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |
      | TIMESTAMP | DB2 CATALOG.Column:::7 | 10     | 2000-01-01 00:00:00.0 | 2000-01-01 00:00:00.0 | 1                         | 100                           | 0                     | 1                       | 100                         |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage  | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | db2Queries | getDataTypeMDdetails5 | resultsInMap |
    Then following "metadata property values" for item "DATE3" should match with postgres values stored in "map"
      | Technical Data | topValues |


  @jdbc @webtest @MLP-7325
  Scenario: Verify ScanUDBcataloger does not scans and collects and any data if database passed in URL is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                     | response code | response message                     | jsonPath                                                                  | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                      |                                                                           | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                    |                                          | 200           | DB2CatalogerWithIncorrectDatabaseURL |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectDatabaseURL |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithIncorrectDatabaseURL')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectDatabaseURL  |                                          | 200           |                                      |                                                                           |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectDatabaseURL |                                          | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithIncorrectDatabaseURL')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "An attempt was made to access a database, check, which was either not found or does not support transactions" in Analysis Log of IDC UI


  @jdbc @webtest @MLP-7325
  Scenario: Verify ScanUDBCataloger does not scans and collects and any data if username and password are not provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                 | body                                     | response code | response message                      | jsonPath                                                                   | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                   | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                       |                                                                            | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                     |                                          | 200           | DB2CatalogerWithNoUsernameAndPassword |                                                                            |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithNoUsernameAndPassword |                                          | 200           | IDLE                                  | $.[?(@.configurationName=='DB2CatalogerWithNoUsernameAndPassword')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithNoUsernameAndPassword  |                                          | 200           |                                       |                                                                            |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithNoUsernameAndPassword |                                          | 200           | IDLE                                  | $.[?(@.configurationName=='DB2CatalogerWithNoUsernameAndPassword')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |

  @jdbc @webtest @MLP-7325
  Scenario: Verify ScanUDBCataloger does not collect any DB items and log throws error when the jdbc url is for databases other than DB2(postgress and oracle)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                             | body                                     | response code | response message                  | jsonPath                                                               | endpointType | itemName    |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                               | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                   |                                                                        | catalog      | DB2 CATALOG |
      |                  |       |       | Get             | settings/analyzers/UDBCataloger                                                                 |                                          | 200           | DB2CatalogerWithOracleDatabaseURL |                                                                        |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithOracleDatabaseURL |                                          | 200           | IDLE                              | $.[?(@.configurationName=='DB2CatalogerWithOracleDatabaseURL')].status |              |             |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithOracleDatabaseURL  |                                          | 200           |                                   |                                                                        |              |             |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithOracleDatabaseURL |                                          | 200           | IDLE                              | $.[?(@.configurationName=='DB2CatalogerWithOracleDatabaseURL')].status |              |             |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "DB2 CATALOG" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
    And Execute REST API with following parameters
      | Header | Query | Param | type            | url                                                                                               | body                                     | response code | response message                    | jsonPath                                                                 | endpointType | itemName    |
      |        |       |       | DeleteAndCreate | settings/catalogs                                                                                 | ida/jdbcAnalyzerPayloads/db2Catalog.json | 204           |                                     |                                                                          | catalog      | DB2 CATALOG |
      |        |       |       | Get             | settings/analyzers/UDBCataloger                                                                   |                                          | 200           | DB2CatalogerWithPostgresDatabaseURL |                                                                          |              |             |
      |        |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithPostgresDatabaseURL |                                          | 200           | IDLE                                | $.[?(@.configurationName=='DB2CatalogerWithPostgresDatabaseURL')].status |              |             |
      |        |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithPostgresDatabaseURL  |                                          | 200           |                                     |                                                                          |              |             |
      |        |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithPostgresDatabaseURL |                                          | 200           | IDLE                                | $.[?(@.configurationName=='DB2CatalogerWithPostgresDatabaseURL')].status |              |             |
    And user select "DB2 CATALOG" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |

  @jdbc
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                             | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/UDBCataloger |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBAnalyzer  |      | 204           |                  |          |


  @jdbc
  Scenario: Drop Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema   | Table           | Database |
      | db2                | DROP      | UDBTEST1 | TABLE_PRIMARY   |          |
      | db2                | DROP      | UDBTEST1 | DB2_TAG_DETAILS |          |
      | db2                | DROP      | UDBTEST1 | DB2_EMPTY       |          |
      | db2                | DROP      | UDBTEST1 | DB2_TABLE       |          |

  @jdbc
  Scenario: Delete Catalog
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                             | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/catalogs/DB2%20CATALOG |      | 204           |                  |          |



