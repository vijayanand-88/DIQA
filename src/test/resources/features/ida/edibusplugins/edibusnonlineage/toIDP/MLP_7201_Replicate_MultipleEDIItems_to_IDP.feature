Feature: MLP-7201 Replicating Multiple EDI items mapped to a IDP item with standard license

  @edibus @mlp-7201 @webtest @positive @release10.0 @toIDP
  Scenario:SC1#_MLP-7201_Verification of Replicating Service items from EDI to IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_7201_EDITOIDXConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXService |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXService')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXService  |                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXService |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXService')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TFMSystem" and clicks on search
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    Then user "verify presence" of following "Items List" in Search Results Page
      | TFMSystem≫Operation |
    And user enters the search text "TestFileSystem" and clicks on search
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    Then user "verify presence" of following "Items List" in Search Results Page
      | TestFileSystem≫FS |
    And user enters the search text "EDItoIDXService" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXService%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |


  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7201_EDITOIDXConfig.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_7201_EDITOIDXConfig.json | 204           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXService |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXService')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXService  |                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXService |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXService')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXService% | Analysis |       |       |


  @edibus @mlp-7201 @webtest @positive @release10.0 @toIDP
  Scenario:SC2#_MLP-7201_Verification of Replicating Service items from EDI to IDP with incremental true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP_7201_EDITOIDXConfigIncr.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXServiceIncr |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXServiceIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXServiceIncr  |                                                     | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXServiceIncr |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXServiceIncr')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDItoIDXServiceIncr" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXServiceIncr%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TestDBSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | TestDBSystem≫DB |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    And user enters the search text "TFMSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | TFMSystem≫Operation |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    And user enters the search text "TestFileSystem" and clicks on search
    Then user "verify presence" of following "Items List" in Search Results Page
      | TestFileSystem≫FS |
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |


  Scenario:SC2#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7201_EDITOIDXConfigIncr.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP_7201_EDITOIDXConfigIncr.json | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXServiceIncr |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXServiceIncr')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXServiceIncr  |                                                     | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXServiceIncr |                                                     | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXServiceIncr')].status |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDItoIDXServiceIncr% | Analysis |       |       |


  @edibus @mlp-7201 @positive @release10.0
  Scenario:SC4#_MLP-7201 Deleting used catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned