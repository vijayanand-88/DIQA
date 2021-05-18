Feature: MLP-7139_MLP-28376_Conflict Checking

    ##6464644##7208595#
  @edibus @mlp-7139 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#_MLP-7139_MLP-28376_Scenario1.6_Verification of replicating technology items to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDX.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                      | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_EDITOIDX.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConflict  |                                           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user enters the search text "EDIBusConflict" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConflict%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 2             |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Oracle≫DB |
      | XE        |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusConflict%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 35 items | EDIBUS-I0024 |            |               |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                         | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_EDITOIDXNew.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConflict  |                                              | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos BI" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cognos≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user enters the search text "EDIBusConflict" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConflict%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 4             |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Oracle≫DB      |
      | XE             |
      | CognosDatabase |
      | Cognos≫DB      |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusConflict%" should display below info/error/warning
      | type | logValue                                                               | logCode      | pluginName | removableText |
      | INFO | An incremental replication is not possible because of these conflicts: | EDIBUS-I0101 |            |               |
      | INFO | Types have been added to the configuration.                            | EDIBUS-I0102 |            |               |
      | INFO | Technologies have been added to the configuration                      | EDIBUS-I0102 |            |               |
      | INFO | A full replication will be done instead.                               | EDIBUS-I0103 |            |               |


  Scenario:SC1#Cleanup
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDX.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                      | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_EDITOIDX.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConflict  |                                           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                         | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_EDITOIDXNew.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConflict  |                                              | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusConflict% | Analysis |       |       |


    ##6464825## ##6464849##
  @edibus @mlp-7139 @webtest @positive @release10.0 @toIDP
  Scenario:SC2#_MLP-7139 Scenario2.6_Verification of replicating with same technology from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDX.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                      | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_EDITOIDX.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConflict  |                                           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user enters the search text "EDIBusConflict" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConflict%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXSameTech.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                              | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_EDITOIDXSameTech.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConflict  |                                                   | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
    And user enters the search text "EDIBusConflict" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConflict%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 4             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusConflict%" should display below info/error/warning
      | type  | logValue                                                                                                                                                        | logCode      | pluginName | removableText |
      | ERROR | Cannot execute the replication because of these conflicts:                                                                                                      | EDIBUS-E5104 |            |               |
      | ERROR | The source EDI subject area of the configuration has been changed.                                                                                              | EDIBUS-E5105 |            |               |
      | ERROR | Cannot execute the replication because of conflicts with other configuration(s), details can be found in the log.                                               | EDIBUS-E5107 |            |               |
      | INFO  | Hint for resolving the replication conflict(s): Run the function "cleanup" for the configurations which replicated the conflicting items to delete these items. | EDIBUS-I0106 |            |               |

  Scenario:SC2#Cleanup
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDX.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                      | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_EDITOIDX.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConflict  |                                           | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConflict |                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConflict')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusConflict% | Analysis |       |       |

     ##6459326##
  @edibus @mlp-7139 @webtest @positive @release10.0 @toIDP
  Scenario:SC3#_MLP-7139 Scenario1.4_Verification of incremental replication from EDI to  IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXTypes.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                           | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP-7139_EDITOIDXTypes.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTypesConflict |                                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTypesConflict')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTypesConflict  |                                                | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTypesConflict |                                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTypesConflict')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "XE" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Service  |
    And user enters the search text "EDIBusTypesConflict" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTypesConflict%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Oracle≫DB |
      | XE        |
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXTypesNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body                                              | response code | response message | jsonPath                                                 |
      |        |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP-7139_EDITOIDXTypesNew.json | 204           |                  |                                                          |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTypesConflict |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTypesConflict')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTypesConflict  |                                                   | 200           |                  |                                                          |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTypesConflict |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTypesConflict')].status |
    And user enters the search text "XE" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Service  |
      | Table    |
    And user enters the search text "EDIBusTypesConflict" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTypesConflict%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Oracle≫DB |
      | XE        |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTypesConflict%" should display below info/error/warning
      | type | logValue                                                               | logCode      | pluginName | removableText |
      | INFO | An incremental replication is not possible because of these conflicts: | EDIBUS-I0101 |            |               |
      | INFO | A full replication will be done instead.                               | EDIBUS-I0103 |            |               |
      | INFO | Types have been added to the configuration.                            | EDIBUS-I0102 |            |               |


  Scenario:SC3#Cleanup
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXTypes.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                           | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP-7139_EDITOIDXTypes.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTypesConflict |                                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTypesConflict')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTypesConflict  |                                                | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTypesConflict |                                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTypesConflict')].status |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXTypesNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body                                              | response code | response message | jsonPath                                                 |
      |        |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP-7139_EDITOIDXTypesNew.json | 204           |                  |                                                          |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTypesConflict |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTypesConflict')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTypesConflict  |                                                   | 200           |                  |                                                          |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTypesConflict |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTypesConflict')].status |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTypesConflict% | Analysis |       |       |


    ##6468515##
  @edibus @mlp-7139 @webtest @positive @release10.0 @toIDP
  Scenario:SC4#_MLP-7139 Scenario_2.10_Verification of replicating items from multiple source catalogs with additional technologies from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXTech.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                          | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/MLP-7139_EDITOIDXTech.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechConflict |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechConflict')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTechConflict  |                                               | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechConflict |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechConflict')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "XE" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user enters the search text "EDIBusTechConflict" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTechConflict%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXTechNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                     | body                                             | response code | response message | jsonPath                                                |
      |        |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/MLP-7139_EDITOIDXTechNew.json | 204           |                  |                                                         |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechConflict |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechConflict')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTechConflict  |                                                  | 200           |                  |                                                         |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechConflict |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechConflict')].status |
    And user enters the search text "XE" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user enters the search text "Cognos" and clicks on search
    And user performs "facet selection" in "Cognos≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user enters the search text "EDIBusTechConflict" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTechConflict%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 4             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusTechConflict%" should display below info/error/warning
      | type | logValue              | logCode      | pluginName | removableText |
      | INFO | 40 items were written | EDIBUS-I0024 |            |               |


  Scenario:SC4#Cleanup
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXTechNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                             | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/MLP-7139_EDITOIDXTechNew.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechConflict |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechConflict')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTechConflict  |                                                  | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechConflict |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechConflict')].status |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXTech.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                     | body                                          | response code | response message | jsonPath                                                |
      |        |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/MLP-7139_EDITOIDXTech.json | 204           |                  |                                                         |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechConflict |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechConflict')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTechConflict  |                                               | 200           |                  |                                                         |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechConflict |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechConflict')].status |

  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTechConflict% | Analysis |       |       |

     ##6468618##
  @edibus @mlp-7139 @webtest @positive @release10.0 @toIDP
  Scenario:SC5#_MLP-7139 Scenario_2.12_Verification of replicating items from multiple source catalogs with overlapping and different types from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXOverlap.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                             | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP-7139_EDITOIDXOverlap.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechOverlap |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechOverlap')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTechOverlap  |                                                  | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechOverlap |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechOverlap')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GO Data Warehouse" and clicks on search
    And user performs "facet selection" in "GO Data Warehouse [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Cube        |
      | Dimension   |
      | OlapSchema  |
      | OlapPackage |
    And user enters the search text "EDIBusTechOverlap" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTechOverlap%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 4             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXOverlapNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                    | body                                                | response code | response message | jsonPath                                               |
      |        |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP-7139_EDITOIDXOverlapNew.json | 204           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechOverlap |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechOverlap')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTechOverlap  |                                                     | 200           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechOverlap |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechOverlap')].status |
    And user enters the search text "EDIBusTechOverlap" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusTechOverlap%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 80            |

  Scenario:SC5#Cleanup
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXOverlap.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                             | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP-7139_EDITOIDXOverlap.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechOverlap |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechOverlap')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTechOverlap  |                                                  | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechOverlap |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechOverlap')].status |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_EDITOIDXOverlapNew.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                    | body                                                | response code | response message | jsonPath                                               |
      |        |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP-7139_EDITOIDXOverlapNew.json | 204           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechOverlap |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechOverlap')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusTechOverlap  |                                                     | 200           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusTechOverlap |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDIBusTechOverlap')].status |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusTechOverlap% | Analysis |       |       |


       ##6459264##
  @edibus @mlp-7139 @webtest @positive @release10.0 @toIDP
  Scenario:SC6#_MLP-7139 _Scenario1.2_Verification of changing source for replication from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_1.2Config.json" file for following values
      | jsonPath          | jsonValues          |
      | $..['function']   | replicate           |
      | $..['dataSource'] | EDIBusIDPDataSource |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_1.2Config.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='ColumnEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ColumnEDItoIDP  |                                            | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='ColumnEDItoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ColumnEDItoIDP" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ColumnEDItoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 2             |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_1.2Config.json" file for following values
      | jsonPath          | jsonValues           |
      | $..['function']   | replicate            |
      | $..['dataSource'] | EDIBusAutoDataSource |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                       | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_1.2Config.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='ColumnEDItoIDP')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ColumnEDItoIDP  |                                            | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='ColumnEDItoIDP')].status |
    And user enters the search text "ColumnEDItoIDP" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ColumnEDItoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 4             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ColumnEDItoIDP%" should display below info/error/warning
      | type  | logValue                                                                                                          | logCode      | pluginName | removableText |
      | ERROR | Cannot execute the replication because of these conflicts:                                                        | EDIBUS-E5104 |            |               |
      | ERROR | Cannot execute the replication because of conflicts with other configuration(s), details can be found in the log. | EDIBUS-E5107 |            |               |
      | ERROR | The source EDI subject area of the configuration has been changed.                                                | EDIBUS-E5105 |            |               |

  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/ColumnEDItoIDP% | Analysis |       |       |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_1.2Config.json" file for following values
      | jsonPath          | jsonValues          |
      | $..['function']   | cleanup             |
      | $..['dataSource'] | EDIBusIDPDataSource |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP-7139_1.2Config.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='ColumnEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ColumnEDItoIDP  |                                            | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ColumnEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='ColumnEDItoIDP')].status |


        ##6434814##bugid 15898#
  @edibus @mlp-7139 @webtest @positive @release10.0 @toIDP
  Scenario:SC7#_MLP-7139 _Scenario 2.2_Verification of replicating items from multiple source catalogs with different technology from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP_7139_2.2Config.json" file for following values
      | jsonPath                               | jsonValues          |
      | $..['EDI technologies'].['technology'] | Oracle              |
      | $..['dataSource']                      | EDIBusOrcDataSource |
      | $..['name']                            | TechEDItoIDP        |
      | $..['function']                        | replicate           |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                       | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/TechEDItoIDP                            | idc/EdiBusPayloads/MLP_7139_2.2Config.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TechEDItoIDP  |                                            | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "XE" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user enters the search text "TechEDItoIDP" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TechEDItoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user update the json file "idc/EdiBusPayloads/MLP_7139_2.2Config.json" file for following values
      | jsonPath          | jsonValues             |
      | $..['technology'] | SCANCOGNOS             |
      | $..['dataSource'] | EDIBusCognosDataSource |
      | $..['name']       | TechEDItoIDP2          |
      | $..['function']   | replicate              |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                | body                                       | response code | response message | jsonPath                                           |
      |        |       |       | Put          | settings/analyzers/EDIBus/TechEDItoIDP2                            | idc/EdiBusPayloads/MLP_7139_2.2Config.json | 204           |                  |                                                    |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP2 |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP2')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TechEDItoIDP2  |                                            | 200           |                  |                                                    |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP2 |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP2')].status |
    And user enters the search text "TechEDItoIDP2" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TechEDItoIDP2%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 4             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDIBusConflict%" should display below info/error/warning
      | type  | logValue                                                                                                                                                        | logCode      | pluginName | removableText |
      | ERROR | Cannot execute the replication because of these conflicts:                                                                                                      | EDIBUS-E5104 |            |               |
      | ERROR | The configuration 'TechEDItoIDP' has a different EDI subject area                                                                                               | EDIBUS-E5105 |            |               |
      | ERROR | Cannot execute the replication because of conflicts with other configuration(s), details can be found in the log.                                               | EDIBUS-E5107 |            |               |
      | INFO  | Hint for resolving the replication conflict(s): Run the function "cleanup" for the configurations which replicated the conflicting items to delete these items. | EDIBUS-I0106 |            |               |


  Scenario:SC7#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7139_2.2Config.json" file for following values
      | jsonPath          | jsonValues          |
      | $..['technology'] | Oracle              |
      | $..['dataSource'] | EDIBusOrcDataSource |
      | $..['name']       | TechEDItoIDP        |
      | $..function       | cleanup             |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                       | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/TechEDItoIDP                            | idc/EdiBusPayloads/MLP_7139_2.2Config.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TechEDItoIDP  |                                            | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP')].status |
    And user update the json file "idc/EdiBusPayloads/MLP_7139_2.2Config.json" file for following values
      | jsonPath          | jsonValues             |
      | $..['technology'] | SCANCOGNOS             |
      | $..['dataSource'] | EDIBusCognosDataSource |
      | $..['name']       | TechEDItoIDP2          |
      | $..function       | cleanup                |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                | body                                       | response code | response message | jsonPath                                           |
      |        |       |       | Put          | settings/analyzers/EDIBus/TechEDItoIDP2                            | idc/EdiBusPayloads/MLP_7139_2.2Config.json | 204           |                  |                                                    |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP2 |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP2')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TechEDItoIDP2  |                                            | 200           |                  |                                                    |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP2 |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP2')].status |

  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/TechEDItoIDP%  | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/TechEDItoIDP2% | Analysis |       |       |

     ##6434822#
  @edibus @mlp-7139 @webtest @positive @release10.0 @toIDP
  Scenario:SC8#_MLP-7139 _Scenario 2.4_Verification of replicating items from multiple source catalogs with different types from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_2.4Config.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                       | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/TypesEDItoIDP                            | idc/EdiBusPayloads/MLP-7139_2.4Config.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TypesEDItoIDP  |                                            | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "XE" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Table    |
      | Service  |
      | Database |
    And user enters the search text "TypesEDItoIDP" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TypesEDItoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_2.4Config1.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                        | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus/TypesEDItoIDP2                            | idc/EdiBusPayloads/MLP-7139_2.4Config1.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP2 |                                             | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP2')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TypesEDItoIDP2  |                                             | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP2 |                                             | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP2')].status |
    And user enters the search text "TypesEDItoIDP2" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TypesEDItoIDP2%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 4             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/TypesEDItoIDP2%" should display below info/error/warning
      | type  | logValue                                                                                                                                                        | logCode      | pluginName | removableText |
      | ERROR | Cannot execute the replication because of these conflicts:                                                                                                      | EDIBUS-E5104 |            |               |
      | ERROR | The configuration 'TypesEDItoIDP' has a different EDI subject area                                                                                              | EDIBUS-E5105 |            |               |
      | ERROR | Cannot execute the replication because of conflicts with other configuration(s), details can be found in the log.                                               | EDIBUS-E5107 |            |               |
      | INFO  | Hint for resolving the replication conflict(s): Run the function "cleanup" for the configurations which replicated the conflicting items to delete these items. | EDIBUS-I0106 |            |               |


  Scenario:SC8#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_2.4Config.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                       | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/TypesEDItoIDP                            | idc/EdiBusPayloads/MLP-7139_2.4Config.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TypesEDItoIDP  |                                            | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP')].status |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_2.4Config1.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                        | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus/TypesEDItoIDP2                            | idc/EdiBusPayloads/MLP-7139_2.4Config1.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP2 |                                             | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP2')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TypesEDItoIDP2  |                                             | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP2 |                                             | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP2')].status |

  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/TypesEDItoIDP%  | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/TypesEDItoIDP2% | Analysis |       |       |

  @edibus @mlp-7054 @positive @release10.0
  Scenario:SC9#_MLP-7054 Deleting used catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned