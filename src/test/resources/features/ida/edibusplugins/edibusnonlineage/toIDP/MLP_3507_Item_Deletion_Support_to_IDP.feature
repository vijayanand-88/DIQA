Feature: MLP-3507 Support of item deletion for items replciated to IDX  with standard license

  @MLP-3507 @edibus
  Scenario Outline: SC1#-Set the DataSource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                           | path                                  | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusAutoDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAutoDataSource.configurations | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                      |                                                                    |                                       | 200           | EDIBusAutoDataSource |          |


  @edibus @mlp-3507 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#MLP-3507 Full Replication of data from EDI to IDX and verify all items replicated in IDX
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                              | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/EDITOIDXConfigAllTypesNew.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXAutomation |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXAutomation  |                                                   | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXAutomation |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXAutomation')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TestDBSystem" and clicks on search
    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user verifies "7" items found
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Database |
      | Table    |
      | Schema   |
      | Service  |
    And user enters the search text "TFMSystem" and clicks on search
    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user verifies "3" items found
    And user enters the search text "EDItoIDXAutomation" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXAutomation%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXAutomation%" should display below info/error/warning
      | type | logValue              | logCode      | pluginName | removableText |
      | INFO | 19 items were written | EDIBUS-I0024 |            |               |


  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/EDITOIDXConfigAllTypesNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                              | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/EDITOIDXConfigAllTypesNew.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXAutomation |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXAutomation  |                                                   | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXAutomation |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXAutomation')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXAutomation% | Analysis |       |       |


  @edibus @mlp-3507 @webtest @positive @release10.0 @toIDP
  Scenario:SC2#MLP-3507 Validate replication of incremental data when adding new item and running EDI Bus with incremental replication
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                        | body                                         | response code | response message | jsonPath                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json | 204           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                              | 200           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TestDBSystem" and clicks on search
    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user verifies "7" items found
    And user enters the search text "ToIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ToIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ToIDX%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 16 items | EDIBUS-I0024 |            |               |
    And user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | itemType          | itemName  |
      | AP-DATA      | EDIAUTOMATION | 1.0                | DWR_RDB_DB_SYSTEM | NewSystem |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                        | body                                             | response code | response message | jsonPath                                   |
      |        |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfigIncr.json | 204           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                                  | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                                  | 200           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                                  | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And user enters the search text "NewSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | NewSystem≫DB |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    And user enters the search text "ToIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ToIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC2#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                        | body                                         | response code | response message | jsonPath                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json | 204           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                              | 200           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name               | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/ToIDX% | Analysis |       |       |


  @edibus @mlp-3507 @webtest @positive @release10.0 @toIDP
  Scenario:SC3#MLP-3507 Verify Full replication of data when adding item from EDI with incremental as false
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              | itemCount |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | 0         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                        | body                                         | response code | response message | jsonPath                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json | 204           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                              | 200           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ToIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ToIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ToIDX%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 16 items | EDIBUS-I0024 |            |               |
    And user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | itemType          | itemName  |
      | AP-DATA      | EDIAUTOMATION | 1.0                | DWR_RDB_DB_SYSTEM | NewSystem |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                        | body                                   | response code | response message | jsonPath                                   |
      |        |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDX.json | 204           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                        | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                        | 200           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                        | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And user enters the search text "NewSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | NewSystem≫DB |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    And user enters the search text "ToIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ToIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC3#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                        | body                                         | response code | response message | jsonPath                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json | 204           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                              | 200           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDX.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                        | body                                   | response code | response message | jsonPath                                   |
      |        |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDX.json | 204           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                        | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                        | 200           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                        | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name               | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/ToIDX% | Analysis |       |       |

  @edibus @mlp-3507 @webtest @positive @release10.0 @toIDP
  Scenario Outline:SC4#MLP-3507 Validate in IDP once the item is deleted in EDI and imported to IDX
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
    And user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | itemType          | itemName  |
      | AP-DATA      | EDIAUTOMATION | 1.0                | DWR_RDB_DB_SYSTEM | NewSystem |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              | itemCount |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | 1         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                        | body                                         | response code | response message | jsonPath                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json | 204           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                              | 200           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ToIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ToIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ToIDX%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 17 items | EDIBUS-I0024 |            |               |
    And user enters the search text "NewSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | NewSystem≫DB |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
    And user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDX.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                        | body                                   | response code | response message | jsonPath                                   |
      |        |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDX.json | 204           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                        | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                        | 200           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                        | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And user enters the search text "ToIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ToIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | NewSystem≫DB |             |            |          |


  Scenario:SC4#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                        | body                                         | response code | response message | jsonPath                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json | 204           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                              | 200           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |

  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name               | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/ToIDX% | Analysis |       |       |


  @edibus @mlp-3507 @webtest @positive @release10.0 @toIDP
  Scenario Outline:SC5#MLP-3507 Validate replication of incremental data when deleting  item in EDI and running EDI Bus with incremental replication
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
    And user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | itemType          | itemName  |
      | AP-DATA      | EDIAUTOMATION | 1.0                | DWR_RDB_DB_SYSTEM | NewSystem |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              | itemCount |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | 1         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                        | body                                         | response code | response message | jsonPath                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json | 204           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                              | 200           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ToIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ToIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ToIDX%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 17 items | EDIBUS-I0024 |            |               |
    And user enters the search text "NewSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | NewSystem≫DB |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                        | body                                       | response code | response message | jsonPath                                   |
      |        |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXTrue.json | 204           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                            | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                            | 200           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                            | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And user enters the search text "ToIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ToIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | NewSystem≫DB |             |            |          |

  Scenario:SC5#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                        | body                                         | response code | response message | jsonPath                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXConfig.json | 204           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                              | 200           |                  |                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                              | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
    And user update the json file "idc/EdiBusPayloads/MLP_3507_TOIDXTrue.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                        | body                                       | response code | response message | jsonPath                                   |
      |        |       |       | Put          | settings/analyzers/EDIBus                                  | idc/EdiBusPayloads/MLP_3507_TOIDXTrue.json | 204           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                            | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ToIDX  |                                            | 200           |                  |                                            |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ToIDX |                                            | 200           | IDLE             | $.[?(@.configurationName=='ToIDX')].status |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name               | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/ToIDX% | Analysis |       |       |


  @edibus @mlp-3507 @webtest @positive @release10.0 @toIDP
  Scenario:SC6#MLP-3507 Run EDI Bus with item types in metability which has zero items and validate the replication in IDX
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                            | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_3507_EDITOIDXConfig.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDX  |                                                 | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDX')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDItoIDX" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDX%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 0 items | EDIBUS-I0024 |            |               |


  Scenario:SC6#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3507_EDITOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                            | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_3507_EDITOIDXConfig.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDX  |                                                 | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDX')].status |

  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDX% | Analysis |       |       |

  @edibus @edibus @mlp-3507 @positive @release10.0
  Scenario:SC8#Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea   | subjectAreaVersion | query                                                                              |
      | AP-DATA      | EDIAUTOMATION | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |