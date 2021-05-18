Feature: Azure SQL Database Cataloger


  @jdbc
  Scenario: Catalog creation
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                  | body                                      | response code | response message | jsonPath |
      | application/json |       |       | Post | settings/catalogs                    | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                  |          |
      |                  |       |       | Get  | settings/catalogs/AZURESQL%20CATALOG |                                           | 200           | AZURESQL CATALOG |          |


  @jdbc
  Scenario: Create JDBC Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body                                              | response code | response message  | jsonPath                                               |
      | application/json | raw   | false | Put          | settings/analyzers/AzureSQLDatabaseCataloger                                                 | ida/AzureSQLPayloads/azureSQLCatalogerConfig.json | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/analyzers/AzureSQLDatabaseCataloger                                                 |                                                   | 200           | AzureSqlCataloger |                                                        |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCataloger |                                                   | 200           | IDLE              | $.[?(@.configurationName=='AzureSqlCataloger')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCataloger  |                                                   | 200           |                   |                                                        |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCataloger |                                                   | 200           | IDLE              | $.[?(@.configurationName=='AzureSqlCataloger')].status |


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects data if schema name and table names are not provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "15 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getSchemaList | rowCount     |
    Then Postgres item count for "Field" attribute should be "15"
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "28 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getTableList | rowCount     |
    Then Postgres item count for "Field" attribute should be "20"


  @webtest @jdbc @MLP-7718
  Scenario: Verify the Service/Host should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "AZURE SQL Server" item from search results
    Then user "verify metadata property values" with following expected parameters for item "AZURE SQL Server"
      | Application Version            | ID                           |
      | Microsoft SQL Server12.00.1400 | AZURESQL CATALOG.Service:::1 |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getServiceMD | resultsInMap |
    Then following "metadata property values" for item "AZURE SQL Server" should match with postgres values stored in "hashMap"
      | Application Version |
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Host" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "asg-jdbc.database.windows.net" item from search results
    Then user "verify metadata property values" with following expected parameters for item "asg-jdbc.database.windows.net"
      | Number of cores | Host name                     | ID                        |
      | 0               | asg-jdbc.database.windows.net | AZURESQL CATALOG.Host:::1 |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getHostMD  | resultsInMap |
    Then following "metadata property values" for item "asg-jdbc.database.windows.net" should match with postgres values stored in "hashMap"
      | Host name |


  @webtest @jdbc @MLP-7718
  Scenario: Verify the Database Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "asg-jdbc" item from search results
    Then user "verify metadata property values" with following expected parameters for item "asg-jdbc"
      | Storage type                   | ID                            |
      | Microsoft SQL Server12.00.1400 | AZURESQL CATALOG.Database:::1 |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | asg-jdbc                                 |
      | attributeName  | Technical Data                           |
      | actualFilePath | ida/AzureSQLPayloads/actualTechData.json |
    And user "update" the json file "ida/AzureSQLPayloads/actualTechData.json" file for following values
      | jsonPath        | jsonValues |
      | $..['password'] |            |
    Then user verifies the presence of json "file value" in the json file
      | actualFilePath                           | jsonPath | jsonValue | expectedFilePath                           |
      | ida/AzureSQLPayloads/actualTechData.json | $        |           | ida/AzureSQLPayloads/expectedTechData.json |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getDatabaseMD | resultsInMap |
    Then following "metadata property values" for item "asg-jdbc" should match with postgres values stored in "jsonHashMap"
      | Technical Data | Storage type |


  @webtest @jdbc @MLP-7718
  Scenario: Verify the Table Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "employee [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "employee" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    Then user "verify metadata property values" with following expected parameters for item "employee"
      | Table Type |
      | TABLE      |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getTableMD | resultsInMap |
    Then following "metadata property values" for item "employee" should match with postgres values stored in "jsonHashMap"
      | Table Type |


  @webtest @jdbc @MLP-7718
  Scenario: Verify the column Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "employee [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "empid" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    Then user "verify metadata property values" with following expected parameters for item "empid"
      | Data type | Length |
      | INTEGER   | 10     |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | empid                                    |
      | attributeName  | Technical Data                           |
      | actualFilePath | ida/AzureSQLPayloads/actualTechData.json |
    Then user verifies the presence of json "file value" in the json file
      | actualFilePath                           | jsonPath | jsonValue | expectedFilePath                                 |
      | ida/AzureSQLPayloads/actualTechData.json | $        |           | ida/AzureSQLPayloads/expectedColumnTechData.json |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getColumnMD | resultsInMap |
    Then following "metadata property values" for item "empid" should match with postgres values stored in "jsonHashMap"
      | Technical Data | Data type | Length |


  @webtest @jdbc @MLP-7718
  Scenario: Verify the Table should not have constraints window if the table is not having any constraints.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "diffdatatypes [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    Then user verify "catalog not contains" any "Constriant" attribute under "Type" facets


  @webtest @jdbc @MLP-7718
  Scenario: Verify the Table should have constraints window with the Primary Key and Foreign key,Unique key constraints available.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "ProductModelProductDescription [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "PK_ProductModelProductDescription_ProductModelID_ProductDescriptionID_Culture" item from search results
    Then user "verify metadata property values" with following expected parameters for item "PK_ProductModel"
      | Constraint Type | ID                               |
      | PRIMARY_KEY     | AZURESQL CATALOG.Constraint:::33 |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getConstraintPrimaryKeyMD | resultsInMap |
    Then following "metadata property values" for item "PK_ProductModel" should match with postgres values stored in "jsonHashMap"
      | Constraint Type |
    Then user clicks on close button in the item full view page
    And user performs "item click" on "FK_ProductModelProductDescription_ProductModel_ProductModelID" item from search results
    Then user "verify metadata property values" with following expected parameters for item "FK_ProductModel"
      | Constraint Type |
      | FOREIGN_KEY     |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getConstraintForeignKeyMD | resultsInMap |
    Then following "metadata property values" for item "FK_ProductModel" should match with postgres values stored in "jsonHashMap"
      | Constraint Type |
    Then user clicks on close button in the item full view page
    And user performs "item click" on "AK_ProductModelProductDescription_rowguid" item from search results
    Then user "verify metadata property values" with following expected parameters for item "AK_ProductModel"
      | Constraint Type |
      | UNIQUE          |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getConstraintUniqueMD | resultsInMap |
    Then following "metadata property values" for item "AK_ProductModel" should match with postgres values stored in "jsonHashMap"
      | Constraint Type |


  @webtest @jdbc @MLP-7718
  Scenario:  Verify JDBC cataloger scans and collects data if schema name alone is provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                          | body                                      | response code | response message                  | jsonPath                                                               | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                            | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                   |                                                                        | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                 |                                           | 200           | AzureSqlCatalogerWithSchemaFilter |                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaFilter |                                           | 200           | IDLE                              | $.[?(@.configurationName=='AzureSqlCatalogerWithSchemaFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaFilter  |                                           | 200           |                                   |                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaFilter |                                           | 200           | IDLE                              | $.[?(@.configurationName=='AzureSqlCatalogerWithSchemaFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "dbo [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | ErrorLog      |
      | BuildVersion  |
      | diffdatatypes |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | BuildVersion  |
      | diffdatatypes |
      | ErrorLog      |


  @webtest @jdbc @MLP-7718
  Scenario:  Verify JDBC cataloger scans and collects data if multiple schema names having tables in it are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                          | body                                      | response code | response message                                  | jsonPath                                                                               | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                            | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                                   |                                                                                        | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                                 |                                           | 200           | AzureSqlCatalogerWithMultipleSchemaAndTableFilter |                                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithMultipleSchemaAndTableFilter |                                           | 200           | IDLE                                              | $.[?(@.configurationName=='AzureSqlCatalogerWithMultipleSchemaAndTableFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithMultipleSchemaAndTableFilter  |                                           | 200           |                                                   |                                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithMultipleSchemaAndTableFilter |                                           | 200           | IDLE                                              | $.[?(@.configurationName=='AzureSqlCatalogerWithMultipleSchemaAndTableFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema |
      | dbo        |
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "dbo [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | BuildVersion  |
      | diffdatatypes |
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "testschema [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | department |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | BuildVersion  |
      | diffdatatypes |
      | department    |


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects data if schema name and table name are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                  | body                                      | response code | response message                          | jsonPath                                                                       | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                    | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                           |                                                                                | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                         |                                           | 200           | AzureSqlCatalogerWithSchemaAndTableFilter |                                                                                |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndTableFilter |                                           | 200           | IDLE                                      | $.[?(@.configurationName=='AzureSqlCatalogerWithSchemaAndTableFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndTableFilter  |                                           | 200           |                                           |                                                                                |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndTableFilter |                                           | 200           | IDLE                                      | $.[?(@.configurationName=='AzureSqlCatalogerWithSchemaAndTableFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | dbo |
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | BuildVersion |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | BuildVersion |


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects data if single schema name with multiple table names are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                          | body                                      | response code | response message                                  | jsonPath                                                                               | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                            | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                                   |                                                                                        | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                                 |                                           | 200           | AzureSqlCatalogerWithSchemaAndMultipleTableFilter |                                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndMultipleTableFilter |                                           | 200           | IDLE                                              | $.[?(@.configurationName=='AzureSqlCatalogerWithSchemaAndMultipleTableFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndMultipleTableFilter  |                                           | 200           |                                                   |                                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndMultipleTableFilter |                                           | 200           | IDLE                                              | $.[?(@.configurationName=='AzureSqlCatalogerWithSchemaAndMultipleTableFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | dbo |
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | diffdatatypes |
      | BuildVersion  |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | BuildVersion  |
      | diffdatatypes |


  @webtest @jdbc @MLP-7718
  Scenario: Verify table name alone can be provided without a schema name in JDBC cataloger filters and it should search across all schemas.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                         | body                                      | response code | response message                 | jsonPath                                                              | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                           | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                  |                                                                       | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                |                                           | 200           | AzureSqlCatalogerWithTableFilter |                                                                       |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithTableFilter |                                           | 200           | IDLE                             | $.[?(@.configurationName=='AzureSqlCatalogerWithTableFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithTableFilter  |                                           | 200           |                                  |                                                                       |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithTableFilter |                                           | 200           | IDLE                             | $.[?(@.configurationName=='AzureSqlCatalogerWithTableFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema |
      | dbo        |
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | diffdatatypes |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | diffdatatypes |


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects data if multiple schema name alone is provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                  | body                                      | response code | response message                          | jsonPath                                                                       | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                    | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                           |                                                                                | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                         |                                           | 200           | AzureSqlCatalogerWithMultipleSchemaFilter |                                                                                |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithMultipleSchemaFilter |                                           | 200           | IDLE                                      | $.[?(@.configurationName=='AzureSqlCatalogerWithMultipleSchemaFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithMultipleSchemaFilter  |                                           | 200           |                                           |                                                                                |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithMultipleSchemaFilter |                                           | 200           | IDLE                                      | $.[?(@.configurationName=='AzureSqlCatalogerWithMultipleSchemaFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema |
      | dbo        |
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "16 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getTableList | rowCount     |
    Then Postgres item count for "Field" attribute should be "8"


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects Table and columns properly if the table contains possible different built in data types
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                           | body                                      | response code | response message   | jsonPath                                                | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                             | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                    |                                                         | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                  |                                           | 200           | AzureSqlCataloger1 |                                                         |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCataloger1 |                                           | 200           | IDLE               | $.[?(@.configurationName=='AzureSqlCataloger1')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCataloger1  |                                           | 200           |                    |                                                         |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCataloger1 |                                           | 200           | IDLE               | $.[?(@.configurationName=='AzureSqlCataloger1')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "diffdatatypes [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "27 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getColumnList | rowCount     |
    Then Postgres item count for "Field" attribute should be "27"


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects Table and columns properly if the table contains possible different user defined data types
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "usertype [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "3 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField     | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLdbQueries | getColumnList1 | rowCount     |
    Then Postgres item count for "Field" attribute should be "3"

  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects data if non existing schema name and table name are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                             | body                                      | response code | response message                                     | jsonPath                                                                                  | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                               | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                                      |                                                                                           | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                                    |                                           | 200           | AzureSqlCatalogerWithNonExistingSchemaAndTableFilter |                                                                                           |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNonExistingSchemaAndTableFilter |                                           | 200           | IDLE                                                 | $.[?(@.configurationName=='AzureSqlCatalogerWithNonExistingSchemaAndTableFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNonExistingSchemaAndTableFilter  |                                           | 200           |                                                      |                                                                                           |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNonExistingSchemaAndTableFilter |                                           | 200           | IDLE                                                 | $.[?(@.configurationName=='AzureSqlCatalogerWithNonExistingSchemaAndTableFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Service  |
    Then user verify "catalog not contains" any "Schema" attribute under "Type" facets
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects data if existing schema name and non existing table name are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                             | body                                      | response code | response message                                     | jsonPath                                                                                  | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                               | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                                      |                                                                                           | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                                    |                                           | 200           | AzureSqlCatalogerWithSchemaAndNonExistingTableFilter |                                                                                           |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndNonExistingTableFilter |                                           | 200           | IDLE                                                 | $.[?(@.configurationName=='AzureSqlCatalogerWithSchemaAndNonExistingTableFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndNonExistingTableFilter  |                                           | 200           |                                                      |                                                                                           |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithSchemaAndNonExistingTableFilter |                                           | 200           | IDLE                                                 | $.[?(@.configurationName=='AzureSqlCatalogerWithSchemaAndNonExistingTableFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Schema   |
      | Service  |
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger scans and collects data if  schema name is not provided and non existing table name are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                    | body                                      | response code | response message                            | jsonPath                                                                         | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                      | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                             |                                                                                  | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                           |                                           | 200           | AzureSqlCatalogerWithNonExistingTableFilter |                                                                                  |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNonExistingTableFilter |                                           | 200           | IDLE                                        | $.[?(@.configurationName=='AzureSqlCatalogerWithNonExistingTableFilter')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNonExistingTableFilter  |                                           | 200           |                                             |                                                                                  |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNonExistingTableFilter |                                           | 200           | IDLE                                        | $.[?(@.configurationName=='AzureSqlCatalogerWithNonExistingTableFilter')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Service  |
    Then user verify "catalog not contains" any "Schema" attribute under "Type" facets
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger does not scans and collects and any data if database is not passed in URL
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                             | body                                      | response code | response message                     | jsonPath                                                                  | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                               | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                      |                                                                           | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                    |                                           | 200           | AzureSqlCatalogerWithNoDatabaseInURL |                                                                           |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNoDatabaseInURL |                                           | 200           | IDLE                                 | $.[?(@.configurationName=='AzureSqlCatalogerWithNoDatabaseInURL')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNoDatabaseInURL  |                                           | 200           |                                      |                                                                           |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNoDatabaseInURL |                                           | 200           | IDLE                                 | $.[?(@.configurationName=='AzureSqlCatalogerWithNoDatabaseInURL')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Database Name is not provided in URL" in Analysis Log of IDC UI


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger does not scans and collects and any data if username and password are not provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                           | body                                      | response code | response message                   | jsonPath                                                                | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                             | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                    |                                                                         | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                  |                                           | 200           | AzureSqlCatalogerWithNoCredentials |                                                                         |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNoCredentials |                                           | 200           | IDLE                               | $.[?(@.configurationName=='AzureSqlCatalogerWithNoCredentials')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNoCredentials  |                                           | 200           |                                    |                                                                         |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNoCredentials |                                           | 200           | IDLE                               | $.[?(@.configurationName=='AzureSqlCatalogerWithNoCredentials')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "No JDBC connection could be established" in Analysis Log of IDC UI


  @webtest @jdbc @MLP-7718
  Scenario: Verify proper error message is shown if mandatory fields are not filled in AzureSQLDatabaseCataloger plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "AzureSQLDatabaseCataloger" plugin config list in Plugin Manager page
    And user add button in "AZURESQLDATABASECATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | URL                   |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | DRIVER BUNDLE NAME    | A                      |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | NAME                                         |
      | errorMessage | Name field should not be empty               |
      | fieldName    | URL                                          |
      | errorMessage | URL field should not be empty                |
      | fieldName    | DRIVER BUNDLE NAME                           |
      | errorMessage | Driver Bundle Name field should not be empty |


  @webtest @jdbc @MLP-7718
  Scenario: Verify JDBC cataloger does not collect any DB items and log throws error when the jdbc url is for databases other than azure sql server(postgress and DB2)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "AzureSQLDatabaseCataloger" plugin config list in Plugin Manager page
    And user add button in "AZURESQLDATABASECATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                                 |
      | URL                   | jdbc:postgresql://decheqaperf01v.asg.com:5432/postgres |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | URL                                                                                                                               |
      | errorMessage | UnSupported Azure SQL JDBC URL Format. Sample Format : jdbc:sqlserver://<sqlserver_hostname\instance_name>:1433;databaseName=<db> |
    And user clicks the close button inside the field "PLUGIN CONFIGURATION" panel
    And user add button in "AZURESQLDATABASECATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                       |
      | URL                   | jdbc:db2://gechcae-col1.asg.com:50000/SAMPLE |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | URL                                                                                                                               |
      | errorMessage | UnSupported Azure SQL JDBC URL Format. Sample Format : jdbc:sqlserver://<sqlserver_hostname\instance_name>:1433;databaseName=<db> |


  @webtest @jdbc @MLP-7718
  Scenario:  Verify JDBC cataloger collects only analysis items when the jdbc url format is wrong
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                          | body                                      | response code | response message                  | jsonPath                                                               | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                            | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                   |                                                                        | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                 |                                           | 200           | AzureSqlCatalogerWithIncorrectURL |                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectURL |                                           | 200           | IDLE                              | $.[?(@.configurationName=='AzureSqlCatalogerWithIncorrectURL')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectURL  |                                           | 200           |                                   |                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectURL |                                           | 200           | IDLE                              | $.[?(@.configurationName=='AzureSqlCatalogerWithIncorrectURL')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |


  @webtest @jdbc @MLP-7718
  Scenario:  Verify JDBC cataloger does not scans and collects and any data if driver bundle name is incorrectly provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                       | body                                      | response code | response message                               | jsonPath                                                                            | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                         | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                                |                                                                                     | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                              |                                           | 200           | AzureSqlCatalogerWithIncorrectDriverBundleName |                                                                                     |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverBundleName |                                           | 200           | IDLE                                           | $.[?(@.configurationName=='AzureSqlCatalogerWithIncorrectDriverBundleName')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverBundleName  |                                           | 200           |                                                |                                                                                     |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverBundleName |                                           | 200           | IDLE                                           | $.[?(@.configurationName=='AzureSqlCatalogerWithIncorrectDriverBundleName')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Bundle com.microsoft.sqlserver.mssql-jdbc1 not found" in Analysis Log of IDC UI


  @webtest @jdbc @MLP-7718
  Scenario:  Verify JDBC cataloger does not scans and collects and any data if driver bundle name is correctly provided but driver version are incorrectly provided.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                          | body                                      | response code | response message                                  | jsonPath                                                                               | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                            | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                                   |                                                                                        | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                                 |                                           | 200           | AzureSqlCatalogerWithIncorrectDriverBundleVersion |                                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverBundleVersion |                                           | 200           | IDLE                                              | $.[?(@.configurationName=='AzureSqlCatalogerWithIncorrectDriverBundleVersion')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverBundleVersion  |                                           | 200           |                                                   |                                                                                        |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverBundleVersion |                                           | 200           | IDLE                                              | $.[?(@.configurationName=='AzureSqlCatalogerWithIncorrectDriverBundleVersion')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Bundle com.microsoft.sqlserver.mssql-jdbc not found" in Analysis Log of IDC UI


  @webtest @jdbc @MLP-7718
  Scenario:  Verify JDBC cataloger does not collect any DB items and log throws error when the jdbc url is for azure sql databases but the driver name is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                 | body                                      | response code | response message                         | jsonPath                                                                      | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                   | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                          |                                                                               | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                        |                                           | 200           | AzureSqlCatalogerWithIncorrectDriverName |                                                                               |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverName |                                           | 200           | IDLE                                     | $.[?(@.configurationName=='AzureSqlCatalogerWithIncorrectDriverName')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverName  |                                           | 200           |                                          |                                                                               |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithIncorrectDriverName |                                           | 200           | IDLE                                     | $.[?(@.configurationName=='AzureSqlCatalogerWithIncorrectDriverName')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Error while loading JDBC Driver com.microsoft.sqlserver.jdbc.SQLServer" in Analysis Log of IDC UI


  @webtest @jdbc @MLP-7718
  Scenario:  Verify JDBC cataloger scans and collects data if Node condition is specified in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                              | body                                      | response code | response message                   | jsonPath                                                                | endpointType | itemName         |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                | ida/AzureSQLPayloads/azureSQLCatalog.json | 204           |                                    |                                                                         | catalog      | AZURESQL CATALOG |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDatabaseCataloger                                                                     |                                           | 200           | AzureSqlCatalogerWithNodeCondition |                                                                         |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNodeCondition |                                           | 200           | IDLE                               | $.[?(@.configurationName=='AzureSqlCatalogerWithNodeCondition')].status |              |                  |
      |                  |       |       | Post            | /extensions/analyzers/start/InternalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNodeCondition  |                                           | 200           |                                    |                                                                         |              |                  |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/cataloger/AzureSQLDatabaseCataloger/AzureSqlCatalogerWithNodeCondition |                                           | 200           | IDLE                               | $.[?(@.configurationName=='AzureSqlCatalogerWithNodeCondition')].status |              |                  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "AZURESQL CATALOG" from Catalog list
    And user clicks the show all button for the "Type" facet
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Column     |
      | Constraint |
      | Table      |
      | Schema     |
      | Analysis   |
      | Cluster    |
      | Database   |
      | Host       |
      | Service    |


  @webtest @jdbc @MLP-7718
  Scenario:  Verify the technology tags got assigned to all AzureSQL DB items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName      | name       | facet | Tag                     |
      | AZURESQL CATALOG | Column     | Type  | Cloud Data,Azure SQL DB |
      | AZURESQL CATALOG | Schema     | Type  | Cloud Data,Azure SQL DB |
      | AZURESQL CATALOG | Table      | Type  | Cloud Data,Azure SQL DB |
      | AZURESQL CATALOG | Analysis   | Type  | Cloud Data,Azure SQL DB |
      | AZURESQL CATALOG | Cluster    | Type  | Cloud Data,Azure SQL DB |
      | AZURESQL CATALOG | Database   | Type  | Cloud Data,Azure SQL DB |
      | AZURESQL CATALOG | Service    | Type  | Cloud Data,Azure SQL DB |
      | AZURESQL CATALOG | Constraint | Type  | Cloud Data,Azure SQL DB |
      | AZURESQL CATALOG | Host       | Type  | Cloud Data,Azure SQL DB |


  @jdbc
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                          | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AzureSQLDatabaseCataloger |      | 204           |                  |          |


  @jdbc
  Scenario: Delete Catalog
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                  | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/catalogs/AZURESQL%20CATALOG |      | 204           |                  |          |