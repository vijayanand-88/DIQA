Feature: MLP_23048 Verification of warning message in logs when all scope items are not defined with standard license

  @MLP-23048 @edibus
  Scenario Outline: SC1#-Set the DataSource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                           | path                                  | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusAutoDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAutoDataSource.configurations | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                      |                                                                    |                                       | 200           | EDIBusAutoDataSource |          |

#7177256#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC1#MLP-23048 Verification of warning message in logs when all scope items not defined during replicate under DWR_RDB_DB_SYSTEM hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeDB.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                          | body                                      | response code | response message | jsonPath                                     |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                    | idc/EdiBusPayloads/MLP_23048_ScopeDB.json | 204           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeDB |                                           | 200           | IDLE             | $.[?(@.configurationName=='ScopeDB')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeDB  |                                           | 200           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeDB |                                           | 200           | IDLE             | $.[?(@.configurationName=='ScopeDB')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeDB%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeDB%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                              | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_RDB_TABLE_OR_VIEW, DWR_RDB_SCHEMA, DWR_RDB_COLUMN]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeDB% | Analysis |       |       |

  #7177258#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC2#MLP-23048  Verification of warning message in logs when all scope items not defined during cleanup under DWR_RDB_DB_SYSTEM hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeDB.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                          | body                                      | response code | response message | jsonPath                                     |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                    | idc/EdiBusPayloads/MLP_23048_ScopeDB.json | 204           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeDB |                                           | 200           | IDLE             | $.[?(@.configurationName=='ScopeDB')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeDB  |                                           | 200           |                  |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeDB |                                           | 200           | IDLE             | $.[?(@.configurationName=='ScopeDB')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeDB%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeDB%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                              | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_RDB_TABLE_OR_VIEW, DWR_RDB_SCHEMA, DWR_RDB_COLUMN]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeDB% | Analysis |       |       |

  #7177259#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC3#MLP-23048 Verification of warning message in logs when all scope items not defined during replicate under DWR_TFM_SYSTEM hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeTFM.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                       | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_23048_ScopeTFM.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeTFM |                                            | 200           | IDLE             | $.[?(@.configurationName=='ScopeTFM')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeTFM  |                                            | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeTFM |                                            | 200           | IDLE             | $.[?(@.configurationName=='ScopeTFM')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeTFM%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeTFM%" should display below info/error/warning
      | type  | logValue                                                                                                                                                             | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_TFM_TRANSFORMATION, DWR_TFM_TASK]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeTFM% | Analysis |       |       |

#7177260#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC4#MLP-23048 Verification of warning message in logs when all scope items not defined during cleanup under DWR_TFM_SYSTEM hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeTFM.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                       | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_23048_ScopeTFM.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeTFM |                                            | 200           | IDLE             | $.[?(@.configurationName=='ScopeTFM')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeTFM  |                                            | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeTFM |                                            | 200           | IDLE             | $.[?(@.configurationName=='ScopeTFM')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeTFM%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeTFM%" should display below info/error/warning
      | type  | logValue                                                                                                                                                             | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_TFM_TRANSFORMATION, DWR_TFM_TASK]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeTFM% | Analysis |       |       |

    #7177261#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC5#MLP-23048 Verification of warning message in logs when all scope items not defined during replicate under DWR_ANL_OLAP_PACKAGE hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeOLAP.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_23048_ScopeOLAP.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeOLAP |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScopeOLAP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeOLAP  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeOLAP |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScopeOLAP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeOLAP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeOLAP%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                         | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_ANL_LEVEL, DWR_ANL_CUBE, DWR_ANL_OLAP_SCHEMA]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeOLAP% | Analysis |       |       |

#7177262#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC6#MLP-23048 Verification of warning message in logs when all scope items not defined during cleanup under DWR_TFM_SYSTEM hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeOLAP.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_23048_ScopeOLAP.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeOLAP |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScopeOLAP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeOLAP  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeOLAP |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScopeOLAP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeOLAP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeOLAP%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                         | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_ANL_LEVEL, DWR_ANL_CUBE, DWR_ANL_OLAP_SCHEMA]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeOLAP% | Analysis |       |       |

  #7177263#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC7#MLP-23048 Verification of warning message in logs when all scope items not defined during replicate under DWR_ANL_RPT_PACKAGE hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeRPT.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                       | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_23048_ScopeRPT.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeRPT |                                            | 200           | IDLE             | $.[?(@.configurationName=='ScopeRPT')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeRPT  |                                            | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeRPT |                                            | 200           | IDLE             | $.[?(@.configurationName=='ScopeRPT')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeRPT%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeRPT%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                                  | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_ANL_RPT_STRUCTURE, DWR_ANL_REPORT, DWR_ANL_RPT_SCHEMA]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeRPT% | Analysis |       |       |

#7177347#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC8#MLP-23048 Verification of warning message in logs when all scope items not defined during cleanup under DWR_ANL_RPT_PACKAGE hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeRPT.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                       | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_23048_ScopeRPT.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeRPT |                                            | 200           | IDLE             | $.[?(@.configurationName=='ScopeRPT')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeRPT  |                                            | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeRPT |                                            | 200           | IDLE             | $.[?(@.configurationName=='ScopeRPT')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeRPT%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeRPT%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                                  | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_ANL_RPT_STRUCTURE, DWR_ANL_REPORT, DWR_ANL_RPT_SCHEMA]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeRPT% | Analysis |       |       |

  #7177348#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC9#MLP-23048 Verification of warning message in logs when all scope items not defined during replicate under DWR_DAT_FILE_SYSTEM hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeFile.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_23048_ScopeFile.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeFile |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScopeFile')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeFile  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeFile |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScopeFile')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeFile%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeFile%" should display below info/error/warning
      | type  | logValue                                                                                                                                          | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_DAT_DIRECTORY]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |


  Scenario:SC9#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeFile% | Analysis |       |       |

  #7177349#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC10#MLP-23048 Verification of warning message in logs when all scope items not defined during cleanup under DWR_DAT_FILE_SYSTEM hierarchy
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeFile.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_23048_ScopeFile.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeFile |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScopeFile')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeFile  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeFile |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScopeFile')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeFile%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScopeFile%" should display below info/error/warning
      | type  | logValue                                                                                                                                          | logCode      | pluginName | removableText |
      | ERROR | Cannot do the replication because for these types to be replicated: "[DWR_DAT_DIRECTORY]" not all scope types have been defined in the type list. | EDIBUS-E0216 |            |               |

  Scenario:SC10#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeFile% | Analysis |       |       |

    #7177350#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC11#MLP-23048 Verification of warning message not displayed in logs when all scope items defined during replicate.
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeDefined.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                           | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_23048_ScopeDefined.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeDefined |                                                | 200           | IDLE             | $.[?(@.configurationName=='ScopeDefined')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeDefined  |                                                | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeDefined |                                                | 200           | IDLE             | $.[?(@.configurationName=='ScopeDefined')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeDefined%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
      | Warnings          | 0             |


  Scenario:SC11#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeDefined% | Analysis |       |       |

##7177351#
  @edibus @mlp-23048 @webtest @positive @toIDP
  Scenario:SC12#MLP-23048 Verification of warning message not displayed in logs when all scope items defined during cleanup.
    Given user update the json file "idc/EdiBusPayloads/MLP_23048_ScopeDefined.json" file for following values
      | jsonPath        | jsonValues |
      | $..['function'] | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                           | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_23048_ScopeDefined.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeDefined |                                                | 200           | IDLE             | $.[?(@.configurationName=='ScopeDefined')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScopeDefined  |                                                | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScopeDefined |                                                | 200           | IDLE             | $.[?(@.configurationName=='ScopeDefined')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScopeDefined%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
      | Warnings          | 0             |


  Scenario:SC12#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScopeDefined% | Analysis |       |       |

  @edibus @mlp-23048 @positive @release10.0
  Scenario:MLP-23048 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                                |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusAutoDataSource |      | 204           |                  |          |
