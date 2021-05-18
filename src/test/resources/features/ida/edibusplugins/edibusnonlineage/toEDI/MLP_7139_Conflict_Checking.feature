Feature: MLP-7139 Conflict Checking with standard license toEDI

  @edibus @mlp-4075 @positive
  Scenario Outline:MLP-7139_SC1#_To create catalog and import items of all types
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |



#    ##6459225##bug 15898# Since Multiple catalog can't be created in IDP This scenario is Out of scope
#  @edibus @mlp-7139 @webtest @positive @release10.0 @toEDI
#  Scenario:MLP-7139_SC1#_Scenario 1.1_Verification of changing source for replication from IDP to EDI
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user update json file "idc/EdiBusPayloads/MLP-7139_1.1Config.json" file for following values using property loader
#      | jsonPath                       | jsonValues    |
#      | $..['EDI access'].['EDI host'] | EDIHostName   |
#      | $..['EDI access'].['EDI port'] | EDIPortNumber |
#    And user update the json file "idc/EdiBusPayloads/MLP-7139_1.1Config.json" file for following values
#      | jsonPath           | jsonValues |
#      | $..['function']    | toEDI      |
#      | $..['catalogName'] | BigData    |
#    Given user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                | body                                       | response code | response message | jsonPath                                           |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus/toEDIConflict                            | idc/EdiBusPayloads/MLP-7139_1.1Config.json | 204           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConflict |                                            | 200           | IDLE             | $.[?(@.configurationName=='toEDIConflict')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDIConflict  |                                            | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConflict |                                            | 200           | IDLE             | $.[?(@.configurationName=='toEDIConflict')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "BigData" catalog from catalog list
#    And user enters the search text "toEDIConflict" and clicks on search
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "toEDIConflict"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user update the json file "idc/EdiBusPayloads/MLP-7139_1.1Config.json" file for following values
#      | jsonPath           | jsonValues |
#      | $..['function']    | toEDI      |
#      | $..['catalogName'] | IDCData    |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                | body                                       | response code | response message | jsonPath                                           |
#      |        |       |       | Put          | settings/analyzers/EDIBus/toEDIConflict                            | idc/EdiBusPayloads/MLP-7139_1.1Config.json | 204           |                  |                                                    |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConflict |                                            | 200           | IDLE             | $.[?(@.configurationName=='toEDIConflict')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDIConflict  |                                            | 200           |                  |                                                    |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConflict |                                            | 200           | IDLE             | $.[?(@.configurationName=='toEDIConflict')].status |
#    And user selects "IDCData" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "toEDIConflict"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 2                 |
#    And user clicks on log link and opens the log
#    And Analysis log should display the analysis info for below parameters
#      | type  | logValue                                                                                                                               | logLine      |
#      | ERROR | Cannot execute the replication because of these conflicts:                                                                             | EDIBUS-I0104 |
#      | ERROR | The source EDI subject area of the configuration has been changed, please delete existing replicated data for this configuration first | EDIBUS-I0105 |
#    And user update the json file "idc/EdiBusPayloads/MLP-7139_1.1Config.json" file for following values
#      | jsonPath           | jsonValues   |
#      | $..['function']    | toEDICleanup |
#      | $..['catalogName'] | BigData      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                | body                                       | response code | response message | jsonPath                                           |
#      |        |       |       | Put          | settings/analyzers/EDIBus/toEDIConflict                            | idc/EdiBusPayloads/MLP-7139_1.1Config.json | 204           |                  |                                                    |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConflict |                                            | 200           | IDLE             | $.[?(@.configurationName=='toEDIConflict')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDIConflict  |                                            | 200           |                  |                                                    |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConflict |                                            | 200           | IDLE             | $.[?(@.configurationName=='toEDIConflict')].status |
#    And user selects "BigData" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user "click" on "LastAnalysisItem" containing "toEDIConflict"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user clicks on logout button


#    ##6459809## Since Multiple catalog can't be created in IDP This scenario is Out of scope
#  @edibus @mlp-7139 @webtest @positive @release10.0 @toEDI
#  Scenario:MLP-7139_SC2#_Scenario 1.7_Verification of changing source for incremental replication from IDP to EDI
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user update json file "idc/EdiBusPayloads/MLP-7139_1.7Config.json" file for following values using property loader
#      | jsonPath                       | jsonValues    |
#      | $..['EDI access'].['EDI host'] | EDIHostName   |
#      | $..['EDI access'].['EDI port'] | EDIPortNumber |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                              | body                                       | response code | response message | jsonPath                                         |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus/ConflictEDI                            | idc/EdiBusPayloads/MLP-7139_1.7Config.json | 204           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ConflictEDI |                                            | 200           | IDLE             | $.[?(@.configurationName=='ConflictEDI')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ConflictEDI  |                                            | 200           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ConflictEDI |                                            | 200           | IDLE             | $.[?(@.configurationName=='ConflictEDI')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "BigData" catalog from catalog list
#    And user enters the search text "ConflictEDI" and clicks on search
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "ConflictEDI"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                              | body                                           | response code | response message | jsonPath                                         |
#      |        |       |       | Put          | settings/analyzers/EDIBus/ConflictEDI                            | idc/EdiBusPayloads/MLP-7139_1.7ConfigIncr.json | 204           |                  |                                                  |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ConflictEDI |                                                | 200           | IDLE             | $.[?(@.configurationName=='ConflictEDI')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ConflictEDI  |                                                | 200           |                  |                                                  |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ConflictEDI |                                                | 200           | IDLE             | $.[?(@.configurationName=='ConflictEDI')].status |
#    And user clicks on cross button in the Search Data Intelligence Suite area
#    And user selects "IDCData" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user "click" on "LastAnalysisItem" containing "ConflictEDI"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user clicks on log link and opens the log
#    And Analysis log should display the analysis info for below parameters
#      | type | logValue                                                               | logLine      |
#      | INFO | An incremental replication is not possible because of these conflicts: | EDIBUS-I0101 |
#      | INFO | Types have been added to the configuration.                            | EDIBUS-I0102 |
#      | INFO | A full replication will be done instead.                               | EDIBUS-I0103 |
#    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           | itemNames |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) | Tb1       |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN )        | Col1      |
#    And user clicks on logout button


    ##6459289##
  @edibus @mlp-7139 @webtest @positive @toEDI
  Scenario:MLP-7139_SC3#_Scenario 1.3_Verification of incremental replication from IDP to EDI
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                       | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP-7139_1.3Config.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Conflict1.3 |                                            | 200           | IDLE             | $.[?(@.configurationName=='Conflict1.3')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Conflict1.3  |                                            | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Conflict1.3 |                                            | 200           | IDLE             | $.[?(@.configurationName=='Conflict1.3')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Conflict1.3" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Conflict1.3%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                              | body                                           | response code | response message | jsonPath                                         |
      |        |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP-7139_1.3ConfigIncr.json | 204           |                  |                                                  |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Conflict1.3 |                                                | 200           | IDLE             | $.[?(@.configurationName=='Conflict1.3')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Conflict1.3  |                                                | 200           |                  |                                                  |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Conflict1.3 |                                                | 200           | IDLE             | $.[?(@.configurationName=='Conflict1.3')].status |
    And user enters the search text "Conflict1.3" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Conflict1.3%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/Conflict1.3%" should display below info/error/warning
      | type | logValue                                                               | logCode      | pluginName | removableText |
      | INFO | An incremental replication is not possible because of these conflicts: | EDIBUS-I0101 |            |               |
      | INFO | Types have been added to the configuration.                            | EDIBUS-I0102 |            |               |
      | INFO | A full replication will be done instead.                               | EDIBUS-I0103 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN )        | 7         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) | 7         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE )      | 1         |
    And user clicks on logout button


      ##6468845##
  @edibus @mlp-7139 @webtest @positive @toEDI
  Scenario:MLP-7139_SC4#_Scenario 2.11_Verification of replicating items from multiple source catalogs with different and overlapping types from IDP to EDI
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                        | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP-7139_2.11Config.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Conflict2.11 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Conflict2.11')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Conflict2.11  |                                             | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Conflict2.11 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Conflict2.11')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Conflict2.11" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Conflict2.11%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                   | body                                            | response code | response message | jsonPath                                              |
      |        |       |       | Put          | settings/analyzers/EDIBus                                             | idc/EdiBusPayloads/MLP-7139_2.11ConfigData.json | 204           |                  |                                                       |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Conflict2.11Data |                                                 | 200           | IDLE             | $.[?(@.configurationName=='Conflict2.11Data')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Conflict2.11Data  |                                                 | 200           |                  |                                                       |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Conflict2.11Data |                                                 | 200           | IDLE             | $.[?(@.configurationName=='Conflict2.11Data')].status |
    And user enters the search text "Conflict2.11Data" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Conflict2.11Data%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/Conflict2.11Data%" should display below info/error/warning
      | type | logValue                   | logCode      | pluginName | removableText |
      | INFO | 15 items have been written | EDIBUS-I0031 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN )        | 7         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) | 7         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE )  | MultiHop                              |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | LineageTestCluster≫LineageTestService |
    And user clicks on logout button


  @edibus @positive
  Scenario:MLP-7139_SC5#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                          | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/Conflict1.3%      | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/Conflict2.11Data% | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/Conflict2.11%     | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster            | Cluster  |       |       |


  @edibus @positive
  Scenario:MLP-7139_SC5#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |