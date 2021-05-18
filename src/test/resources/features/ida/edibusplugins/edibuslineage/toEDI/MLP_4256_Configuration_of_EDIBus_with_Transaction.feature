Feature: MLP-4256 Feature for configuration of IDX/EDI integration with transaction

  @edibus @mlp-4256 @positive @release10.0
  Scenario Outline:MLP-4256_SC1#_To create catalog and import items of all types
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |

  @MLP-4256 @edibus
  Scenario Outline: SC1#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                                         | jsonValues  |
      | $.EDIBusTransDataSource.configurations..['EDI transaction name'] | TRX.LOB.ONE |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTransDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTransDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusTransDataSource |          |


#6224034#6223799#
  @edibus @mlp-4256 @webtest @positive @toEDI
  Scenario: MLP-4256_SC1#_Run replication from IDX to EDI with run in transaction enabled and commit it
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "creates newTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionTime |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.ONE     | 36000000        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.ONE     | ACTIVE            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                    | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP-4256_Config.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransaction |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransaction')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransaction  |                                         | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransaction |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransaction')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusTransaction" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransaction%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransaction%" should display below info/error/warning
      | type | logValue                        | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.ONE joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.ONE left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.ONE     | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.ONE     | commit               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 38        |
    

  @MLP-4256 @edibus
  Scenario Outline: SC2#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                                         | jsonValues  |
      | $.EDIBusTransDataSource.configurations..['EDI transaction name'] | TRX.LOB.TWO |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTransDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTransDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusTransDataSource |          |


    #6228539#
  @edibus @mlp-4256 @webtest @positive @toEDI
  Scenario: MLP-4256_SC2#_Run replication from IDX to EDI with run in transaction enabled and abort it
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "creates newTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionTime |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TWO     | 36000000        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TWO     | ACTIVE            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body                                         | response code | response message | jsonPath                                                    |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                   | idc/EdiBusPayloads/MLP-4256_AbortConfig.json | 204           |                  |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionAbort |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionAbort')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransactionAbort  |                                              | 200           |                  |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionAbort |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionAbort')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusTransactionAbort" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionAbort%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionAbort%" should display below info/error/warning
      | type | logValue                        | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.TWO joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.TWO left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TWO     | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TWO     | abort                |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
    

  @MLP-4256 @edibus
  Scenario Outline: SC3#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                                         | jsonValues    |
      | $.EDIBusTransDataSource.configurations..['EDI transaction name'] | TRX.LOB.THREE |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTransDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTransDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusTransDataSource |          |



#6228652#6228657#
  @edibus @mlp-4256 @webtest @positive @toEDI
  Scenario: MLP-4256_SC3#_Run replication from IDX to EDI using transaction after commit and recreate  it
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "creates newTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionTime |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.THREE   | 36000000        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.THREE   | ACTIVE            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body                                                     | response code | response message | jsonPath                                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                            | idc/EdiBusPayloads/MLP-4256_CommitAndRecreateConfig.json | 204           |                  |                                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionCommitRecreate |                                                          | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionCommitRecreate')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransactionCommitRecreate  |                                                          | 200           |                  |                                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionCommitRecreate |                                                          | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionCommitRecreate')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusTransactionCommitRecreate" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionCommitRecreate%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionCommitRecreate%" should display below info/error/warning
      | type | logValue                          | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.THREE joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.THREE left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.THREE   | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.THREE   | commitAndNew         |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 38        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.THREE   | ACTIVE            |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                            | body                                            | response code | response message | jsonPath                                                       |
      |        |       |       | Put          | settings/analyzers/EDIBus                                                      | idc/EdiBusPayloads/MLP-4256_RecreateConfig.json | 204           |                  |                                                                |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionRecreate |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionRecreate')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransactionRecreate  |                                                 | 200           |                  |                                                                |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionRecreate |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionRecreate')].status |
    And user enters the search text "EDIBusTransactionRecreate" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionRecreate%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionRecreate%" should display below info/error/warning
      | type | logValue                          | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.THREE joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.THREE left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.THREE   | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.THREE   | commit               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 3         |
    


  @MLP-4256 @edibus
  Scenario Outline: SC4#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                                         | jsonValues   |
      | $.EDIBusTransDataSource.configurations..['EDI transaction name'] | TRX.LOB.FOUR |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTransDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTransDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusTransDataSource |          |


    #6228653#6228659#
  @edibus @mlp-4256 @webtest @positive @toEDI
  Scenario: MLP-4256_SC4#_Run replication from IDX to EDI using transaction after abort and recreate  it
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "creates newTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionTime |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FOUR    | 36000000        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FOUR    | ACTIVE            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body                                                    | response code | response message | jsonPath                                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                           | idc/EdiBusPayloads/MLP-4256_AbortAndRecreateConfig.json | 204           |                  |                                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionAbortRecreate |                                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionAbortRecreate')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransactionAbortRecreate  |                                                         | 200           |                  |                                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionAbortRecreate |                                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionAbortRecreate')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusTransactionAbortRecreate" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionAbortRecreate%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionAbortRecreate%" should display below info/error/warning
      | type | logValue                         | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.FOUR joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.FOUR left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FOUR    | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FOUR    | abortAndNew          |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FOUR    | ACTIVE            |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body                                                 | response code | response message | jsonPath                                                 |
      |        |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP-4256_AbortRecreateConfig.json | 204           |                  |                                                          |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAbortRecreate |                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAbortRecreate')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAbortRecreate  |                                                      | 200           |                  |                                                          |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAbortRecreate |                                                      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAbortRecreate')].status |
    And user enters the search text "EDIBusTransactionAbortRecreate" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionAbortRecreate%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionAbortRecreate%" should display below info/error/warning
      | type | logValue                         | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.FOUR joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.FOUR left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FOUR    | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FOUR    | commit               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 3         |
    

  @MLP-4256 @edibus
  Scenario Outline: SC5#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                                         | jsonValues   |
      | $.EDIBusTransDataSource.configurations..['EDI transaction name'] | TRX.LOB.FIVE |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTransDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTransDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusTransDataSource |          |


    #6228838#
  @edibus @mlp-4256 @webtest @positive @toEDI
  Scenario: MLP-4256_SC5#_Run incremental replication from IDX to EDI with run in transaction enabled and commit it
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "creates newTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionTime |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FIVE    | 36000000        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FIVE    | ACTIVE            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                        | body                                        | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                  | idc/EdiBusPayloads/MLP-4256_ConfigIncr.json | 204           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransactionIncr  |                                             | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionIncr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusTransactionIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionIncr%" should display below info/error/warning
      | type | logValue                         | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.FIVE joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.FIVE left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FIVE    | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.FIVE    | commit               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 38        |
    

  @MLP-4256 @edibus
  Scenario Outline: SC6#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                                         | jsonValues  |
      | $.EDIBusTransDataSource.configurations..['EDI transaction name'] | TRX.LOB.SIX |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTransDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTransDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusTransDataSource |          |


     #6228839#
  @edibus @mlp-4256 @webtest @positive @toEDI
  Scenario: MLP-4256_SC6#_Run incremental replication from IDX to EDI with run in transaction enabled and abort it
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "creates newTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionTime |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SIX     | 36000000        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SIX     | ACTIVE            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body                                             | response code | response message | jsonPath                                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                       | idc/EdiBusPayloads/MLP-4256_AbortConfigIncr.json | 204           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionAbortIncr |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionAbortIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransactionAbortIncr  |                                                  | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionAbortIncr |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionAbortIncr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusTransactionAbortIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionAbortIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionAbortIncr%" should display below info/error/warning
      | type | logValue                        | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.SIX joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.SIX left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SIX     | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SIX     | abort                |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
    

  @MLP-4256 @edibus
  Scenario Outline: SC7#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                                         | jsonValues    |
      | $.EDIBusTransDataSource.configurations..['EDI transaction name'] | TRX.LOB.SEVEN |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTransDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTransDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusTransDataSource |          |


    #6228842#6228840#
  @edibus @mlp-4256 @webtest @positive @toEDI
  Scenario: MLP-4256_SC7#_Run incremental  replication from IDX to EDI using transaction after commit and recreate  it
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "creates newTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionTime |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SEVEN   | 36000000        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SEVEN   | ACTIVE            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body                                                         | response code | response message | jsonPath                                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                          | idc/EdiBusPayloads/MLP-4256_CommitAndRecreateConfigIncr.json | 204           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TransactionCommitRecreateIncr |                                                              | 200           | IDLE             | $.[?(@.configurationName=='TransactionCommitRecreateIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TransactionCommitRecreateIncr  |                                                              | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TransactionCommitRecreateIncr |                                                              | 200           | IDLE             | $.[?(@.configurationName=='TransactionCommitRecreateIncr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TransactionCommitRecreateIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TransactionCommitRecreateIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/TransactionCommitRecreateIncr%" should display below info/error/warning
      | type | logValue                          | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.SEVEN joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.SEVEN left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SEVEN   | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SEVEN   | commitAndNew         |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 38        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SEVEN   | ACTIVE            |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                | body                                                | response code | response message | jsonPath                                                           |
      |        |       |       | Put          | settings/analyzers/EDIBus                                                          | idc/EdiBusPayloads/MLP-4256_RecreateConfigIncr.json | 204           |                  |                                                                    |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionRecreateIncr |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionRecreateIncr')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransactionRecreateIncr  |                                                     | 200           |                  |                                                                    |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionRecreateIncr |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionRecreateIncr')].status |
    And user enters the search text "EDIBusTransactionRecreateIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionRecreateIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionRecreateIncr%" should display below info/error/warning
      | type | logValue                          | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.SEVEN joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.SEVEN left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SEVEN   | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.SEVEN   | commit               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 3         |
    


  @MLP-4256 @edibus
  Scenario Outline: SC8#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                                         | jsonValues   |
      | $.EDIBusTransDataSource.configurations..['EDI transaction name'] | TRX.LOB.TEST |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTransDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTransDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusTransDataSource |          |


     #6228843#6228841#
  @edibus @mlp-4256 @webtest @positive @toEDI
  Scenario: MLP-4256_SC8#_Run incremental replication from IDX to EDI using transaction after abort and recreate it
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user connects Rochade Server and "creates newTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionTime |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TEST    | 36000000        |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TEST    | ACTIVE            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                        | response code | response message | jsonPath                                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                               | idc/EdiBusPayloads/MLP-4256_AbortAndRecreateConfigIncr.json | 204           |                  |                                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionAbortRecreateIncr |                                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionAbortRecreateIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTransactionAbortRecreateIncr  |                                                             | 200           |                  |                                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTransactionAbortRecreateIncr |                                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTransactionAbortRecreateIncr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusTransactionAbortRecreateIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionAbortRecreateIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionAbortRecreateIncr%" should display below info/error/warning
      | type | logValue                         | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.TEST joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.TEST left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TEST    | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TEST    | abortAndNew          |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
    And user connects Rochade Server and "verify transactionStatus" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionStatus |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TEST    | ACTIVE            |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                          | body                                                     | response code | response message | jsonPath                                                     |
      |        |       |       | Put          | settings/analyzers/EDIBus                                                    | idc/EdiBusPayloads/MLP-4256_AbortRecreateConfigIncr.json | 204           |                  |                                                              |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAbortRecreateIncr |                                                          | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAbortRecreateIncr')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAbortRecreateIncr  |                                                          | 200           |                  |                                                              |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAbortRecreateIncr |                                                          | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAbortRecreateIncr')].status |
    And user enters the search text "EDIBusTransactionAbortRecreateIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTransactionAbortRecreateIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTransactionAbortRecreateIncr%" should display below info/error/warning
      | type | logValue                         | logCode      | pluginName | removableText |
      | INFO | Transaction TRX.LOB.TEST joined. | EDIBUS-I0036 |            |               |
      | INFO | Transaction TRX.LOB.TEST left.   | EDIBUS-I0040 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 0         |
#    And user connects Rochade Server and "verify transactionID" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionID |
#      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TEST    | 1011          |
    And user connects Rochade Server and "updateTransaction" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | transactionName | transactionOperation |
      | AP-DATA      | AUTOMATION  | 1.0                | TRX.LOB.TEST    | commit               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 3         |
    

  @edibus @positive
  Scenario:SC9#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransaction%                  | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransactionAbort%             | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransactionCommitRecreate%    | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransactionRecreate%          | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransactionAbortRecreate%     | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusAbortRecreate%                | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransactionIncr%              | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransactionAbortIncr%         | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusAbortRecreateIncr%            | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/TransactionCommitRecreateIncr%      | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransactionRecreateIncr%      | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/EDIBusTransactionAbortRecreateIncr% | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster                              | Cluster  |       |       |

  @edibus @positive
  Scenario:SC9#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
