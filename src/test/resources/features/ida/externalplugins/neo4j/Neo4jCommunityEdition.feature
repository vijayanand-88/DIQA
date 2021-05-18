Feature:  Neo4j plugin for community edition

  @positive @datacreation @MLP-8658
  Scenario:Create data in Neo4j Community Edition
    Given User connects to neoDB "Community Edition" and "Create" data
    Then user "verify presence" of following labels in neoDB "Community Edition"
      | "player"     |
      | "Country"    |
      | "Tournament" |
      | "umpire"     |

  @positive @MLP-8658
  Scenario: Catalog creation in Community Edition
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                               | body                                | response code | response message | jsonPath |
      | application/json |       |       | Post | settings/catalogs                 | ida/neo4jPayloads/neo4jCatalog.json | 204           |                  |          |
      |                  |       |       | Get  | settings/catalogs/Neo4j%20CATALOG |                                     | 200           | Neo4j CATALOG    |          |
      |                  |       |       | Post | settings/catalogs                 | ida/neo4jPayloads/catalogNeo4j.json | 204           |                  |          |
      |                  |       |       | Get  | settings/catalogs/neo4j05         |                                     | 200           | neo4j05          |          |


  @positive @MLP-8658
  Scenario: Create Neo4j Plugin config1
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                               | body                                                        | response code | response message               | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/Neo4jCataloger | ida/neo4jPayloads/Neo4jCommunityEditionCatalogerConfig.json | 204           |                                |          |
      |                  |       |       | Get  | settings/analyzers/Neo4jCataloger |                                                             | 200           | Neo4jCatalogerCommunityEdition |          |


  @positive @MLP-8658
  Scenario: Start the plugin config1
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                            | body | response code | response message | jsonPath                                                            |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition |      | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEdition')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition  |      | 200           |                  |                                                                     |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition |      | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEdition')].status |


  @webtest @positive @MLP-8658
  Scenario: Verify the Cluster should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Cluster" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Neo4jCataloger" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage    | queryField        | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | Neo4JQueries | getClusterDetails | resultsInMap |
    Then following "metadata property values" for item "Neo4jCataloger" should match with postgres values stored in "jsonHashMap"
      | ID |


  @webtest @positive @MLP-8658
  Scenario: Verify the Service should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Neo4j Kernel" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage    | queryField        | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | Neo4JQueries | getServiceDetails | resultsInMap |
    Then following "metadata property values" for item "Neo4j Kernel" should match with postgres values stored in "jsonHashMap"
      | Application Version | Description |

  @webtest @positive @MLP-8658
  Scenario: Verify the Database should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "default.graphdb" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage    | queryField         | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | Neo4JQueries | getDatabaseDetails | resultsInMap |
    Then following "metadata property values" for item "default.graphdb" should match with postgres values stored in "jsonHashMap"
      | Technical Data |

  @webtest @positive @MLP-8658
  Scenario: Verify the Table should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "player" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage    | queryField      | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | Neo4JQueries | getTableDetails | resultsInMap |
    Then following "metadata property values" for item "player" should match with postgres values stored in "jsonHashMap"
      | Table Type |


  @webtest @positive @MLP-8658
  Scenario: Verify the Column should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "POB" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage    | queryField       | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | Neo4JQueries | getColumnDetails | resultsInMap |
    Then following "metadata property values" for item "POB" should match with postgres values stored in "jsonHashMap"
      | Data type |


  @webtest @positive @MLP-8658
  Scenario: Verify Neo4jCataloger collects items like Cluster, Service, Database, Table, Columns if node condition is specified in configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                | body                                | response code | response message | jsonPath                                                                             | endpointType | itemName      |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                  | ida/neo4jPayloads/neo4jCatalog.json | 204           |                  |                                                                                      | catalog      | Neo4j CATALOG |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithNodeCondition |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEditionWithNodeCondition')].status |              |               |
      |                  |       |       | Post            | /extensions/analyzers/start/InternalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithNodeCondition  |                                     | 200           |                  |                                                                                      |              |               |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithNodeCondition |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEditionWithNodeCondition')].status |              |               |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user clicks the show all button for the "Type" facet
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Column       |
      | Relationship |
      | Field        |
      | Table        |
      | Analysis     |
      | Cluster      |
      | Database     |
      | Host         |
      | Service      |

  @webtest @positive @MLP-8658
  Scenario: Verify the breadcrumb hierarchy appears correctly when Neo4jCataloger is executed.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Field" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Wickets" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | Neo4jCataloger          |
      | Neo4j Kernel            |
      | default.graphdb         |
      | HIGHEST_WICKET_TAKER_OF |
      | Wickets                 |

  @webtest @positive @MLP-8658
  Scenario: Verify Neo4jCataloger plugin config throws error message in UI if mandatory fields are not passed as input.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "Neo4jCataloger" plugin config list in Plugin Manager page
    And user add button in "NEO4JCATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | BOLT REPOSITORY URL   |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | REPOSITORY USER       |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | REPOSITORY PASSWORD   |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | NAME                                          |
      | errorMessage | Name field should not be empty                |
      | fieldName    | BOLT REPOSITORY URL                           |
      | errorMessage | Bolt Repository URL field should not be empty |
      | fieldName    | REPOSITORY USER                               |
      | errorMessage | Repository user field should not be empty     |
      | fieldName    | REPOSITORY PASSWORD                           |
      | errorMessage | Repository password field should not be empty |


  @webtest @positive @MLP-8658
  Scenario: Verify the data sampling information for Neo4j
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM VIEW MANAGER" list
      | CATALOGS      | SUPPORTED TYPES |
      | Neo4j CATALOG | Table           |
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "player" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | name                | POB         | YOB  |
      | MahendraSingh Dhoni | Ranchi      | 1981 |
      | shikar Dhawan       | Delhi       | 1995 |
      | Ravindra Jadeja     | NavagamGhed | 1988 |


  @webtest @positive @MLP-8658
  Scenario: Verify the Relationship should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Relationship" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "WINNERS_OF" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage    | queryField             | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | Neo4JQueries | getRelationshipDetails | resultsInMap |
    Then following "metadata property values" for item "WINNERS_OF" should match with postgres values stored in "jsonHashMap"
      | ID |


  @webtest @positive @MLP-8658
  Scenario: Verify the Field should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Field" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "ODI" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage    | queryField      | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | Neo4JQueries | getFieldDetails | resultsInMap |
    Then following "metadata property values" for item "ODI" should match with postgres values stored in "jsonHashMap"
      | Data type |


  @webtest @positive @MLP-8658
  Scenario: Verify the Database should have the index constraint inside techData in metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "default.graphdb" item from search results
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | default.graphdb               |
      | attributeName  | Technical Data                |
      | actualFilePath | ida/neo4jPayloads/actual.json |
    Then user "verifies" the presence of the Values in "ida/neo4jPayloads/actual.json" json using the Jsonpath "$..Indexes"
      | Indexes1 | INDEX ON :Customer(customerID) |
      | Indexes2 | INDEX ON :Order(orderID)       |
      | Indexes3 | INDEX ON :Product(productID)   |


  @webtest @positive @Diagramming @MLP-8658
  Scenario: Verify the Lineage for the type 'Relationship' should have the appropriate details
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Relationship" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "HIGHEST_WICKET_TAKER_OF" item from search results
    Then user "verify presence" of following "item view section" in item view page
      | FIELDS |
      | FROM   |
      | TO     |
    And user "navigatesToTab" name "Relationships" in item view page
    Then user verifies whether the following image is present
      | Method           | Action           | Path                    |
      | initializeImage  | LineageNeo4j.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                |                         |


  @webtest @positive @MLP-8658
  Scenario: Verify the technology tags(Graph Databases, Neo4j) got assigned to all Neo4j DB items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName   | name         | facet | Tag                   |
      | Neo4j CATALOG | Column       | Type  | Graph Databases,Neo4j |
      | Neo4j CATALOG | Relationship | Type  | Graph Databases,Neo4j |
      | Neo4j CATALOG | Field        | Type  | Graph Databases,Neo4j |
      | Neo4j CATALOG | Table        | Type  | Graph Databases,Neo4j |
      | Neo4j CATALOG | Analysis     | Type  | Graph Databases,Neo4j |
      | Neo4j CATALOG | Cluster      | Type  | Graph Databases,Neo4j |
      | Neo4j CATALOG | Database     | Type  | Graph Databases,Neo4j |
      | Neo4j CATALOG | Service      | Type  | Graph Databases,Neo4j |


  @positive @datacreation @MLP-8658
  Scenario:Update data in Neo4j
    Given User connects to neoDB "Community Edition" and "update" data
    Then user "verify presence" of following labels in neoDB "Community Edition"
      | "Album" |


  @webtest @positive @MLP-8658
  Scenario:  Verify Neo4jCataloger recollects items like Cluster, Service, Database, Table, Columns if there is any data alterations in Neo4j Database
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                            | body                                | response code | response message | jsonPath                                                            | endpointType | itemName      |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                              | ida/neo4jPayloads/neo4jCatalog.json | 204           |                  |                                                                     | catalog      | Neo4j CATALOG |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEdition')].status |              |               |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition  |                                     | 200           |                  |                                                                     |              |               |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEdition')].status |              |               |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user clicks the show all button for the "Type" facet
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Column       |
      | Relationship |
      | Field        |
      | Table        |
      | Analysis     |
      | Cluster      |
      | Database     |
      | Host         |
      | Service      |
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Album" item from search results
    Then user "verify presence" of following "item view section" in item view page
      | METADATA |


  @webtest @positive @MLP-8658
  Scenario: Verify Neo4jCataloger plugin config does not catalog any items if the Repository Username is incorrectly provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                               | body                                | response code | response message | jsonPath                                                                               | endpointType | itemName      |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                 | ida/neo4jPayloads/neo4jCatalog.json | 204           |                  |                                                                                        | catalog      | Neo4j CATALOG |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithInvalidUsername |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEditionWithInvalidUsername')].status |              |               |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithInvalidUsername  |                                     | 200           |                  |                                                                                        |              |               |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithInvalidUsername |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEditionWithInvalidUsername')].status |              |               |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "AuthenticationException: The client is unauthorized due to authentication failure." in Analysis Log of IDC UI


  @webtest @positive @MLP-8658
  Scenario: Verify Neo4jCataloger plugin config does not catalog any items if the repository password is incorrectly provided.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                               | body                                | response code | response message | jsonPath                                                                               | endpointType | itemName      |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                 | ida/neo4jPayloads/neo4jCatalog.json | 204           |                  |                                                                                        | catalog      | Neo4j CATALOG |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithInvalidPassword |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEditionWithInvalidPassword')].status |              |               |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithInvalidPassword  |                                     | 200           |                  |                                                                                        |              |               |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEditionWithInvalidPassword |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEditionWithInvalidPassword')].status |              |               |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "AuthenticationException: The client is unauthorized due to authentication failure." in Analysis Log of IDC UI


  @webtest @positive @MLP-8658
  Scenario: Verify Neo4jCataloger does not catalog any items if host URL is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                       | body                                | response code | response message | jsonPath                                                                       | endpointType | itemName      |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                         | ida/neo4jPayloads/neo4jCatalog.json | 204           |                  |                                                                                | catalog      | Neo4j CATALOG |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityWithInvalidHostURL |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityWithInvalidHostURL')].status |              |               |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityWithInvalidHostURL  |                                     | 200           |                  |                                                                                |              |               |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityWithInvalidHostURL |                                     | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityWithInvalidHostURL')].status |              |               |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Neo4j CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "ServiceUnavailableException: Unable to connect" in Analysis Log of IDC UI


  @positive @MLP-8658
  Scenario: Delete Catalog
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/catalogs/Neo4j%20CATALOG |      | 204           |                  |          |

  @positive @MLP-8658
  Scenario: Create Neo4j Plugin config2
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                               | body                                        | response code | response message               | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/Neo4jCataloger | ida/neo4jPayloads/catalogerConfigNeo4j.json | 204           |                                |          |
      |                  |       |       | Get  | settings/analyzers/Neo4jCataloger |                                             | 200           | Neo4jCatalogerCommunityEdition |          |


  @positive @MLP-8658
  Scenario: Start the plugin config2
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                            | body | response code | response message | jsonPath                                                            |
      | application/json |       |       | Get          | settings/analyzers/Neo4jCataloger                                                              |      | 200           | Neo4jCataloger   |                                                                     |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition |      | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEdition')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition  |      | 200           |                  |                                                                     |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/Neo4jCataloger/Neo4jCatalogerCommunityEdition |      | 200           | IDLE             | $.[?(@.configurationName=='Neo4jCatalogerCommunityEdition')].status |


