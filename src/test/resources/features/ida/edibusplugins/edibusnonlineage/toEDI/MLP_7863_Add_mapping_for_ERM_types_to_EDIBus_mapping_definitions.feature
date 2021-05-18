Feature: MLP-7863 Add mapping for ERM types to EDIBus mapping definitions with standard license toEDI

    ##6478874 ##
  @edibus @mlp-7863 @webtest @positive @toEDI
  Scenario:MLP-7863_SC1#_Verification of replicating  ERM item types from  IDP to EDI
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                            | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_7863_IDXTOEDIConfig.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDPTOEDI |                                                 | 200           | IDLE             | $.[?(@.configurationName=='IDPTOEDI')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDPTOEDI  |                                                 | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDPTOEDI |                                                 | 200           | IDLE             | $.[?(@.configurationName=='IDPTOEDI')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "IDPTOEDI" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDPTOEDI%"
    Then METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 1                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And And Analysis log "bulk/EDIBus/IDPTOEDI%" should display below info/error/warning
      | type  | logValue                                                                                   | logCode      | pluginName | removableText |
      | ERROR | Object "IDA types" must contain at least one type name mapped to a target type.            | EDIBUS-E0002 |            |               |
      | WARN  | Sqlg type "Attribute" can"t be replicated to EDI because of missing mapping definition.    | EDIBUS-W0006 |            |               |
      | WARN  | Sqlg type "SubjectArea" can"t be replicated to EDI because of missing mapping definition.  | EDIBUS-W0006 |            |               |
      | WARN  | Sqlg type "Relationship" can"t be replicated to EDI because of missing mapping definition. | EDIBUS-W0006 |            |               |
      | WARN  | Sqlg type "Entity" can"t be replicated to EDI because of missing mapping definition.       | EDIBUS-W0006 |            |               |
      | WARN  | Sqlg type "ER-Model" can"t be replicated to EDI because of missing mapping definition.     | EDIBUS-W0006 |            |               |
      | WARN  | Sqlg type "Identifier" can"t be replicated to EDI because of missing mapping definition.   | EDIBUS-W0006 |            |               |
    And user clicks on logout button


  @edibus @positive
  Scenario:MLP-7863_SC2#_Delete all the External Packages and analysis with respect to EDIBus
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/IDPTOEDI% | Analysis |       |       |


  @edibus @positive
  Scenario:MLP-7863_SC2#_Delete plugin Configurations and Clearing of Subject Area in EDI
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus |      | 204           |                  |          |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
