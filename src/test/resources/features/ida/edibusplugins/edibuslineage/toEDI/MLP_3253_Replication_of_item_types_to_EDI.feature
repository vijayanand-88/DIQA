Feature: MLP-3253 Determine Items to be replicated from IDx to EDI

  @edibus @mlp-3253 @positive
  Scenario Outline:MLP-3253_SC1#_To import items of all types
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |


  ##5556834##
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC1#_Export items from IDX to EDI with type as DataDomain
    And user update the json file "idc/EdiBusPayloads/MLP_3253_IDXTOEDIDataDomain.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | false      |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                                | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/MLP_3253_IDXTOEDIDataDomain.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIDataDomain |                                                     | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIDataDomain')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIDataDomain  |                                                     | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIDataDomain |                                                     | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIDataDomain')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIDataDomain" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIDataDomain%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DataDomain" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DOMAIN ) |
    And user gets the count and item names from UI
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DOMAIN ) |
    And user clicks on logout button

  ##5715413## #Bug id- MLP-21531
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC2#_Export items from IDX to EDI with type as Service
    Given user update the json file "idc/EdiBusPayloads/MLP_3253_IDXTOEDIService.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | false      |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_3253_IDXTOEDIService.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIService |                                                  | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIService')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIService  |                                                  | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIService |                                                  | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIService')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIService" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIService%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM )   |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM )      |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | LineageTestCluster≫LineageTestService |
    And user clicks on logout button

    ##5715414## #Bug id- MLP-21531
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC3#_Export items from IDX to EDI with type as Operation
    And user update the json file "idc/EdiBusPayloads/MLP_3253_IDXTOEDIOperation.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | false      |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                               | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP_3253_IDXTOEDIOperation.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIOperation |                                                    | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIOperation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIOperation  |                                                    | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIOperation |                                                    | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIOperation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIOperation" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIOperation%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK )          |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION) |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           | itemNames            |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK )          | LineageTestOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION) | Added≫Operation      |
    And user clicks on logout button

##5715433##
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC4#_Export items from IDX to EDI with type as DataDomain and incremental as true
    Given user update the json file "idc/EdiBusPayloads/MLP_3253_IDXTOEDIDataDomain.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | true       |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                                | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/MLP_3253_IDXTOEDIDataDomain.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIDataDomain |                                                     | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIDataDomain')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIDataDomain  |                                                     | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIDataDomain |                                                     | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIDataDomain')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIDataDomain" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIDataDomain%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DataDomain" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DOMAIN ) |
    And user gets the count and item names from UI
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DOMAIN ) |
    And user clicks on logout button