#  @webtest @positive @MLP-8658
#  Scenario:Verify the Starts an analysis in the Neo4j plugin
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    When user "Click" on "Administration" dashboard
#    Then user "Click" on "PLUGIN MANAGER" dashboard
#    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
#    Then user "navigates" to "Neo4jCataloger" plugin config list in Plugin Manager page
#    And user updates the Neo4j plugin configuration with new catalog "neo4j05"
#    And user "Click" on "ANALYSIS NODES" tab in "Plugin Manager" page
#    Then user monitors the "LocalNode" and starts the analysis on "Neo4jCataloger" plugin
#    And user selects "neo4j05" catalog from catalog list
#    And user clicks the show all button for the "Type" facet
#    Then user verify "presence of facets" with following values under "Type" section in item search results page
#      | Column       |
#      | Relationship |
#      | Field        |
#      | Table        |
#      | Analysis     |
#      | Cluster      |
#      | Database     |
#      | Host         |
#      | Service      |


  @webtest @positive @MLP-8658
  Scenario:Add the Neo4j Catalog to ItemView
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    When user "Click" on "Administration" dashboard
    Then user "Click" on "ITEM VIEW MANAGER" dashboard
    And user clicks on "itemView_Table" from item view list
    And user chooses catalog "neo4j05" in CATALOGS
    And user clicks on save button

  @webtest @positive @MLP-8658
  Scenario:Verify the Analysed Column data from Neo4j plugin
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "neo4j05" catalog from catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Column       |
      | Relationship |
      | Field        |
      | Table        |
      | Analysis     |
      | Cluster      |
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    Then user gets the table data sample and validates the columns in neoDB "Community Edition"


  @webtest @positive @MLP-8658
  Scenario:Verify the Analysed Table data from Neo4j plugin
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "neo4j05" catalog from catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Column       |
      | Relationship |
      | Field        |
      | Table        |
      | Analysis     |
      | Cluster      |
    And user clicks on table in the neo4j catalog
    And user connects to neoDB "Community Edition" gets the "neo4j05" table tech data and validates with db table "V_table"


  @webtest @positive @MLP-8658
  Scenario:Verify the Analysed Database data from Neo4j plugin
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "neo4j05" catalog from catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Column       |
      | Relationship |
      | Field        |
      | Table        |
      | Analysis     |
      | Cluster      |
    When user clicks on database in the neo4j catalog
    Then user gets the "neo4j05" database tech data and validates with db table "V_Database"


  @webtest @positive @MLP-8658
  Scenario:Verify the Analysed Servcie data from Neo4j plugin
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "neo4j05" catalog from catalog list
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Column       |
      | Relationship |
      | Field        |
      | Table        |
      | Analysis     |
      | Cluster      |
    And user clicks on service in the catalog
    And user connects to neoDB "Community Edition" gets the "neo4j05" service tech data and validates with db table "V_Service"


  @positive @data @MLP-8658
  Scenario:Delete data in Neo4j
    Given User connects to neoDB "Community Edition" and "Delete" data

  @positibe @MLP-8658
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/Neo4jCataloger |      | 204           |                  |          |


  @positive @MLP-8658
  Scenario:To delete the catalog
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/settings/catalogs/neo4j05"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "/settings/catalogs/neo4j05"
    And response message contains value "CONFIG-0007"
    And verify created schema "neo4j05" doesn't exists in database



