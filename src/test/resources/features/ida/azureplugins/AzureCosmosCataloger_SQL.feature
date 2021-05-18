Feature:Verification of Azure Cosmos Cataloger (SQL API)

  @AzureCosmosSQL @MLP-8341
  Scenario: Create new DB, Table and upload Document, Then Create new Catalog, Create New Plugin Configuration and Run the Plugin Configuration
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase1 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName        | dirPath | documentName |
      | testSqlDatabase1 | TestCollection   |         |              |
      | testSqlDatabase1 | Items            |         |              |
      | testSqlDatabase1 | SampleDB         |         |              |
      | testSqlDatabase1 | Varycolumns      |         |              |
      | testSqlDatabase1 | VaryColumnValues |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName        | dirPath                                   | documentName              |
      | testSqlDatabase1 | TestCollection   | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
      | testSqlDatabase1 | Items            | ida/azureCosmosPayloads/SQL_API/TestData/ | Items1.json               |
      | testSqlDatabase1 | SampleDB         | ida/azureCosmosPayloads/SQL_API/TestData/ | SampleDB1.json            |
      | testSqlDatabase1 | Varycolumns      | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumns1.json         |
      | testSqlDatabase1 | VaryColumnValues | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumnValues1.json    |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                        | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/SQL_API/cosmosCatalog1.json         | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosSql1                                                     |                                                             | 200           | AzureCosmosSql1  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfig1.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                             | 200           | AzureCosmosSql1  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql1 |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSql1')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql1  |                                                             | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql1 |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSql1')].status |

  @webtest @AzureCosmosSQL @MLP-8341
  Scenario: SC6464718:Verify the Service(SQLCosmosDB) should have the appropriate metadata information in IDC UI and Database (Enabling Geo Location)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSql1" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "3 items were found" in Item Search results page
    And user performs "item click" on "asgsqlcosmos" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getMetaDataOfFirstService | resultsInMap |
    Then following "metadata property values" for item "asgsqlcosmos" should match with postgres values stored in "hashMap"
      | Application Version |
      | Location            |
    And user select "AzureCosmosSql1" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "https://asgsqlcosmos-westus" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField                 | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getMetaDataOfSecondService | resultsInMap |
    Then following "metadata property values" for item "https://asgsqlcosmos-westus" should match with postgres values stored in "hashMap"
      | Location      |
      | serviceStatus |
    And user select "AzureCosmosSql1" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "https://asgsqlcosmos-eastus" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getMetaDataOfThirdService | resultsInMap |
    Then following "metadata property values" for item "https://asgsqlcosmos-eastus" should match with postgres values stored in "hashMap"
      | Location      |
      | serviceStatus |


  @webtest @AzureCosmosSQL @MLP-8341
  Scenario: SC6464719:Verify the Database should have the appropriate app version information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSql1" from Catalog list
    And user performs "facet selection" in "testSqlDatabase1 [Database]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "testSqlDatabase1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField              | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getStorageMetaDataForDB | resultsInMap |
    Then following "metadata property values" for item "testSqlDatabase1" should match with postgres values stored in "hashMap"
      | Storage type |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | testSqlDatabase1                                               |
      | attributeName  | Technical Data                                                 |
      | actualFilePath | ida/azureCosmosPayloads/SQL_API/TestData/actualDBTechData.json |
    And user "update" the json file "ida/azureCosmosPayloads/SQL_API/TestData/actualDBTechData.json" file for following values
      | jsonPath        | jsonValues |
      | $..['password'] |            |
    And user "update" the json file "ida/azureCosmosPayloads/SQL_API/TestData/expectedDBTechData.json" file for following values
      | jsonPath        | jsonValues |
      | $..['password'] |            |
    Then file content in "ida/azureCosmosPayloads/SQL_API/TestData/expectedDBTechData.json" should be same as the content in "ida/azureCosmosPayloads/SQL_API/TestData/actualDBTechData.json"


  @webtest @AzureCosmosSQL @MLP-8341
  Scenario: SC6464720:Verify the Table(TestCollection) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSql1" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "5 items were found" in Item Search results page
    And user performs "item click" on "TestCollection" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField       | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getTableMetaData | resultsInMap |
    Then following "metadata property values" for item "TestCollection" should match with postgres values stored in "hashMap"
      | Table Type  |
      | Description |


  @webtest @AzureCosmosSQL @MLP-8341
  Scenario: SC6464721:Verify the Column(address.city) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSql1" from Catalog list
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "address.city" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField        | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getColumnMetaData | resultsInMap |
    Then following "metadata property values" for item "address.city" should match with postgres values stored in "hashMap"
      | Data type |
      | Length    |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | address.city                                                    |
      | attributeName  | Technical Data                                                  |
      | actualFilePath | ida/azureCosmosPayloads/SQL_API/TestData/actualColTechData.json |
    Then file content in "ida/azureCosmosPayloads/SQL_API/TestData/expectedColTechData.json" should be same as the content in "ida/azureCosmosPayloads/SQL_API/TestData/actualColTechData.json"


  @webtest @AzureCosmosSQL @MLP-8341
  Scenario: SC6464722:Verify the Cluster(asgsqlcosmos.documents.azure.com) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSql1" from Catalog list
    And user performs "facet selection" in "Cluster" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "asgsqlcosmos.documents.azure.com" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField         | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getClusterMetaData | resultsInMap |
    Then following "metadata property values" for item "asgsqlcosmos.documents.azure.com" should match with postgres values stored in "hashMap"
      | ID |


  @AzureCosmosSQL @MLP-8341
  Scenario: Delete Plugin Configuration,  Delete Catalog and Delete Database
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                     | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AzureCosmosCataloger |      | 204           |                  |          |
      |                  |       |       | Delete | settings/catalogs/AzureCosmosSql1       |      | 204           |                  |          |
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase1 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6464784: Verify Azure Cosmos cataloger scans and collects data if multiple table names are provided in filters
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase2 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase2 | Items     |         |              |
      | testSqlDatabase2 | SampleDB  |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath                                   | documentName   |
      | testSqlDatabase2 | Items     | ida/azureCosmosPayloads/SQL_API/TestData/ | Items1.json    |
      | testSqlDatabase2 | Items     | ida/azureCosmosPayloads/SQL_API/TestData/ | Items2.json    |
      | testSqlDatabase2 | SampleDB  | ida/azureCosmosPayloads/SQL_API/TestData/ | SampleDB1.json |
      | testSqlDatabase2 | SampleDB  | ida/azureCosmosPayloads/SQL_API/TestData/ | SampleDB2.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                        | response code | response message   | jsonPath                                                |
      | application/json |       |       | Post         | settings/catalogs                                                                        | ida/azurecosmosPayloads/SQL_API/cosmosCatalog2.json         | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosFilter4                                                     |                                                             | 200           | AzureCosmosFilter4 |                                                         |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                  | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfig2.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                  |                                                             | 200           | AzureCosmosFilter4 |                                                         |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFilter4 |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AzureCosmosFilter4')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFilter4  |                                                             | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFilter4 |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AzureCosmosFilter4')].status |
    And verify created schema "AzureCosmosFilter4" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosFilter4" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "2 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getTablesAfterFilters | rowCount     |
    Then Postgres item count for "Field" attribute should be "2"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureCosmosFilter4"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase2 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6464786: Verify Azure Cosmos cataloger scans and collects data if table names are not provided in filters
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase3 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName        | dirPath | documentName |
      | testSqlDatabase3 | TestCollection   |         |              |
      | testSqlDatabase3 | Items            |         |              |
      | testSqlDatabase3 | SampleDB         |         |              |
      | testSqlDatabase3 | Varycolumns      |         |              |
      | testSqlDatabase3 | VaryColumnValues |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName        | dirPath                                   | documentName              |
      | testSqlDatabase3 | TestCollection   | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
      | testSqlDatabase3 | Items            | ida/azureCosmosPayloads/SQL_API/TestData/ | Items1.json               |
      | testSqlDatabase3 | SampleDB         | ida/azureCosmosPayloads/SQL_API/TestData/ | SampleDB1.json            |
      | testSqlDatabase3 | Varycolumns      | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumns1.json         |
      | testSqlDatabase3 | VaryColumnValues | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumnValues1.json    |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                        | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/SQL_API/cosmosCatalog3.json         | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosSQL                                                      |                                                             | 200           | AzureCosmosSQL   |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfig3.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                             | 200           | AzureCosmosSQL   |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSQL1 |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSQL1')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSQL1  |                                                             | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSQL1 |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSQL1')].status |
    And verify created schema "AzureCosmosSQL" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSQL" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "5 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField              | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getTablesWithoutFilters | rowCount     |
    Then Postgres item count for "Field" attribute should be "5"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureCosmosSQL"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase3 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6464788: Verify Azure Cosmos cataloger scans and collects data if non existing table name are provided in filters
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase4 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName      | dirPath | documentName |
      | testSqlDatabase4 | TestCollection |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName      | dirPath                                   | documentName              |
      | testSqlDatabase4 | TestCollection | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                        | response code | response message   | jsonPath                                                |
      | application/json |       |       | Post         | settings/catalogs                                                                        | ida/azurecosmosPayloads/SQL_API/cosmosCatalog5.json         | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosFilter6                                                     |                                                             | 200           | AzureCosmosFilter6 |                                                         |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                  | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfig5.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                  |                                                             | 200           | AzureCosmosFilter6 |                                                         |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFilter6 |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AzureCosmosFilter6')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFilter6  |                                                             | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFilter6 |                                                             | 200           | IDLE               | $.[?(@.configurationName=='AzureCosmosFilter6')].status |
    And verify created schema "AzureCosmosFilter6" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosFilter6" from Catalog list
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField             | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | NonExistingTableFilter | rowCount     |
    Then Postgres item count for "Field" attribute should be "0"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField               | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | ExistingServiceClusterDB | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureCosmosFilter6"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase4 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6464792: Verify the Table should have constraints window with the Primary Key constraint available
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase5 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName        | dirPath | documentName |
      | testSqlDatabase5 | TestCollection   |         |              |
      | testSqlDatabase5 | Items            |         |              |
      | testSqlDatabase5 | SampleDB         |         |              |
      | testSqlDatabase5 | Varycolumns      |         |              |
      | testSqlDatabase5 | VaryColumnValues |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName        | dirPath                                   | documentName              |
      | testSqlDatabase5 | TestCollection   | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
      | testSqlDatabase5 | Items            | ida/azureCosmosPayloads/SQL_API/TestData/ | Items1.json               |
      | testSqlDatabase5 | SampleDB         | ida/azureCosmosPayloads/SQL_API/TestData/ | SampleDB1.json            |
      | testSqlDatabase5 | Varycolumns      | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumns1.json         |
      | testSqlDatabase5 | VaryColumnValues | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumnValues1.json    |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                        | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/SQL_API/cosmosCatalog4.json         | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosSql2                                                     |                                                             | 200           | AzureCosmosSql2  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfig4.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                             | 200           | AzureCosmosSql2  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql2 |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSql2')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql2  |                                                             | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql2 |                                                             | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSql2')].status |
    And verify created schema "AzureCosmosSql2" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSql2" from Catalog list
    And user performs "facet selection" in "Constraint" attribute under "Type" facets in Item Search results page
    And user performs "facet selection" in "Items [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField        | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getConstraintInfo | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureCosmosSql2"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase5 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @MLP-9755 @webtest
  Scenario: SC6464805: Verify Azure Cosmos cataloger plugin config throws error message in UI if mandatory fields are not passed as input
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "AzureCosmosCataloger" from the available plugin list in Plugin Manager
    And user add button in "AZURECOSMOSCATALOGER CONFIGURATIONS" section
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
      | HOST                  |                        |
      | DATABASE NAME         |                        |
      | PRIMARY KEY           |                        |
    And user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage                       | pageName             |
      | NAME                  | Name field should not be empty          | PLUGIN CONFIGURATION |
      | HOST                  | Host field should not be empty          | PLUGIN CONFIGURATION |
      | DATABASE NAME         | Database Name field should not be empty | PLUGIN CONFIGURATION |
      | PRIMARY KEY           | Primary Key field should not be empty   | PLUGIN CONFIGURATION |


  @AzureCosmosSQL @MLP-8341 @MLP-9755 @webtest
  Scenario: SC6464818: Verify Azure Cosmos cataloger plugin config does not catalog any items if the Database name is incorrectly provided
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase6 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName      | dirPath | documentName |
      | testSqlDatabase6 | TestCollection |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName      | dirPath                                   | documentName              |
      | testSqlDatabase6 | TestCollection | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                                | response code | response message  | jsonPath                                               |
      | application/json |       |       | Post         | settings/catalogs                                                                       | ida/azurecosmosPayloads/SQL_API/cosmosCatalog13.json                | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosFiltr6                                                     |                                                                     | 200           | AzureCosmosFiltr6 |                                                        |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                 | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfigInvalidDB.json | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                 |                                                                     | 200           | AzureCosmosFiltr6 |                                                        |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFiltr6 |                                                                     | 200           | IDLE              | $.[?(@.configurationName=='AzureCosmosFiltr6')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFiltr6  |                                                                     | 200           |                   |                                                        |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosFiltr6 |                                                                     | 200           | IDLE              | $.[?(@.configurationName=='AzureCosmosFiltr6')].status |
    And verify created schema "AzureCosmosFiltr6" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosFiltr6" from Catalog list
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureCosmosFiltr6"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase6 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6466212: Verify Azure Cosmos cataloger scans and collects data if User name is incorrectly provided
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase7 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName        | dirPath | documentName |
      | testSqlDatabase7 | TestCollection   |         |              |
      | testSqlDatabase7 | Items            |         |              |
      | testSqlDatabase7 | SampleDB         |         |              |
      | testSqlDatabase7 | Varycolumns      |         |              |
      | testSqlDatabase7 | VaryColumnValues |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName        | dirPath                                   | documentName              |
      | testSqlDatabase7 | TestCollection   | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
      | testSqlDatabase7 | Items            | ida/azureCosmosPayloads/SQL_API/TestData/ | Items1.json               |
      | testSqlDatabase7 | SampleDB         | ida/azureCosmosPayloads/SQL_API/TestData/ | SampleDB1.json            |
      | testSqlDatabase7 | Varycolumns      | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumns1.json         |
      | testSqlDatabase7 | VaryColumnValues | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumnValues1.json    |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                           | body                                                                  | response code | response message        | jsonPath                                                     |
      | application/json |       |       | Post         | settings/catalogs                                                                             | ida/azurecosmosPayloads/SQL_API/cosmosCatalog6.json                   | 204           |                         |                                                              |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosInvalidUser7                                                     |                                                                       | 200           | AzureCosmosInvalidUser7 |                                                              |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                       | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfigInvalidUser.json | 204           |                         |                                                              |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                       |                                                                       | 200           | AzureCosmosInvalidUser7 |                                                              |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosInvalidUser7 |                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AzureCosmosInvalidUser7')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosInvalidUser7  |                                                                       | 200           |                         |                                                              |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosInvalidUser7 |                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='AzureCosmosInvalidUser7')].status |
    And verify created schema "AzureCosmosInvalidUser7" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosInvalidUser7" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "5 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField              | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getTablesForInvalidUser | rowCount     |
    Then Postgres item count for "Field" attribute should be "5"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureCosmosInvalidUser7"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase7 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6466216: Verify Azure Cosmos cataloger plugin config does not catalog any items if the primary key is incorrectly provided
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase8 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName      | dirPath | documentName |
      | testSqlDatabase8 | TestCollection |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName      | dirPath                                   | documentName              |
      | testSqlDatabase8 | TestCollection | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body                                                                | response code | response message | jsonPath                                            |
      | application/json |       |       | Post         | settings/catalogs                                                                    | ida/azurecosmosPayloads/SQL_API/cosmosCatalog7.json                 | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/catalogs/AzureInvalidPK                                                     |                                                                     | 200           | AzureInvalidPK   |                                                     |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                              | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfigInvalidPK.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                              |                                                                     | 200           | AzureInvalidPK   |                                                     |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureInvalidPK |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AzureInvalidPK')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureInvalidPK  |                                                                     | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureInvalidPK |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AzureInvalidPK')].status |
    And verify created schema "AzureInvalidPK" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureInvalidPK" from Catalog list
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureInvalidPK"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase8 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6468742: Verify Azure Cosmos Cataloger plugin config does not catalog any items if the HostName is incorrectly provided(SQL API)
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase9 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName      | dirPath | documentName |
      | testSqlDatabase9 | TestCollection |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName      | dirPath                                   | documentName              |
      | testSqlDatabase9 | TestCollection | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                                                                  | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | settings/catalogs                                                                      | ida/azurecosmosPayloads/SQL_API/cosmosCatalog8.json                   | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/catalogs/AzureInvalidHost                                                     |                                                                       | 200           | AzureInvalidHost |                                                       |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfigInvalidHost.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                |                                                                       | 200           | AzureInvalidHost |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureInvalidHost |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AzureInvalidHost')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureInvalidHost  |                                                                       | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureInvalidHost |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='AzureInvalidHost')].status |
    And verify created schema "AzureInvalidHost" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureInvalidHost" from Catalog list
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureInvalidHost"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName     | tableName | dirPath | documentName |
      | testSqlDatabase9 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6468747: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns if node condition is specified in configuration
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName      | tableName | dirPath | documentName |
      | testSqlDatabase10 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName      | tableName        | dirPath | documentName |
      | testSqlDatabase10 | TestCollection   |         |              |
      | testSqlDatabase10 | Items            |         |              |
      | testSqlDatabase10 | SampleDB         |         |              |
      | testSqlDatabase10 | Varycolumns      |         |              |
      | testSqlDatabase10 | VaryColumnValues |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName      | tableName        | dirPath                                   | documentName              |
      | testSqlDatabase10 | TestCollection   | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
      | testSqlDatabase10 | Items            | ida/azureCosmosPayloads/SQL_API/TestData/ | Items1.json               |
      | testSqlDatabase10 | SampleDB         | ida/azureCosmosPayloads/SQL_API/TestData/ | SampleDB1.json            |
      | testSqlDatabase10 | Varycolumns      | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumns1.json         |
      | testSqlDatabase10 | VaryColumnValues | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumnValues1.json    |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                               | response code | response message   | jsonPath                                                |
      | application/json |       |       | Post         | settings/catalogs                                                                        | ida/azurecosmosPayloads/SQL_API/cosmosCatalog9.json                | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/catalogs/CosmosSpecificNode                                                     |                                                                    | 200           | CosmosSpecificNode |                                                         |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                  | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfigSpecNode.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                  |                                                                    | 200           | CosmosSpecificNode |                                                         |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosSpecificNode |                                                                    | 200           | IDLE               | $.[?(@.configurationName=='CosmosSpecificNode')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosSpecificNode  |                                                                    | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosSpecificNode |                                                                    | 200           | IDLE               | $.[?(@.configurationName=='CosmosSpecificNode')].status |
    And verify created schema "CosmosSpecificNode" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosSpecificNode" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "5 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField               | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getTablesWithoutFilters1 | rowCount     |
    Then Postgres item count for "Field" attribute should be "5"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosSpecificNode"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName      | tableName | dirPath | documentName |
      | testSqlDatabase10 |           |         |              |


  @webtest @AzureCosmosSQL @MLP-8341
  Scenario: SC6479227: Verify AzureCosmosCataloger collects three services if geolocation is enabled for azure cosmos DB SQL API and the service that matches the hostname should have all DB items collected.
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName      | tableName | dirPath | documentName |
      | testSqlDatabase11 |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName      | tableName      | dirPath | documentName |
      | testSqlDatabase11 | TestCollection |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName      | tableName      | dirPath                                   | documentName              |
      | testSqlDatabase11 | TestCollection | ida/azureCosmosPayloads/SQL_API/TestData/ | Table_TestCollection.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                                                         | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | settings/catalogs                                                                      | ida/azurecosmosPayloads/SQL_API/cosmosCatalog10.json         | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/catalogs/AzureSqlServices                                                     |                                                              | 200           | AzureSqlServices |                                                       |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfig11.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                |                                                              | 200           | AzureSqlServices |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureSqlServices |                                                              | 200           | IDLE             | $.[?(@.configurationName=='AzureSqlServices')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureSqlServices  |                                                              | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureSqlServices |                                                              | 200           | IDLE             | $.[?(@.configurationName=='AzureSqlServices')].status |
    And verify created schema "AzureSqlServices" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureSqlServices" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "3 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getServices | rowCount     |
    Then Postgres item count for "Field" attribute should be "3"
    And user performs "dynamic item click" on "asgsqlcosmos" item from search results
    Then verify the table "DATABASES" has item "testSqlDatabase11"
    And user clicks on item "testSqlDatabase11" in table "DATABASES"
    Then verify the table "TABLES" has item "TestCollection"
    And user clicks on item "TestCollection" in table "TABLES"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureSqlServices"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName      | tableName | dirPath | documentName |
      | testSqlDatabase11 |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6468744: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns if data having dynamic columns
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName | tableName | dirPath | documentName |
      | testSqlDB    |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName | tableName             | dirPath | documentName |
      | testSqlDB    | TableOfVaryingColumns |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName | tableName             | dirPath                                   | documentName      |
      | testSqlDB    | TableOfVaryingColumns | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumns1.json |
      | testSqlDB    | TableOfVaryingColumns | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumns2.json |
      | testSqlDB    | TableOfVaryingColumns | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumns3.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                                                                 | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | settings/catalogs                                                                      | ida/azurecosmosPayloads/SQL_API/cosmosCatalog11.json                 | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosSql11                                                     |                                                                      | 200           | AzureCosmosSql11 |                                                       |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfigSqlDynCols.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                |                                                                      | 200           | AzureCosmosSql11 |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql11 |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSql11')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql11  |                                                                      | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql11 |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSql11')].status |
    And verify created schema "AzureCosmosSql11" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSql11" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "TableOfVaryingColumns" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getTablesWithDynamicColumns | rowCount     |
    Then Postgres item count for "Field" attribute should be "12"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureCosmosSql11"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName | tableName | dirPath | documentName |
      | testSqlDB    |           |         |              |


  @AzureCosmosSQL @MLP-8341 @webtest
  Scenario: SC6468745: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns if data having dynamic column values
    Given user "Create" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName | tableName | dirPath | documentName |
      | testSqlDB2   |           |         |              |
    Given user "Create" a "Table" under the Azure Cosmos Account using SQL API
      | dataBaseName | tableName                | dirPath | documentName |
      | testSqlDB2   | TableOfVaryingColumnVals |         |              |
    Given user "Create" a "Document" under the Azure Cosmos Account using SQL API
      | dataBaseName | tableName                | dirPath                                   | documentName           |
      | testSqlDB2   | TableOfVaryingColumnVals | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumnValues1.json |
      | testSqlDB2   | TableOfVaryingColumnVals | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumnValues2.json |
      | testSqlDB2   | TableOfVaryingColumnVals | ida/azureCosmosPayloads/SQL_API/TestData/ | varyColumnValues3.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                                                                    | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | settings/catalogs                                                                      | ida/azurecosmosPayloads/SQL_API/cosmosCatalog12.json                    | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/catalogs/AzureCosmosSql12                                                     |                                                                         | 200           | AzureCosmosSql12 |                                                       |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                | ida/azurecosmosPayloads/SQL_API/cosmosCatalogerConfigSqlDynColVals.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                |                                                                         | 200           | AzureCosmosSql12 |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql12 |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSql12')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql12  |                                                                         | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/AzureCosmosSql12 |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='AzureCosmosSql12')].status |
    And verify created schema "AzureCosmosSql12" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "AzureCosmosSql12" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "TableOfVaryingColumnVals" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage             | queryField                    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosSQLQueries | getTablesWithDynamicColumnVal | rowCount     |
    Then Postgres item count for "Field" attribute should be "12"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/AzureCosmosSql12"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using SQL API
      | dataBaseName | tableName | dirPath | documentName |
      | testSqlDB2   |           |         |              |