##5715434## #Bug id- MLP-21531
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC5#_Export items from IDX to EDI with type as Service and incremental as true
    Given user update the json file "idc/EdiBusPayloads/MLP_3253_IDXTOEDIService.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | true       |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_3253_IDXTOEDIService.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIService |                                                  | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIService')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIService  |                                                  | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIService |                                                  | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIService')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIService" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIService%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM )   |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM )      |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM )   | LineageTestCluster≫LineageTestService |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) | LineageTestCluster≫LineageTestService |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM )      | LineageTestCluster≫LineageTestService |
    And user clicks on logout button

    ##5715435## #Bug id- MLP-21531
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC6#_Export items from IDX to EDI with type as Operation and incremental as true
    Given user update the json file "idc/EdiBusPayloads/MLP_3253_IDXTOEDIOperation.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | true       |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                               | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP_3253_IDXTOEDIOperation.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIOperation |                                                    | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIOperation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIOperation  |                                                    | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIOperation |                                                    | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIOperation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIOperation" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIOperation%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK )          |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION) |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                            | itemNames            |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK )           | LineageTestOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION ) | Added≫Operation      |
    And user clicks on logout button

     ##5715416##
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC7#_Export items from IDX to EDI  with type as Column and Operation
    Given user update the json file "idc/EdiBusPayloads/MLP_3253_ColumnOperation.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | false      |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                             | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/MLP_3253_ColumnOperation.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnOperationEDI |                                                  | 200           | IDLE             | $.[?(@.configurationName=='ColumnOperationEDI')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ColumnOperationEDI  |                                                  | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnOperationEDI |                                                  | 200           | IDLE             | $.[?(@.configurationName=='ColumnOperationEDI')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ColumnOperationEDI" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ColumnOperationEDI%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user gets the count and item names from UI
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) |
    And user gets the count and item names from UI
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) |
    And user clicks on logout button


    ##5715423##6725136#
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC8#_Export items from IDX to EDI with type as LineageHop and Operation
    Given user update the json file "idc/EdiBusPayloads/MLP_3253_OperationLineage.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | false      |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                              | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP_3253_OperationLineage.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/OperationLineageEDI |                                                   | 200           | IDLE             | $.[?(@.configurationName=='OperationLineageEDI')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/OperationLineageEDI  |                                                   | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/OperationLineageEDI |                                                   | 200           | IDLE             | $.[?(@.configurationName=='OperationLineageEDI')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "OperationLineageEDI" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/OperationLineageEDI%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) |
    And user gets the count and item names from UI
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                               | itemNames               |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP) | 9LIW9NA,UE5KVXR,VEL4EHC |
    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemName | itemType                   | attributeName | attributeValue |
      | AP-DATA      | AUTOMATION  | 1.0                | 9LIW9NA  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | Col7           |
      | AP-DATA      | AUTOMATION  | 1.0                | 9LIW9NA  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Col4           |
      | AP-DATA      | AUTOMATION  | 1.0                | UE5KVXR  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | Col2           |
      | AP-DATA      | AUTOMATION  | 1.0                | UE5KVXR  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Col5           |
      | AP-DATA      | AUTOMATION  | 1.0                | VEL4EHC  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | Col3           |
      | AP-DATA      | AUTOMATION  | 1.0                | VEL4EHC  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Col1           |
    And user clicks on logout button


     ##5715436##
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC9#_Export items from IDX to EDI  with type as Column and Operation and incremental true
    And user update the json file "idc/EdiBusPayloads/MLP_3253_ColumnOperation.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | true       |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                             | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/MLP_3253_ColumnOperation.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnOperationEDI |                                                  | 200           | IDLE             | $.[?(@.configurationName=='ColumnOperationEDI')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ColumnOperationEDI  |                                                  | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnOperationEDI |                                                  | 200           | IDLE             | $.[?(@.configurationName=='ColumnOperationEDI')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ColumnOperationEDI" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ColumnOperationEDI%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user gets the count and item names from UI
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) |
    And user gets the count and item names from UI
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) |
    And user clicks on logout button


    ##5715437##
  @edibus @mlp-3253 @webtest @positive @toEDI
  Scenario:MLP-3253_SC10#_Export items from IDX to EDI with type as LineageHop and Operation and incremental true
    Given user update the json file "idc/EdiBusPayloads/MLP_3253_OperationLineage.json" file for following values
      | jsonPath                               | jsonValues |
      | $..configurations[-1:].['incremental'] | true       |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                              | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP_3253_OperationLineage.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/OperationLineageEDI |                                                   | 200           | IDLE             | $.[?(@.configurationName=='OperationLineageEDI')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/OperationLineageEDI  |                                                   | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/OperationLineageEDI |                                                   | 200           | IDLE             | $.[?(@.configurationName=='OperationLineageEDI')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "OperationLineageEDI" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/OperationLineageEDI%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) |
    And user gets the count and item names from UI
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                | itemNames               |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 9LIW9NA,UE5KVXR,VEL4EHC |
    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemName | itemType                   | attributeName | attributeValue |
      | AP-DATA      | AUTOMATION  | 1.0                | 9LIW9NA  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | Col7           |
      | AP-DATA      | AUTOMATION  | 1.0                | 9LIW9NA  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Col4           |
      | AP-DATA      | AUTOMATION  | 1.0                | UE5KVXR  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | Col2           |
      | AP-DATA      | AUTOMATION  | 1.0                | UE5KVXR  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Col5           |
      | AP-DATA      | AUTOMATION  | 1.0                | VEL4EHC  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | Col3           |
      | AP-DATA      | AUTOMATION  | 1.0                | VEL4EHC  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | Col1           |
    And user clicks on logout button

  @edibus @positive
  Scenario:SC11#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDIDataDomain%  | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDIService%     | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDIOperation%   | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/ColumnOperationEDI%  | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/OperationLineageEDI% | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster               | Cluster  |       |       |

  @edibus @positive
  Scenario:SC11#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


