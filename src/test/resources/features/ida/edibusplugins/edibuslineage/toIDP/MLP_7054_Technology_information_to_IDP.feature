Feature: MLP_7054 Replicate to IDP by Technologies

  @edibus @mlp-7054 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#MLP-7054 Verification of "Technology tag" assigned to items that are replicated from EDI to IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                              | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_7054_OracleTechnology.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnology |                                                   | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnology')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnology  |                                                   | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnology |                                                   | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnology')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verify displayed" for listed "Tags" facet in Search results page
      | ItemType   |
      | Technology |
      | Oracle     |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag        | fileName | userTag |
      | Default     | Database | Metadata Type | Oracle,ROC | XE       | Oracle  |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPTechnology%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toIDPTechnology%" should display below info/error/warning
      | type | logValue              | logCode      | pluginName | removableText |
      | INFO | 39 items were written | EDIBUS-I0024 |            |               |


  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7054_OracleTechnology.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                              | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_7054_OracleTechnology.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnology |                                                   | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnology')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnology  |                                                   | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnology |                                                   | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnology')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toIDPTechnology% | Analysis |       |       |


  @edibus @mlp-7054 @webtest @positive @release10.0 @toIDP
  Scenario:SC2#MLP-7054 Verification  of Technology tag assigned for items that are replicated with Specific item types
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                                   | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/MLP_7054_OracleTechnologyTypes.json | 204           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypes |                                                        | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnologyTypes  |                                                        | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypes |                                                        | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verify displayed" for listed "Tags" facet in Search results page
      | ItemType   |
      | Technology |
      | Oracle     |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Service  |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag        | fileName | userTag |
      | Default     | Database | Metadata Type | Oracle,ROC | XE       | Oracle  |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPTechnologyTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |

  Scenario:SC2#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7054_OracleTechnologyTypes.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                                   | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                 | idc/EdiBusPayloads/MLP_7054_OracleTechnologyTypes.json | 204           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypes |                                                        | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnologyTypes  |                                                        | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyTypes |                                                        | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyTypes')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                              | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toIDPTechnologyTypes% | Analysis |       |       |

  @edibus @mlp-7054 @positive @release10.0
  Scenario:MLP-7054 Deleting EDIBus configuration
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned



