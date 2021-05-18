Feature: MLP-8161 Message Improvements

  @MLP-8161 @edibus
  Scenario Outline: SC1#-Set the DataSource for EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                             | bodyFile                                                           | path                                         | response code | response message            | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusInvalidHostDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusInvalidHostDataSource.configurations | 204           |                             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                             |                                                                    |                                              | 200           | EDIBusInvalidHostDataSource |          |


  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC1# MLP-8161 Verification of error code EDIBUS-E0002 and EDIBUS-E0003
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0003.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0003 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0003')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0003  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0003 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0003')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0003%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/Error0003%" should display below info/error/warning
      | type  | logValue                                         | logCode      |
      | ERROR | EDIBus reported an error                         | EDIBUS-E0002 |
      | ERROR | Could not find EDI host usyp5thirmoga11v.asg.com | EDIBUS-E0100 |


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0003% | Analysis |       |       |


  @MLP-8161 @edibus
  Scenario Outline: SC2#-Set the DataSource for EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                         | bodyFile                                                           | path                                     | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusInvalidDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusInvalidDataSource.configurations | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusInvalidDataSource |          |


  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC2# MLP-8161 Verification of error code EDIBUS-E0006
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0006.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0006 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0006')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0006  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0006 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0006')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0006%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/Error0006%" should display below info/error/warning
      | type  | logValue                                                                            | logCode      |
      | ERROR | Access to EDI server usyp5thirmoga1v.asg.com at port 9292 denied for user ADMINTEST | EDIBUS-E0103 |


  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0006% | Analysis |       |       |

  @MLP-8161 @edibus
  Scenario Outline: SC3#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                    | jsonValues              |
      | $.EDIBusDynamicDataSource..['EDI database'] | AP-DATATEST             |
      | $.EDIBusDynamicDataSource..['EDI host']     | usyp5thirmoga1v.asg.com |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                         | bodyFile                                                           | path                                     | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDynamicDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDynamicDataSource.configurations | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusDynamicDataSource |          |


  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC3#MLP-8161 Verification of error code EDIBUS-E0008
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0008.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0008 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0008')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0008  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0008 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0008')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0008%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/Error0008%" should display below info/error/warning
      | type  | logValue                                | logCode      |
      | ERROR | Could not find EDI database AP-DATATEST | EDIBUS-E0105 |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0008% | Analysis |       |       |

  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC4#MLP-8161 Verification of error code EDIBUS-E0059 for EDI to IDX
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_8161_ErrorE0059EDIToIDX.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0059toIDX |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Error0059toIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0059toIDX  |                                                     | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0059toIDX |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Error0059toIDX')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0059toIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/Error0059toIDX%" should display below info/error/warning
      | type  | logValue                                                 | logCode      |
      | ERROR | Setting "EDI types" must contain at least one type name. | EDIBUS-E1304 |

  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0059toIDX% | Analysis |       |       |

     #DD to EDI flow is disabled
#  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
#  Scenario:SC5#MLP-8161 Verification of error code EDIBUS-E0059 for IDX to EDI
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                               | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_8161_Error0059IDXTOEDI.json | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0059toEDI |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Error0059toEDI')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0059toEDI  |                                                    | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0059toEDI |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Error0059toEDI')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBus" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0059toEDI%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 1                 |
#    Then user performs click and verify in new window
#      | Table | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data  | log   | click and switch tab | No               |             |
#    Then Analysis log "bulk/EDIBus/Error0059toEDI%" should display below info/error/warning
#      | type  | logValue                                               | logCode      |
#      | ERROR | Object "IDA types" must contain at least one type name | EDIBUS-E1304 |
#
#
#  Scenario:SC5#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                        | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/Error0059toEDI% | Analysis |       |       |

  @MLP-8161 @edibus
  Scenario Outline: SC6#-Set the DataSource for EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusRolesDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusRolesDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusRolesDataSource |          |

  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC6#MLP-8161 Verification of error code EDIBUS-E0053
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0053.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0053 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0053')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0053  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0053 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0053')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0053%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/Error0053%" should display below info/error/warning
      | type  | logValue                                                    | logCode      |
      | ERROR | Parameter "EDI subject area access roles" must not be empty | EDIBUS-E1108 |

  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0053% | Analysis |       |       |

  @MLP-8161 @edibus
  Scenario Outline: SC7#-Set the DataSource for EDIBus
    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
      | jsonPath                                             | jsonValues              |
      | $.EDIBusDynamicDataSource..['EDI subject area name'] | INVALIDSUB              |
      | $.EDIBusDynamicDataSource..['EDI host']              | usyp5thirmoga1v.asg.com |
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                         | bodyFile                                                           | path                                     | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDynamicDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDynamicDataSource.configurations | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusDynamicDataSource |          |


  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC7#MLP-8161 Verification of error code EDIBUS-E0011
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0011.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0011 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0011')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0011  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0011 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0011')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0011%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/Error0011%" should display below info/error/warning
      | type  | logValue                                    | logCode      |
      | ERROR | Could not access EDI application INVALIDSUB | EDIBUS-E0108 |

  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0011% | Analysis |       |       |

  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC8#MLP-8161 Verification of error code EDIBUS-E0060 for EDI to IDX
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_8161_ErrorE0060EDIToIDX.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0060toIDX |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Error0060toIDX')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0060toIDX  |                                                     | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0060toIDX |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Error0060toIDX')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0060toIDX%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 2             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/Error0060toIDX%" should display below info/error/warning
      | type  | logValue                                                                                                         | logCode      |
      | ERROR | Setting "EDI types" must contain at least the name of one type which exists in the source and can be replicated. | EDIBUS-E1310 |

  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0060toIDX% | Analysis |       |       |

    #DD to EDI flow is disabled
#  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
#  Scenario:SC9#MLP-8161 Verification of error code EDIBUS-E0060 for IDX to EDI
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                               | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_8161_Error0060IDXTOEDI.json | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0060toEDI |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Error0060toEDI')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0060toEDI  |                                                    | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0060toEDI |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Error0060toEDI')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBus" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0060toEDI%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 1                 |
#    Then user performs click and verify in new window
#      | Table | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data  | log   | click and switch tab | No               |             |
#    Then Analysis log "bulk/EDIBus/Error0060toEDI%" should display below info/error/warning
#      | type  | logValue                                                                        | logCode      |
#      | ERROR | Object "IDA types" must contain at least one type name mapped to a target type. | EDIBUS-E1305 |
#
#
#  Scenario:SC9#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                        | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/Error0060toEDI% | Analysis |       |       |
#
#  @MLP-8161 @edibus
#  Scenario Outline: SC10#-Set the DataSource for EDIBus
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusGlossDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusGlossDataSource.configurations | 204           |                       |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusGlossDataSource |          |
#
#
#  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
#  Scenario:SC10#MLP-8161 Verification of error code EDIBUS-E0062
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0062.json | 204           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0062 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0062')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0062  |                                             | 200           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0062 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0062')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBus" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0062%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 2                 |
#    Then user performs click and verify in new window
#      | Table | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data  | log   | click and switch tab | No               |             |
#    And Analysis log "bulk/EDIBus/Error0062%" should display below info/error/warning
#      | type  | logValue                        | logCode      |
#      | ERROR | Glossary name must not be empty | EDIBUS-E1307 |
#
#  Scenario:SC10#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                   | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/Error0062% | Analysis |       |       |
#
#
#  @MLP-8161 @edibus
#  Scenario Outline: SC11#-Set the DataSource for EDIBus
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                              | bodyFile                                                           | path                                          | response code | response message             | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusInvalidGlossDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusInvalidGlossDataSource.configurations | 204           |                              |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                              |                                                                    |                                               | 200           | EDIBusInvalidGlossDataSource |          |
#
#
#  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
#  Scenario:SC11#MLP-8161 Verification of error code EDIBUS-E0063
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0063.json | 204           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0063 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0063')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0063  |                                             | 200           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0063 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0063')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBus" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0063%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 2                 |
#    Then user performs click and verify in new window
#      | Table | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data  | log   | click and switch tab | No               |             |
#    Then Analysis log "bulk/EDIBus/Error0063%" should display below info/error/warning
#      | type  | logValue                               | logCode      |
#      | ERROR | No Glossary found with name "NEWGLOSS" | EDIBUS-E1308 |
#
#  Scenario:SC11#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                   | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/Error0063% | Analysis |       |       |

  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC12#MLP-8161 Verification of error code EDIBUS-E0057
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0057.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0057 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0057')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0057  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0057 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0057')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0057%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/Error0057%" should display below info/error/warning
      | type  | logValue                                         | logCode      |
      | ERROR | The value of "batchSize" must not be below "500" | EDIBUS-E1301 |

  Scenario:SC12#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0057% | Analysis |       |       |

  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC13#MLP-8161 Verification of error code EDIBUS-E0058
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0058.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0058 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0058')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0058  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0058 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0058')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0058%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/Error0058%" should display below info/error/warning
      | type  | logValue                                         | logCode      |
      | ERROR | The value of "threadCount" must not be above "8" | EDIBUS-E1302 |

  Scenario:SC13#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0058% | Analysis |       |       |

    # DD to EDI flow is disabled
#  @MLP-8161 @edibus
#  Scenario Outline: SC14#-Set the DataSource for EDIBus
#    Given user update the json file "idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json" file for following values
#      | jsonPath                                             | jsonValues              |
#      | $.EDIBusDynamicDataSource..['EDI subject area name'] | WRONGTYPE               |
#      | $.EDIBusDynamicDataSource..['EDI host']              | usyp5thirmoga1v.asg.com |
#    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                         | bodyFile                                                           | path                                     | response code | response message        | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDynamicDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDynamicDataSource.configurations | 204           |                         |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusDynamicDataSource |          |
#
#
#  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
#  Scenario:SC14#MLP-8161 Verification of error code EDIBUS-E0040
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0040.json | 204           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0040 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0040')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0040  |                                             | 200           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0040 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0040')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBus" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0040%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 1                 |
#    Then user performs click and verify in new window
#      | Table | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data  | log   | click and switch tab | No               |             |
#    Then Analysis log "bulk/EDIBus/Error0040%" should display below info/error/warning
#      | type  | logValue                                                                                                          | logCode      |
#      | ERROR | The model of the EDI replication target subjectArea does not contain the required target type: "DWR_OOP_VARIABLE" | EDIBUS-E1001 |
#
#
#  Scenario:SC14#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                   | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/Error0040% | Analysis |       |       |

  @MLP-8161 @edibus
  Scenario Outline: SC15#-Set the DataSource for EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                             | bodyFile                                                           | path                                         | response code | response message            | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusInvalidPortDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusInvalidPortDataSource.configurations | 204           |                             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                             |                                                                    |                                              | 200           | EDIBusInvalidPortDataSource |          |


  @edibus @mlp-8161 @webtest @positive @release10.0 @toIDP
  Scenario:SC15#MLP-8161 Verification of error code EDIBUS-E0004
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                        | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_8161_ErrorE0004.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0004 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0004')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Error0004  |                                             | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Error0004 |                                             | 200           | IDLE             | $.[?(@.configurationName=='Error0004')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Error0004%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/Error0004%" should display below info/error/warning
      | type  | logValue                                                           | logCode      |
      | ERROR | Could not connect to EDI host usyp5thirmoga1v.asg.com at port 9290 | EDIBUS-E0101 |

  Scenario:SC15#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/Error0004% | Analysis |       |       |

  @edibus @positive @release10.0
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned