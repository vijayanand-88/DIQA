Feature: MLP_4539 Replicating Supported Types toIDP and to EDI

  @edibus @mlp-4539 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#_MLP-4539_Run full replication from EDI to IDX with sqlg RDB & Data item types
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_EDITOIDXConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXRDBData |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXRDBData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXRDBData  |                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXRDBData |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXRDBData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TestDBSystem" and clicks on search
    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Database |
      | Service  |
      | Table    |
      | Schema   |
    And user enters the search text "DataPackage" and clicks on search
    And user performs "facet selection" in "DataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | DataPackage |
      | DataType    |
    And user enters the search text "TestFi" and clicks on search
    And user performs "facet selection" in "TestFile [File]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | File  |
      | Field |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXRDBData%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_4539_EDITOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_EDITOIDXConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXRDBData |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXRDBData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXRDBData  |                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXRDBData |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXRDBData')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXRDBData% | Analysis |       |       |

  @edibus @mlp-4539 @webtest @positive @release10.0 @toIDP
  Scenario:SC2#_MLP-4539_Run full replication from EDI to IDX with sqlg RDB & Data item types incremental true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_EDITOIDXConfigIncr.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXRDBData |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXRDBData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXRDBData  |                                                     | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXRDBData |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXRDBData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TestDBSystem" and clicks on search
    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Database |
      | Service  |
      | Table    |
      | Schema   |
    And user enters the search text "DataPackage" and clicks on search
    And user performs "facet selection" in "DataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | DataPackage |
      | DataType    |
    And user enters the search text "TestFi" and clicks on search
    And user performs "facet selection" in "TestFile [File]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | File  |
      | Field |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXRDBData%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC2#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_4539_EDITOIDXConfigIncr.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_EDITOIDXConfigIncr.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXRDBData |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXRDBData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXRDBData  |                                                     | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXRDBData |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXRDBData')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXRDBData% | Analysis |       |       |

  @edibus @mlp-4539 @webtest @positive @release10.0 @toIDP
  Scenario:SC3#_MLP-4539_Run full replication from EDI to IDX with rochade OLAP&Report ItemTypes
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_4539_EDITOIDXOLAPConfig.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXOLAP |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXOLAP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXOLAP  |                                                     | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXOLAP |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXOLAP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXOLAP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TestOLAPPackage" and clicks on search
    And user performs "facet selection" in "TestOLAPPackage [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Dimension        |
      | AggregationLevel |
      | Hierarchy        |
      | Measure          |
      | OlapPackage      |
      | OlapSchema       |
      | Cube             |
    And user enters the search text "TestRPTPackage" and clicks on search
    And user performs "facet selection" in "TestRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Dashboard     |
      | DashboardPage |
      | DataType      |
      | Field         |
      | Report        |
      | ReportPackage |
      | ReportSchema  |
    And user enters the search text "TestRPTStructure" and clicks on search
    And user performs "item click" on "TestRPTStructure" item from search results
    Then user performs click and verify in new window
      | Table        | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TestRPTMap | verify widget contains | No               |             |
    And user enters the search text "TestDimension" and clicks on search
    And user performs "item click" on "TestDimension" item from search results
    Then user performs click and verify in new window
      | Table        | value            | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TestDimensionMap | verify widget contains | No               |             |

  Scenario:SC3#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_4539_EDITOIDXOLAPConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_4539_EDITOIDXOLAPConfig.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXOLAP |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXOLAP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXOLAP  |                                                     | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXOLAP |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXOLAP')].status |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXOLAP% | Analysis |       |       |

  @edibus @mlp-4539 @webtest @positive @release10.0 @toIDP
  Scenario:SC4#_MLP-4539_Run full replication from EDI to IDX with rochade OLAP&Report ItemTypes incremental true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                    | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_4539_EDITOIDXOLAPConfigIncr.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXOLAP |                                                         | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXOLAP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXOLAP  |                                                         | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXOLAP |                                                         | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXOLAP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXOLAP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TestOLAPPackage" and clicks on search
    And user performs "facet selection" in "TestOLAPPackage [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Dimension        |
      | AggregationLevel |
      | Hierarchy        |
      | Measure          |
      | OlapPackage      |
      | OlapSchema       |
      | Cube             |
    And user enters the search text "TestRPTPackage" and clicks on search
    And user performs "facet selection" in "TestRPTPackage [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Dashboard     |
      | DashboardPage |
      | DataType      |
      | Field         |
      | Report        |
      | ReportPackage |
      | ReportSchema  |
    And user enters the search text "TestRPTStructure" and clicks on search
    And user performs "item click" on "TestRPTStructure" item from search results
    Then user performs click and verify in new window
      | Table        | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TestRPTMap | verify widget contains | No               |             |
    And user enters the search text "TestDimension" and clicks on search
    And user performs "item click" on "TestDimension" item from search results
    Then user performs click and verify in new window
      | Table        | value            | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TestDimensionMap | verify widget contains | No               |             |


  Scenario:SC4#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_4539_EDITOIDXOLAPConfigIncr.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                    | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_4539_EDITOIDXOLAPConfigIncr.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXOLAP |                                                         | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXOLAP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXOLAP  |                                                         | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXOLAP |                                                         | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXOLAP')].status |

  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXOLAP% | Analysis |       |       |

  @edibus @mlp-4539 @webtest @positive @release10.0 @toIDP
  Scenario:SC5#_MLP-4539_Run full replication from EDI to IDX with rochade TFM ItemTypes
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                               | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_EDITOIDXTFMConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXTFMData |                                                    | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXTFMData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXTFMData  |                                                    | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXTFMData |                                                    | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXTFMData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TFMSystem" and clicks on search
    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Operation |
      | Service   |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXTFMData%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC5#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_4539_EDITOIDXTFMConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                               | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_EDITOIDXTFMConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXTFMData |                                                    | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXTFMData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXTFMData  |                                                    | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXTFMData |                                                    | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXTFMData')].status |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXTFMData% | Analysis |       |       |

  @edibus @mlp-4539 @webtest @positive @release10.0 @toIDP
  Scenario:SC6#_MLP-4539_Run full replication from EDI to IDX with rochade TFM ItemTypes incremental true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                   | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_EDITOIDXTFMConfigIncr.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXTFMData |                                                        | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXTFMData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXTFMData  |                                                        | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXTFMData |                                                        | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXTFMData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TFMSystem" and clicks on search
    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Operation |
      | Service   |
    And user enters the search text "TestDBSystem" and clicks on search
    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Database |
      | Service  |
      | Table    |
      | Schema   |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXTFMData%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "Transformation" and clicks on search
    And user performs "item click" on "Transformation" item from search results
    Then user performs click and verify in new window
      | Table        | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TransformationMap | verify widget contains | No               |             |


  Scenario:SC6#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_4539_EDITOIDXTFMConfigIncr.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                   | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_4539_EDITOIDXTFMConfigIncr.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXTFMData |                                                        | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXTFMData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXTFMData  |                                                        | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXTFMData |                                                        | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXTFMData')].status |

  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXTFMData% | Analysis |       |       |

  @edibus @mlp-4539 @positive @release10.0
  Scenario:SC7#_MLP-4539 Deleting used catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned
