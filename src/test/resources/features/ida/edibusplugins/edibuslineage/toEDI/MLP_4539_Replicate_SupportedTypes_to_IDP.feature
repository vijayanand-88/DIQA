Feature: MLP_4539 Replicating Supported Types toIDP and to EDI

  @edibus @mlp-4539 @positive @release10.0 @sanity
  Scenario Outline:MLP-4539_SC1#_To create catalog and import items of all types
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |


    ##6181195##6181198##
  @edibus @mlp-4539 @webtest @positive @toEDI @sanity
  Scenario:MLP-4539_SC1#_Run full replication from IDX to EDI with sqlg RDB & Data item types and TFM types
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                      | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_4539_IDXTOEDI.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBTFMTypes |                                           | 200           | IDLE             | $.[?(@.configurationName=='RDBTFMTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/RDBTFMTypes  |                                           | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBTFMTypes |                                           | 200           | IDLE             | $.[?(@.configurationName=='RDBTFMTypes')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RDBTFMTypes" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/RDBTFMTypes%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN )             | 7         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW )      | 7         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DOMAIN )             | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_PACKAGE )            | 3         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DATA_TYPE )          | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY )          | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE )               | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FIELD )              | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE )           | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM )          | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION )     | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 3         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA )             | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM )             | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK )               | 1         |
    And user clicks on logout button


     ##6181201##6181202##
  @edibus @mlp-4539 @webtest @positive @toEDI
  Scenario:MLP-4539_SC2#_Run replication from IDX to EDI with sqlg RDB & Data item types incrmental as true and TFM types
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                          | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_IDXTOEDIIncr.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBTFMTypesIncr |                                               | 200           | IDLE             | $.[?(@.configurationName=='RDBTFMTypesIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/RDBTFMTypesIncr  |                                               | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBTFMTypesIncr |                                               | 200           | IDLE             | $.[?(@.configurationName=='RDBTFMTypesIncr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RDBTFMTypes" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/RDBTFMTypes%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN )             | 7         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW )      | 7         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DOMAIN )             | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_PACKAGE )            | 3         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DATA_TYPE )          | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY )          | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE )               | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FIELD )              | 2         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE )           | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM )          | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION )     | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 3         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA )             | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM )             | 1         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK )               | 1         |
    And user clicks on logout button


  @edibus @positive
  Scenario:MLP-4539_SC3#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/RDBTFMTypes%     | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/RDBTFMTypesIncr% | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster           | Cluster  |       |       |

  @edibus @positive @sanity
  Scenario:MLP-4539_SC3#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
