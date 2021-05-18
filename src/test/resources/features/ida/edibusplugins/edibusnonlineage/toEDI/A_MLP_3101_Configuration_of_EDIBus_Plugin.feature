Feature: MLP-3101 Feature for configuration of IDX/EDI integration from IDX to EDI with standard license toEDI


       #################################PreConditions################################

  @edibus @mlp-3101 @positive @release10.0
  Scenario Outline: To import oracle xml items to Default catalog
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |

  @edibus @mlp-3101 @positive @release10.0
  Scenario: To update license key with lineage
    Given user connects Rochade Server and "licenseUpdate" the items in EDI subject areas
      | databaseName | licenseInfo       |
      | AP-DATA      | windowsNonLineage |

  @precondition
  Scenario: MLP-3101:SC1#Update credential payload json for EDIBus
    Given User update the below "ediBus credentials" in following files using json path
      | filePath                                              | username                           | password                           |
      | idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusValidCredentials..userName | $.edibusValidCredentials..password |
    And User update the below "ediBus host" in following files using json path
      | filePath                                                  | username                             | password                             |
      | idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAutoDataSource..['EDI host'] | $.EDIBusAutoDataSource..['EDI port'] |


  @MLP-22760 @edibus
  Scenario Outline: SC1#-Set the Credentials for EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                           | path                                  | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials              | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json     | $.edibusValidCredentials              | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials              |                                                                    |                                       | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusAutoDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAutoDataSource.configurations | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                      |                                                                    |                                       | 200           | EDIBusAutoDataSource |          |

       #################################Scenarios################################


  @edibus @mlp-3101 @webtest @positive @release10.0 @toEDI
  Scenario: MLP-3101_SC1#_Verification of Plugin configuration in IDX UI and full replication of item  from IDX to EDI under Test IDA Node
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
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION )     | 0         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 0         |
    And user clicks on logout button

   ##5583187## #Bug id- MLP-21531
  @edibus @mlp-3101 @webtest @positive @release10.0 @toEDI
  Scenario:MLP-3101_MLP-3219_SC2#_Run EDIBUS with EDI CleanUp as function parameter and validate data is cleaned up in EDI
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                     | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/EDICleanupConfig.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDICleanup |                                          | 200           | IDLE             | $.[?(@.configurationName=='toEDICleanup')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDICleanup  |                                          | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDICleanup |                                          | 200           | IDLE             | $.[?(@.configurationName=='toEDICleanup')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 2         |
    And user enters the search text "toEDICleanup" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toEDICleanup%"
    And METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user clicks on logout button

  ##5584566##
  @edibus @mlp-3101 @webtest @positive @release10.0 @toEDI
  Scenario: MLP-3101_SC3#_Add some items in IDX and validate the incremental replication in EDI
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                           | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigAllTypes.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                                | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                                | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                                | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 34        |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
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
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) | NewColumn |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/IDXtoEDI_AutomationIncr%" should display below info/error/warning
      | type | logValue                            | logCode      | pluginName | removableText |
      | INFO | replication of 34 items in 1 cycles | EDIBUS-I0031 |            |               |
    And user clicks on logout button

  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario:SC3#_Delete Analysis with respect to EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDIAutomation%      | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/toEDICleanup%            | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/IDXtoEDI_AutomationIncr% | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster                   | Cluster  |       |       |

  @edibus @positive @release10.0
  Scenario:SC3#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |