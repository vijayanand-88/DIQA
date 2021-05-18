Feature: MLP-9918 Conflicts between EDIBus configurations

  ##6584703##
  @edibus @mlp-9918 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#MLP-9918_Verification of conflicts identified by names of configurations during replicating with same technology from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-7139_2.2Config.json" file for following values
      | jsonPath          | jsonValues          |
      | $..['technology'] | Oracle              |
      | $..['dataSource'] | EDIBusOrcDataSource |
      | $..['name']       | TechEDItoIDP        |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                       | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/TechEDItoIDP                            | idc/EdiBusPayloads/MLP-7139_2.2Config.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TechEDItoIDP  |                                            | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TechEDItoIDP" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TechEDItoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user update the json file "idc/EdiBusPayloads/MLP-7139_2.2Config.json" file for following values
      | jsonPath          | jsonValues             |
      | $..['technology'] | Oracle                 |
      | $..['dataSource'] | EDIBusIDCOrcDataSource |
      | $..['name']       | TechEDItoIDP2          |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                | body                                       | response code | response message | jsonPath                                           |
      |        |       |       | Put          | settings/analyzers/EDIBus/TechEDItoIDP2                            | idc/EdiBusPayloads/MLP-7139_2.2Config.json | 204           |                  |                                                    |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP2 |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP2')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TechEDItoIDP2  |                                            | 200           |                  |                                                    |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP2 |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP2')].status |
    And user enters the search text "TechEDItoIDP2" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TechEDItoIDP2%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 4             |
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/TechEDItoIDP2%" should display below info/error/warning
      | type  | logValue                                                                                                          | logCode      |
      | ERROR | Cannot execute the replication because of these conflicts:                                                        | EDIBUS-E5104 |
      | ERROR | The configuration 'TechEDItoIDP' has a different EDI subject area                                                 | EDIBUS-E5105 |
      | ERROR | Cannot execute the replication because of conflicts with other configuration(s), details can be found in the log. | EDIBUS-E5107 |

  Scenario:SC1#Cleanup
    And user update the json file "idc/EdiBusPayloads/MLP-7139_2.2Config.json" file for following values
      | jsonPath          | jsonValues          |
      | $..['technology'] | Oracle              |
      | $..['dataSource'] | EDIBusOrcDataSource |
      | $..['name']       | TechEDItoIDP        |
      | $..function       | cleanup             |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                       | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/TechEDItoIDP                            | idc/EdiBusPayloads/MLP-7139_2.2Config.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TechEDItoIDP  |                                            | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TechEDItoIDP |                                            | 200           | IDLE             | $.[?(@.configurationName=='TechEDItoIDP')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/TechEDItoIDP%  | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/TechEDItoIDP2% | Analysis |       |       |


    ##6584703##
  @edibus @mlp-9918 @webtest @positive @release10.0 @toIDP
  Scenario:SC2#MLP-9918_Verification of checking conflict during replication from multiple source catalogs with same types from EDI to IDP
    Given user update the json file "idc/EdiBusPayloads/MLP-9918_Config.json" file for following values
      | jsonPath          | jsonValues          |
      | $..['dataSource'] | EDIBusOrcDataSource |
      | $..['name']       | TypesEDItoIDP       |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/TypesEDItoIDP                            | idc/EdiBusPayloads/MLP-9918_Config.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP |                                         | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TypesEDItoIDP  |                                         | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP |                                         | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "XE" and clicks on search
    And user performs "facet selection" in "XE [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Table  |
      | Column |
    And user enters the search text "TypesEDItoIDP" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TypesEDItoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user update the json file "idc/EdiBusPayloads/MLP-9918_Config.json" file for following values
      | jsonPath          | jsonValues             |
      | $..['dataSource'] | EDIBusIDCOrcDataSource |
      | $..['name']       | TypesEDItoIDP2         |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                    | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/EDIBus/TypesEDItoIDP2                            | idc/EdiBusPayloads/MLP-9918_Config.json | 204           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP2 |                                         | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP2')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TypesEDItoIDP2  |                                         | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP2 |                                         | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP2')].status |
    And user enters the search text "TypesEDItoIDP2" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TypesEDItoIDP2%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 4             |
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "bulk/EDIBus/TypesEDItoIDP2%" should display below info/error/warning
      | type  | logValue                                                                                                          | logCode      |
      | ERROR | Cannot execute the replication because of these conflicts:                                                        | EDIBUS-E5104 |
      | ERROR | The configuration 'TypesEDItoIDP' has a different EDI subject area                                                | EDIBUS-E5105 |
      | ERROR | Cannot execute the replication because of conflicts with other configuration(s), details can be found in the log. | EDIBUS-E5107 |

  Scenario:SC2#Cleanup
    And user update the json file "idc/EdiBusPayloads/MLP-9918_Config.json" file for following values
      | jsonPath          | jsonValues          |
      | $..['dataSource'] | EDIBusOrcDataSource |
      | $..['name']       | TypesEDItoIDP       |
      | $..function       | cleanup             |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/TypesEDItoIDP                            | idc/EdiBusPayloads/MLP-9918_Config.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP |                                         | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TypesEDItoIDP  |                                         | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TypesEDItoIDP |                                         | 200           | IDLE             | $.[?(@.configurationName=='TypesEDItoIDP')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/TypesEDItoIDP%  | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/TypesEDItoIDP2% | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus%                | Analysis |       |       |


  @edibus @mlp-7054 @positive @release10.0
  Scenario:MLP-7054 Deleting used catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned

  @MLP-20754 @edibus @sanity
  Scenario: Delete Credentials for EDIBus
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                               | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/EDIBusInValidCredentials     |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/EDIBusValidCredentials       |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/EDIBusEmptyCredentials       |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/EDIBusUserInValidCredentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/EDIBusReportCredentials      |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource               |      | 204           |                  |          |
