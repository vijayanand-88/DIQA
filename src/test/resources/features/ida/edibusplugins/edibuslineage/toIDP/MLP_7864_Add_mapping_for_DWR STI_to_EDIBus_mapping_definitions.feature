Feature: MLP-7864 Add mapping between DWR STI (stitching) types and IDP LineageHops to EDIBus mapping definitions

 #6518173#
  @edibus @mlp-7864 @webtest @positive @toIDP
  Scenario:SC1#_MLP-7864_Verification of linking columns to field link in incremental mode  from EDI to IDP
    Given user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName      | linkItemType   | linkItemName  | attributeName           | operationName |
      | AP-DATA      | STITCHING   | 1.0                | STI_FIELD_LINK | TestFieldLink | DWR_RDB_COLUMN | TestColumnOne | STI_ELEMENT_STITCH_FROM | REMOVE        |
      | AP-DATA      | STITCHING   | 1.0                | STI_FIELD_LINK | TestFieldLink | DWR_RDB_COLUMN | TestColumn    | STI_ELEMENT_STITCH_TO   | REMOVE        |
    And user update the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_StitchingConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPStitching  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "toIDPStitching" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPStitching%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TestSTIContainer" and clicks on search
    And user performs "facet selection" in "TestSTIContainer≫Stitching [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | TestSTIContainer≫Stitching |
      | TestStructureLink          |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName      | linkItemType   | linkItemName  | attributeName           | operationName |
      | AP-DATA      | STITCHING   | 1.0                | STI_FIELD_LINK | TestFieldLink | DWR_RDB_COLUMN | TestColumnOne | STI_ELEMENT_STITCH_FROM | SET           |
      | AP-DATA      | STITCHING   | 1.0                | STI_FIELD_LINK | TestFieldLink | DWR_RDB_COLUMN | TestColumn    | STI_ELEMENT_STITCH_TO   | SET           |
    And user update the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfigIncr.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                                 | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_StitchingConfigIncr.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                      | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPStitching  |                                                      | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                      | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
    And user enters the search text "toIDPStitching" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPStitching%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TestSTIContainer" and clicks on search
    And user performs "facet selection" in "TestSTIContainer≫Stitching [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TestStructureLink" item from search results
    Then user performs click and verify in new window
      | Table        | value         | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TestFieldLink | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | mode         | STITCH            |
    Then user performs click and verify in new window
      | Table          | value         | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Source | TestColumnOne | verify widget contains | No               |             |
      | Lineage Target | TestColumn    | verify widget contains | No               |             |
    And user enters the search text "DBSystemTest" and clicks on search
    And user performs "facet selection" in "DBSystemTest≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Table    |
      | Database |

  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_StitchingConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPStitching  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
    Given user update the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfigIncr.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                                 | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_StitchingConfigIncr.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                      | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPStitching  |                                                      | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                      | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName      | linkItemType   | linkItemName  | attributeName           | operationName |
      | AP-DATA      | STITCHING   | 1.0                | STI_FIELD_LINK | TestFieldLink | DWR_RDB_COLUMN | TestColumnOne | STI_ELEMENT_STITCH_FROM | SET           |
      | AP-DATA      | STITCHING   | 1.0                | STI_FIELD_LINK | TestFieldLink | DWR_RDB_COLUMN | TestColumn    | STI_ELEMENT_STITCH_TO   | SET           |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toIDPStitching% | Analysis |       |       |


##6518166##6518168##
  @edibus @mlp-7864 @webtest @positive @toIDP
  Scenario:SC2#_MLP-7864_Verification of Replicating stitching items from EDI to IDP
    Given user "update" the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfig.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user update the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_StitchingConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPStitching  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "toIDPStitching" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPStitching%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TestSTIContainer" and clicks on search
    And user performs "facet selection" in "TestSTIContainer≫Stitching [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | TestSTIContainer≫Stitching |
      | TestStructureLink          |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service   |
      | Operation |
    And user performs "item click" on "TestStructureLink" item from search results
    Then user performs click and verify in new window
      | Table        | value         | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TestFieldLink | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | mode         | STITCH            |
    Then user performs click and verify in new window
      | Table          | value         | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Source | TestColumnOne | verify widget contains | No               |             |
      | Lineage Target | TestColumn    | verify widget contains | No               |             |


  Scenario:SC2#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_StitchingConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPStitching  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toIDPStitching% | Analysis |       |       |


    #6518172##
  @edibus @mlp-7864 @webtest @positive @toIDP
  Scenario:SC3#_MLP-7864 Verification of replicating stitching items in incremental mode  from EDI to IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                          | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_ColumnConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDPColumn |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDPColumn')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDPColumn  |                                               | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDPColumn |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDPColumn')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDItoIDPColumn" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDPColumn%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user update the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And user "update" the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfig.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_StitchingConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPStitching  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
    And user enters the search text "TestSTIContainer" and clicks on search
    And user performs "facet selection" in "TestSTIContainer≫Stitching [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | TestSTIContainer≫Stitching |
      | TestStructureLink          |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service   |
      | Operation |
    And user performs "item click" on "TestStructureLink" item from search results
    Then user performs click and verify in new window
      | Table        | value         | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TestFieldLink | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | mode         | STITCH            |
    Then user performs click and verify in new window
      | Table          | value         | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Source | TestColumnOne | verify widget contains | No               |             |
      | Lineage Target | TestColumn    | verify widget contains | No               |             |
    And user enters the search text "DBSystemTest" and clicks on search
    And user performs "facet selection" in "DBSystemTest≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPStitching%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toIDPStitching%" should display below info/error/warning
      | type | logValue                                                                                  | logCode      | pluginName | removableText |
      | INFO | Cannot replicate incrementally because of missing time of last replication in DD catalog. | EDIBUS-I0019 |            |               |


  Scenario:SC3#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7864_ColumnConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                          | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_ColumnConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDPColumn |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDPColumn')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDPColumn  |                                               | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDPColumn |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDPColumn')].status |
    Given user update the json file "idc/EdiBusPayloads/MLP_7864_StitchingConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7864_StitchingConfig.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPStitching  |                                                  | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPStitching |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPStitching')].status |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toIDPStitching% | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDPColumn% | Analysis |       |       |

  @edibus @mlp-12644 @webtest @positive @toIDP
  Scenario:SC4#_MLP-12644 Verification of replicating DWR_TFM_TRANSFORMATION_MAP, DWR_ANL_DIMENSION_MAP, DWR_ANL_RPT_MAP, STI_FIELD_LINKs to IDP with special license
    And user update the json file "idc/EdiBusPayloads/MLP_12644_Config.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                     | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_12644_Config.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDILineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='EDILineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDILineage  |                                          | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDILineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='EDILineage')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDILineage" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDILineage%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "STIStruct" and clicks on search
    And user performs "item click" on "STIStruct" item from search results
    Then user performs click and verify in new window
      | Table        | value    | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | STIField | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table          | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Source | NewColumn    | verify widget contains | No               |             |
      | Lineage Target | NewColumnOne | verify widget contains | No               |             |
    And user enters the search text "Transformation" and clicks on search
    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Transformation" item from search results
    Then user performs click and verify in new window
      | Table        | value             | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TransformationMap | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table          | value         | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Source | TestColumn    | verify widget contains | No               |             |
      | Lineage Target | TestColumnOne | verify widget contains | No               |             |
    And user enters the search text "TestRPTStructure" and clicks on search
    And user performs "facet selection" in "TestRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TestRPTStructure" item from search results
    Then user performs click and verify in new window
      | Table        | value      | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TestRPTMap | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table          | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Source | TestRPTField | verify widget contains | No               |             |
      | Lineage Target | NewRPTField  | verify widget contains | No               |             |


  Scenario:SC4#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_12644_Config.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                     | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_12644_Config.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDILineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='EDILineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDILineage  |                                          | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDILineage |                                          | 200           | IDLE             | $.[?(@.configurationName=='EDILineage')].status |

  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDILineage% | Analysis |       |       |


  @edibus @mlp-9314 @positive
  Scenario:SC4#_Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned
    And user connects Rochade Server and "linkItem" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName      | linkItemType   | linkItemName  | attributeName           | operationName |
      | AP-DATA      | STITCHING   | 1.0                | STI_FIELD_LINK | TestFieldLink | DWR_RDB_COLUMN | TestColumnOne | STI_ELEMENT_STITCH_FROM | SET           |
      | AP-DATA      | STITCHING   | 1.0                | STI_FIELD_LINK | TestFieldLink | DWR_RDB_COLUMN | TestColumn    | STI_ELEMENT_STITCH_TO   | SET           |


