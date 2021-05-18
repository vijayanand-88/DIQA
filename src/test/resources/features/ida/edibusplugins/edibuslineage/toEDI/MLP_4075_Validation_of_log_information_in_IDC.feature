Feature: MLP-4075 Provide minimum statistics about replication full and incr to EDI

  @edibus @mlp-4075 @positive
  Scenario Outline:MLP-4075_SC1#_To create catalog and import items of all types
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |



##5713820##
  @edibus @mlp-4075 @webtest @positive @toEDI
  Scenario: MLP-4075_SC1#_Run full replication from IDX to EDI and validate the log information in IDX
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
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/IDXtoEDIAutomation%" should display below info/error/warning
      | type | logValue                   | logCode      | pluginName | removableText |
      | INFO | 37 items have been written | EDIBUS-I0031 |            |               |
      | INFO | Start                      | EDIBUS-I0006 |            |               |
      | INFO | End                        | EDIBUS-I0007 |            |               |
    

     ##5713831##
  @edibus @mlp-4075 @webtest @positive @toEDI
  Scenario Outline:MLP-4075_SC2#_1_Validate IDX log when item is modified in IDX and replicated to EDI
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/Default_New_Column.xml | 200           |                  |          |


  Scenario Outline:SC2#_2_User retrieves Service item ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type    | name               | asg_scopeid | targetFile                          | jsonpath          |
      | APPDBPOSTGRES | ID      | Default | Service | LineageTestService |             | response/edibus/actual/itemIds.json | $..has_Service.id |

  Scenario Outline:SC2#_2_Modify Service item name
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                     | body                                        | responseCode | inputJson         | inputFile                           | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.Service:::dynamic | idc/EdiBusPayloads/ServiceItemModified.json | 204          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |

   ##5713831##
  @edibus @mlp-4075 @webtest @positive @toEDI
  Scenario:MLP-4075_SC2#_3_Validate IDX log when item is modified in IDX and replicated to EDI
    And user connects Rochade Server and "clears" the items in EDI subject area
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
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/IDXtoEDIAutomation%" should display below info/error/warning
      | type | logValue | logCode      | pluginName | removableText |
      | INFO | Start    | EDIBUS-I0006 |            |               |
      | INFO | End      | EDIBUS-I0007 |            |               |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                                     |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | LineageTestCluster≫LineageTestServiceModified |
    

  @edibus @positive
  Scenario:SC2#_4_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name      | type   | query | param |
      | SingleItemDelete | Default | NewColumn | Column |       |       |

     ##5713823##
  @edibus @mlp-4075 @webtest @positive @toEDI
  Scenario: MLP-4075_SC3#_Run Incremental replication from IDX to EDI and valiate the log in IDX
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body                                               | response code | response message | jsonPath                                                     |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                    | idc/EdiBusPayloads/IDXTOEDIConfigAllTypesIncr.json | 204           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDI_AutomationIncr |                                                    | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDI_AutomationIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDI_AutomationIncr  |                                                    | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDI_AutomationIncr |                                                    | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDI_AutomationIncr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDI_AutomationIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDI_AutomationIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/IDXtoEDI_AutomationIncr%" should display below info/error/warning
      | type | logValue                   | logCode      | pluginName | removableText |
      | INFO | 37 items have been written | EDIBUS-I0031 |            |               |
      | INFO | Start                      | EDIBUS-I0006 |            |               |
      | INFO | End                        | EDIBUS-I0007 |            |               |
    


     ##5713882##5572433##
  @edibus @mlp-4075 @webtest @positive @toEDI
  Scenario: MLP-4075_MLP-3257_SC4#_Validate log in IDX when adding an item in IDX and replicating to EDI
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/EdiBusPayloads/Default_New_Column.xml"
    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body                                               | response code | response message | jsonPath                                                     |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                    | idc/EdiBusPayloads/IDXTOEDIConfigAllTypesIncr.json | 204           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDI_AutomationIncr |                                                    | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDI_AutomationIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDI_AutomationIncr  |                                                    | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDI_AutomationIncr |                                                    | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDI_AutomationIncr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDI_AutomationIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDI_AutomationIncr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/IDXtoEDI_AutomationIncr%" should display below info/error/warning
      | type | logValue | logCode      | pluginName | removableText |
      | INFO | Start    | EDIBUS-I0006 |            |               |
      | INFO | End      | EDIBUS-I0007 |            |               |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) | NewColumn |


     ##5713836##5713136## #Bug id- MLP-21531
  @edibus @mlp-4075 @webtest @positive @toEDI
  Scenario: MLP-4075_MLP_3681_SC5#_Run cleanup in EDI and validate the log in IDX
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                    | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/IDXTOEDICleanup.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDICleanup |                                         | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDICleanup')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDICleanup  |                                         | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDICleanup |                                         | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDICleanup')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDICleanup" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDICleanup%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/IDXtoEDICleanup%" should display below info/error/warning
      | type | logValue | logCode      | pluginName | removableText |
      | INFO | Start    | EDIBUS-I0006 |            |               |
      | INFO | End      | EDIBUS-I0007 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 2         |
    

  @edibus @positive
  Scenario:SC5#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name               | type    | query | param |
      | SingleItemDelete | Default | LineageTestCluster | Cluster |       |       |

    ##5713848##
  @edibus @mlp-4075 @webtest @positive @toEDI
  Scenario: MLP-4075_SC6#_Replicate zero items to EDI and validate the log in IDX
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And configure a new REST API for the service "IDC"
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
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/IDXtoEDIAutomation%" should display below info/error/warning
      | type | logValue                  | logCode      | pluginName | removableText |
      | INFO | 0 items have been written | EDIBUS-I0031 |            |               |
      | INFO | Start                     | EDIBUS-I0006 |            |               |
      | INFO | End                       | EDIBUS-I0007 |            |               |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 1         |
    


  @edibus @positive
  Scenario:SC7#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDIAutomation%      | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDI_AutomationIncr% | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/IDXtoEDICleanup%         | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster                   | Cluster  |       |       |

  @edibus @positive
  Scenario:SC7#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

