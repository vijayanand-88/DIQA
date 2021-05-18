Feature: MLP_3213_Verify_Date_of_last_replication_in_EDI with standard license

  @MLP-3214 @edibus
  Scenario Outline: SC1#-Set the DataSource for EDIBus
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                                           | path                                 | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusIDCDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusIDCDataSource.configurations | 204           |                     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                     |                                                                    |                                      | 200           | EDIBusIDCDataSource |          |


    #5584580#
  @edibus @mlp-3214 @webtest @positive @toIDP
  Scenario:SC1#MLP-3214_Validate full replication of items in IDX when an item is added and an item is modified in EDI
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                |
      | AP-DATA      | IDCDATA     | 1.0                | (XNAME * *  ~= NewDBSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
    And user connects Rochade Server and "add" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType          | itemName    |
      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_DB_SYSTEM | NewDBSystem |
    And user connects Rochade Server and "rename" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName   | renameName       |
      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_COLUMN | TestColumn | TestColumnUpdate |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_3214_Config.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusFullRep  |                                         | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusFullRep" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusFullRep%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "NewDBSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | NewDBSystem≫DB |
    And user update the json file "idc/EdiBusPayloads/HierarchyFilter.json" file for following values
      | jsonPath                                                | jsonValues              |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Service/TestDbSystem≫DB |
      | $..selections.['type_s'][*]                             | Column                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                | body                                    | response code | response message | jsonPath |
      |        |       |       | Post | searches/fulltext?query=TestDbSystem&advanced=false&natural=false&limit=10&offset=0&limitFacets=10 | idc/EdiBusPayloads/HierarchyFilter.json | 200           |                  |          |
    And user stores the values in list from response using jsonpath "$..name"
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | IDCDATA     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "TestColumnUpdate" and clicks on search
    And user performs "facet selection" in "TestDbSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TestColumnUpdate |

  Scenario:SC1#MLP-3214_Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3214_Config.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_3214_Config.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusFullRep  |                                         | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusFullRep% | Analysis |       |       |


     #5584655#
  @edibus @mlp-3214 @webtest @positive @toIDP
  Scenario:SC2#MLP-3214_Validate incremental replication of items in IDX when an item is added and an item is modified in EDI
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                        | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_3214_ConfigIncr.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusIncr  |                                             | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusIncr')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBusIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusIncr%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "NewDBSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | NewDBSystem≫DB |
    And user update the json file "idc/EdiBusPayloads/HierarchyFilter.json" file for following values
      | jsonPath                                                | jsonValues              |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Service/TestDbSystem≫DB |
      | $..selections.['type_s'][*]                             | Column                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                         | body                                    | response code | response message | jsonPath |
      |        |       |       | Post | searches/fulltext?query=TestDbSystem&what=id&what=catalog&limitFacet=10&offset=0&limit=2500 | idc/EdiBusPayloads/HierarchyFilter.json | 200           |                  |          |
    And user stores the values in list from response using jsonpath "$..name"
    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | IDCDATA     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "TestColumnUpdate" and clicks on search
    And user performs "facet selection" in "TestDbSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TestColumnUpdate |

  Scenario:SC2#MLP-3214_Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3214_ConfigIncr.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                        | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_3214_ConfigIncr.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusIncr  |                                             | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusIncr')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusIncr% | Analysis |       |       |


  @edibus @positive
  Scenario:SC2#Remove added item and update modified item
    Given user connects Rochade Server and "rename" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName         | renameName |
      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_COLUMN | TestColumnUpdate | TestColumn |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                |
      | AP-DATA      | IDCDATA     | 1.0                | (XNAME * *  ~= NewDBSystem ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |

# #5579781# Bug Id:17687,MLP-3774 Out of Scope#
#  @edibus @mlp-3507 @webtest @positive @toIDP
#  Scenario:SC3# MLP-3507_Verify Full replication of data when renaming item in EDI and validate IDX deleted At and deleted By attribute for old item name in IDX database
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_3214_Config.json | 204           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusFullRep  |                                         | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBusFullRep" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusFullRep%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user connects Rochade Server and "add" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType          | itemName    |
#      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_DB_SYSTEM | DBSystemOne |
#    And user connects Rochade Server and "rename" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName   | renameName         |
#      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_COLUMN | TestColumn | TestColumnModified |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                | body | response code | response message | jsonPath                                           |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusFullRep  |      | 200           |                  |                                                    |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#    And user enters the search text "EDIBusFullRep" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusFullRep%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user verifies "TestColumn" column is updated with "current date"
#      | database      | catalogName | columnName    | type   |
#      | APPDBPOSTGRES | Default     | asg_deletedat | Column |
#    And user verifies "TestColumn" column is updated with "Service"
#      | database      | catalogName | columnName    | type   |
#      | APPDBPOSTGRES | Default     | asg_deletedby | Column |
#
#
#  Scenario:SC3#MLP-3214_Cleanup
#    Given user update the json file "idc/EdiBusPayloads/MLP_3214_Config.json" file for following values
#      | jsonPath    | jsonValues   |
#      | $..function | toIDPCleanup |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_3214_Config.json | 204           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusFullRep  |                                         | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#
#  Scenario:SC3#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                       | type     | query | param |
#      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusFullRep% | Analysis |       |       |
#
#  @edibus @positive
#  Scenario:SC3#Remove added item and update modified item
#    Given user connects Rochade Server and "rename" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName           | renameName |
#      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_COLUMN | TestColumnModified | TestColumn |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                |
#      | AP-DATA      | IDCDATA     | 1.0                | (XNAME * *  ~= DBSystemOne ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
#
#
#  #5579793#bug id:17687#
#  @edibus @mlp-3507 @webtest @positive @toIDP
#  Scenario:SC4# MLP-3507_Verify incremental replication of data when renaming item in EDI and validate IDX deleted At and deleted By attribute for old item name in IDX database
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_3214_Config.json | 204           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusFullRep  |                                         | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBusFullRep" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusFullRep%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user connects Rochade Server and "add" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType          | itemName    |
#      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_DB_SYSTEM | DBSystemOne |
#    And user connects Rochade Server and "rename" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName   | renameName         |
#      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_COLUMN | TestColumn | TestColumnModified |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                | body                                        | response code | response message | jsonPath                                           |
#      |        |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_3507_ConfigIncr.json | 204           |                  |                                                    |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusFullRep  |                                             | 200           |                  |                                                    |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#    And user enters the search text "EDIBusFullRep" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusFullRep%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user verifies "TestColumn" column is updated with "current date"
#      | database      | catalogName | columnName    | type   |
#      | APPDBPOSTGRES | Default     | asg_deletedat | Column |
#    And user verifies "TestColumn" column is updated with "Service"
#      | database      | catalogName | columnName    | type   |
#      | APPDBPOSTGRES | Default     | asg_deletedby | Column |
#
#
#  Scenario:SC4#MLP-3214_Cleanup
#    Given user update the json file "idc/EdiBusPayloads/MLP_3214_Config.json" file for following values
#      | jsonPath    | jsonValues   |
#      | $..function | toIDPCleanup |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_3214_Config.json | 204           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusFullRep  |                                         | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusFullRep |                                         | 200           | IDLE             | $.[?(@.configurationName=='EDIBusFullRep')].status |

  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusFullRep% | Analysis |       |       |

  @edibus @positive
  Scenario:SC5#Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    Given user connects Rochade Server and "rename" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName           | renameName |
      | AP-DATA      | IDCDATA     | 1.0                | DWR_RDB_COLUMN | TestColumnModified | TestColumn |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                |
      | AP-DATA      | IDCDATA     | 1.0                | (XNAME * *  ~= DBSystemOne ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
