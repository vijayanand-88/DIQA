Feature: MLP-3681 Deletion using Full and incremental replication with standard license toEDI

  @edibus @mlp-3681 @positive
  Scenario Outline:MLP-3681_MLP-3219_SC1#_To import items of all types
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |



    #5713138##5710421## #Bug id- MLP-21531
  @edibus @mlp-3681 @webtest @positive @toEDI
  Scenario: MLP-3681_MLP-3219_SC1#_Run EDIBUS with EDI CleanUp as function parameter with incremental true and validate data is cleaned up in EDI
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                           | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigAllTypes.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                                | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                                | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                                | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIAutomation" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIAutomation%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                        | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/IDXTOEDICleanupIncr.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDICleanupIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDICleanupIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDICleanupIncr  |                                             | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDICleanupIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDICleanupIncr')].status |
    And user enters the search text "IDXtoEDICleanupIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDICleanupIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 2         |
    And user clicks on logout button


    #5714034##
  @edibus @mlp-3681 @webtest @positive @toEDI
  Scenario: MLP-3681_SC2#_Run EDIBUS with EDI CleanUp as function parameter with types Database and validate data is cleaned up in EDI
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                           | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigAllTypes.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                                | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                                | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                                | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      | itemNames |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) | MultiHop  |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                         | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/IDXTOEDICleanupTypes.json | 204           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDICleanupTypes |                                              | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDICleanupTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDICleanupTypes  |                                              | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDICleanupTypes |                                              | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDICleanupTypes')].status |
    And user enters the search text "IDXtoEDICleanupTypes" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDICleanupTypes%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) | 0         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )                                 | 19        |
    And user clicks on logout button

  @edibus @positive
  Scenario:SC3#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                              | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDIAutomation%   | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/IDXtoEDICleanupTypes% | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/IDXtoEDICleanupIncr%  | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster                | Cluster  |       |       |

  @edibus @positive
  Scenario:SC3#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |