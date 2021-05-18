Feature:MLP_3667 Feature for Mapping has to support types with standard license toEDI

  @edibus @mlp-3667 @positive
  Scenario Outline:MLP-3667_SC1#_To import items of all types
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |


     ##5586883##6411039##
  @edibus @mlp-3667 @positive @toEDI
  Scenario:MLP-3667_MLP-4346_SC1#_Add all item types in IDC with incremental false and Validate in EDI and Verification of items with type File residing in scope of item File is ignored
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                           | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigAllTypes.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                                | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                                | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                                | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | LineageTestCluster≫LineageTestService |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames            |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) | TestFile,TestFileOne |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) | 2         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | LineageTestCluster≫LineageTestService |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | 1         |

      ##5713130##6411833##
  @edibus @mlp-3667 @mlp-4346 @positive @toEDI
  Scenario:MLP-3667_MLP-4346_SC2#_Add all item types in IDC with incremental true and Validate in EDI and Verification of items with type File residing in scope of item File
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                       | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigIncr.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                            | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | LineageTestCluster≫LineageTestService |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames            |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) | TestFile,TestFileOne |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) | 2         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | LineageTestCluster≫LineageTestService |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | 1         |

  @edibus @positive
  Scenario:SC3#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDIAutomation% | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster              | Cluster  |       |       |

  @edibus @positive
  Scenario:SC3#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
