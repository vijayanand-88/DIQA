Feature: EDI_MLP-3101 Feature for configuration of IDX/EDI integration and validate items with standard license toEDI

  @edibus @mlp-3101 @positive @release10.0
  Scenario: To create catalog and import items of all types
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/EdiBusPayloads/IDCData.xml"
    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
    Then Status code 200 must be returned

  ##5584566##5710171##
  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario: MLP-3101_MLP-3219_SC1#_Add some items in IDX and validate the incremental replication in EDI
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
      | databaseName | subjectArea | subjectAreaVersion | query                                                                   | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_RDB_COLUMN ) | 7         |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/EdiBusPayloads/Default_New_Column.xml"
    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                       | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigIncr.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                            | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIAutomation" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIAutomation%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) | NewColumn |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log should display the analysis info for below parameters "bulk/EDIBus/IDXtoEDIAutomation%"
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 5 items | EDIBUS-I0031 |            |               |
    And user clicks on logout button

     ##5584567##5583204## #Bug id- MLP-21531
  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario: MLP-3101_SC2#_1_Verification of incremental replication when item is modified in IDX
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
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | LineageTestCluster≫LineageTestService |


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

    ##5584567##5583204## #Bug id- MLP-21531
  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario: MLP-3101_SC2#_3_Verification of incremental replication when item is modified in IDX
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                       | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigIncr.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                            | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIAutomation" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIAutomation%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                                     |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | LineageTestCluster≫LineageTestServiceModified |
    And user clicks on logout button

        ##5584568##
  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario:MLP-3101_SC3#_Verification of incremental replication when an item is deleted in IDX
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
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_DAT_FIELD ) | 2         |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type  | query | param |
      | SingleItemDelete | Default | TestFieldOne | Field |       |       |
    And user update json file "idc/EdiBusPayloads/IDXTOEDIConfigIncr.json" file for following values using property loader
      | jsonPath                                           | jsonValues    |
      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                       | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigIncr.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                            | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIAutomation" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIAutomation%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_DAT_FIELD ) | 1         |
    And user clicks on logout button

  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario:SC3#_To import all type of items
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name               | type    | query | param |
      | SingleItemDelete | Default | LineageTestCluster | Cluster |       |       |
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/EdiBusPayloads/IDCData.xml"
    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
    Then Status code 200 must be returned

  ##5584569##5583074##
  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario: MLP-3101_SC4#_Verification of full replication in EDI when item is added in IDX with incremental as false
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
      | databaseName | subjectArea | subjectAreaVersion | query                                                                   | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_RDB_COLUMN ) | 7         |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/EdiBusPayloads/Default_New_Column.xml"
    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
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
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) | NewColumn |
    And user clicks on logout button

     ##5584571##5583075##
  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario:MLP-3101_SC5#_1_Verification of full replication in EDI when item is modified in IDX with incremental as false
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
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | LineageTestCluster≫LineageTestService |

  Scenario Outline:SC5#_2_User retrieves Service item ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type    | name               | asg_scopeid | targetFile                          | jsonpath          |
      | APPDBPOSTGRES | ID      | Default | Service | LineageTestService |             | response/edibus/actual/itemIds.json | $..has_Service.id |

  Scenario Outline:SC5#_2_Modify Service item name
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                     | body                                        | responseCode | inputJson         | inputFile                           | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.Service:::dynamic | idc/EdiBusPayloads/ServiceItemModified.json | 204          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |

         ##5584571##5583075##
  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario:MLP-3101_SC5#_3_Verification of full replication in EDI when item is modified in IDX with incremental as false
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
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                                     |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | LineageTestCluster≫LineageTestServiceModified |
    And user clicks on logout button


        ##5584572##5572434##
  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario: MLP-3101_MLP-3257_SC6#_Verification of full replication in EDI when item is deleted in IDX with incremental as false
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
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_DAT_FIELD ) | 2         |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type  | query | param |
      | SingleItemDelete | Default | TestFieldOne | Field |       |       |
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
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_DAT_FIELD ) | 1         |
    And user clicks on logout button

  @edibus @mlp-3101 @positive @release10.0
  Scenario:MLP-3101_MLP-3213_SC7#_1_To import items of all types
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name               | type    | query | param |
      | SingleItemDelete | Default | LineageTestCluster | Cluster |       |       |
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/EdiBusPayloads/IDCData.xml"
    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
    Then Status code 200 must be returned

  ##5584574##5584575##
  @edibus @mlp-3101 @mlp-3213 @webtest @positive @toEDI
  Scenario: MLP-3101_MLP-3213_SC7#_1_Verification of incremental replication when item is added,an item is modified and item is deleted in IDX
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
      | databaseName | subjectArea | subjectAreaVersion | query                                                                   | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_RDB_COLUMN ) | 7         |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_DAT_FIELD )  | 2         |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames                             |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) | LineageTestCluster≫LineageTestService |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/EdiBusPayloads/Default_New_Column.xml"
    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type  | query | param |
      | SingleItemDelete | Default | TestFieldOne | Field |       |       |

  Scenario Outline:SC7#_2_User retrieves Service item ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type    | name               | asg_scopeid | targetFile                          | jsonpath          |
      | APPDBPOSTGRES | ID      | Default | Service | LineageTestService |             | response/edibus/actual/itemIds.json | $..has_Service.id |

  Scenario Outline:SC7#_2_Modify Service item name
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                     | body                                        | responseCode | inputJson         | inputFile                           | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.Service:::dynamic | idc/EdiBusPayloads/ServiceItemModified.json | 204          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |


     ##5584574##5584575##
  @edibus @mlp-3101 @mlp-3213 @webtest @positive @toEDI
  Scenario: MLP-3101_MLP-3213_SC7#_3_Verification of incremental replication when item is added,an item is modified and item is deleted in IDX
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                       | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDXTOEDIConfigIncr.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIAutomation  |                                            | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIAutomation |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIAutomation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDXtoEDIAutomation" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIAutomation%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       | itemNames                                     |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN )    | NewColumn                                     |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) | LineageTestCluster≫LineageTestServiceModified |
    And user connects Rochade Server and "verifies" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 )AND,( TYPE = DWR_DAT_FIELD ) | 1         |
    And user clicks on logout button

  @edibus @mlp-3101 @webtest @positive @toEDI
  Scenario:SC8#_Delete all the External Packages and analysis with respect to EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/IDXtoEDIAutomation% | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster              | Cluster  |       |       |

  @edibus @positive @release10.0
  Scenario:SC8#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
