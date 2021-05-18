Feature:MLP_4341 Replicate to IDP by Technologies


  @edibus @mlp-4341 @mlp-6809 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#MLP-4341 MLP_6809 Verification of replicating Oracle items from EDI to IDP with incremental set to "false" and through "TOIDP" function
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/EDITOIDXOracleTechnology.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnology |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnology')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnology  |                                                  | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnology |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnology')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Table    |
      | Database |
      | Schema   |
      | Service  |
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


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPTechnology% | Analysis |       |       |

  @edibus @mlp-4341 @webtest @positive @toIDP
  Scenario Outline:SC2#MLP-4341 Verification of IDP cleanup of oracle item types with incremental set to false
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                               | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/IDPCleanupConfigTechnology.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnology |                                                    | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnology')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnology  |                                                    | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnology |                                                    | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnology')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
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
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 39 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name      | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | Oracle≫DB |             |            |          |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPTechnology% | Analysis |       |       |

  @edibus @mlp-4341 @webtest @positive @release10.0 @toIDP
  Scenario:SC3#MLP-4341 Verification of replicating Oracle items from EDI to IDP with incremental set to "true"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body                                                        | response code | response message | jsonPath                                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                       | idc/EdiBusPayloads/EDITOIDXOracleTechnologyIncremental.json | 204           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyIncremental |                                                             | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyIncremental')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnologyIncremental  |                                                             | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyIncremental |                                                             | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyIncremental')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Table    |
      | Database |
      | Schema   |
      | Service  |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPTechnologyIncremental%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toIDPTechnologyIncremental%" should display below info/error/warning
      | type | logValue              | logCode      | pluginName | removableText |
      | INFO | 39 items were written | EDIBUS-I0024 |            |               |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPTechnologyIncremental% | Analysis |       |       |

  @edibus @mlp-4341 @webtest @positive @release10.0 @toIDP
  Scenario Outline:SC4#MLP-4341 Verification of IDP cleanup of oracle item types with incremental set to true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body                                                          | response code | response message | jsonPath                                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                       | idc/EdiBusPayloads/IDPCleanupConfigTechnologyIncremental.json | 204           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyIncremental |                                                               | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyIncremental')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTechnologyIncremental  |                                                               | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTechnologyIncremental |                                                               | 200           | IDLE             | $.[?(@.configurationName=='toIDPTechnologyIncremental')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPTechnologyIncremental%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toIDPTechnologyIncremental%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 39 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name      | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | Oracle≫DB |             |            |          |

  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPTechnologyIncremental% | Analysis |       |       |


  @edibus @mlp-4341 @mlp-6809 @webtest @positive @release10.0 @toIDP
  Scenario:SC5#MLP-4341 MLP_6809 Verification of replicating Teradata items from EDI to IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                     | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/EDITOIDXTeradata.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTeradata |                                          | 200           | IDLE             | $.[?(@.configurationName=='toIDPTeradata')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTeradata  |                                          | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTeradata |                                          | 200           | IDLE             | $.[?(@.configurationName=='toIDPTeradata')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "didtde01v.did.dev.asgint.loc" and clicks on search
    And user performs "facet selection" in "didtde01v.did.dev.asgint.loc≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Teradata" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Table    |
      | Database |
      | Schema   |
      | Service  |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPTeradata%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toIDPTeradata%" should display below info/error/warning
      | type | logValue                   | logCode      | pluginName | removableText |
      | INFO | replication of 21051 items | EDIBUS-I0024 |            |               |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPTeradata% | Analysis |       |       |

  @edibus @mlp-4341 @mlp-6809 @webtest @positive @release10.0 @toIDP
  Scenario Outline:SC6#MLP-4341 MLP_6809 Verification of cleanup of Teradata items from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/EDITOIDXTeradata.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                     | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/EDITOIDXTeradata.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTeradata |                                          | 200           | IDLE             | $.[?(@.configurationName=='toIDPTeradata')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPTeradata  |                                          | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPTeradata |                                          | 200           | IDLE             | $.[?(@.configurationName=='toIDPTeradata')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPTeradata%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toIDPTeradata%" should display below info/error/warning
      | type | logValue            | logCode      | pluginName | removableText |
      | INFO | 21051 items deleted | EDIBUS-I0024 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | didtde01v.did.dev.asgint.loc≫DB |             |            |          |


  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPTeradata% | Analysis |       |       |


  @edibus @mlp-4341 @mlp-6809 @webtest @positive @release10.0 @toIDP
  Scenario:SC7#MLP-4341 MLP_6809 Verification of replicating ScanCognos technology items from EDI to IDP
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/EDITOIDXCognosTechnology.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/CognosTechtoIDP |                                                  | 200           | IDLE             | $.[?(@.configurationName=='CognosTechtoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/CognosTechtoIDP  |                                                  | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/CognosTechtoIDP |                                                  | 200           | IDLE             | $.[?(@.configurationName=='CognosTechtoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DefaultScanCognos" and clicks on search
    And user performs "facet selection" in "$$DefaultScanCognos≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cognos BI" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Table    |
      | Database |
      | Schema   |
      | Service  |
    And user enters the search text "GO" and clicks on search
    And user performs "facet selection" in "GO Data Warehouse [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "GO Sales [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cognos BI" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Measure          |
      | AggregationLevel |
      | Dimension        |
      | Hierarchy        |
      | OlapSchema       |
      | OlapPackage      |
      | Cube             |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/CognosTechtoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/CognosTechtoIDP%" should display below info/error/warning
      | type | logValue                  | logCode      | pluginName | removableText |
      | INFO | replication of 8287 items | EDIBUS-I0024 |            |               |


  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/CognosTechtoIDP% | Analysis |       |       |


  @edibus @mlp-4341 @mlp-6809 @webtest @positive @release10.0 @toIDP
  Scenario Outline:SC8#MLP-4341 MLP_6809 Verification of cleanup of ScanCognos technology items from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/EDITOIDXCognosTechnology.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/EDITOIDXCognosTechnology.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/CognosTechtoIDP |                                                  | 200           | IDLE             | $.[?(@.configurationName=='CognosTechtoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/CognosTechtoIDP  |                                                  | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/CognosTechtoIDP |                                                  | 200           | IDLE             | $.[?(@.configurationName=='CognosTechtoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/CognosTechtoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/CognosTechtoIDP%" should display below info/error/warning
      | type | logValue           | logCode      | pluginName | removableText |
      | INFO | 5209 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                   | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | $$DefaultScanCognos≫DB |             |            |          |


  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/CognosTechtoIDP% | Analysis |       |       |


  @edibus @edibus @mlp-4341 @positive @release10.0
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned