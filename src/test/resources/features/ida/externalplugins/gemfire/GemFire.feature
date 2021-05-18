Feature: Start Analysis job in Gemfire plugin


#  @positive @datacreation @MLP-8669
#  Scenario: Create Data for gemfire
#    Given User connects to cmd and "create" data for gemfire

  @positive @MLP-8669
  Scenario: Catalog creation
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                 | body                                    | response code | response message | jsonPath |
      | application/json |       |       | Post | settings/catalogs                   | ida/gemfirePayloads/gemfireCatalog.json | 204           |                  |          |
      |                  |       |       | Get  | settings/catalogs/Gemfire%20Catalog |                                         | 200           | Gemfire Catalog  |          |

  @positive @MLP-8669
  Scenario: Create Gemfire Plugin config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                 | body                                            | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/GemfireCataloger | ida/gemfirePayloads/gemfireCatalogerConfig.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/GemfireCataloger |                                                 | 200           | GemfireCataloger |          |

  @positive @MLP-8669
  Scenario: Start the plugin config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body | response code | response message | jsonPath                                              |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/GemfireCataloger/GemfireCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='GemfireCataloger')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/GemfireCataloger/GemfireCataloger  |      | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/GemfireCataloger/GemfireCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='GemfireCataloger')].status |


  @webtest @jdbc @MLP-8669
  Scenario: Verify the Cluster should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Cluster" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Gemfire" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage      | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | gemfireQueries | getClusterMD | resultsInMap |
    Then following "metadata property values" for item "Gemfire" should match with postgres values stored in "jsonHashMap"
      | Technical Data |

  @webtest @positive @MLP-8669
  Scenario: Verify the Database Name should have the appropriate metadata information in IDC UI and Database(gemfire)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Gemfire" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage      | queryField      | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | gemfireQueries | getDatabaseName | resultsInMap |
    Then following "metadata property values" for item "Gemfire" should match with postgres values stored in "jsonHashMap"
      | ID |


  @webtest @positive @MLP-8669
  Scenario: Verify the Service should have the appropriate metadata information in IDC UI and Database(gemfire)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Gemfire" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage      | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | gemfireQueries | getServiceMD | resultsInMap |
    Then following "metadata property values" for item "Gemfire" should match with postgres values stored in "jsonHashMap"
      | Application Version | ID |


  @webtest @positive @MLP-8669
  Scenario: Verify the Host(locator) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Host" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "gemfire_locator1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage      | queryField | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | gemfireQueries | getHostMD  | resultsInMap |
    Then following "metadata property values" for item "gemfire_locator1" should match with postgres values stored in "map"
      | Technical Data | hostIp | Host name | Number of cores |


  @webtest @positive @MLP-8669
  Scenario: Verify local index and lucene index are properly collected under server metadata
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Host" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "gemfire_server1" item from search results
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | gemfire_server1                 |
      | attributeName  | Technical Data                  |
      | actualFilePath | ida/gemfirePayloads/actual.json |
    Then user verifies the presence of json "value" in the json file
      | actualFilePath                  | jsonPath                          | jsonValue          |
      | ida/gemfirePayloads/actual.json | $['Index'].['Indexes1']           | TestKeyIndex       |
      | ida/gemfirePayloads/actual.json | $['Lucene Index'].['Index Name1'] | lucene_Index_order |
      | ida/gemfirePayloads/actual.json | $['Lucene Index'].['Region Path'] | /orders            |
    And user clicks on close button in the item full view page
    And user performs "item click" on "gemfire_server2" item from search results
    Then user "verify metadata property values" with following expected parameters for item "gemfire_server2"
      | ID                       |
      | Gemfire Catalog.Host:::3 |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | gemfire_server2                 |
      | attributeName  | Technical Data                  |
      | actualFilePath | ida/gemfirePayloads/actual.json |
    Then user verifies the presence of json "value" in the json file
      | actualFilePath                  | jsonPath                          | jsonValue          |
      | ida/gemfirePayloads/actual.json | $['Index'].['Indexes1']           | myKeyIndex_local   |
      | ida/gemfirePayloads/actual.json | $['Lucene Index'].['Index Name1'] | lucene_Index_order |
      | ida/gemfirePayloads/actual.json | $['Lucene Index'].['Region Path'] | /orders            |


  @webtest @positive @MLP-8669
  Scenario: Verify Gemfirecataloger scans and collects different built in primitive data types and the entryCount property gets updated with correct value for different region types
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Host" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "gemfire_server1" item from search results
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | gemfire_server1                 |
      | attributeName  | Technical Data                  |
      | actualFilePath | ida/gemfirePayloads/actual.json |
    Then user verifies the presence of json "value" in the json file
      | actualFilePath                  | jsonPath                                                 | jsonValue |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_datatype'].['Entry Count']  | 3         |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_local'].['Entry Count']     | 6         |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_partition'].['Entry Count'] | 6         |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_pincode'].['Entry Count']   | 68        |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_replicate'].['Entry Count'] | 4         |
    And user clicks on close button in the item full view page
    And user performs "item click" on "gemfire_server2" item from search results
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | gemfire_server2                 |
      | attributeName  | Technical Data                  |
      | actualFilePath | ida/gemfirePayloads/actual.json |
    Then user verifies the presence of json "value" in the json file
      | actualFilePath                  | jsonPath                                                 | jsonValue |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_datatype'].['Entry Count']  | 4         |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_local'].['Entry Count']     | 0         |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_partition'].['Entry Count'] | 7         |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_pincode'].['Entry Count']   | 68        |
      | ida/gemfirePayloads/actual.json | $['Server Regions'].['region_replicate'].['Entry Count'] | 4         |


  @webtest @positive @MLP-8669
  Scenario: Verify the Host(server)/GatewaySender/GatewayReceiver should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Host" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "gemfire_server1" item from search results
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | gemfire_server1                              |
      | attributeName  | Technical Data                               |
      | actualFilePath | ida/gemfirePayloads/actualGatewaySender.json |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | gemfire_server1                                |
      | attributeName  | Technical Data                                 |
      | actualFilePath | ida/gemfirePayloads/actualGatewayReceiver.json |
    Then user verifies the presence of json "file value" in the json file
      | actualFilePath                                 | jsonPath              | jsonValue | expectedFilePath                                 |
      | ida/gemfirePayloads/actualGatewaySender.json   | $['Gateway Sender']   |           | ida/gemfirePayloads/expectedGatewaySender.json   |
      | ida/gemfirePayloads/actualGatewayReceiver.json | $['Gateway Receiver'] |           | ida/gemfirePayloads/expectedGatewayReceiver.json |


  @webtest @positive @Diagramming @MLP-8669
  Scenario: Verify Relationships is not supported for column level.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
    Then user verify "catalog not contains" any "Column" attribute under "Type" facets
#    And user performs "item click" on "Gemfire" item from search results
#    And user "navigatesToTab" name "Relationships" in item view page
#    Then user verifies whether the following image is present
#      | Method           | Action      | Path                    | Percentage |
#      | initializeImage  | Gemfire.png | DIAGRAMMING_IMAGES_PATH |            |
#      | verifyImageExist | 2           |                         |            |


  @webtest @positive @MLP-8669
  Scenario: Verify the Table Name(Region Type: NORMAL) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "region_local" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage      | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | gemfireQueries | getTableType | resultsInMap |
    Then following "metadata property values" for item "region_local" should match with postgres values stored in "jsonHashMap"
      | Table Type | Technical Data | Table size | ID |


  @webtest @positive @MLP-8669
  Scenario: Verify the breadcrumb hierarchy appears correctly when JDBC cataloger is ran for Gemfire Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "region_local" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | Gemfire      |
      | Gemfire      |
      | Gemfire      |
      | region_local |


  @webtest @positive @MLP-8669
  Scenario: Verify the Table Name(Region Type: PARTITION) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "region_pincode" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage      | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | gemfireQueries | getTableType1 | resultsInMap |
    Then following "metadata property values" for item "region_pincode" should match with postgres values stored in "jsonHashMap"
      | Table Type | Technical Data | Table size | ID |


  @webtest @positive @MLP-8669
  Scenario: Verify the Table Name(Region Type: REPLICATE) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "region_replicate" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage      | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | gemfireQueries | getTableType2 | resultsInMap |
    Then following "metadata property values" for item "region_replicate" should match with postgres values stored in "jsonHashMap"
      | Table Type | Technical Data | Table size | ID |


  @webtest @positive @MLP-8669
  Scenario: Verify the Table Name(Region Type: PERSISTENT_PARTITION) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "region_partition" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage      | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | gemfireQueries | getTableType3 | resultsInMap |
    Then following "metadata property values" for item "region_partition" should match with postgres values stored in "jsonHashMap"
      | Table Type | Technical Data | Table size | ID |


  @webtest @positive @MLP-8669
  Scenario: Verify the technology tags got assigned to all Gemfire items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName     | name     | facet | Tag                         |
      | Gemfire Catalog | Table    | Type  | Gemfire,In-Memory Databases |
      | Gemfire Catalog | Host     | Type  | Gemfire,In-Memory Databases |
      | Gemfire Catalog | Analysis | Type  | Gemfire,In-Memory Databases |
      | Gemfire Catalog | Cluster  | Type  | Gemfire,In-Memory Databases |
      | Gemfire Catalog | Database | Type  | Gemfire,In-Memory Databases |
      | Gemfire Catalog | Service  | Type  | Gemfire,In-Memory Databases |


  @webtest @jdbc @MLP-8669
  Scenario: Verify proper error message is shown if mandatory fields are not filled in GemfireCataloger plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "GemfireCataloger" plugin config list in Plugin Manager page
    And user add button in "GEMFIRECATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | HOSTNAME              |                        |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | LOCATORPORT           |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | JMXPORT               |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | NAME                                  |
      | errorMessage | Name field should not be empty        |
      | fieldName    | HOSTNAME                              |
      | errorMessage | HostName field should not be empty    |
      | fieldName    | LOCATORPORT                           |
      | errorMessage | locatorPort field should not be empty |
      | fieldName    | JMXPORT                               |
      | errorMessage | JMXPort field should not be empty     |


  @webtest @positive @MLP-8669
  Scenario: Verify the data sampling information for primitive data types in gemfire database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM VIEW MANAGER" list
      | CATALOGS        | SUPPORTED TYPES |
      | Gemfire Catalog | Table           |
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "region_pincode" item from search results
    Then user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | key                    | value  |
      | Royapettah S.O         | 600014 |
      | Valmiki Nagar S.O      | 600041 |
      | Kovur S.O              | 600128 |
      | Arungolam S.O          | 631201 |
      | Palayaseevaram S.O     | 631606 |
      | Mylapore H.O           | 600004 |
      | Parthasarathy Koil S.O | 600005 |
      | Manampathi S.O         | 603403 |
      | Perambakkam S.O        | 631402 |
      | Balchettychatram S.O   | 631551 |

  @webtest @positive @MLP-8669
  Scenario: Verify the GemFireCataloger works properly when node condition is mentioned
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                    | body                                    | response code | response message                  | jsonPath                                                               | endpointType | itemName        |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                      | ida/gemfirePayloads/gemfireCatalog.json | 204           |                                   |                                                                        | catalog      | Gemfire Catalog |
      |                  |       |       | Get             | settings/analyzers/GemfireCataloger                                                                    |                                         | 200           | GemfireCatalogerWithNodeCondition |                                                                        |              |                 |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/cataloger/GemfireCataloger/GemfireCatalogerWithNodeCondition |                                         | 200           | IDLE                              | $.[?(@.configurationName=='GemfireCatalogerWithNodeCondition')].status |              |                 |
      |                  |       |       | Post            | /extensions/analyzers/start/InternalNode/cataloger/GemfireCataloger/GemfireCatalogerWithNodeCondition  |                                         | 200           |                                   |                                                                        |              |                 |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/cataloger/GemfireCataloger/GemfireCatalogerWithNodeCondition |                                         | 200           | IDLE                              | $.[?(@.configurationName=='GemfireCatalogerWithNodeCondition')].status |              |                 |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user clicks the show all button for the "Type" facet
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Table    |
      | Host     |
      | Analysis |
      | Cluster  |
      | Database |
      | Service  |


  @webtest @positive @MLP-8669
  Scenario: Verify Gemfire cataloger does not catalog any items if host url is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                    | body                                    | response code | response message                     | jsonPath                                                                  | endpointType | itemName        |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                      | ida/gemfirePayloads/gemfireCatalog.json | 204           |                                      |                                                                           | catalog      | Gemfire Catalog |
      |                  |       |       | Get             | settings/analyzers/GemfireCataloger                                                                    |                                         | 200           | GemfireCatalogerWithIncorrectHostURL |                                                                           |              |                 |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/GemfireCataloger/GemfireCatalogerWithIncorrectHostURL |                                         | 200           | IDLE                                 | $.[?(@.configurationName=='GemfireCatalogerWithIncorrectHostURL')].status |              |                 |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/GemfireCataloger/GemfireCatalogerWithIncorrectHostURL  |                                         | 200           |                                      |                                                                           |              |                 |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/GemfireCataloger/GemfireCatalogerWithIncorrectHostURL |                                         | 200           | IDLE                                 | $.[?(@.configurationName=='GemfireCatalogerWithIncorrectHostURL')].status |              |                 |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Unknown host: USYP5DIV.asg.com" in Analysis Log of IDC UI


  @webtest @positive @MLP-8669
  Scenario: Verify Gemfire cataloger does not catalog any items if local port/jmx port is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                 | body                                    | response code | response message                  | jsonPath                                                               | endpointType | itemName        |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                   | ida/gemfirePayloads/gemfireCatalog.json | 204           |                                   |                                                                        | catalog      | Gemfire Catalog |
      |                  |       |       | Get             | settings/analyzers/GemfireCataloger                                                                 |                                         | 200           | GemfireCatalogerWithIncorrectPort |                                                                        |              |                 |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/GemfireCataloger/GemfireCatalogerWithIncorrectPort |                                         | 200           | IDLE                              | $.[?(@.configurationName=='GemfireCatalogerWithIncorrectPort')].status |              |                 |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/GemfireCataloger/GemfireCatalogerWithIncorrectPort  |                                         | 200           |                                   |                                                                        |              |                 |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/GemfireCataloger/GemfireCatalogerWithIncorrectPort |                                         | 200           | IDLE                              | $.[?(@.configurationName=='GemfireCatalogerWithIncorrectPort')].status |              |                 |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "Gemfire Catalog" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Connection refused to host: USYP5DIVYBHAR1V.asg.com" in Analysis Log of IDC UI


  @positibe @MLP-8669
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                 | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GemfireCataloger |      | 204           |                  |          |


  @positive @MLP-8669
  Scenario: Delete Catalog
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                 | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/catalogs/Gemfire%20Catalog |      | 204           |                  |          |


#  @webtest @positive
#  Scenario:Verify the updates Gemfire plugin configuration
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    When user clicks on Administration widget
#    Then user clicks on Plugin Manager in Administration dashboard
#    And user clicks on "IDANode" from nodes list
#    Then user navigate to "GemfireCataloger" plugin configuration page
#    And user updates the Gemfire plugin configuration with new catalog "gemfire05"
#
#
#  @positive
#  Scenario: User fetch the gemfire plugin status and starts gemfire cataloger
#    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "/extensions/analyzers/status/IDANode/*/GemfireCataloger/Gemfire"
#    Then Status code 200 must be returned
#    And response message contains value "IDLE"
#    And user makes a REST Call for POST request with url "/extensions/analyzers/start/IDANode/*/GemfireCataloger/Gemfire"
#    And Status code 200 must be returned
#    And user makes a recursive REST Call for GET request "/extensions/analyzers/status/IDANode/*/GemfireCataloger/Gemfire" till the status becomes "IDLE" with maximum threshhold of "10" times
#
#
#  @webtest @positive
#  Scenario:Verify the cluster data from the catalog
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user searches for the "gemfire05" catalog
#    Then verify the search result has the "gemfire05" catalog
#    When user clicks on cluster in the catalog
#    Then user gets the "gemfire05" cluster tech data and validates with db table "V_Cluster"
#
#
#  @webtest @positive
#  Scenario:Verify the host data from the catalog
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user searches for the "gemfire05" catalog
#    Then verify the search result has the "gemfire05" catalog
#    And user clicks on host in the gemfire catalog
#    And user verifies the gemfire "gemfire05" catalog host techdata with the database table "V_Host"
#
#
#  @webtest @positive
#  Scenario:Verify the table data from the catalog
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user searches for the "gemfire05" catalog
#    Then verify the search result has the "gemfire05" catalog
#    And user clicks on table in the gemfire catalog
#    And user verifies the gemfire "gemfire05" catalog table techdata with the database table "V_Table"
#
#  @negative
#  Scenario:To delete the catalog
#    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "/settings/catalogs/gemfire05"
#    Then Status code 204 must be returned
#    When user makes a REST Call for Get request with url "/settings/catalogs/gemfire05"
#    And response message contains value "CONFIG-0007"
#    And verify created schema "gemfire05" doesn't exists in database
