Feature: MLP-7863 Add mapping for ERM types to EDIBus mapping definitions

##6478483##
  @edibus @mlp-7863 @webtest @positive @toIDP
  Scenario:SC1#MLP-7863_Verification of replicating ER item types from EDI to IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                              | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7863_EDITOIDXERConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXERData |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXERData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXERData  |                                                   | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXERData |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXERData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ERMModel" and clicks on search
    And user performs "facet selection" in "ERMModel [ER-Model]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Attribute    |
      | ER-Model     |
      | Entity       |
      | Identifier   |
      | Relationship |
      | SubjectArea  |
    Then user "verify presence" of following "Items List" in Search Results Page
      | ERMSubjectArea  |
      | ERMAttribute    |
      | ERMRelationship |
      | ERMEntity       |
      | ERMModel        |
      | ERMIdentifier   |
    And user enters the search text "EDItoIDXERData" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXERData%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXERData%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 6 items | EDIBUS-I0024 |            |               |


  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7863_EDITOIDXERConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                              | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_7863_EDITOIDXERConfig.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXERData |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXERData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXERData  |                                                   | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXERData |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXERData')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXERData% | Analysis |       |       |


##6478517##
  @edibus @mlp-7863 @webtest @positive @toIDP
  Scenario:SC2#MLP-7863_Verification of replicating RDB item types along with ERM types from EDI to IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                            | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_7863_EDITOIDXConfig.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ERRDBData |                                                 | 200           | IDLE             | $.[?(@.configurationName=='ERRDBData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ERRDBData  |                                                 | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ERRDBData |                                                 | 200           | IDLE             | $.[?(@.configurationName=='ERRDBData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ERMModel" and clicks on search
    And user performs "facet selection" in "ERMModel [ER-Model]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Attribute    |
      | ER-Model     |
      | Entity       |
      | Identifier   |
      | Relationship |
      | SubjectArea  |
      | Service      |
    Then user "verify presence" of following "Items List" in Search Results Page
      | ERMSubjectArea  |
      | ERMAttribute    |
      | ERMRelationship |
      | ERMEntity       |
      | ERMModel        |
      | ERMIdentifier   |
    And user enters the search text "DBSystem" and clicks on search
    And user "verify displayed" for listed "Metadata Type" facet in Search results page
      | ItemType |
      | Service  |
    Then user "verify presence" of following "Items List" in Search Results Page
      | DBSystem≫DB |
    And user enters the search text "ERRDBData" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ERRDBData%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ERRDBData%" should display below info/error/warning
      | type | logValue             | logCode      | pluginName | removableText |
      | INFO | 7 items were written | EDIBUS-I0024 |            |               |


  Scenario:SC2#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7863_EDITOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                            | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_7863_EDITOIDXConfig.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ERRDBData |                                                 | 200           | IDLE             | $.[?(@.configurationName=='ERRDBData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ERRDBData  |                                                 | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ERRDBData |                                                 | 200           | IDLE             | $.[?(@.configurationName=='ERRDBData')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/ERRDBData% | Analysis |       |       |


   ##6478871##7208630#7208594#
  @edibus @mlp-7863 @webtest @positive @toIDP
  Scenario:SC3#MLP-7863_MLP-28376_Verification of adding ERM item types from EDI to IDP incremental replication
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                          | body                                    | response code | response message | jsonPath                                     |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                    | idc/EdiBusPayloads/MLP_7863_Config.json | 204           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBData |                                         | 200           | IDLE             | $.[?(@.configurationName=='RDBData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/RDBData  |                                         | 200           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBData |                                         | 200           | IDLE             | $.[?(@.configurationName=='RDBData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DBSystem" and clicks on search
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    Then user "verify presence" of following "Items List" in Search Results Page
      | DBSystem≫DB |
    And user enters the search text "RDBData" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/RDBData%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 1             |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | DBSystem≫DB |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                        | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_7863_IncrConfig.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBDataIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='RDBDataIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/RDBDataIncr  |                                             | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBDataIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='RDBDataIncr')].status |
    And user enters the search text "ERMModel" and clicks on search
    And user performs "facet selection" in "ERMModel [ER-Model]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Attribute    |
      | ER-Model     |
      | Entity       |
      | Identifier   |
      | Relationship |
      | SubjectArea  |
      | Service      |
    Then user "verify presence" of following "Items List" in Search Results Page
      | ERMSubjectArea  |
      | ERMAttribute    |
      | ERMRelationship |
      | ERMEntity       |
      | ERMModel        |
      | ERMIdentifier   |
    And user enters the search text "DBSystem" and clicks on search
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    Then user "verify presence" of following "Items List" in Search Results Page
      | DBSystem≫DB |
    And user enters the search text "RDBDataIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/RDBDataIncr%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 2             |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | DBSystem≫DB |
      | ERMModel    |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/RDBDataIncr%" should display below info/error/warning
      | type | logValue             | logCode      | pluginName | removableText |
      | INFO | 7 items were written | EDIBUS-I0024 |            |               |


  Scenario:SC3#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7863_Config.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                          | body                                    | response code | response message | jsonPath                                     |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                    | idc/EdiBusPayloads/MLP_7863_Config.json | 204           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBData |                                         | 200           | IDLE             | $.[?(@.configurationName=='RDBData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/RDBData  |                                         | 200           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBData |                                         | 200           | IDLE             | $.[?(@.configurationName=='RDBData')].status |
    Given user update the json file "idc/EdiBusPayloads/MLP_7863_IncrConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                              | body                                        | response code | response message | jsonPath                                         |
      |        |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_7863_IncrConfig.json | 204           |                  |                                                  |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBDataIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='RDBDataIncr')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/RDBDataIncr  |                                             | 200           |                  |                                                  |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/RDBDataIncr |                                             | 200           | IDLE             | $.[?(@.configurationName=='RDBDataIncr')].status |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/RDBDataIncr% | Analysis |       |       |


  @edibus @mlp-7863 @positive
  Scenario:SC4#Clearing of Subject Area
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

#Attribute test case has been verified in MLP_26233
###6563763##
#  @edibus @mlp-9314 @webtest @positive @toIDP
#  Scenario:SC5#MLP-9314_Verification of replication of attribute values for item type from EDI to IDP
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_9314_EDITOIDXConfig.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAttribute |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAttribute')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAttribute  |                                                 | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAttribute |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAttribute')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "TestOLAPSchema" and clicks on search
#    And user performs "facet selection" in "TestOLAPPackage [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TestOLAPSchema" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Definition   | TestDefinition    |
#      | Description  | Test              |
#    And user enters the search text "TestRPTField" and clicks on search
#    And user performs "facet selection" in "TestRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TestRPTField" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Comments     | Desc              |
#      | Definition   | TestDefinition    |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName |
#      | Minimum length    | 6             | Statistics |
#    And user enters the search text "TestRPTStructure" and clicks on search
#    And user performs "facet selection" in "TestRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TestRPTStructure" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Definition   | TestDefinition    |
#      | Description  | Desc              |
#    And user clicks on type of item "TestRPTMap" in table "LINEAGE HOPS"
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Definition   | TestDefinition    |
#      | source       | Test              |
#    And user enters the search text "DataType" and clicks on search
#    And user performs "facet selection" in "DataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "DataType" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem      | metaDataItemValue |
#      | Definition        | TestDefinition    |
#      | dataAllowedValues | 6                 |
#      | dataDefaultValue  | 5                 |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName |
#      | dataMinimumLength | 4             | Statistics |
#    And user enters the search text "DataDomain" and clicks on search
#    And user performs "facet selection" in "DataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "DataDomain" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Definition   | TestDefinition    |
#    And user enters the search text "TestField" and clicks on search
#    And user performs "item click" on "TestField" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem   | metaDataItemValue |
#      | Minimum length | 5                 |
#      | Comments       | Test              |
#    And user enters the search text "DataPackage" and clicks on search
#    And user performs "facet selection" in "DataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "DataPackage" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Description  | Test              |
#    And user enters the search text "TestRecordType" and clicks on search
#    And user performs "facet selection" in "DataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TestRecordType" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Description  | Test              |
#    And user enters the search text "TestColumn" and clicks on search
#    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TestColumn" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem      | metaDataItemValue |
#      | dataAllowedValues | 5                 |
#      | dataDefaultValue  | 5                 |
#      | Length            | 10                |
#    Then verify the table "TYPE" has item "DataType"
#    And user enters the search text "TestSchema" and clicks on search
#    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TestSchema" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Description  | Test              |
#      | Definition   | TestDefinition    |
#    And user enters the search text "TestTable" and clicks on search
#    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TestTable" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Table Type   | VIEW              |
#    Then verify the table "DEPENDENCIES" has item "TestTableOne"
#    And user enters the search text "TFMTask" and clicks on search
#    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TFMTask" item from search results
#    And user clicks on type of item "Instructions" in table "DATA"
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Data         | StatusCheck       |
#    And user enters the search text "Transformation" and clicks on search
#    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "Transformation" item from search results
#    And user clicks on type of item "Instructions" in table "DATA"
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | Data         | Test              |
#    And user enters the search text "Transformation" and clicks on search
#    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "Transformation" item from search results
#    And user clicks on type of item "TransformationMap" in table "LINEAGE HOPS"
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | source       | Test              |
#      | Definition   | TestDefinition    |
#    And user enters the search text "TestDimension" and clicks on search
#    And user performs "facet selection" in "TestOLAPPackage [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "TestDimension" item from search results
#    And user clicks on type of item "TestDimensionMap" in table "LINEAGE HOPS"
#    And METADATA widget should have following item values
#      | metaDataItem | metaDataItemValue |
#      | source       | Test              |
#      | Definition   | Definition        |
#
#
#  Scenario:SC5#Cleanup
#    Given user update the json file "idc/EdiBusPayloads/MLP_9314_EDITOIDXConfig.json" file for following values
#      | jsonPath    | jsonValues   |
#      | $..function | toIDPCleanup |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_9314_EDITOIDXConfig.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAttribute |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAttribute')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAttribute  |                                                 | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAttribute |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAttribute')].status |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusAttribute% | Analysis |       |       |

  @edibus @mlp-9314 @webtest @positive
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned
