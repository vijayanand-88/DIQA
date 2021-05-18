Feature:Verification of Azure Cosmos Cataloger (Mongo API)

  @webtest @AzureCosmosMongo @MLP-8341
  Scenario: Create new Catalog, Create New Plugin Configuration, Run the Plugin Configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body                                                          | response code | response message | jsonPath                                            |
      | application/json |       |       | Post         | settings/catalogs                                                                    | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog1.json         | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata                                                     |                                                               | 200           | CosmosMetadata   |                                                     |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                              | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfig1.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                              |                                                               | 200           | CosmosMetadata   |                                                     |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata  |                                                               | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata')].status |

  @webtest @AzureCosmosMongo @MLP-8341
  Scenario: SC6466764:Verify the Cluster(asgmongo.documents.azure.com) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata" from Catalog list
    And user performs "facet selection" in "Cluster" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "asgmongo.documents.azure.com" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField         | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getClusterMetadata | resultsInMap |
    Then following "metadata property values" for item "asgmongo.documents.azure.com" should match with postgres values stored in "hashMap"
      | ID |


  @webtest @AzureCosmosMongo @MLP-8341
  Scenario: SC6466766: Verify the Services should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "3 items were found" in Item Search results page
    And user performs "dynamic item click" on "asgmongo" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField              | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getFirstServiceMetaData | resultsInMap |
    Then following "metadata property values" for item "asgmongo" should match with postgres values stored in "hashMap"
      | Application Version |
      | Location            |
    And user select "CosmosMetadata" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "https://asgmongo-westus" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField                 | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getMetaDataOfSecondService | resultsInMap |
    Then following "metadata property values" for item "https://asgmongo-westus" should match with postgres values stored in "hashMap"
      | Location      |
      | serviceStatus |
    And user select "CosmosMetadata" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "https://asgmongo-eastus" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getMetaDataOfThirdService | resultsInMap |
    Then following "metadata property values" for item "https://asgmongo-eastus" should match with postgres values stored in "hashMap"
      | Location      |
      | serviceStatus |


  @webtest @AzureCosmosMongo @MLP-8341
  Scenario: SC6466767:Verify the Database(Cosmos) should have the appropriate app version information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata" from Catalog list
    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "Cosmos" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField              | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getStorageMetadataForDB | resultsInMap |
    Then following "metadata property values" for item "Cosmos" should match with postgres values stored in "hashMap"
      | Storage type |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | Cosmos                                                           |
      | attributeName  | Technical Data                                                   |
      | actualFilePath | ida/azureCosmosPayloads/Mongo_API/TestData/actualDBTechData.json |
    And user "update" the json file "ida/azureCosmosPayloads/Mongo_API/TestData/actualDBTechData.json" file for following values
      | jsonPath        | jsonValues |
      | $..['password'] |            |
    And user "update" the json file "ida/azureCosmosPayloads/Mongo_API/TestData/expectedDBTechData.json" file for following values
      | jsonPath        | jsonValues |
      | $..['password'] |            |
    Then file content in "ida/azureCosmosPayloads/Mongo_API/TestData/expectedDBTechData.json" should be same as the content in "ida/azureCosmosPayloads/Mongo_API/TestData/actualDBTechData.json"


  @webtest @AzureCosmosMongo @MLP-8341
  Scenario: SC6466768:Verify the Table(Tool_Regions) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Tool_Regions" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField       | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getTableMetaData | resultsInMap |
    Then following "metadata property values" for item "Tool_Regions" should match with postgres values stored in "hashMap"
      | Table Type  |
      | Description |


  @webtest @AzureCosmosMongo @MLP-8341
  Scenario: SC6466769:Verify the Column(RegionID) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata" from Catalog list
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "RegionID" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField        | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getColumnMetaData | resultsInMap |
    Then following "metadata property values" for item "RegionID" should match with postgres values stored in "hashMap"
      | Data type |
      | Length    |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | RegionID                                                          |
      | attributeName  | Technical Data                                                    |
      | actualFilePath | ida/azureCosmosPayloads/Mongo_API/TestData/actualColTechData.json |
    Then file content in "ida/azureCosmosPayloads/Mongo_API/TestData/expectedColTechData.json" should be same as the content in "ida/azureCosmosPayloads/Mongo_API/TestData/actualColTechData.json"


  @AzureCosmosMongo
  Scenario: Delete Plugin Configuration and Delete Catalog
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                     | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AzureCosmosCataloger |      | 204           |                  |          |
      |                  |       |       | Delete | settings/catalogs/CosmosMetadata        |      | 204           |                  |          |


  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6467103: Verify the Table should have constraints window with the Primary Key constraint available
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                          | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog2.json         | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata2                                                     |                                                               | 200           | CosmosMetadata2  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfig2.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                               | 200           | CosmosMetadata2  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata2 |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata2')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata2  |                                                               | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata2 |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata2')].status |
    And verify created schema "CosmosMetadata2" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata2" from Catalog list
    And user performs "facet selection" in "Constraint" attribute under "Type" facets in Item Search results page
    And user performs "facet selection" in "Tool_Regions [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField        | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getConstraintInfo | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata2"
    Then Status code 204 must be returned

  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468477: Verify AzureCosmosCataloger cataloger scans and collects data if table names are not provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                          | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog3.json         | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata3                                                     |                                                               | 200           | CosmosMetadata3  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfig3.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                               | 200           | CosmosMetadata3  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata3 |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata3')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata3  |                                                               | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata3 |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata3')].status |
    And verify created schema "CosmosMetadata3" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata3" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "11 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField              | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getTablesWithoutFilters | rowCount     |
    Then Postgres item count for "Field" attribute should be "11"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata3"
    Then Status code 204 must be returned

  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468480: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns with filters(one table) applied
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                          | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog4.json         | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata4                                                     |                                                               | 200           | CosmosMetadata4  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfig4.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                               | 200           | CosmosMetadata4  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata4 |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata4')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata4  |                                                               | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata4 |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata4')].status |
    And verify created schema "CosmosMetadata4" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata4" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "Tool_Shippers" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getTablesAfterFilters | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata4"
    Then Status code 204 must be returned

  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468481: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns with filters(multiple table) applied.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                          | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog5.json         | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata5                                                     |                                                               | 200           | CosmosMetadata5  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfig5.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                               | 200           | CosmosMetadata5  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata5 |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata5')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata5  |                                                               | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata5 |                                                               | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata5')].status |
    And verify created schema "CosmosMetadata5" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata5" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "3 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getMultipleTableInFilters | rowCount     |
    Then Postgres item count for "Field" attribute should be "3"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata5"
    Then Status code 204 must be returned


  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468484: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns with filters(non-existing table) applied.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                                         | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog6.json                        | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata6                                                     |                                                                              | 200           | CosmosMetadata6  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfigNonExistingTable.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                                              | 200           | CosmosMetadata6  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata6 |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata6')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata6  |                                                                              | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata6 |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata6')].status |
    And verify created schema "CosmosMetadata6" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata6" from Catalog list
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField             | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | NonExistingTableFilter | rowCount     |
    Then Postgres item count for "Field" attribute should be "0"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField               | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | ExistingServiceClusterDB | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata6"
    Then Status code 204 must be returned


  @AzureCosmosMongo @MLP-8341 @MLP-9755 @webtest
  Scenario: SC6468498: Verify JDBC cataloger plugin config throws error message in UI if mandatory fields are not passed as input
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


  @AzureCosmosMongo @MLP-8341 @MLP-9755 @webtest
  Scenario: SC6468503: Verify AzureCosmosCataloger plugin config does not catalog any items if the Database name is incorrectly provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                                      | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog7.json                     | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata7                                                     |                                                                           | 200           | CosmosMetadata7  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfigNonExistingDB.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                                           | 200           | CosmosMetadata7  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata7 |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata7')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata7  |                                                                           | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata7 |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata7')].status |
    And verify created schema "CosmosMetadata7" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata7" from Catalog list
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata7"
    Then Status code 204 must be returned

  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468504: Verify AzureCosmosCataloger plugin config does not catalog any items if the Primary Key is incorrectly provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                                  | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog8.json                 | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata8                                                     |                                                                       | 200           | CosmosMetadata8  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfigInvalidPK.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                                       | 200           | CosmosMetadata8  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata8 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata8')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata8  |                                                                       | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata8 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata8')].status |
    And verify created schema "CosmosMetadata8" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata8" from Catalog list
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata8"
    Then Status code 204 must be returned


  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468593: Verify AzureCosmosCataloger plugin config does not catalog any items if the Host is incorrectly(Mongo API)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                                    | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | settings/catalogs                                                                     | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog9.json                   | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata9                                                     |                                                                         | 200           | CosmosMetadata9  |                                                      |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                               | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfigInvalidHost.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                               |                                                                         | 200           | CosmosMetadata9  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata9 |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata9')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata9  |                                                                         | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata9 |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata9')].status |
    And verify created schema "CosmosMetadata9" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata9" from Catalog list
    Then user verify "catalog not contains" any "Table" attribute under "Type" facets
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata9"
    Then Status code 204 must be returned


  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468623: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns if User name is incorrectly provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                                                                    | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | settings/catalogs                                                                      | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog10.json                  | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata10                                                     |                                                                         | 200           | CosmosMetadata10 |                                                       |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfigInvalidUser.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                |                                                                         | 200           | CosmosMetadata10 |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata10 |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata10')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata10  |                                                                         | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata10 |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata10')].status |
    And verify created schema "CosmosMetadata10" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata10" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "3 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField              | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getTablesForInvalidUser | rowCount     |
    Then Postgres item count for "Field" attribute should be "3"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata10"
    Then Status code 204 must be returned

  @webtest @AzureCosmosMongo @MLP-8341
  Scenario: SC6468625: Verify AzureCosmosCataloger collects three services if geolocation is enabled for azure cosmos DB Mongo API and the service that matches the hostname should have all DB items collected.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                                                           | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | settings/catalogs                                                                      | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog11.json         | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata11                                                     |                                                                | 200           | CosmosMetadata11 |                                                       |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfig11.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                |                                                                | 200           | CosmosMetadata11 |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata11 |                                                                | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata11')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata11  |                                                                | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosMetadata11 |                                                                | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata11')].status |
    And verify created schema "CosmosMetadata11" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata11" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "3 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getServices | rowCount     |
    Then Postgres item count for "Field" attribute should be "3"
    And user performs "dynamic item click" on "asgmongo" item from search results
    Then verify the table "DATABASES" has item "Cosmos"
    And user clicks on item "Cosmos" in table "DATABASES"
    Then verify the table "TABLES" has item "Tool_Shippers"
    And user clicks on item "Tool_Shippers" in table "TABLES"
    Then verify the table "COLUMNS" has item "Phone"
    And user clicks on item "Phone" in table "COLUMNS"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata11"
    Then Status code 204 must be returned


  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468655: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns if node condition is specified in configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                           | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | settings/catalogs                                                                         | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog12.json         | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/catalogs/CosmosMetadata12                                                        |                                                                | 200           | CosmosMetadata12 |                                                       |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                   | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfig12.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                   |                                                                | 200           | CosmosMetadata12 |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/cataloger/AzureCosmosCataloger/CosmosMetadata12 |                                                                | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata12')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/cataloger/AzureCosmosCataloger/CosmosMetadata12  |                                                                | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/cataloger/AzureCosmosCataloger/CosmosMetadata12 |                                                                | 200           | IDLE             | $.[?(@.configurationName=='CosmosMetadata12')].status |
    And verify created schema "CosmosMetadata12" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosMetadata12" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "11 items were found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField               | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getTablesWithoutFilters1 | rowCount     |
    Then Postgres item count for "Field" attribute should be "11"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosMetadata12"
    Then Status code 204 must be returned


  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468657: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns if data having dynamic columns
    Given user "Create" a "Database" under the Azure Cosmos Account using MongoAPI
      | dataBaseName | collectionName | dirPath                                     | documentName          |
      | testDB1      |                |                                             |                       |
    Given user "Create" a "Collection" under the Azure Cosmos Account using MongoAPI
      | dataBaseName | collectionName  | dirPath                                     | documentName          |
      | testDB1      | testCollection1 |                                             |                       |
    Given user "Create" a "Document" under the Azure Cosmos Account using MongoAPI
      | dataBaseName | collectionName  | dirPath                                     | documentName           |
      | testDB1      | testCollection1 | ida/azureCosmosPayloads/Mongo_API/TestData/ | TestDynamicTable1.json |
      | testDB1      | testCollection1 | ida/azureCosmosPayloads/Mongo_API/TestData/ | TestDynamicTable2.json |
      | testDB1      | testCollection1 | ida/azureCosmosPayloads/Mongo_API/TestData/ | TestDynamicTable3.json |
      | testDB1      | testCollection1 | ida/azureCosmosPayloads/Mongo_API/TestData/ | TestDynamicTable4.json |
      | testDB1      | testCollection1 | ida/azureCosmosPayloads/Mongo_API/TestData/ | TestDynamicTable5.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body                                                                | response code | response message     | jsonPath                                                  |
      | application/json |       |       | Post         | settings/catalogs                                                                          | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog13.json              | 204           |                      |                                                           |
      |                  |       |       | Get          | settings/catalogs/CosmosDynCols                                                            |                                                                     | 200           | CosmosDynCols        |                                                           |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                    | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfigDynCols.json | 204           |                      |                                                           |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                    |                                                                     | 200           | CosmosDynCols        |                                                          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosDynCols        |                                                                     | 200           | IDLE                 | $.[?(@.configurationName=='CosmosDynCols')].status        |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosDynCols         |                                                                     | 200           |                      |                                                           |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosDynCols        |                                                                     | 200           | IDLE                 | $.[?(@.configurationName=='CosmosDynCols')].status        |
    And verify created schema "CosmosDynCols" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosDynCols" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getTablesWithDynamicColumns | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosDynCols"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using MongoAPI
      | dataBaseName | collectionName | dirPath | documentName |
      | testDB1      |                |         |              |


  @AzureCosmosMongo @MLP-8341 @webtest
  Scenario: SC6468658: Verify AzureCosmosCataloger collects items like Cluster, Service, Database, Table, Columns if data having dynamic columns
    Given user "Create" a "Database" under the Azure Cosmos Account using MongoAPI
      | dataBaseName | collectionName | dirPath                                     | documentName          |
      | testDB2      |                |                                             |                       |
    Given user "Create" a "Collection" under the Azure Cosmos Account using MongoAPI
      | dataBaseName | collectionName         | dirPath                                     | documentName          |
      | testDB2      | TableWithDiffDataTypes |                                             |                       |
    Given user "Create" a "Document" under the Azure Cosmos Account using MongoAPI
      | dataBaseName | collectionName         | dirPath                                     | documentName          |
      | testDB2      | TableWithDiffDataTypes | ida/azureCosmosPayloads/Mongo_API/TestData/ | TestAllDataTypes.json |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body                                                                | response code | response message     | jsonPath                                                  |
      | application/json |       |       | Post         | settings/catalogs                                                                          | ida/azurecosmosPayloads/Mongo_API/cosmosCatalog14.json              | 204           |                      |                                                           |
      |                  |       |       | Get          | settings/catalogs/CosmosDatatypes                                                          |                                                                     | 200           | CosmosDatatypes      |                                                           |
      |                  | raw   | false | Put          | settings/analyzers/AzureCosmosCataloger                                                    | ida/azurecosmosPayloads/Mongo_API/cosmosCatalogerConfigDiffTypes.json | 204           |                      |                                                           |
      |                  |       |       | Get          | settings/analyzers/AzureCosmosCataloger                                                    |                                                                       | 200           | CosmosDatatypes      |                                                           |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosDatatypes      |                                                                     | 200           | IDLE                 | $.[?(@.configurationName=='CosmosDatatypes')].status        |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/AzureCosmosCataloger/CosmosDatatypes       |                                                                     | 200           |                      |                                                             |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/AzureCosmosCataloger/CosmosDatatypes      |                                                                     | 200           | IDLE                 | $.[?(@.configurationName=='CosmosDatatypes')].status        |
    And verify created schema "CosmosDatatypes" exists in database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "CosmosDatatypes" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
    And user performs "item click" on "TableWithDiffDataTypes" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage               | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | AzureCosmosMongoQueries | getTablesWithDiffDataTypes  | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    When user makes a REST Call for DELETE request with url "/settings/catalogs/CosmosDatatypes"
    Then Status code 204 must be returned
    Given user "Delete" a "Database" under the Azure Cosmos Account using MongoAPI
      | dataBaseName | collectionName | dirPath | documentName |
      | testDB2      |                |         |              |