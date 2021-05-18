Feature:MLP_3667 Feature for Mapping has to support types

  @edibus @mlp-3667 @webtest @positive @toIDP
  Scenario:SC1#_MLP-3667 Add new Item of type DWR_TFM_SYSTEM and DWR_RDB_DB_SYSTEM in EDI and Validate whether item is suffixed with Operation and DB
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | 0         |
    And user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType          | itemName     |
      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_SYSTEM    | NewTFMSystem |
      | AP-DATA      | AUTOMATION  | 1.0                | DWR_RDB_DB_SYSTEM | NewSystem    |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                              | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~= NewTFMSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | 1         |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                              | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~= NewSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | 1         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                            | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_3667_EDITOIDXConfig.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXNew |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXNew')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXNew  |                                                 | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXNew |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXNew')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "NewTFMSystem" and clicks on search
    And user performs "item click" on "NewTFMSystem≫Operation" item from search results
    And user enters the search text "NewSystem" and clicks on search
    And user performs "item click" on "NewSystem≫DB" item from search results
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXNew%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3667_EDITOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                            | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_3667_EDITOIDXConfig.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXNew |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXNew')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXNew  |                                                 | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXNew |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXNew')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXNew% | Analysis |       |       |

  @edibus @edibus @mlp-3667 @positive
  Scenario:SC2#_Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
