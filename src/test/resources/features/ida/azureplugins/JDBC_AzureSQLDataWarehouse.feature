Feature: Azure SQL Warehouse Cataloger


  @jdbc
  Scenario: Catalog creation
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                          | response code | response message | jsonPath |
      | application/json |       |       | Post | settings/catalogs                | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                  |          |
      |                  |       |       | Get  | settings/catalogs/Azurewarehouse |                                               | 200           | Azurewarehouse   |          |


  @jdbc
  Scenario: Create JDBC Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                                   | body                                                  | response code | response message | jsonPath                                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                     | ida/AzureSQLWHPayloads/azureSQLWHCatalogerConfig.json | 204           |                  |                                                                            |
      |                  |       |       | Get          | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                     |                                                       | 200           |                  |                                                                            |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMultipleSchemaInFilters |                                                       | 200           | IDLE             | $.[?(@.configurationName=='AzurewarehouseMultipleSchemaInFilters')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMultipleSchemaInFilters  |                                                       | 200           |                  |                                                                            |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMultipleSchemaInFilters |                                                       | 200           | IDLE             | $.[?(@.configurationName=='AzurewarehouseMultipleSchemaInFilters')].status |

  @webtest @jdbc @MLP-7717
  Scenario:  Verify JDBC cataloger scans and collects data if multiple schema names having tables in it are provided in filters
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema |
      | dbo        |
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "dbo [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | FactInternetSales |
      | DimProduct        |
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "testschema [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | person_info   |
      | diffdatatypes |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | FactInternetSales |
      | DimProduct        |
      | person_info       |
      | diffdatatypes     |


  @webtest @jdbc @MLP-7717
  Scenario: Verify the Service/Host should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Azure SQL Data Warehouse" item from search results
    Then user "verify metadata property values" with following expected parameters for item "Azure SQL Data Warehouse"
      | Application Version            | ID                         |
      | Microsoft SQL Server12.00.2531 | Azurewarehouse.Service:::1 |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getServiceMD | resultsInMap |
    Then following "metadata property values" for item "Azure SQL Data Warehouse" should match with postgres values stored in "hashMap"
      | Application Version |
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Host" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "asg-jdbc.database.windows.net" item from search results
    Then user "verify metadata property values" with following expected parameters for item "asg-jdbc.database.windows.net"
      | Number of cores | Host name                     | ID                      |
      | 0               | asg-jdbc.database.windows.net | Azurewarehouse.Host:::1 |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getHostMD  | resultsInMap |
    Then following "metadata property values" for item "asg-jdbc.database.windows.net" should match with postgres values stored in "hashMap"
      | Host name |


  @webtest @jdbc @MLP-7717
  Scenario: Verify the Database Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "asgsqlwarehouse" item from search results
    Then user "verify metadata property values" with following expected parameters for item "asgsqlwarehouse"
      | Storage type                   | ID                          |
      | Microsoft SQL Server12.00.2531 | Azurewarehouse.Database:::1 |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | asgsqlwarehouse                              |
      | attributeName  | Technical Data                               |
      | actualFilePath | ida/AzureSQLWHPayloads/actualDBTechData.json |
    And user "update" the json file "ida/AzureSQLWHPayloads/actualDBTechData.json" file for following values
      | jsonPath        | jsonValues |
      | $..['password'] |            |
    And user "update" the json file "ida/AzureSQLWHPayloads/expectedDBTechData.json" file for following values
      | jsonPath        | jsonValues |
      | $..['password'] |            |
    Then file content in "ida/AzureSQLWHPayloads/expectedDBTechData.json" should be same as the content in "ida/AzureSQLWHPayloads/actualDBTechData.json"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getDatabaseMD | resultsInMap |
    Then following "metadata property values" for item "asgsqlwarehouse" should match with postgres values stored in "jsonHashMap"
      | Technical Data | Storage type |


  @webtest @jdbc @MLP-7717
  Scenario: Verify the Table Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "FactInternetSales [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "FactInternetSales" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    Then user "verify metadata property values" with following expected parameters for item "FactInternetSales"
      | Table Type | ID                       |
      | TABLE      | Azurewarehouse.Table:::1 |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableMD | resultsInMap |
    Then following "metadata property values" for item "FactInternetSales" should match with postgres values stored in "jsonHashMap"
      | Table Type |


  @webtest @jdbc @MLP-7717
  Scenario: Verify the column Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "FactInternetSales [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "ShipDateKey" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    Then user "verify metadata property values" with following expected parameters for item "ShipDateKey"
      | Data type | ID                        | Length |
      | INTEGER   | Azurewarehouse.Column:::4 | 10     |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | ShipDateKey                                   |
      | attributeName  | Technical Data                                |
      | actualFilePath | ida/AzureSQLWHPayloads/actualColTechData.json |
    Then file content in "ida/AzureSQLWHPayloads/expectedColTechData.json" should be same as the content in "ida/AzureSQLWHPayloads/actualColTechData.json"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getColumnMD | resultsInMap |
    Then following "metadata property values" for item "ShipDateKey" should match with postgres values stored in "jsonHashMap"
      | Data type | Length |


  @webtest @jdbc @MLP-7717
  Scenario: Verify the Table should not have constraints window if the table is not having any constraints.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "person_info [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    Then user verify "catalog not contains" any "Constraint" attribute under "Type" facets


  @webtest @jdbc @MLP-7717
  Scenario:  Verify JDBC cataloger scans and collects data if schema name alone is provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                               | body                                          | response code | response message                  | jsonPath                                                               | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                 | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                   |                                                                        | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                 |                                               | 200           | AzurewarehouseSchemaNameInfilters |                                                                        |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSchemaNameInfilters |                                               | 200           | IDLE                              | $.[?(@.configurationName=='AzurewarehouseSchemaNameInfilters')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSchemaNameInfilters  |                                               | 200           |                                   |                                                                        |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSchemaNameInfilters |                                               | 200           | IDLE                              | $.[?(@.configurationName=='AzurewarehouseSchemaNameInfilters')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "testschema [Schema]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | person_info   |
      | diffdatatypes |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | person_info   |
      | diffdatatypes |

  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger scans and collects data if schema name and table name are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                    | body                                          | response code | response message                       | jsonPath                                                                    | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                      | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                        |                                                                             | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                      |                                               | 200           | AzurewarehouseSchemaAndTablesInfilters |                                                                             |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSchemaAndTablesInfilters |                                               | 200           | IDLE                                   | $.[?(@.configurationName=='AzurewarehouseSchemaAndTablesInfilters')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSchemaAndTablesInfilters  |                                               | 200           |                                        |                                                                             |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSchemaAndTablesInfilters |                                               | 200           | IDLE                                   | $.[?(@.configurationName=='AzurewarehouseSchemaAndTablesInfilters')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema |
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | person_info |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | BuildVersion |


  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger scans and collects data if single schema name with multiple table names are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                      | body                                          | response code | response message                         | jsonPath                                                                      | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                        | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                          |                                                                               | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                        |                                               | 200           | AzurewarehouseSingleSchemaMultipleTables |                                                                               |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSingleSchemaMultipleTables |                                               | 200           | IDLE                                     | $.[?(@.configurationName=='AzurewarehouseSingleSchemaMultipleTables')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSingleSchemaMultipleTables  |                                               | 200           |                                          |                                                                               |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseSingleSchemaMultipleTables |                                               | 200           | IDLE                                     | $.[?(@.configurationName=='AzurewarehouseSingleSchemaMultipleTables')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | dbo |
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | FactInternetSales |
      | DimProduct        |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | FactInternetSales |
      | DimProduct        |


  @webtest @jdbc @MLP-7717
  Scenario: Verify table name alone can be provided without a schema name in JDBC cataloger filters and it should search across all schemas.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                         | body                                          | response code | response message            | jsonPath                                                         | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                           | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                             |                                                                  | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                           |                                               | 200           | AzurewarehouseWithoutSchema |                                                                  |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutSchema |                                               | 200           | IDLE                        | $.[?(@.configurationName=='AzurewarehouseWithoutSchema')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutSchema  |                                               | 200           |                             |                                                                  |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutSchema |                                               | 200           | IDLE                        | $.[?(@.configurationName=='AzurewarehouseWithoutSchema')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | members |
      | dbo     |
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | personal_details |
      | DimProduct       |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableList | resultsInMap |
    Then postgres database query result stored in "linkedhashset" should have following values listed
      | personal_details |
      | DimProduct       |


  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger scans and collects data if multiple schema with tables in it is provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                     | body                                          | response code | response message                        | jsonPath                                                                     | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                       | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                         |                                                                              | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                       |                                               | 200           | AzurewarehouseMultipleSchemasWithTables |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMultipleSchemasWithTables |                                               | 200           | IDLE                                    | $.[?(@.configurationName=='AzurewarehouseMultipleSchemasWithTables')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMultipleSchemasWithTables  |                                               | 200           |                                         |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMultipleSchemasWithTables |                                               | 200           | IDLE                                    | $.[?(@.configurationName=='AzurewarehouseMultipleSchemasWithTables')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | personal_details |
      | address_details  |
      | person_info      |
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "3 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableList | rowCount     |
    Then Postgres item count for "Field" attribute should be "3"


  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger scans and collects data if schema name and table names are not provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                 | body                                          | response code | response message                    | jsonPath                                                                 | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                   | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                     |                                                                          | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                   |                                               | 200           | AzurewarehouseWithoutSchemaAndTable |                                                                          |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutSchemaAndTable |                                               | 200           | IDLE                                | $.[?(@.configurationName=='AzurewarehouseWithoutSchemaAndTable')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutSchemaAndTable  |                                               | 200           |                                     |                                                                          |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutSchemaAndTable |                                               | 200           | IDLE                                | $.[?(@.configurationName=='AzurewarehouseWithoutSchemaAndTable')].status |              |                |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "6 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getSchemaList | rowCount     |
    Then Postgres item count for "Field" attribute should be "6"
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "8 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableList | rowCount     |
    Then Postgres item count for "Field" attribute should be "8"


  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger scans and collects data if non existing schema name and table name are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                             | body                                          | response code | response message                | jsonPath                                                             | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                               | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                 |                                                                      | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                               |                                               | 200           | AzurewarehouseNonExistingSchema |                                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseNonExistingSchema |                                               | 200           | IDLE                            | $.[?(@.configurationName=='AzurewarehouseNonExistingSchema')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseNonExistingSchema  |                                               | 200           |                                 |                                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseNonExistingSchema |                                               | 200           | IDLE                            | $.[?(@.configurationName=='AzurewarehouseNonExistingSchema')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Service  |
    Then user verify "catalog not contains" any "Schema" attribute under "Type" facets
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets

  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger scans and collects Table and columns properly if the table contains possible different built in data types
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                   | body                                          | response code | response message                      | jsonPath                                                                   | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                     | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                       |                                                                            | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                     |                                               | 200           | AzurewarehouseTablesWithDiffDataTypes |                                                                            |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseTablesWithDiffDataTypes |                                               | 200           | IDLE                                  | $.[?(@.configurationName=='AzurewarehouseTablesWithDiffDataTypes')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseTablesWithDiffDataTypes  |                                               | 200           |                                       |                                                                            |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseTablesWithDiffDataTypes |                                               | 200           | IDLE                                  | $.[?(@.configurationName=='AzurewarehouseTablesWithDiffDataTypes')].status |              |                |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    Then results panel "item counts" should be displayed as "24 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField                    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getColCountInDiffDataTypTable | rowCount     |
    Then Postgres item count for "Field" attribute should be "24"

  @webtest @jdbc @MLP-7717
  Scenario: Verify the external Table Name should have the appropriate metadata information in IDC UI and Database
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                         | body                                          | response code | response message            | jsonPath                                                         | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                           | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                             |                                                                  | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                           |                                               | 200           | AzurewarehouseExternalTable |                                                                  |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseExternalTable |                                               | 200           | IDLE                        | $.[?(@.configurationName=='AzurewarehouseExternalTable')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseExternalTable  |                                               | 200           |                             |                                                                  |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseExternalTable |                                               | 200           | IDLE                        | $.[?(@.configurationName=='AzurewarehouseExternalTable')].status |              |                |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "DimProduct_external1" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    Then user "verify metadata property values" with following expected parameters for item "DimProduct_external1"
      | Table Type | ID                       |
      | EXTERNAL   | Azurewarehouse.Table:::2 |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage         | queryField                 | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | azureSQLWHQueries | getTableMDForExternalTable | resultsInMap |
    Then following "metadata property values" for item "DimProduct_external1" should match with postgres values stored in "jsonHashMap"
      | Table Type |


  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger scans and collects data if existing schema name and non existing table name are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                   | body                                          | response code | response message                      | jsonPath                                                                   | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                     | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                       |                                                                            | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                     |                                               | 200           | AzureWarehouseValidSchemaInvalidTable |                                                                            |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzureWarehouseValidSchemaInvalidTable |                                               | 200           | IDLE                                  | $.[?(@.configurationName=='AzureWarehouseValidSchemaInvalidTable')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzureWarehouseValidSchemaInvalidTable  |                                               | 200           |                                       |                                                                            |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzureWarehouseValidSchemaInvalidTable |                                               | 200           | IDLE                                  | $.[?(@.configurationName=='AzureWarehouseValidSchemaInvalidTable')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Schema   |
      | Service  |
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets


  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger scans and collects data if  schema name is not provided and non existing table name are provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                    | body                                          | response code | response message                       | jsonPath                                                                    | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                      | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                        |                                                                             | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                      |                                               | 200           | AzurewarehouseMissedSchemaInvalidTable |                                                                             |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMissedSchemaInvalidTable |                                               | 200           | IDLE                                   | $.[?(@.configurationName=='AzurewarehouseMissedSchemaInvalidTable')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMissedSchemaInvalidTable  |                                               | 200           |                                        |                                                                             |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMissedSchemaInvalidTable |                                               | 200           | IDLE                                   | $.[?(@.configurationName=='AzurewarehouseMissedSchemaInvalidTable')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Service  |
    Then user verify "catalog not contains" any "Schema" attribute under "Type" facets
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets


  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger does not scans and collects and any data if database is not passed in URL
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                    | body                                          | response code | response message       | jsonPath                                                    | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                      | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                        |                                                             | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                      |                                               | 200           | AzurewarehouseMissedDB |                                                             |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMissedDB |                                               | 200           | IDLE                   | $.[?(@.configurationName=='AzurewarehouseMissedDB')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMissedDB  |                                               | 200           |                        |                                                             |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseMissedDB |                                               | 200           | IDLE                   | $.[?(@.configurationName=='AzurewarehouseMissedDB')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Database Name is not provided in URL" in Analysis Log of IDC UI

  @webtest @jdbc @MLP-7717
  Scenario:  Verify JDBC cataloger does not scans and collects and any data if driver bundle name is incorrectly provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                             | body                                          | response code | response message                | jsonPath                                                             | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                               | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                 |                                                                      | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                               |                                               | 200           | AzurewarehouseInvalidBundleName |                                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidBundleName |                                               | 200           | IDLE                            | $.[?(@.configurationName=='AzurewarehouseInvalidBundleName')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidBundleName  |                                               | 200           |                                 |                                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidBundleName |                                               | 200           | IDLE                            | $.[?(@.configurationName=='AzurewarehouseInvalidBundleName')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Bundle com.microsoft.sqlserver.mssql-jdbc1 not found" in Analysis Log of IDC UI

  @webtest @jdbc @MLP-7717
  Scenario:  Verify JDBC cataloger does not collect any DB items and log throws error when the jdbc url is for azure sql databases but the driver name is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                 | body                                          | response code | response message                    | jsonPath                                                                 | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                   | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                     |                                                                          | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                   |                                               | 200           | AzurewarehouseInvalidVersionNDriver |                                                                          |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidVersionNDriver |                                               | 200           | IDLE                                | $.[?(@.configurationName=='AzurewarehouseInvalidVersionNDriver')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidVersionNDriver  |                                               | 200           |                                     |                                                                          |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidVersionNDriver |                                               | 200           | IDLE                                | $.[?(@.configurationName=='AzurewarehouseInvalidVersionNDriver')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "ERROR - ANALYSIS-JDBC-0002: No Driver class returned: Bundle com.microsoft.sqlserver.mssql-jdb not found?" in Analysis Log of IDC UI

  @webtest @jdbc @MLP-7717
  Scenario:  Verify JDBC cataloger collects only analysis items when the jdbc url format is wrong
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                       | body                                          | response code | response message          | jsonPath                                                       | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                         | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                           |                                                                | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                         |                                               | 200           | AzurewarehouseInvalidURL1 |                                                                |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidURL1 |                                               | 200           | IDLE                      | $.[?(@.configurationName=='AzurewarehouseInvalidURL1')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidURL1  |                                               | 200           |                           |                                                                |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseInvalidURL1 |                                               | 200           | IDLE                      | $.[?(@.configurationName=='AzurewarehouseInvalidURL1')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |

  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger does not collect any DB items and log throws error when the jdbc url is for databases other than azure sql server(postgress and DB2)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "AzureSQLDataWarehouseCataloger" plugin config list in Plugin Manager page
    And user add button in "AZURESQLDATAWAREHOUSECATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                                 |
      | URL                   | jdbc:postgresql://decheqaperf01v.asg.com:5432/postgres |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | URL                                                                                                                                              |
      | errorMessage | UnSupported Azure SQL Data warehouse JDBC URL Format. Sample Format : jdbc:sqlserver://<sqlserver_hostname\instance_name>:1433;databaseName=<db> |
    And user clicks the close button inside the field "PLUGIN CONFIGURATION" panel
    And user add button in "AZURESQLDATAWAREHOUSECATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                       |
      | URL                   | jdbc:db2://gechcae-col1.asg.com:50000/SAMPLE |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | URL                                                                                                                                              |
      | errorMessage | UnSupported Azure SQL Data warehouse JDBC URL Format. Sample Format : jdbc:sqlserver://<sqlserver_hostname\instance_name>:1433;databaseName=<db> |

  @webtest @jdbc @MLP-7717
  Scenario:  Verify JDBC cataloger does not collect any DB items and log throws error when the jdbc url is for azure sql databases but the driver bundle name/driver name/driver version is for databases other than oracle(postgress and DB2)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                 | body                                          | response code | response message                    | jsonPath                                                                 | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                   | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                     |                                                                          | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                   |                                               | 200           | AzurewarehouseValidURLInvalidBundle |                                                                          |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseValidURLInvalidBundle |                                               | 200           | IDLE                                | $.[?(@.configurationName=='AzurewarehouseValidURLInvalidBundle')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseValidURLInvalidBundle  |                                               | 200           |                                     |                                                                          |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseValidURLInvalidBundle |                                               | 200           | IDLE                                | $.[?(@.configurationName=='AzurewarehouseValidURLInvalidBundle')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |

  @webtest @jdbc @MLP-7717
  Scenario: Verify proper error message is shown if mandatory fields are not filled in AzureSQLDatabaseCataloger plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "AzureSQLDataWarehouseCataloger" plugin config list in Plugin Manager page
    And user add button in "AZURESQLDATAWAREHOUSECATALOGER CONFIGURATIONS" section
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


  @webtest @jdbc @MLP-7717
  Scenario: Verify JDBC cataloger does not scans and collects and any data if username and password are not provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                              | body                                          | response code | response message                 | jsonPath                                                              | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                | ida/AzureSQLWHPayloads/azureSQLWHCatalog.json | 204           |                                  |                                                                       | catalog      | Azurewarehouse |
      |                  |       |       | Get             | settings/analyzers/AzureSQLDataWarehouseCataloger                                                                |                                               | 200           | AzurewarehouseWithoutUserNamePwd |                                                                       |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutUserNamePwd |                                               | 200           | IDLE                             | $.[?(@.configurationName=='AzurewarehouseWithoutUserNamePwd')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutUserNamePwd  |                                               | 200           |                                  |                                                                       |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/AzureSQLDataWarehouseCataloger/AzurewarehouseWithoutUserNamePwd |                                               | 200           | IDLE                             | $.[?(@.configurationName=='AzurewarehouseWithoutUserNamePwd')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Azurewarehouse" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "No JDBC connection could be established" in Analysis Log of IDC UI


  @jdbc
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                               | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AzureSQLDataWarehouseCataloger |      | 204           |                  |          |


  @jdbc
  Scenario: Delete Catalog
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/catalogs/Azurewarehouse |      | 204           |                  |          |