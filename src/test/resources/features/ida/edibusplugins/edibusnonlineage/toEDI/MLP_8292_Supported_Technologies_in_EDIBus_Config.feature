Feature: MLP_8292_Supported_Technologies_in_EDIBus_Config with standard license toEDI

  #6449714
  @edibus @mlp-8292 @webtest @positive @toEDI
  Scenario:MLP-8292_SC1#_Verification of replicating  items of non supported technology to EDI
    Given user update the json file "idc/EdiBusPayloads/toEDINonSupportedTechnology.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | toEDI      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/toEDINonSupportedTechnology.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDINotSupported |                                                     | 200           | IDLE             | $.[?(@.configurationName=='toEDINotSupported')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDINotSupported  |                                                     | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDINotSupported |                                                     | 200           | IDLE             | $.[?(@.configurationName=='toEDINotSupported')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "toEDINotSupported" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toEDINotSupported%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 1                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toEDINotSupported%" should display below info/error/warning
      | type  | logValue                                                                                           | logCode      | pluginName | removableText |
      | ERROR | The specified technologies "[Test]" require the explicit definition of the types to be replicated. | EDIBUS-E1309 |            |               |

    #6450006
  @edibus @mlp-8292 @webtest @positive @toEDI
  Scenario:MLP-8292_SC2#_Verification of replicating  items of non supported technology to EDICleanup
    Given user update the json file "idc/EdiBusPayloads/toEDINonSupportedTechnology.json" file for following values
      | jsonPath    | jsonValues   |
      | $..function | toEDICleanup |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                              | idc/EdiBusPayloads/toEDINonSupportedTechnology.json | 204           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDINotSupported |                                                     | 200           | IDLE             | $.[?(@.configurationName=='toEDINotSupported')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDINotSupported  |                                                     | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDINotSupported |                                                     | 200           | IDLE             | $.[?(@.configurationName=='toEDINotSupported')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "toEDINotSupported" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/toEDINotSupported%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 1                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/toEDINotSupported%" should display below info/error/warning
      | type  | logValue                                                                                           | logCode      | pluginName | removableText |
      | ERROR | The specified technologies "[Test]" require the explicit definition of the types to be replicated. | EDIBUS-E1309 |            |               |


  @edibus @positive
  Scenario:MLP-8292_SC3#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/toEDINotSupported% | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus%                   | Analysis |       |       |
    And  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                   |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/EDIBusValidCredentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource         |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |