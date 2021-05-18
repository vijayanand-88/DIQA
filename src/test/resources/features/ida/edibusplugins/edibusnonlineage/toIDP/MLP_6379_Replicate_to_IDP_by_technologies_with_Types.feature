Feature: MLP-6379 Replicate to IDP by Oracle Technologies with Types with standard license

  @edibus @mlp-6379 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#MLP-6379 Run full replication from EDI to IDX with oracle technology with types
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                                     | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/MLP_6379_EDITOIDXOraclewithTypes.json | 204           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypes |                                                          | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnologyTypes  |                                                          | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypes |                                                          | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | Oracle≫DB |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPTechnologyTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_6379_EDITOIDXOraclewithTypes.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                                     | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/MLP_6379_EDITOIDXOraclewithTypes.json | 204           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypes |                                                          | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnologyTypes  |                                                          | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypes |                                                          | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypes')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                              | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toIDPTechnologyTypes% | Analysis |       |       |


  @edibus @mlp-6379 @webtest @positive @release10.0 @toIDP
  Scenario:SC2#MLP-6379 Run incremental replication from EDI to IDX with oracle technology with types
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                         | response code | response message | jsonPath                                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                     | idc/EdiBusPayloads/MLP_6379_EDITOIDXOraclewithTypesIncr.json | 204           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypesIncr |                                                              | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypesIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnologyTypesIncr  |                                                              | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypesIncr |                                                              | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypesIncr')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service  |
      | Database |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPTechnologyTypesIncr%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC2#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_6379_EDITOIDXOraclewithTypesIncr.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                         | response code | response message | jsonPath                                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                     | idc/EdiBusPayloads/MLP_6379_EDITOIDXOraclewithTypesIncr.json | 204           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypesIncr |                                                              | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypesIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnologyTypesIncr  |                                                              | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypesIncr |                                                              | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypesIncr')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toIDPTechnologyTypesIncr% | Analysis |       |       |

  @edibus @mlp-6379 @webtest @positive @release10.0 @toIDP
  Scenario:SC3#MLP-6379 Run replication from EDI to IDX with oracle technology which contains no oracle data
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                  | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP_6379_EDITOIDXNoOracleData.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPNoOracleData |                                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPNoOracleData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPNoOracleData  |                                                       | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPNoOracleData |                                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPNoOracleData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPNoOracleData%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/toIDPNoOracleData%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 0 items | EDIBUS-I0024 |            |               |


  Scenario:SC3#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_6379_EDITOIDXNoOracleData.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                  | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/MLP_6379_EDITOIDXNoOracleData.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPNoOracleData |                                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPNoOracleData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPNoOracleData  |                                                       | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPNoOracleData |                                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPNoOracleData')].status |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toIDPNoOracleData% | Analysis |       |       |

  @edibus @edibus @mlp-6379 @positive @release10.0
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned