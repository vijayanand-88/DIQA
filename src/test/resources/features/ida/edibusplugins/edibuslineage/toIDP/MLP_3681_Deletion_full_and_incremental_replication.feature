Feature: MLP-3681 Deletion using Full and incremental replication

  @edibus @mlp-3681 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#MLP-3681_Run EDIBUS with IDPCleanUp as function parameter and type as DWR_RDB_Column and validate data is cleaned up in IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_3681_EDITOIDXConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXCleanup  |                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDItoIDXCleanup" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXCleanup%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXCleanup%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 17 items | EDIBUS-I0024 |            |               |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                  | body                                              | response code | response message | jsonPath                                             |
      |        |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_3681_IDPCleanupConfig.json | 204           |                  |                                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXCleanup  |                                                   | 200           |                  |                                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
    And user enters the search text "EDItoIDXCleanup" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXCleanup%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXCleanup%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 7 items deleted | EDIBUS-I0010 |            |               |


  Scenario Outline:SC1#Verification of deleted item
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type   | name          | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Column | TestColumn    |             |            |          |
      | APPDBPOSTGRES | deletedID | Default | Column | TestColumnOne |             |            |          |

  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3681_EDITOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_3681_EDITOIDXConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXCleanup  |                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXCleanup% | Analysis |       |       |


  @edibus @mlp-3681 @webtest @positive @release10.0 @toIDP
  Scenario Outline:SC2#MLP-3681_Run EDIBUS with IDPCleanUp as function parameter and with multiple types [DWR_TFM_SYSTEM, DWR_TFM_TRANSFORMATION]
    Given user update the json file "idc/EdiBusPayloads/MLP_3681_EDITOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | replicate  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_3681_EDITOIDXConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXCleanup  |                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDItoIDXCleanup" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXCleanup%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXCleanup%" should display below info/error/warning
      | type | logValue              | logCode      | pluginName | removableText |
      | INFO | 20 items were written | EDIBUS-I0024 |            |               |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                  | body                                                      | response code | response message | jsonPath                                             |
      |        |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_3681_IDPCleanupConfigMultiple.json | 204           |                  |                                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                           | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXCleanup  |                                                           | 200           |                  |                                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                           | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
    And user enters the search text "EDItoIDXCleanup" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXCleanup%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXCleanup%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 5 items deleted. | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | TFMSystem≫Operation |             |            |          |


  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXCleanup% | Analysis |       |       |

  @edibus @mlp-3681 @webtest @positive @release10.0 @toIDP
  Scenario:SC3#MLP-3681_Run EDIBUS with IDPCleanUp as function parameter with incremental true and validate data is cleaned up in IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                   | body                                                  | response code | response message | jsonPath                                              |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                             | idc/EdiBusPayloads/MLP_3681_IDPCleanupConfigIncr.json | 204           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPCleanupIncr |                                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPCleanupIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPCleanupIncr  |                                                       | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPCleanupIncr |                                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPCleanupIncr')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "toIDPCleanupIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toIDPCleanupIncr%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toIDPCleanupIncr%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 7 items deleted. | EDIBUS-I0010 |            |               |


  Scenario Outline:SC3#MLP-3681_Verification of deleted item
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type   | name          | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Table  | TestTable     |             |            |          |
      | APPDBPOSTGRES | deletedID | Default | Table  | TestTableOne  |             |            |          |
      | APPDBPOSTGRES | deletedID | Default | Column | TestColumn    |             |            |          |
      | APPDBPOSTGRES | deletedID | Default | Column | TestColumnOne |             |            |          |


  Scenario:SC3#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_3681_EDITOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_3681_EDITOIDXConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXCleanup  |                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXCleanup |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXCleanup')].status |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                          | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXCleanup%  | Analysis |       |       |
      | SingleItemDelete | Default | bulk/EDIBus/toIDPCleanupIncr% | Analysis |       |       |

  @edibus @edibus @mlp-3681 @positive @release10.0
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
