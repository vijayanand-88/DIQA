Feature: MLP_3213_Verify_Date_of_last_replication_in_EDI with standard license toEDI

  @edibus @mlp-3213 @positive @release10.0
  Scenario Outline:MLP-3213_SC1#_To import items of all types
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
  Examples:
  | ServiceName | ServiceUser    | Header   | Query | Param | type | url                                                                                                                          | body                           | response code | response message | jsonPath |
  | IDC         | TestSystemUser | xml/json |       |       | Post | import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false | idc/EdiBusPayloads/IDCData.xml | 200           |                  |          |


#5583179#
  @edibus @mlp-3213 @webtest @positive @toEDI
  Scenario: MLP-3213_SC1#_Export items from IDX to EDI with incremental as true and validate only newly added item timestamp is updated
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                          | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_3213_EDIBusConfig.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConfig  |                                               | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusConfig" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConfig%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
    And supply payload with file name "idc/EdiBusPayloads/Default_New_Database.xml"
    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
    Then Status code 200 must be returned
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                              | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP_3213_EDIBusConfigIncr.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Config_Inr |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Config_Inr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Config_Inr  |                                                   | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Config_Inr |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Config_Inr')].status |
    And user enters the search text "EDIBus_Config_Inr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBus_Config_Inr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "compare date" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemName | itemType         | operationName | childItemName | childItemType    |
      | AP-DATA      | AUTOMATION  | 1.0                | MultiHop | DWR_RDB_DATABASE | CreatedDate   | NewDatabase   | DWR_RDB_DATABASE |
      | AP-DATA      | AUTOMATION  | 1.0                | MultiHop | DWR_RDB_DATABASE | ModifiedDate  | NewDatabase   | DWR_RDB_DATABASE |
    And user clicks on logout button


  @edibus @mlp-3213 @positive @release10.0
  Scenario:MLP-3213_SC2#_To import items of all types
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

#5583178#
  @edibus @mlp-3213 @webtest @positive @toEDI
  Scenario: MLP-3213_MLP-3213_SC2#_1_Export items from IDX to EDI with incremental as true and validate only modified item timestamp is updated
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                          | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_3213_EDIBusConfig.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConfig  |                                               | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusConfig" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConfig%"
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

  Scenario Outline:SC2#_2_User retrieves Column item ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type   | name | asg_scopeid | targetFile                           | jsonpath         |
      | APPDBPOSTGRES | ID      | Default | Column | Col4 |             | response/edibus/actual/Item_Ids.json | $..has_Column.id |

  Scenario Outline:SC2#_2_Modify Column item name
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                    | body                                           | responseCode | inputJson        | inputFile                            | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.Column:::dynamic | idc/EdiBusPayloads/MLP-3213_Item_Updation.json | 204          | $..has_Column.id | response/edibus/actual/Item_Ids.json |                 |

#5583178#
  @edibus @mlp-3213 @webtest @positive @toEDI
  Scenario: MLP-3213_MLP-3213_SC2#_3_Export items from IDX to EDI with incremental as true and validate only modified item timestamp is updated
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                              | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP_3213_EDIBusConfigIncr.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Config_Inr |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Config_Inr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Config_Inr  |                                                   | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Config_Inr |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Config_Inr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus_Config_Inr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBus_Config_Inr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And user connects Rochade Server and "compare date" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemName    | itemType       | operationName | childItemName | childItemType  |
      | AP-DATA      | AUTOMATION  | 1.0                | Col1Updated | DWR_RDB_COLUMN | ModifiedDate  | Col1          | DWR_RDB_COLUMN |
      | AP-DATA      | AUTOMATION  | 1.0                | Col1Updated | DWR_RDB_COLUMN | CreatedDate   | Col1          | DWR_RDB_COLUMN |
      | AP-DATA      | AUTOMATION  | 1.0                | Col1Updated | DWR_RDB_COLUMN | ModifiedDate  | Col2          | DWR_RDB_COLUMN |
    And user clicks on logout button


  @edibus @mlp-3213 @positive @release10.0
  Scenario:SC3#_To import items of all types
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

 #5583177#BugID MLP-17570#
  @edibus @mlp-3213 @webtest @positive @toEDI
  Scenario: MLP-3213_SC3#_Export items from IDX to EDI with incremental as true and validate deleted item is removed in EDI
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                          | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_3213_EDIBusConfig.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConfig  |                                               | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusConfig" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConfig%"
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
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type   | query | param |
      | SingleItemDelete | Default | Col1 | Column |       |       |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                    | body                                              | response code | response message | jsonPath                                               |
      |        |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP_3213_EDIBusConfigIncr.json | 204           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Config_Inr |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Config_Inr')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Config_Inr  |                                                   | 200           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Config_Inr |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Config_Inr')].status |
    And user enters the search text "EDIBus_Config_Inr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBus_Config_Inr%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |
    And Analysis log should display the analysis info for below parameters "bulk/EDIBus/EDIBus_Config_Inr%"
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | Items deleted in EDI: 1 | EDIBUS-I0032 |            |               |
    And user connects Rochade Server and "verify itemNames notFound" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    | itemNames |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) | Col1      |
    And user clicks on logout button

  Scenario:SC4#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusConfig%      | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_Config_Inr% | Analysis |       |       |
      | SingleItemDelete | Default | LineageTestCluster             | Cluster  |       |       |

  @edibus @positive
  Scenario:SC4#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |